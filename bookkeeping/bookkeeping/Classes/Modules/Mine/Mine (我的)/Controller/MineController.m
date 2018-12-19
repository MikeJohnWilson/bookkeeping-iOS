/**
 * 记账
 * @author 郑业强 2018-12-16 创建文件
 */

#import "MineController.h"
#import "MineView.h"
#import "BadgeController.h"
#import "CategoryController.h"
#import "TIController.h"
#import "MINE_EVENT_MANAGER.h"


#pragma mark - 声明
@interface MineController()

@property (nonatomic, strong) MineView *mine;
@property (nonatomic, strong) NSDictionary<NSString *, NSInvocation *> *eventStrategy;

@end


#pragma mark - 实现
@implementation MineController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setJz_navigationBarHidden:YES];
    [self mine];
}


#pragma mark - 事件
- (void)routerEventWithName:(NSString *)eventName data:(id)data {
    [self handleEventWithName:eventName data:data];
}
- (void)handleEventWithName:(NSString *)eventName data:(id)data {
    NSInvocation *invocation = self.eventStrategy[eventName];
    [invocation setArgument:&data atIndex:2];
    [invocation invoke];
    [super routerEventWithName:eventName data:data];
}
// 列表点击
- (void)mineCellClick:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        // 徽章
        if (indexPath.row == 0) {
            BadgeController *vc = [[BadgeController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if (indexPath.section == 1) {
        // 类别
        if (indexPath.row == 0) {
            CategoryController *vc = [[CategoryController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        // 定时
        else if (indexPath.row == 1) {
            TIController *vc = [[TIController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
// 头像点击
- (void)headerIconClick:(id)data {
    
}
// 打卡点击
- (void)punchClick:(id)data {
    
}
// 连续打卡点击
- (void)headerPunchClick:(id)data {
    
}
// 总天数点击
- (void)headerDayClick:(id)data {
    
}
// 总笔数点击
- (void)headerNumberClick:(id)data {
    
}


#pragma mark - get
- (MineView *)mine {
    if (!_mine) {
        _mine = [MineView loadCode:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TabbarHeight)];
        [self.view addSubview:_mine];
    }
    return _mine;
}
- (NSDictionary<NSString *, NSInvocation *> *)eventStrategy {
    if (!_eventStrategy) {
        _eventStrategy = @{
                           MINE_CELL_CLICK: [self createInvocationWithSelector:@selector(mineCellClick:)],
                           MINE_HEADER_ICON_CLICK: [self createInvocationWithSelector:@selector(headerIconClick:)],
                           MINE_PUNCH_CLICK: [self createInvocationWithSelector:@selector(punchClick:)],
                           MINE_HEADER_PUNCH_CLICK: [self createInvocationWithSelector:@selector(headerPunchClick:)],
                           MINE_HEADER_DAY_CLICK: [self createInvocationWithSelector:@selector(headerDayClick:)],
                           MINE_HEADER_NUMBER_CLICK: [self createInvocationWithSelector:@selector(headerNumberClick:)]
                           };
    }
    return _eventStrategy;
}


@end

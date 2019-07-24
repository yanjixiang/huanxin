//
//  GCDCountDown.h


#import <Foundation/Foundation.h>

//如果你是要更新UI，一定要加上返回到主线程。
typedef void (^CountCallback)(NSInteger time,dispatch_source_t timer);

@protocol GCDCountDownDelegate <NSObject>

/**
 计时器工作回调,在使用时，如果你是要更新UI，一定要加上返回到主线程。
 For example:
 -(void)CountDownTimer:(dispatch_source_t)timer time:(NSInteger)time{
 dispatch_async(dispatch_get_main_queue(), ^{
 [self.btn setTitle:[NSString stringWithFormat:@"- %lds",time] forState:UIControlStateNormal];
 });
 
 }
 @param timer 计时器
 @param time 剩余时间
 */
@optional
-(void)CountDownTimer:(dispatch_source_t)timer time:(NSInteger)time;
@end

@interface GCDCountDown : NSObject

/**
 计时器
 */
@property (nonatomic) dispatch_source_t timer;

/**
 代理
 例如要实现按钮倒计时：在ViewController中 viewDidload方法初始化一次(delegate = self)。
 重点！！！：必须在dealloc方法中设置delegate = nil;
 */
@property (nonatomic,assign) id <GCDCountDownDelegate>delegate;

/**
 计时器回调
 */
@property (nonatomic,copy) CountCallback countCallback;

/**
 开始倒计时
 */
-(void)startTask;

/**
 停止倒计时
 */
-(void)stopTask;

/**
 通过Block回调

 @param countDown Block
 */
-(void)acceptData:(CountCallback)countDown;

/**
 通过这个方法进行初始化

 @param tempTime 倒计时的时间
 @return 计时器
 */
- (instancetype)initWithTime:(NSInteger)tempTime;
@end

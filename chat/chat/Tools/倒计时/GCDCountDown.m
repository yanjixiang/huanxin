//
//  GCDCountDown.m


#import "GCDCountDown.h"

@implementation GCDCountDown{
    __block NSInteger time;
    BOOL isStart;
    NSInteger oriTime;
}

- (instancetype)initWithTime:(NSInteger)tempTime
{
    self = [super init];
    if (self) {
        oriTime = tempTime;
        time    = tempTime; //倒计时时间
        isStart = NO;
        [self openCountdown];
    }
    return self;
}

-(void)openCountdown{
    if (!self.timer) {
        [self initSource];
    }
    [self execute];
}

-(void)acceptData:(CountCallback)countDown{
    _countCallback = countDown;
    if (isStart) {
        self.countCallback(time,self.timer);
    }
}

- (void)execute{
    dispatch_source_set_timer(self.timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(self.timer, ^{
        
        if(self->time <= 0){ //倒计时结束，关闭
            //将数据返回主线程 下面这种做法，会有界面卡顿的感觉，原因、、、。
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if ([self.delegate respondsToSelector:@selector(CountDownTimer:time:)]) {
//                    [self.delegate CountDownTimer:self.timer time:time];
//                }
//                if (self.countCallback) {
//                    self.countCallback(time,self.timer);
//                }
//            });
            if ([self.delegate respondsToSelector:@selector(CountDownTimer:time:)]) {
                [self.delegate CountDownTimer:self.timer time:self->time];
            }
            if (self.countCallback) {
                self.countCallback(self->time,self.timer);
            }
            
            
            //关闭源
            dispatch_source_cancel(self.timer);
            self->isStart    = NO;
            self.timer = nil;
        }else{
            if ([self.delegate respondsToSelector:@selector(CountDownTimer:time:)]) {
                [self.delegate CountDownTimer:self.timer time:self->time];
            }
            if (self.countCallback) {
                self.countCallback(self->time,self.timer);
            }
            self->time--;
        }
    });
}

- (void)initSource{
    if (!self.timer) {
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        self.timer             = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    }
}

-(void)startTask{
    if (isStart) {
        return;
    }
    isStart = YES;
    //开启源
    if (self.timer) {
        dispatch_resume(self.timer);
    }else{
        time = oriTime;
        [self openCountdown];
        dispatch_resume(self.timer);
    }
    
}
-(void)stopTask{
    //关闭源
    dispatch_source_cancel(self.timer);
    self.timer = nil;
    isStart    = NO;
}

@synthesize delegate = _delegate;

-(void)setDelegate:(id<GCDCountDownDelegate>)delegate{
    _delegate     = delegate;
    if(_delegate != nil && isStart){
        if ([self.delegate respondsToSelector:@selector(CountDownTimer:time:)]) {
            [self.delegate CountDownTimer:self.timer time:time];
        }
        if (self.countCallback) {
            self.countCallback(time,self.timer);
        }
    }
}

-(id<GCDCountDownDelegate>)delegate{
    return _delegate;
}


@end

//
//  HFGCDTimer.m
//  HFTimer
//
//  Created by hui hong on 2019/1/29.
//  Copyright © 2019 hui hong. All rights reserved.
//

#import "HFGCDTimer.h"

@interface HFGCDTimer ()

@property (nonatomic, strong) dispatch_source_t timer;
@property (nonatomic, assign) NSTimeInterval timeInterval;
@property (nonatomic, assign) BOOL fireNow;
@property (nonatomic, copy) HFGCDTimerBlock timerBlock;

@property (nonatomic, assign) NSTimeInterval startTime;

@end

@implementation HFGCDTimer

- (void)dealloc {
    [self stopTimer];
}

+ (instancetype)timerWithTimerInterval:(NSTimeInterval)timeInterval fireNow:(BOOL)fireNow timerBlock:(HFGCDTimerBlock)timerBlock {
    HFGCDTimer *timer = [HFGCDTimer new];
    timer.timeInterval = timeInterval;
    timer.fireNow = fireNow;
    timer.timerBlock = timerBlock;
    return timer;
}

- (void)startTimer {
    self.timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(0, 0));
    NSTimeInterval delay = self.fireNow ? 0 : self.timeInterval;
    dispatch_source_set_timer(self.timer, dispatch_time(DISPATCH_WALLTIME_NOW, delay*NSEC_PER_SEC), self.timeInterval * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.timer, ^{
        if (self.timerBlock) {
            self.timerBlock(self, (CFAbsoluteTimeGetCurrent())-self.startTime);
        }
    });
    if (self.startTime <= 0) {
        self.startTime = CFAbsoluteTimeGetCurrent();
    }
    dispatch_resume(self.timer);
}

- (void)stopTimer {
    dispatch_cancel(self.timer);
    self.timer = nil;
}

// 重置timer的开始时间
- (void)resetTimerStartTime {
    self.startTime = 0;
}

@end

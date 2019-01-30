//
//  HFTimer.m
//  HFTimer
//
//  Created by hui hong on 2019/1/29.
//  Copyright © 2019 hui hong. All rights reserved.
//

#import "HFTimer.h"
#import "HFWeakObject.h"

@interface HFTimer ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSTimeInterval timeInterval;
@property (nonatomic, copy) HFTimerBlock timerBlock;
@property (nonatomic, assign) BOOL fireNow;
@property (nonatomic, assign) BOOL repeat;

@property (nonatomic, assign) NSTimeInterval startTime;

@end

@implementation HFTimer

- (void)dealloc {
    [self clearTimer];
}

- (instancetype)initTimerWithTimeInterval:(NSTimeInterval)timerInterval
                                   repeat:(BOOL)repeat
                                  fireNow:(BOOL)fireNow
                               timerBlock:(HFTimerBlock)timerBlock {
    self = [super init];
    if (self) {
        self.timeInterval = timerInterval;
        self.repeat = repeat;
        self.fireNow = fireNow;
        self.timerBlock = timerBlock;
    }
    return self;
}

- (void)setIsTimerStart:(BOOL)isTimerStart {
    if (isTimerStart) {
        if (self.startTime <= 0) {
            self.startTime = CFAbsoluteTimeGetCurrent();
        }
        [self configTimer];
    } else {
        [self clearTimer];
    }
}

// 重置timer的开始时间
- (void)resetTimerStartTime {
    self.startTime = 0;
}

#pragma mark - private methods

- (void)clearTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)configTimer {
    [self clearTimer];
    _timer = [NSTimer timerWithTimeInterval:self.timeInterval target:[HFWeakObject weakObjectOfTarget:self] selector:@selector(timerAction) userInfo:nil repeats:self.repeat];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    if (self.fireNow) {
        [_timer fire];
    }
}

- (void)timerAction {
    if (self.timerBlock) {
        self.timerBlock(self, (CFAbsoluteTimeGetCurrent() - self.startTime));
    }
}

@end

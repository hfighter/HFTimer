//
//  HFGCDTimer.h
//  HFTimer
//
//  Created by hui hong on 2019/1/29.
//  Copyright © 2019 hui hong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HFGCDTimer;
typedef void(^HFGCDTimerBlock) (HFGCDTimer *timer, NSTimeInterval timeInterval);

@interface HFGCDTimer : NSObject

+ (instancetype)timerWithTimerInterval:(NSTimeInterval)timeInterval fireNow:(BOOL)fireNow timerBlock:(HFGCDTimerBlock)timerBlock;
- (void)startTimer;
- (void)stopTimer;

@end


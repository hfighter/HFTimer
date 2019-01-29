//
//  HFTimer.h
//  HFTimer
//
//  Created by hui hong on 2019/1/29.
//  Copyright © 2019 hui hong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HFTimer;
typedef void(^HFTimerBlock) (HFTimer *timer, NSTimeInterval interval);

/**
 不用关注循环引用问题
 */
@interface HFTimer : NSObject

@property (nonatomic, assign) BOOL isTimerStart;

- (instancetype)initTimerWithTimeInterval:(NSTimeInterval)timerInterval
                                   repeat:(BOOL)repeat
                                  fireNow:(BOOL)fireNow
                               timerBlock:(HFTimerBlock)timerBlock;

@end


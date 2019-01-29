//
//  ViewController.m
//  HFTimer
//
//  Created by hui hong on 2019/1/29.
//  Copyright © 2019 hui hong. All rights reserved.
//

#import "ViewController.h"
#import "HFTimer.h"
#import "HFDisplayLink.h"
#import "HFGCDTimer.h"

@interface ViewController ()

@property (nonatomic, strong) HFTimer *timer;
@property (nonatomic, strong) HFDisplayLink *displayLink;
@property (nonatomic, strong) HFGCDTimer *gcdTimer;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    self.timer = [[HFTimer alloc] initTimerWithTimeInterval:1 repeat:YES fireNow:NO timerBlock:^(HFTimer *timer, NSTimeInterval interval) {
//        NSLog(@"timer interval is %@", @(interval));
////        NSLog(@"timer interval is %f", interval);
////        timer.isTimerStart = NO;
//    }];
//    self.timer.isTimerStart = YES;
    
//    self.displayLink = [HFDisplayLink displayLinkOfFrameInterval:60 displayLinkBlock:^(HFDisplayLink *displayLink) {
//        NSLog(@"---HFDisplayLink---");
//    }];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.displayLink removeDisplayLink];
//    });
    
    self.gcdTimer = [HFGCDTimer timerWithTimerInterval:1 fireNow:YES
                                            timerBlock:^(HFGCDTimer *timer, NSTimeInterval timeInterval) {
        NSLog(@"timeInterval is %@, is main thread %@", @(timeInterval), @([NSThread isMainThread]));
    }];
    [self.gcdTimer startTimer];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.gcdTimer stopTimer];
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.gcdTimer startTimer];
    });
}

@end

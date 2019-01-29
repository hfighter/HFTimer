//
//  HFDisplayLink.m
//  HFTimer
//
//  Created by hui hong on 2019/1/29.
//  Copyright © 2019 hui hong. All rights reserved.
//

#import "HFDisplayLink.h"
#import "HFWeakObject.h"

@interface HFDisplayLink ()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, copy) HFDisplayLinkBlock displayLinkBlock;
@property (nonatomic, assign) NSInteger frameInterval;

@end

@implementation HFDisplayLink

- (void)dealloc {
    [self removeDisplayLink];
}

+ (instancetype)displayLinkOfFrameInterval:(NSInteger)frameInterval displayLinkBlock:(HFDisplayLinkBlock)displayLinkBlock {
    HFDisplayLink *displayLink = [HFDisplayLink new];
    displayLink.frameInterval = frameInterval;
    displayLink.displayLinkBlock = displayLinkBlock;
    [displayLink configDisplayLink];
    return displayLink;
}

- (void)removeDisplayLink {
    if (_displayLink) {
        [_displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        [_displayLink invalidate];
        _displayLink = nil;
    }
}

#pragma mark - private methods

- (void)configDisplayLink {
    [self removeDisplayLink];
    _displayLink = [CADisplayLink displayLinkWithTarget:[HFWeakObject weakObjectOfTarget:self] selector:@selector(displayLinkAction)];
    if ([_displayLink respondsToSelector:@selector(setPreferredFramesPerSecond:)]) {
        _displayLink.preferredFramesPerSecond = self.frameInterval;
    } else {
        _displayLink.frameInterval = self.frameInterval;
    }
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)displayLinkAction {
    if (self.displayLinkBlock) {
        self.displayLinkBlock(self);
    }
}

@end

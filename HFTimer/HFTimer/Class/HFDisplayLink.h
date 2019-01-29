//
//  HFDisplayLink.h
//  HFTimer
//
//  Created by hui hong on 2019/1/29.
//  Copyright © 2019 hui hong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HFDisplayLink;
typedef void(^HFDisplayLinkBlock) (HFDisplayLink *displayLink);

/**
 不用关注循环引用问题
 */
@interface HFDisplayLink : NSObject

+ (instancetype)displayLinkOfFrameInterval:(NSInteger)frameInterval displayLinkBlock:(HFDisplayLinkBlock)displayLinkBlock;
- (void)removeDisplayLink;

@end


//
//  HFWeakObject.m
//  HFTimer
//
//  Created by hui hong on 2019/1/29.
//  Copyright © 2019 hui hong. All rights reserved.
//

#import "HFWeakObject.h"

@interface HFWeakObject ()

@property (nonatomic, weak, readwrite) id target;

@end

@implementation HFWeakObject

+ (instancetype)weakObjectOfTarget:(id)target {
    HFWeakObject *weakObj = [HFWeakObject new];
    weakObj.target = target;
    return weakObj;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return self.target;
}

@end

//
//  HFWeakObject.h
//  HFTimer
//
//  Created by hui hong on 2019/1/29.
//  Copyright © 2019 hui hong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HFWeakObject : NSObject

@property (nonatomic, weak, readonly) id target;
+ (instancetype)weakObjectOfTarget:(id)target;

@end

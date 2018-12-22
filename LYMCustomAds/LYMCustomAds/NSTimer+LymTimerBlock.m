//
//  NSTimer+LymTimerBlock.m
//  LYMCustomAds
//
//  Created by 李艳敏 on 2018/12/22.
//  Copyright © 2018年 李艳敏. All rights reserved.
//

#import "NSTimer+LymTimerBlock.h"

@implementation NSTimer (LymTimerBlock)
+ (NSTimer *)jmScheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      repeats:(BOOL)repeats
                                     callback:(LYMVoidBlock)callback {
    return [NSTimer scheduledTimerWithTimeInterval:interval
                                            target:self
                                          selector:@selector(onTimerUpdateBlock:)
                                          userInfo:[callback copy]
                                           repeats:repeats];
}

+ (void)onTimerUpdateBlock:(NSTimer *)timer {
    LYMVoidBlock block = timer.userInfo;
    if (block) {
        block();
    }
}
@end

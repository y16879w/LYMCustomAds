//
//  NSTimer+LymTimerBlock.h
//  LYMCustomAds
//
//  Created by 李艳敏 on 2018/12/22.
//  Copyright © 2018年 李艳敏. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^LYMVoidBlock)(void);
@interface NSTimer (LymTimerBlock)
+ (NSTimer *)jmScheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      repeats:(BOOL)repeats
                                     callback:(LYMVoidBlock)callback;
@end

NS_ASSUME_NONNULL_END

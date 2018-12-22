//
//  LYMAutoRollingMessageView.h
//  LYMCustomAds
//
//  Created by 李艳敏 on 2018/12/22.
//  Copyright © 2018年 李艳敏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYMMessageRollCell.h"

@class LYMAutoRollingMessageView;
@protocol LYMAutoRollingMessageViewDataSource <NSObject>
@required
- (NSInteger)numberOfRowsForRollingMessageView:(LYMAutoRollingMessageView *)rollingView;
- (LYMMessageRollCell *)rollingMessageView:(LYMAutoRollingMessageView *)rollingView cellAtIndex:(NSUInteger)index;

@end

@protocol LYMAutoRollingMessageViewDelegate <NSObject>

@optional
- (void)didClickRollingMessageView:(LYMAutoRollingMessageView *)rollingView forIndex:(NSUInteger)index;

@end

@interface LYMAutoRollingMessageView : UIView
@property (nonatomic, weak)id<LYMAutoRollingMessageViewDelegate>delegate;
@property (nonatomic, weak)id<LYMAutoRollingMessageViewDataSource>dataSource;
/**
 停留时长 默认3秒
 */
@property (nonatomic, assign)NSTimeInterval stayInterval;

/**
 当前cell
 */
@property (nonatomic, assign,readonly)int currentIndex;

/**
 注册cell

 @param cellClass cell的类
 @param identifier 标识
 */
- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(nonnull NSString *)identifier;
- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier;
- (__kindof LYMMessageRollCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;

/**
 刷新数据
 */
- (void)reloadDataAndStartRoll;

/**
 停止滚动
 */
- (void)stopRoll;
@end


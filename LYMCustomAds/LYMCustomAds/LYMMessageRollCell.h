//
//  LYMMessageRollCell.h
//  LYMCustomAds
//
//  Created by 李艳敏 on 2018/12/22.
//  Copyright © 2018年 李艳敏. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYMMessageRollCell : UIView
@property (nonatomic, readonly, strong)UIView *contentView;
@property (nonatomic, readonly, strong) UILabel *textLabel;
@property (nonatomic, readonly, copy)NSString *reuseIdentifier;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END

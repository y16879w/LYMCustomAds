//
//  LYMMessageRollCell.m
//  LYMCustomAds
//
//  Created by 李艳敏 on 2018/12/22.
//  Copyright © 2018年 李艳敏. All rights reserved.
//

#import "LYMMessageRollCell.h"

@implementation LYMMessageRollCell
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _reuseIdentifier = reuseIdentifier;
        [self setupInitialUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

- (void)setupInitialUI
{
    self.backgroundColor = [UIColor whiteColor];
    _contentView = [[UIView alloc] init];
    [self addSubview:_contentView];
    
    _textLabel = [[UILabel alloc]init];
    [_contentView addSubview:_textLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _contentView.frame = self.bounds;
    _textLabel.frame = CGRectMake(10, 0, self.frame.size.width - 20, self.frame.size.height);
}

- (void)dealloc {
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

//
//  LYMAutoRollingMessageView.m
//  LYMCustomAds
//
//  Created by 李艳敏 on 2018/12/22.
//  Copyright © 2018年 李艳敏. All rights reserved.
//

#import "LYMAutoRollingMessageView.h"
#import "NSTimer+LymTimerBlock.h"

@interface LYMAutoRollingMessageView ()

@property (nonatomic, strong)NSMutableDictionary *cellClassDicts;
@property (nonatomic, strong)NSMutableArray *reuseCells;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, strong)LYMMessageRollCell *currentCell;
@property (nonatomic, strong)LYMMessageRollCell *willShowCell;
@property (nonatomic, assign)BOOL isAnimating;

@end

@implementation LYMAutoRollingMessageView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setAdsViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setAdsViews];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setAdsViews];
    }
    return self;
}

- (void)setAdsViews {
    self.clipsToBounds = YES;
    _stayInterval = 3;
    [self addGestureRecognizer:[self createTapGesture]];
}


- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier {
    [self.cellClassDicts setObject:NSStringFromClass(cellClass) forKey:identifier];
}
- (void)registerNib:(UINib *)nib forCellReuseIdentifier:(NSString *)identifier
{
    [self.cellClassDicts setObject:nib forKey:identifier];
}

- (__kindof LYMMessageRollCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier {
    for (LYMMessageRollCell *cell in self.reuseCells) {
        if ([cell.reuseIdentifier isEqualToString:identifier]) {
            return cell;
        }
    }
    id cellClass = self.cellClassDicts[identifier];
    if ([cellClass isKindOfClass:[UINib class]]) {
        UINib *nib = (UINib *)cellClass;
        
        NSArray *arr = [nib instantiateWithOwner:nil options:nil];
        LYMMessageRollCell *cell = [arr firstObject];
        [cell setValue:identifier forKeyPath:@"reuseIdentifier"];
        return cell;
    }else
    {
        Class cellCls = NSClassFromString(self.cellClassDicts[identifier]);
        LYMMessageRollCell *cell = [[cellCls alloc] initWithReuseIdentifier:identifier];
        return cell;
    }
}

#pragma mark action

- (void)stopRoll {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    _isAnimating = NO;
    _currentIndex  = 0;
    [_currentCell removeFromSuperview];
    [_willShowCell removeFromSuperview];
    _currentCell = nil;
    _willShowCell = nil;
    [self.reuseCells removeAllObjects];
}

- (void)reloadDataAndStartRoll {
    [self stopRoll];
    [self layoutCurrentCellAndWillShowCell];
    NSInteger count = [self.dataSource numberOfRowsForRollingMessageView:self];
    if (count && count < 2) {
        return;
    }
    __weak typeof(self) weakSelf = self;
    _timer = [NSTimer scheduledTimerWithTimeInterval:_stayInterval repeats:YES block:^(NSTimer * _Nonnull timer) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.isAnimating) {
            return;
        }
        [strongSelf layoutCurrentCellAndWillShowCell];
        _currentIndex++;
        CGFloat w = strongSelf.frame.size.width;
        CGFloat h = strongSelf.frame.size.height;
        strongSelf.isAnimating = YES;
        [UIView animateWithDuration:0.5 animations:^{
            strongSelf.currentCell.frame = CGRectMake(0, -h, w, h);
            strongSelf.willShowCell.frame = CGRectMake(0, 0, w, h);
        } completion:^(BOOL finished) {
            if (strongSelf.currentCell && strongSelf.willShowCell) {
                [strongSelf.reuseCells addObject:strongSelf.currentCell];
                [strongSelf.currentCell removeFromSuperview];
                strongSelf.currentCell = strongSelf.willShowCell;
            }
            strongSelf.isAnimating = NO;
        }];
    }];
}

- (void)layoutCurrentCellAndWillShowCell {
    int count = (int)[self.dataSource numberOfRowsForRollingMessageView:self];
    if (_currentIndex > count - 1) {
        _currentIndex = 0;
    }
    NSInteger willShowIndex = _currentIndex +1;
    if (willShowIndex > count - 1) {
        willShowIndex = 0;
    }
    float w = self.frame.size.width;
    float h = self.frame.size.height;
    if (!_currentCell) {
        _currentCell = [self.dataSource rollingMessageView:self cellAtIndex:_currentIndex];
        _currentCell.frame  = CGRectMake(0, 0, w, h);
        [self addSubview:_currentCell];
        return;
    }

    _willShowCell = [self.dataSource rollingMessageView:self cellAtIndex:willShowIndex];
    _willShowCell.frame = CGRectMake(0, h, w, h);
    [self addSubview:_willShowCell];
    
    [self.reuseCells removeObject:_currentCell];
    [self.reuseCells removeObject:_willShowCell];
}

- (UITapGestureRecognizer *)createTapGesture {
    return [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleCellTapAction)];
}

- (void)handleCellTapAction {
    int count = (int)[self.dataSource numberOfRowsForRollingMessageView:self];
    if (_currentIndex > count) {
        _currentIndex = 0;
    }
    if ([self.delegate respondsToSelector:@selector(didClickRollingMessageView:forIndex:)]) {
        [self.delegate didClickRollingMessageView:self forIndex:_currentIndex];
    }
}
#pragma mark -lazy
- (NSMutableDictionary *)cellClassDicts {
    if (_cellClassDicts == nil) {
        _cellClassDicts = [[NSMutableDictionary alloc]init];
    }
    return _cellClassDicts;
}

- (NSMutableArray *)reuseCells {
    if (_reuseCells == nil) {
        _reuseCells = [[NSMutableArray alloc]init];
    }
    return _reuseCells;
}
@end

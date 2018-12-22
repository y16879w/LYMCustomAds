//
//  ViewController.m
//  LYMCustomAds
//
//  Created by 李艳敏 on 2018/12/22.
//  Copyright © 2018年 李艳敏. All rights reserved.
//

#import "ViewController.h"
#import "LYMAutoRollingMessageView.h"
#import "LYMMessageRollCell.h"
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXR ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXSM ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneXR1 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1624), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhoneSafeArea (iPhoneX || iPhoneXR || iPhoneXSM || iPhoneXR1)
#define NavigationBarHeight (iPhoneSafeArea ? 88 : 64)
@interface ViewController ()<LYMAutoRollingMessageViewDelegate,LYMAutoRollingMessageViewDataSource>
@property (nonatomic, strong)NSArray *dataResources;
@property (nonatomic, strong) LYMAutoRollingMessageView *noticeView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LYMAutoRollingMessageView *noticeView = [[LYMAutoRollingMessageView alloc]initWithFrame:CGRectMake(100,NavigationBarHeight, 200, 30)];
    noticeView.dataSource = self;
    noticeView.delegate = self;
    [self.view addSubview:noticeView];
    [noticeView registerClass:[LYMMessageRollCell class] forCellReuseIdentifier:@"LYMMessageRollCell"];
    [noticeView reloadDataAndStartRoll];
    noticeView.backgroundColor = [UIColor lightGrayColor];
    self.noticeView = noticeView;
    self.dataResources = @[@"不负青春不负我1",
                           @"生命在于拼搏2",
                           @"不负青春不负我3",
                           @"生命在于拼搏4",
                           ];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.noticeView stopRoll];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.noticeView reloadDataAndStartRoll];
}


#pragma mark dataSources & delegate
- (NSInteger)numberOfRowsForRollingMessageView:(LYMAutoRollingMessageView *)rollingView{
    return self.dataResources.count;
}

- (void)didClickRollingNoticeView:(LYMAutoRollingMessageView *)rollingView forIndex:(NSUInteger)index
{
    NSLog(@"点击的index: %lu", (unsigned long)index);
}
- (LYMMessageRollCell *)rollingMessageView:(LYMAutoRollingMessageView *)rollingView cellAtIndex:(NSUInteger)index{
    LYMMessageRollCell *cell = [rollingView dequeueReusableCellWithIdentifier:@"LYMMessageRollCell"];
    cell.textLabel.text = self.dataResources[index];
    cell.contentView.backgroundColor = [UIColor greenColor];
    return cell;
}
@end

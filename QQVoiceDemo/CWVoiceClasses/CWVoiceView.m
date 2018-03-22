//
//  CWVoiceView.m
//  QQVoiceDemo
//
//  Created by TK on 2017/9/2.
//  Copyright © 2017年 TK. All rights reserved.
//

#import "CWVoiceView.h"
#import "UIView+CWChat.h"
#import "CWRecordView.h"

@interface CWVoiceView ()<UIScrollViewDelegate>

@property (nonatomic,weak) UIScrollView *contentScrollView; // 承载内容的视图
@property (nonatomic,weak) CWRecordView *recordView;        // 录音视图
@property (nonatomic,weak) UIView *smallCirle; // 蓝色小圆点
@property (nonatomic,weak) UIView *bottomView; // 下方（变声、对讲、录音）的view

@property (nonatomic,strong) NSArray *bottomsLabels; // bottomView上的标签数组
@property (nonatomic,weak) UILabel *selectLabel;    // 当前选中的label

@end

@implementation CWVoiceView
{
    CGFloat _labelDistance;
    CGPoint _currentContentOffSize;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    // 设置内容滚动视图
    [self contentScrollView];

    // 设置录音界面
    [self recordView];

    // 设置下方三个标签界面
    [self bottomView];
    // 设置标志小圆点
    [self setupSmallCircleView];
    
    _currentContentOffSize = CGPointMake(self.cw_width, 0);
   
}

- (void)setupSelectLabel:(UILabel *)label {
    _selectLabel.textColor = kNormalBackGroudColor;
    label.textColor = kSelectBackGroudColor;
    _selectLabel = label;
}

#pragma mark - subviews
- (UIScrollView *)contentScrollView {
    if (_contentScrollView == nil) {
        UIScrollView *scrollV = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.cw_width, self.cw_height)];
        scrollV.pagingEnabled = YES;
        scrollV.contentSize = CGSizeMake(self.cw_width, 0);
        scrollV.contentOffset = CGPointMake(self.cw_width, 0);
        scrollV.showsHorizontalScrollIndicator = NO;
        scrollV.delegate = self;
        [self addSubview:scrollV];
        _contentScrollView = scrollV;
    }
    return _contentScrollView;
}

- (CWRecordView *)recordView {
    if (_recordView == nil) {
        CWRecordView *recordView = [[CWRecordView alloc] initWithFrame:CGRectMake(self.cw_width , 0, self.cw_width, self.contentScrollView.cw_height)];
        [self.contentScrollView addSubview:recordView];
        _recordView = recordView;
    }
    return _recordView;
}

- (UIView *)bottomView {
    if (_bottomView == nil) {
        UIView *bottomV = [[UIView alloc] initWithFrame:CGRectMake(0, self.cw_height - 45, self.cw_width, 25)];
        [self addSubview:bottomV];

        _bottomView = bottomV;
        [self setupBottomViewSubviews];
    }
    return _bottomView;
}

- (void)setupBottomViewSubviews {
    NSArray *titleArr = @[@"录音"];
    
    UILabel *recordLabel = [self labelWithText:titleArr[0]];
    recordLabel.center = CGPointMake(self.bottomView.cw_width / 2.0, self.bottomView.cw_height / 2.0);
    [self.bottomView addSubview:recordLabel];
    
    self.bottomsLabels = @[recordLabel];
}

- (UILabel *)labelWithText:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = text;
    label.textColor = kNormalBackGroudColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    [label sizeToFit];
    return label;
}

- (void)setupSmallCircleView {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 8)];
    view.backgroundColor = kSelectBackGroudColor;
    view.layer.cornerRadius = view.cw_width / 2.0;
    view.center = CGPointMake(self.cw_width / 2.0, self.bottomView.cw_top - view.cw_height / 2.0);
    [self addSubview:view];
    self.smallCirle = view;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat scrollDistance = scrollView.contentOffset.x - _currentContentOffSize.x;
    CGFloat transtionX = scrollDistance / self.contentScrollView.cw_width * _labelDistance;
    self.bottomView.transform = CGAffineTransformMakeTranslation(-transtionX, 0);
    
}

#pragma mark - setter
- (void)setState:(CWVoiceState)state {
    _state = state;
    self.bottomView.hidden = state != CWVoiceStateDefault;
    self.smallCirle.hidden = state != CWVoiceStateDefault;
    self.contentScrollView.scrollEnabled = state == CWVoiceStateDefault;
}

@end












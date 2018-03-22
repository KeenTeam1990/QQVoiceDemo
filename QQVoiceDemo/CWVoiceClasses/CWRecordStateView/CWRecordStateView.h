//
//  CWRecordStateView.h
//  QQVoiceDemo
//
//  Created by TK on 2017/9/2.
//  Copyright © 2017年 TK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CWSington.h"

typedef NS_ENUM(NSInteger,CWRecordState) {
    CWRecordStateDefault = 0,       // 按住说话
    CWRecordStateClickRecord,       // 点击录音
    CWRecordStateTouchChangeVoice,  // 按住变声
    CWRecordStateListen ,           // 试听
    CWRecordStateCancel,            // 取消
    CWRecordStateSend,              // 发送
    CWRecordStatePrepare,           // 准备中
    CWRecordStateRecording,         // 录音中
    CWRecordStatePreparePlay,       // 准备播放
    CWRecordStatePlay               // 播放
} ;



@interface CWRecordStateView : UIView

@property (nonatomic,assign) CWRecordState recordState; // 录音状态

@property (nonatomic,copy) void(^playProgress)(CGFloat progress);

// 开始录音
- (void)beginRecord;

// 结束录音
- (void)endRecord;

@end
//
//  PF_RecordingManage.h
//  BeautyProjectDemo
//  视频录制管理器
//  Created by 单小飞 on 2018/7/7.
//  Copyright © 2018年 luchenxiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GPUImageBeautifyFilter.h"
#import "GPUImage.h"
#import "PF_FilterView.h"


typedef NS_ENUM(NSUInteger, PF_RecordingManageCameraType) {
    PF_RecordingManageCameraTypeFront = 0,
    PF_RecordingManageCameraTypeBack,
};


@protocol PF_RecordingManageProtocol <NSObject>


/** 开始录制 */
-(void)didStartRecordVideo;

/** 视频压缩中 */
-(void)didCompressingVideo;

/** 结束录制 */
-(void)didEndRecordVideoWithTime:(CGFloat)totalTime outputFile:(NSString *)filePath;



@end


@interface PF_RecordingManage : NSObject

/** 代理 */
@property (nonatomic,weak) id <PF_RecordingManageProtocol> delegate;

/** 录制视频区域 */
@property (nonatomic,assign) CGRect frame;

/** 录制视频最大时长 */
@property (nonatomic,assign) CGFloat maxTime;

/**
 录制视频单例,若工程中不止一处用到录视频，尺寸有变，直接实例化即可 忽略此方法
 
 @return self
 */
+(instancetype)manager;

/**
 加载到显示的视图上
 @param frame  父视图中的frame
 @param superView 父视图
 */
-(void)showWithFrame:(CGRect)frame superView:(UIView *)superView;


/**
 关闭美颜功能
 */
-(void)closeBeauty;

/**
 打卡美颜功能
 */
-(void)openBeauty;


/**
 磨皮效果 默认4.0。数值越小 效果越好
 */
-(void)bilateralFilterWithLeaveNumber:(CGFloat)num;


/**
 切换滤镜
 */
-(void)switchCameraFilter;

/**
 添加滤镜
 */
-(void)addCameraFilter;

//饱和度
-(void)adjustSaturation:(CGFloat)num;
//亮度
-(void)adjustBrightness:(CGFloat)num;


/**
 开始录制
 */
-(void)startRecording;


/**
 结束录制
 */
-(void)endRecording;


/**
 暂停录制
 */
-(void)pauseRecording;


/**
 继续录制
 */
-(void)resumeRecording;

/**
 切换前后摄像头
 @param type PF_RecordingManageCameraTypeFront 为 前置
 */
-(void)changeCameraPosition:(PF_RecordingManageCameraType)type;


/**
 打开闪光灯
 @param on YES开  NO关
 */
-(void)turnTorchOn:(BOOL)on;
@end

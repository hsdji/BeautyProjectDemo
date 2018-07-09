//
//  RecordingViewController.m
//  BeautyProjectDemo
//
//  Created by 单小飞 on 2018/7/7.
//  Copyright © 2018年 luchenxiao. All rights reserved.
//


#define LMWID [UIScreen mainScreen].bounds.size.width
#define LMHEI [UIScreen mainScreen].bounds.size.height

#import "RecordingViewController.h"


@interface RecordingViewController ()<PF_RecordingManageProtocol,UIGestureRecognizerDelegate>{
    NSString *_filePath;
    UIButton *btn;//录制按钮
}

/** 视频播放视图 */
@property (nonatomic,strong) UIView *videoView;

@property (nonatomic,strong) AVPlayerViewController *player;

/** manager */
@property (nonatomic,strong) PF_RecordingManage *manager;


@end

@implementation RecordingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    self.videoView = [[UIView alloc] initWithFrame:CGRectMake(10, LMHEI/2, LMWID-20, LMHEI/2)];
    self.videoView.userInteractionEnabled = YES;
    self.videoView.backgroundColor = [UIColor orangeColor];
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(swap)];
    recognizer.delegate = self;
//    [self.view addGestureRecognizer:recognizer];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!_manager) {
        _manager = [[PF_RecordingManage alloc] init];
        _manager.delegate = self;
       [_manager showWithFrame:CGRectMake(20, 120, LMWID-40, LMHEI/2-1) superView:self.view];
        _manager.maxTime = 60.0;
    }
}



#pragma --mark              PrivateMethod

-(void)recordBtnAction:(UIButton *)btn {
    if ([btn.titleLabel.text isEqualToString:@"录制视频"]) {
        [btn setTitle:@"暂停录制" forState:UIControlStateNormal];
         [_manager startRecording];
    }else if ([btn.titleLabel.text isEqualToString:@"暂停录制"]){
         [btn setTitle:@"继续录制" forState:UIControlStateNormal];
        [_manager pauseRecording];
    }else if ([btn.titleLabel.text isEqualToString:@"继续录制"]){
        [_manager resumeRecording];
    }
}

-(void)endRecording {
    [_manager endRecording];
    [btn setTitle:@"录制视频" forState:UIControlStateNormal];
}

-(void)playVideo {
    _player = [[AVPlayerViewController alloc] init];
    _player.player = [[AVPlayer alloc] initWithURL:[NSURL fileURLWithPath:_filePath]];
    _player.videoGravity = AVLayerVideoGravityResize;
    [self presentViewController:_player animated:NO completion:nil];
}

- (void)swap{
    [_manager changeCameraPosition:PF_RecordingManageCameraTypeFront];
}

-(void)change:(UISlider *)sender{
    [_manager bilateralFilterWithLeaveNumber:sender.value];
}

-(void)change2:(UISlider *)sender{
    [_manager adjustBrightness:sender.value];
}

-(void)change3:(UISlider *)sender{
    [_manager adjustSaturation:sender.value];
}



- (void)changefilter{
    
}



- (void)closeBeauty:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (!sender.isSelected) {
        [sender setTitle:@"关闭美颜" forState:UIControlStateNormal];
        [_manager openBeauty];
    }else{
         [sender setTitle:@"打开美颜" forState:UIControlStateNormal];
        [_manager closeBeauty];
    }
    
}

#pragma --mark   PF_recoridingProtocol
-(void)didStartRecordVideo {
    
    NSLog(@"开始录制");
}

-(void)didCompressingVideo {
    
    NSLog(@"压缩视频");
    
}

-(void)didEndRecordVideoWithTime:(CGFloat)totalTime outputFile:(NSString *)filePath {
    
    NSLog(@"录制完毕,时长%f \n 路径%@",totalTime,filePath);
    _filePath = filePath;
    
}


- (void)dealloc
{
    NSLog(@"控制器销毁了");
}









#pragma --mark UILayout
- (void)setUpUI{
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"视频";
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 64, LMWID/2, 44);
    btn.backgroundColor = [UIColor yellowColor];
    [btn setTitle:@"录制视频" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(recordBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *stop = [UIButton buttonWithType:UIButtonTypeCustom];
    stop.backgroundColor = [UIColor redColor];
    [stop setTitle:@"停止录制" forState:UIControlStateNormal];
    [stop setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    stop.frame = CGRectMake(LMWID/2, 64, LMWID/2, 44);
    [stop addTarget:self action:@selector(endRecording) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stop];
    UIButton *play = [UIButton buttonWithType:UIButtonTypeCustom];
    play.frame = CGRectMake(0, LMHEI-60, LMWID, 50);
    [play setTitle:@"播放" forState:UIControlStateNormal];
    [play setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [play addTarget:self action:@selector(playVideo) forControlEvents:UIControlEventTouchUpInside];
    [play setBackgroundColor:[UIColor magentaColor]];
    [self.view addSubview:play];
    
    UIButton *changefilter = [[UIButton alloc] initWithFrame:CGRectMake(0, LMHEI-120, LMWID/2.0, 50)];
    [changefilter setTitle:@"切换滤镜" forState:UIControlStateNormal];
    [changefilter setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [changefilter addTarget:self action:@selector(changefilter) forControlEvents:UIControlEventTouchUpInside];
    [changefilter setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:changefilter];
    
    UIButton *closeBeautyBtn = [[UIButton alloc] initWithFrame:CGRectMake(LMWID/2.0, LMHEI-120, LMWID/2.0, 50)];
    [closeBeautyBtn setTitle:@"关闭美颜" forState:UIControlStateNormal];
    [closeBeautyBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [closeBeautyBtn addTarget:self action:@selector(closeBeauty:) forControlEvents:UIControlEventTouchUpInside];
    [closeBeautyBtn setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:closeBeautyBtn];
    
    UISlider *sli = [[UISlider alloc] initWithFrame:CGRectMake(20, LMHEI-150, LMWID-100,20)];
    sli.maximumValue = 500;
    sli.minimumValue = 0;
    sli.value = 4.0;
    sli.continuous = YES;
    [sli addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:sli];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(LMWID-80, LMHEI-150, 60, 20)];
    [lab setText:@"磨皮"];
    [self.view addSubview:lab];


    UISlider *sli2 = [[UISlider alloc] initWithFrame:CGRectMake(20, LMHEI-180, LMWID-100,20)];
    sli2.maximumValue = 2.0;
    sli2.minimumValue = 0.0;
    sli2.value = 1.1;
    sli2.continuous = YES;
    [sli2 addTarget:self action:@selector(change2:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:sli2];
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(LMWID-80, LMHEI-180, 60, 20)];
    [lab2 setText:@"亮度"];
    [self.view addSubview:lab2];

    UISlider *sli3 = [[UISlider alloc] initWithFrame:CGRectMake(20, LMHEI-200, LMWID-100,20)];
    sli3.maximumValue = 2.0;
    sli3.minimumValue = 0.0;
    sli3.value = 1.1;
    sli3.continuous = YES;
    [sli3 addTarget:self action:@selector(change3:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:sli3];
    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(LMWID-80, LMHEI-200, 60, 20)];
    [lab3 setText:@"饱和度"];
    [self.view addSubview:lab3];
    
}


@end

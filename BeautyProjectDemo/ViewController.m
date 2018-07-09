//
//  ViewController.m
//  BeautyProjectDemo
//
//  Created by 单小飞 on 2018/7/7.
//  Copyright © 2018年 luchenxiao. All rights reserved.
//。    

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//
    UIButton *btn  = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [btn setTitle:@"点击调起摄像头" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor cyanColor]];
    btn.frame = CGRectMake(100, 100, 200, 100);
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(pushNextController) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)pushNextController{
    
    [self presentViewController:[NSClassFromString(@"RecordingViewController") new] animated:YES completion:nil];
}

@end

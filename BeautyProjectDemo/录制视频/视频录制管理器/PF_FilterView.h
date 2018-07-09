//
//  PF_FilterView.h
//  BeautyProjectDemo
//
//  Created by 单小飞 on 2018/7/9.
//  Copyright © 2018年 luchenxiao. All rights reserved.
//

#import <GPUImage/GPUImage.h>


@protocol PF_FilterViewDelegate;

@interface PF_FilterView : UICollectionView <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) NSMutableArray *picArray;

@property (assign, nonatomic) id <PF_FilterViewDelegate> filterDelegate;

@end

@protocol PF_FilterViewDelegate <NSObject>

- (void)switchCameraFilter:(NSInteger)index;
@end




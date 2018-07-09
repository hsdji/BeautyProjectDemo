//
//  GPUImageBeautifyFilter.h
//  BeautifyFaceDemo
//
//  Created by guikz on 16/4/28.
//  Copyright © 2016年 guikz. All rights reserved.
//

#import "GPUImage.h"

@class GPUImageCombinationFilter;

@interface GPUImageBeautifyFilter : GPUImageFilterGroup {
    GPUImageBilateralFilter *bilateralFilter;//磨皮
    GPUImageCannyEdgeDetectionFilter *cannyEdgeFilter;//美白
    GPUImageCombinationFilter *combinationFilter;
    GPUImageHSBFilter *hsbFilter;
}
//磨皮
-(void)changeBilateralFilterValue:(CGFloat)num;
//饱和度
-(void)adjustSaturation:(CGFloat)num;
//亮度
-(void)adjustBrightness:(CGFloat)num;
@end


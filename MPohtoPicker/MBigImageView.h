//
//  MBigImageView.h
//  MPohtoPicker
//
//  Created by mark on 15/7/21.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MConfigurationFiles.h"
@interface MBigImageView : UIView
@property (nonatomic, assign) CGFloat minimumZoomScale;
@property (nonatomic, assign) CGFloat maximumZoomScale;
@property (nonatomic, strong) UIImage *image;
- (void)updateLocationImage:(id)img fentchBlock:(MReturnFentchBlock)fentchBlock;
- (void)updateWebImage:(id)urlStr placeIma:(UIImage *)placeIma fentchBlock:(MReturnFentchBlock)fentchBlock;
@end

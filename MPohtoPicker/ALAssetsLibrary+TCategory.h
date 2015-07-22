//
//  ALAssetsLibrary+TCategory.h
//  TBasicLib
//
//  Created by mark on 14-12-12.
//  Copyright (c) 2014年 233. All rights reserved.
//

#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIImage.h>

typedef void(^SaveImageCompletion)(NSError* error);

@interface ALAssetsLibrary (TCategory)

/**
 *  保存照片到相册
 *
 *  @param image           图片
 *  @param albumName       相册名称
 *  @param completionBlock 完成回调的block
 */
-(void)saveImage:(UIImage*)image toAlbum:(NSString*)albumName withCompletionBlock:(SaveImageCompletion)completionBlock;

/**
 *  保存一张图片到照片库
 *
 *  @param assetURL        照片链接
 *  @param albumName       相框名称
 *  @param completionBlock 完成后的回调block
 */
-(void)addAssetURL:(NSURL*)assetURL toAlbum:(NSString*)albumName withCompletionBlock:(SaveImageCompletion)completionBlock;

@end

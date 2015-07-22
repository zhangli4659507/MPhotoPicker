//
//  ALAssetsLibrary+TCategory.m
//  TBasicLib
//
//  Created by kevin.huang on 14-10-9.
//  Copyright (c) 2014年 binxun. All rights reserved.
//

#import "ALAssetsLibrary+TCategory.h"

@implementation ALAssetsLibrary (TCategory)

-(void)saveImage:(UIImage*)image toAlbum:(NSString*)albumName withCompletionBlock:(SaveImageCompletion)completionBlock
{
    [self writeImageToSavedPhotosAlbum:image.CGImage orientation:(ALAssetOrientation)image.imageOrientation completionBlock:^(NSURL* assetURL, NSError* error) {
        
        if (error!=nil) {
            completionBlock(error);
            return;
        }
        
        [self addAssetURL:assetURL toAlbum:albumName withCompletionBlock:completionBlock];
        
    }];
    
}

-(void)addAssetURL:(NSURL*)assetURL toAlbum:(NSString*)albumName withCompletionBlock:(SaveImageCompletion)completionBlock{
    
    __block BOOL albumWasFound = NO;
    
    [self enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        
        if ([albumName compare: [group valueForProperty:ALAssetsGroupPropertyName]]==NSOrderedSame) {
            
            albumWasFound = YES;
            [self assetForURL: assetURL
                  resultBlock:^(ALAsset *asset) {
                      [group addAsset: asset];
                      completionBlock(nil);
                  } failureBlock: completionBlock];
            return;
            
        }
        
        if (group==nil && albumWasFound==NO) {
            __weak ALAssetsLibrary* weakSelf = self;
            [self addAssetsGroupAlbumWithName:albumName resultBlock:^(ALAssetsGroup *group) {
                [weakSelf assetForURL: assetURL resultBlock:^(ALAsset *asset) {
                    [group addAsset: asset];
                    completionBlock(nil);
                } failureBlock: completionBlock];
                
            } failureBlock: completionBlock];
            
            return;
        }
    } failureBlock: completionBlock];
    
}

@end

//
//  MAllPtotoIma.h
//  MPohtoPicker
//
//  Created by mark on 15/7/20.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>
#import "ALAssetsLibrary+TCategory.h"
typedef void (^photoBlock) (NSMutableArray *arrIma);
typedef void (^erroBlock) (NSError *error);


@interface ModelImaGroup : NSObject
@property (nonatomic, strong) NSMutableArray *arrIma;
@property (nonatomic, assign) NSInteger numImas;
@property (nonatomic, strong) UIImage *posterIma;
@property (nonatomic, strong) NSString *groupTitle;
@end

@interface ModelIma : NSObject
@property (nonatomic, strong) UIImage *thumIma;
@property (nonatomic, strong) UIImage *fullIma;
@property (nonatomic, assign) NSUInteger size;
@end

@interface MAllPtotoIma : NSObject
+ (void)getAllImaGroupFromLibaryBlock:(photoBlock)block withFailureBlock:(erroBlock)errorBlock;

+ (void)getallImaFromGroup:(ALAssetsGroup *)group objBlock:(photoBlock)block  ;

+ (ModelImaGroup *)getModelImaGroupWithGroup:(ALAssetsGroup *)group;

+ (ModelIma *)getModekImaWithAlaset:(ALAsset *)set;

+ (void)saveImage:(UIImage*)image toAlbum:(NSString*)albumName withCompletionBlock:(SaveImageCompletion)completionBlock;

@end

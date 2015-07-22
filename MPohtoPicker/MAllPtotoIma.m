//
//  MAllPtotoIma.m
//  MPohtoPicker
//
//  Created by mark on 15/7/20.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MAllPtotoIma.h"

#import <AssetsLibrary/AssetsLibrary.h>


@implementation ModelIma



@end

@implementation ModelImaGroup

- (instancetype)init{

    if (self = [super init]) {
        
        self.arrIma = [NSMutableArray array];
    }
    return self;
}



@end

@implementation MAllPtotoIma


+ (ModelImaGroup *)getModelImaGroupWithGroup:(ALAssetsGroup *)group{

    ModelImaGroup *groupModel = [[ModelImaGroup alloc] init];
    groupModel.groupTitle = [group valueForProperty:ALAssetsGroupPropertyName];
    groupModel.numImas = group.numberOfAssets;
    groupModel.posterIma = [UIImage imageWithCGImage:group.posterImage];
    return groupModel;
}

+(ModelIma *)getModekImaWithAlaset:(ALAsset *)result{

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
    });
    ALAssetRepresentation *sention = result.defaultRepresentation;
    ModelIma *model = [[ModelIma alloc] init];
    model.thumIma = [UIImage imageWithCGImage:[result thumbnail]];
//    model.fullIma = [UIImage imageWithCGImage:sention.fullResolutionImage];//全尺寸图片
    model.size = (NSUInteger)sention.size;
    return model;
}

+ (void)saveImage:(UIImage*)image toAlbum:(NSString*)albumName withCompletionBlock:(SaveImageCompletion)completionBlock{

    ALAssetsLibrary *lib = [self defaultAssetsLibrary];
    [lib saveImage:image toAlbum:albumName withCompletionBlock:completionBlock];
    
}

+ (void)getAllImaGroupFromLibaryBlock:(photoBlock)block withFailureBlock:(erroBlock)errorBlock{

    NSMutableArray *arrGroup = [[NSMutableArray alloc] init];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    
        
        ALAssetsLibraryGroupsEnumerationResultsBlock groupBlock = ^(ALAssetsGroup *group,BOOL *stop){
        
            if (group) {
                [arrGroup addObject:group];
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{

                    !block ?: block(arrGroup );
                });
            }
        };
        
        ALAssetsLibraryAccessFailureBlock failureBlock = ^(NSError *error){
            !errorBlock ?: errorBlock([error copy]);
        };
        ALAssetsLibrary *lib =[self defaultAssetsLibrary];
        [lib enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:groupBlock failureBlock:failureBlock];

        
    });
}


+ (ALAssetsLibrary *)defaultAssetsLibrary {
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}


+ (void)getallImaFromGroup:(ALAssetsGroup *)group objBlock:(photoBlock)block{
    NSMutableArray *arrGroup = [NSMutableArray array];
    [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            [arrGroup addObject:result];
        }else{
            !block ?:block(arrGroup);
        }
    }];

}

@end

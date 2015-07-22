//
//  MBigImaCollectionView.h
//  MPohtoPicker
//
//  Created by mark on 15/7/21.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MConfigurationFiles.h"
typedef enum {
    imaFromLocation = 1,//浏览本地图片
    imaFromWeb = 2//浏览网络图片
    
}imaFromType;

@interface MBigImaCollectionView : UIView


//传入的数组中元素浏览本地图片时为UIImage 网络图片时为地址链接的NSString fentchBlock为nil  当数组中的元素不为指定类型时  可以通过fentchBlock处理 
- (void)updateImaArr:(NSArray *)arrImas fentchBlock:(MReturnFentchBlock)fentchBlock imaFromType:(imaFromType)fromType;


@end

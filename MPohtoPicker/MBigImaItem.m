//
//  MBigImaItem.m
//  MPohtoPicker
//
//  Created by mark on 15/7/21.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MBigImaItem.h"

@implementation MBigImaItem


- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        _imavBig = [[MBigImageView alloc] initWithFrame:self.bounds];
        [self addSubview:_imavBig];
    }
    return self;
}

@end

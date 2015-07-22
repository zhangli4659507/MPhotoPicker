//
//  EWebImaVC.m
//  MPohtoPicker
//
//  Created by mark on 15/7/21.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "EWebImaVC.h"
#import "MBigImaCollectionView.h"
@implementation EWebImaVC

- (void)viewDidLoad{

    [super viewDidLoad];
    MBigImaCollectionView *mbc = [[MBigImaCollectionView alloc] initWithFrame:self.view.bounds];
    
    [mbc updateImaArr:[self imageArr] fentchBlock:nil imaFromType:imaFromWeb];
    [self.view addSubview:mbc];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(actionBack)];
    
}

- (void)actionBack{

    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (NSArray *)imageArr {
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    [arr addObject:@"http://ikaola-image.b0.upaiyun.com/club/2014/9/28/575ba9141352103160644106f6ea328d_898_600.jpg"];
    [arr addObject:@"http://ikaola-image.b0.upaiyun.com/club/2014/9/28/41c856dc843f77c31feaa844010372dd_200_300.jpg"];
    [arr addObject:@"http://ikaola-image.b0.upaiyun.com/club/2014/9/28/7bc3f732cb3d7c8b6f4733e1c4e13e06_200_300.jpg"];
    [arr addObject:@"http://ikaola-image.b0.upaiyun.com/club/2014/9/28/f53df4315d62b8c367e6c15d5f273ca5_225_300.jpg"];
    [arr addObject:@"http://ikaola-image.b0.upaiyun.com/club/2014/9/28/a1733f9c235e4c23b4ebefb518e8d1c6_180_300.jpg"];
    [arr addObject:@"http://ikaola-image.b0.upaiyun.com/club/2014/9/28/17fe9fc8006ae9edc5126811e3df02e5_180_300.jpg"];
    [arr addObject:@"http://ikaola-image.b0.upaiyun.com/club/2014/9/28/7731053fecb2b058b8d412c53cc193d3_200_300.jpg"];
    [arr addObject:@"http://ikaola-image.b0.upaiyun.com/club/2014/9/28/7fe31f771b5367f42ea3e5818f068e05_200_300.jpg"];
    [arr addObject:@"http://ikaola-image.b0.upaiyun.com/club/2014/9/28/0a1fec8d94bfa0023b1e6520beddcf7f_235_300.jpg"];
    [arr addObject:@"http://ikaola-image.b0.upaiyun.com/club/2014/9/28/8b0fb232cbadafcde386f70f1e7a98e0_225_300.jpg"];
    [arr addObject:@"http://ikaola-image.b0.upaiyun.com/club/2014/9/28/37ff76845bc74e107163e111446e99a2_500_333.jpg"];
    return arr;
}
@end

//
//  MShowBigImaVC.m
//  MPohtoPicker
//
//  Created by mark on 15/7/20.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MShowBigImaVC.h"
#import "MBigImaCollectionView.h"

#import <AssetsLibrary/AssetsLibrary.h>

@interface MShowBigImaVC ()<UIScrollViewDelegate>
//@property (nonatomic, strong) UIScrollView *scrBack;
//@property (nonatomic, assign) NSUInteger curIndex;
//@property (nonatomic, strong) NSMutableArray *arrCurIma;
//@property (nonatomic, strong) UIImageView *imavPre;
//@property (nonatomic, strong) UIImageView *imavCenter;
//@property (nonatomic, strong) UIImageView *imavNext;
@property (nonatomic, strong) MBigImaCollectionView *mcView;
@end

@implementation MShowBigImaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
//    CGRect frame = self.view.bounds;
//    self.scrBack = [[UIScrollView alloc] initWithFrame:frame];
//    self.scrBack.delegate = self;
//    self.scrBack.pagingEnabled = YES;
//    self.scrBack.bounces = NO;
//    self.scrBack.showsHorizontalScrollIndicator = NO;
//    self.scrBack.showsVerticalScrollIndicator = NO;
//    self.scrBack.contentSize = CGSizeMake(self.scrBack.frame.size.width * 3,0);
//    self.scrBack.minimumZoomScale = 0.5;
//    self.scrBack.maximumZoomScale = 2;
//    [self.view addSubview:self.scrBack];
//    
//    self.curIndex = 1;
//    self.arrCurIma = [NSMutableArray array];
//    [self refreshScrollView];
    // Do any additional setup after loading the view.
}

- (void)setArrIma:(NSArray *)arrIma{

    _arrIma = arrIma;
    if (_mcView == nil) {
        _mcView = [[MBigImaCollectionView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_mcView];
    }
    [_mcView updateImaArr:arrIma fentchBlock:^id(ALAsset *set) {
        ALAssetRepresentation *sention = set.defaultRepresentation;
        UIImage *ima = [UIImage imageWithCGImage:[sention fullScreenImage]];
        return ima;
    } imaFromType:imaFromLocation];
}


#pragma mark - 下面是使用scrollView实现的循环滚动
//- (void)refreshScrollView{
//
//    NSArray *arr = [self.scrBack subviews];
//    if (arr.count > 0) {
//        [arr makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    }
//    [self displayImaArr];
////    if (self.imavPre == nil) {
//    
//        for(int i = 0 ; i < 3 ; i++){
//            
//            UIImageView *imav = [[UIImageView alloc] initWithFrame:CGRectMake(i*self.scrBack.bounds.size.width, 0, self.scrBack.bounds.size.width, self.scrBack.bounds.size.height)];
//            imav.backgroundColor = [UIColor whiteColor];
//            imav.userInteractionEnabled = YES;
//            imav.image = self.arrCurIma[i];
//            [self.scrBack addSubview:imav];
//            
//            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
//            [imav addGestureRecognizer:tap];
//            
//            UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinAction:)];
//            [imav addGestureRecognizer:pin];
//            
//        }
//        
////    }
////else{
////    
////        self.imavPre.image = self.arrCurIma[0];
////        self.imavCenter.image = self.arrCurIma[1];
////        self.imavNext.image = self.arrCurIma[2];
////    }
//    
//    [self.scrBack setContentOffset:CGPointMake(self.scrBack.bounds.size.width, 0)];
//}
//
//
//-(void)pinAction:(UIPinchGestureRecognizer *)pin{
//    
//    
//}
//
//- (void)tapAction{
//
//    NSLog(@"selectedTag = %d",self.curIndex);
//}
//
//- (void)displayImaArr{
//    
//    int pre = [self validPageValue:self.curIndex-1];
//    int last = [self validPageValue:self.curIndex+1];
//    
//    
//    if([self.arrCurIma count] != 0) [self.arrCurIma removeAllObjects];
//   
//    [self.arrCurIma addObject:[self getImaFromAlset:[self.arrIma objectAtIndex:pre-1]]];
//    [self.arrCurIma addObject:[self getImaFromAlset:[self.arrIma objectAtIndex:self.curIndex-1]]];
//    [self.arrCurIma addObject:[self getImaFromAlset:[self.arrIma objectAtIndex:last-1]]];
//    
//    
//    
//
//}
//
//- (UIImage *)getImaFromAlset:(ALAsset *)set{
//   ALAssetRepresentation *sention = set.defaultRepresentation;
//    UIImage *ima = [UIImage imageWithCGImage:[sention fullScreenImage]];
//    return ima;
//}
//
//- (int)validPageValue:(NSInteger)value {
//    
//    if(value == 0) value = self.arrIma.count;                   // value＝1为第一张，value = 0为前面一张
//    if(value == self.arrIma.count+1) value = 1;
//    
//    return value;
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    int x = scrollView.contentOffset.x;
//    if(x >= (2*self.scrBack.bounds.size.width)) {
//        self.curIndex = [self validPageValue:self.curIndex+1];
//        [self refreshScrollView];
//    }
//    if(x <= 0) {
//       self.curIndex = [self validPageValue:self.curIndex-1];
//        [self refreshScrollView];
//    }
//
//    
//}
//

//- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
//
//    return self.imavCenter;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

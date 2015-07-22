//
//  MBigImaCollectionView.m
//  MPohtoPicker
//
//  Created by mark on 15/7/21.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MBigImaCollectionView.h"
#import "MBigImaItem.h"

static NSString *const bigItemReuseIdentifier = @"itemReuseIdentifier";

@interface MBigImaCollectionView()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *arrIma;
@property (nonatomic, copy) MReturnFentchBlock fentchBlock;
@property (nonatomic, assign) imaFromType fromType;
//@property (nonatomic, strong) UIImageView *imavPre;
//@property (nonatomic, strong) UIImageView *imavNext;
@end

@implementation MBigImaCollectionView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self initsizeView];
    }
    
    return self;
}

- (void)initsizeView{

    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView的滚动方向为横向
     [flowLayOut setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayOut];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.collectionView];
    
    [self.collectionView registerClass:[MBigImaItem class] forCellWithReuseIdentifier:bigItemReuseIdentifier];
    
    self.collectionView.backgroundView.clipsToBounds = NO;
    
//    UIView *backView = [[UIView alloc] initWithFrame:self.collectionView.bounds];
//    self.collectionView.backgroundView = backView;
//    
//    self.imavPre = [[UIImageView alloc] initWithFrame:CGRectMake(-(self.bounds.size.width - 40), 0, self.bounds.size.width, self.bounds.size.height)];
//    self.imavPre.hidden = YES;
//    [self.collectionView  addSubview:self.imavPre];
//    
//    self.imavNext = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 40, 0, self.bounds.size.width, self.bounds.size.height)];
//    self.imavNext.hidden = YES;
//    [self.collectionView  addSubview:self.imavNext];
    
}


#pragma mark - public
- (void)updateImaArr:(NSArray *)arrImas fentchBlock:(MReturnFentchBlock)fentchBlock imaFromType:(imaFromType)fromType{
    
    _fentchBlock = fentchBlock;
    _fromType = fromType;
    self.arrIma = arrImas;
    self.arrIma = arrImas;
    
//    if (arrImas.count > 0) {
//     UIImage *imaPre = [arrImas firstObject];
//     UIImage *imaNext = [arrImas lastObject];
//        if (fentchBlock) {
//            imaPre = fentchBlock(imaPre);
//            imaNext = fentchBlock(imaNext);
//        }
//        self.imavPre.image = imaPre;
//        self.imavNext.image = imaNext;
//    }
    
    
    [self.collectionView reloadData];
    
}

#pragma mark - collectionDelagate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.arrIma.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
 
    MBigImaItem *item = [collectionView dequeueReusableCellWithReuseIdentifier:bigItemReuseIdentifier forIndexPath:indexPath];
    if (_fromType == imaFromWeb) {
        [item.imavBig updateWebImage:self.arrIma[indexPath.row] placeIma:[UIImage imageNamed:@"0.jpg"] fentchBlock:nil];
    }else{
    [item.imavBig updateLocationImage:self.arrIma[indexPath.row] fentchBlock:self.fentchBlock];
    }
    
//    self.imavPre.hidden = !(indexPath.row == 0);
//    self.imavNext.hidden = !(indexPath.row == self.arrIma.count-1);
    return item;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return self.bounds.size;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{

    return 0;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    NSLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
//    
//    if (scrollView.contentOffset.x > (self.arrIma.count-1)*self.bounds.size.width+40) {
//        
//        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
//    }else if(scrollView.contentOffset.x < -40){
//    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.arrIma.count-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionRight animated:YES];
////        [self.collectionView setContentOffset:CGPointMake((self.arrIma.count -1)*self.bounds.size.width,0 )];
//    }
//}




@end

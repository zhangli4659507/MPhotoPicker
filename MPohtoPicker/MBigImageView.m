//
//  MBigImageView.m
//  MPohtoPicker
//
//  Created by mark on 15/7/21.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MBigImageView.h"
#import "SDWebImageManager.h"
#import "SDProgressView.h"
#import "MAllPtotoIma.h"
#import "MBProgressHUD.h"
static NSString *const ablumName = @"Mark自定义相册";

@interface MBigImageView ()<UIScrollViewDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UIImageView *imavIma;
@property (nonatomic, strong) UIScrollView *scrBackGround;
@end

@implementation MBigImageView

- (instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        [self initialize];
    }
    return self;
}

- (void)setMinimumZoomScale:(CGFloat)minimumZoomScale{

    _minimumZoomScale = minimumZoomScale;
    self.scrBackGround.minimumZoomScale = minimumZoomScale;
}

- (void)setMaximumZoomScale:(CGFloat)maximumZoomScale{

    _maximumZoomScale = maximumZoomScale;
    self.scrBackGround.maximumZoomScale = maximumZoomScale;
}

//本地图片
- (void)updateLocationImage:(id)img fentchBlock:(MReturnFentchBlock)fentchBlock {
    self.scrBackGround.scrollEnabled = YES;
    
    UIImage *ima = nil;
    if (fentchBlock) {
        ima = fentchBlock(img);
    }else{
        ima = img;
    }
    self.image = ima;
    [self setImageViewWithImg:ima];
}


- (void)updateWebImage:(id)urlStr placeIma:(UIImage *)placeIma fentchBlock:(MReturnFentchBlock)fentchBlock{

    NSAssert(urlStr, @"链接为空");
    
    [self updateLocationImage:placeIma fentchBlock:nil];
    
    NSString *url = urlStr;
    
    if (fentchBlock) {
        url = fentchBlock(urlStr);
    }
    
  SDLoopProgressView *pie =  [SDLoopProgressView progressView];
    [self addSubview:pie];
    pie.frame = CGRectMake(0, 0, 50, 50);
    pie.center = self.center;
    [self addSubview:pie];
    NSURL *URL = [NSURL URLWithString:url];
    SDWebImageManager *mager = [SDWebImageManager sharedManager];
    
    [mager downloadImageWithURL:URL options:SDWebImageRetryFailed progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        pie.progress = receivedSize*1.0/expectedSize*1.0;
        NSLog(@"%d %d",receivedSize,expectedSize);
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        [pie dismiss];
        if (finished && image) {
            [self updateLocationImage:image fentchBlock:nil];
        }
    }];
    
}



#pragma mark - privateFunc
- (void)initialize{

    self.clipsToBounds = YES;
    self.contentMode = UIViewContentModeScaleAspectFill;
    
    self.scrBackGround = [[UIScrollView alloc] initWithFrame:self.bounds];
    self.scrBackGround.delegate = self;
    self.scrBackGround.showsVerticalScrollIndicator = NO;
    self.scrBackGround.showsHorizontalScrollIndicator = NO;
    self.scrBackGround.minimumZoomScale = 0.5;
    self.scrBackGround.maximumZoomScale = 2;
    self.scrBackGround.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.scrBackGround.bounces = NO;
    self.scrBackGround.contentSize = CGSizeMake(self.bounds.size.width, 0);
    [self addSubview:self.scrBackGround];
    

    
    self.imavIma = [[UIImageView alloc] initWithFrame:self.scrBackGround.bounds];
    self.imavIma.userInteractionEnabled = YES;
    [self.scrBackGround addSubview:self.imavIma];
    
    UITapGestureRecognizer *tapOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapsAction:)];
    UITapGestureRecognizer *tapTwo = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(TapsAction:)];
    [tapTwo setNumberOfTapsRequired:2];
    
    
    
    
    UILongPressGestureRecognizer *longGes = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longGesAction)];
    longGes.minimumPressDuration = 0.8;
    [self.imavIma addGestureRecognizer:longGes];
    [self.imavIma addGestureRecognizer:tapOne];
    [self.imavIma addGestureRecognizer:tapTwo];
    //长按失败后执行双击 双击失败后执行单击
   
    [tapOne requireGestureRecognizerToFail:tapTwo];
    [longGes requireGestureRecognizerToFail:tapOne];
    
}

#pragma mark - private
- (UIImage *)image {
    return _imavIma.image;
}

//获取图片和显示视图宽度的比例系数
- (float)getImgWidthFactor {
    return   self.bounds.size.width / self.image.size.width;
}
//获取图片和显示视图高度的比例系数
- (float)getImgHeightFactor {
    return  self.bounds.size.height / self.image.size.height;
}

//获获取尺寸
- (CGSize)newSizeByoriginalSize:(CGSize)oldSize maxSize:(CGSize)mSize {
    if (oldSize.width <= 0 || oldSize.height <= 0) {
        return CGSizeZero;
    }
    
    CGSize newSize = CGSizeZero;
    if (oldSize.width > mSize.width || oldSize.height > mSize.height) {
        //按比例计算尺寸
        float bs = [self getImgWidthFactor];
        float newHeight = oldSize.height * bs;
        newSize = CGSizeMake(mSize.width, newHeight);
        
        if (newHeight > mSize.height) {
            bs = [self getImgHeightFactor];
            float newWidth = oldSize.width * bs;
            newSize = CGSizeMake(newWidth, mSize.height);
        }
    }else {
        
        newSize = oldSize;
    }
    return newSize;
}


- (void)setImageViewWithImg:(UIImage *)img {
    [self resetViewFrame];
    self.scrBackGround.scrollEnabled = YES;
    
    self.imavIma.image = img;
    CGSize showSize = [self newSizeByoriginalSize:img.size maxSize:self.bounds.size];
    self.imavIma.frame = CGRectMake(0, 0, showSize.width, showSize.height);
    
    _scrBackGround.zoomScale = 1;
    _scrBackGround.contentOffset = CGPointZero;
    [self scrollViewDidZoom:_scrBackGround];
    
    
}
- (void)resetViewFrame{
    _scrBackGround.frame = self.bounds;
    _imavIma.frame = self.bounds;
    _scrBackGround.zoomScale = 1;
}

#pragma makr - actionTap
- (void)longGesAction{
    
    
    UIAlertView *aler = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否保存到自定义相册中" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保存", nil];
    [aler show];
    
    
    
}

- (void)TapsAction:(UITapGestureRecognizer *)tap
{
    NSInteger tapCount = tap.numberOfTapsRequired;
    if (2 == tapCount) {
        if (self.scrBackGround.minimumZoomScale <= self.scrBackGround.zoomScale && self.scrBackGround.maximumZoomScale > self.scrBackGround.zoomScale) {
            [self.scrBackGround setZoomScale:self.scrBackGround.maximumZoomScale animated:YES];
        }else {
            [self.scrBackGround setZoomScale:self.scrBackGround.minimumZoomScale animated:YES];
        }
        
    }else if (1 == tapCount) {
        [self.scrBackGround setZoomScale:1 animated:YES];
    }
}

#pragma mark - AlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    if (buttonIndex == 1) {
        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self animated:YES];
        hub.labelText = @"正在保存...";
    [MAllPtotoIma saveImage:self.imavIma.image toAlbum:ablumName withCompletionBlock:^(NSError *error) {
                    hub.mode = MBProgressHUDModeCustomView;
                    if (!error) {
                        hub.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD_success"]];
                        hub.labelText = @"保存成功";
                        [hub hide:YES afterDelay:1];
                        
                        
                    }else{
                        hub.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HUD_fail"]];
                        hub.labelText = @"保存失败";
                        [hub hide:YES afterDelay:1];
                        
                    }
                    
                }];
            }
    
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    CGFloat Ws = scrollView.frame.size.width - scrollView.contentInset.left - scrollView.contentInset.right;
    CGFloat Hs = scrollView.frame.size.height - scrollView.contentInset.top - scrollView.contentInset.bottom;
    CGFloat W = _imavIma.frame.size.width;
    CGFloat H = _imavIma.frame.size.height;
    CGRect rct = _imavIma.frame;
    rct.origin.x = MAX((Ws-W)*0.5, 0);
    rct.origin.y = MAX((Hs-H)*0.5, 0);
    _imavIma.frame = rct;
    
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{

    return self.imavIma;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

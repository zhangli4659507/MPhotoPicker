//
//  MShowAllIma.m
//  MPohtoPicker
//
//  Created by mark on 15/7/20.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MShowAllIma.h"

#import "MImaShowCell.h"

#import "MShowBigImaVC.h"

#define kScreenWidth self.view.frame.size.width
static NSString *const cellReuseIdentifierStr = @"cellReusestr";

@interface MShowAllIma ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectView ;
@property (nonatomic, strong) NSMutableArray *arrIma;
@property (nonatomic, strong) NSMutableArray *arrSelectdIndexPath;


@end

@implementation MShowAllIma

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    self.collectView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayOut];
    self.collectView.dataSource = self;
    self.collectView.delegate = self;
    [self.view addSubview:self.collectView];
    
    [self.collectView registerNib:[UINib nibWithNibName:@"MImaShowCell" bundle:nil] forCellWithReuseIdentifier:cellReuseIdentifierStr];
    self.collectView.backgroundColor = [UIColor whiteColor];
    
    __weak typeof(self) weak = self;
    self.arrIma = [NSMutableArray array];
    self.arrSelectdIndexPath = [NSMutableArray array];
    [self.group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        (!result) ?: [weak.arrIma addObject:result];
    }];

    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"预览" style:UIBarButtonItemStylePlain target:self action:@selector(actionLook)];
    
    // Do any additional setup after loading the view.
}



- (void)actionLook{

    if (self.arrSelectdIndexPath.count > 0) {
        NSMutableArray *arrSet = [NSMutableArray array];
        for(NSIndexPath *indexPath in self.arrSelectdIndexPath){
            [arrSet addObject:self.arrIma[indexPath.row]];
        }
        MShowBigImaVC *bvc = [[MShowBigImaVC alloc] init];
        bvc.arrIma = arrSet;

        [self.navigationController pushViewController:bvc animated:YES];
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    
    return self.arrIma.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return (self.group)?1:0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    MImaShowCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseIdentifierStr forIndexPath:indexPath];
    ALAsset *set = self.arrIma[indexPath.row];
    cell.imavThumil.image = [UIImage imageWithCGImage:set.thumbnail];
    cell.viewUp.hidden = ![self.arrSelectdIndexPath containsObject:indexPath];
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return CGSizeMake((kScreenWidth-3*5)/4, (kScreenWidth-3*5)/4);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

    return 5;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{

    return 5;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    MImaShowCell *cell = (MImaShowCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if(![self.arrSelectdIndexPath containsObject:indexPath]){
        cell.viewUp.hidden = NO;
        [self.arrSelectdIndexPath addObject:indexPath];
        
    }else{
    
        cell.viewUp.hidden = YES;
        [self.arrSelectdIndexPath removeObject:indexPath];
    }
    
    
    
}



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

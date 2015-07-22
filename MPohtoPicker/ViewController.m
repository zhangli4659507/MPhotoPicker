//
//  ViewController.m
//  MPohtoPicker
//
//  Created by mark on 15/7/20.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "ViewController.h"
#import "MAllPtotoIma.h"
#import "MShowAllIma.h"
#import "MShowGroupVc.h"
#import "EWebImaVC.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [MAllPtotoIma getAllImaFormLibaryWithObjBlock:^(NSArray *arrIma) {
//        
//    }];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)actionWebBtn:(id)sender {
    
    EWebImaVC *imvc = [[EWebImaVC alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:imvc];
    
    [self presentViewController:nav animated:YES completion:nil];
    
}
- (IBAction)actionBtn:(id)sender {
    
    MShowGroupVc *imvc = [[MShowGroupVc alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:imvc];
    
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

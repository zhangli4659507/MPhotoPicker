//
//  MShowGroupVc.m
//  MPohtoPicker
//
//  Created by mark on 15/7/20.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "MShowGroupVc.h"
#import "MImaGroupViewCell.h"
#import "MShowAllIma.h"

#import "MAllPtotoIma.h"

static NSString *const cellReuseIdentifier = @"cell";

@interface MShowGroupVc ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrGroup;
@end

@implementation MShowGroupVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MImaGroupViewCell" bundle:nil] forCellReuseIdentifier:cellReuseIdentifier];
    
    UIBarButtonItem *rightIten = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(actionRight)];
    self.navigationItem.rightBarButtonItem = rightIten;
    
    [MAllPtotoIma getAllImaGroupFromLibaryBlock:^(NSMutableArray *arrIma) {

        self.arrGroup = arrIma;
        [self.tableView reloadData];
    } withFailureBlock:nil];
    // Do any additional setup after loading the view.
}

- (void)actionRight{

    [self dismissViewControllerAnimated:YES completion:nil];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.arrGroup.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    MImaGroupViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    
    ModelImaGroup *group = [MAllPtotoIma getModelImaGroupWithGroup:self.arrGroup[indexPath.row]];
    cell.imavHead.image = group.posterIma;
    cell.lblTitle.text = [NSString stringWithFormat:@"%@(%d)",group.groupTitle,group.numImas];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 58;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MShowAllIma *mvc = [[MShowAllIma alloc] init];
    mvc.group = self.arrGroup[indexPath.row];
    [self.navigationController pushViewController:mvc animated:YES];
    
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

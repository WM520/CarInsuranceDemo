//
//  ViewController.m
//  CarInsuranceDemo
//
//  Created by David on 16/7/4.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "ViewController.h"
#import "CustomButton.h"
#import "CityController.h"

static NSString *cellID = @"cell";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, CityControllerDelegate>

{
    CustomButton *_btn;
}

@property (nonatomic, weak) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    (void)self.tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"行驶城市";
        CustomButton *btn = [[CustomButton alloc] initWithFrame:CGRectMake(100, 0, cell.bounds.size.width - 100, cell.bounds.size.height)];
        [btn setTitle:@"选择城市" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(choseCity) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell.contentView addSubview:btn];
        _btn = btn;
    } else if (indexPath.row == 1) {
        cell.textLabel.text = @"保险公司";
        CustomButton *btn = [[CustomButton alloc] initWithFrame:CGRectMake(100, 0, cell.bounds.size.width - 100, cell.bounds.size.height)];
        [btn setTitle:@"选择保险" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cell.contentView addSubview:btn];
    } else if (indexPath.row == 2) {
        cell.textLabel.text = @"车辆种类";
    }
    
    return cell;
}

- (void)choseCity
{
    CityController *vc = [[CityController alloc] init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark CityControllerDelegate

- (void)goBackWithCity:(NSString *)city
{
    [_btn setTitle:city forState:UIControlStateNormal];
}

// Lazy
- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
        [self.view addSubview:tableView];
        _tableView = tableView;
        
    }
    return _tableView;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

@end

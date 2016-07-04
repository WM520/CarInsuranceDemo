//
//  CityController.m
//  CarInsuranceDemo
//
//  Created by David on 16/7/4.
//  Copyright © 2016年 WM. All rights reserved.
//

#import "CityController.h"

@interface CityController() <UITableViewDelegate, UITableViewDataSource>
{
    NSMutableDictionary *_allCitysDictionary;
    NSMutableArray *_keys;
}
@property (nonatomic, weak) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray *cityArray;

@end

@implementation CityController


- (void)viewDidLoad
{
    [super viewDidLoad];
    (void)self.tableView;
    self.automaticallyAdjustsScrollViewInsets = NO;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"citydict" ofType:@"plist"];
    _allCitysDictionary = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
    for (NSArray *array in _allCitysDictionary.allValues) {
        for (NSString *citys in array) {
            [self.cityArray addObject:citys];
        }
    }
    
    _keys = [NSMutableArray array];
    [_keys addObjectsFromArray:[[_allCitysDictionary allKeys] sortedArrayUsingSelector:@selector(compare:)]];
}


#pragma mark tableView dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _keys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [_allCitysDictionary objectForKey:[_keys objectAtIndex:section]];
    return array.count;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _keys;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identfire=@"cellID";
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identfire];
    
    if (!cell) {
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identfire];
    }
    
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    NSArray *array=[_allCitysDictionary objectForKey:[_keys objectAtIndex:indexPath.section]];
    
    cell.textLabel.text=array[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(goBackWithCity:)]) {
        NSArray *array=[_allCitysDictionary objectForKey:[_keys objectAtIndex:indexPath.section]];
        NSString *city = array[indexPath.row];
        [self.delegate goBackWithCity:city];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark tableView delgate
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, 35)];
    label.backgroundColor = [UIColor lightGrayColor];
    label.text = [NSString stringWithFormat:@"   %@", _keys[section]];
    return label;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        UITableView * tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        [self.view addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}

- (NSMutableArray *)cityArray
{
    if (!_cityArray) {
        _cityArray = [NSMutableArray array];
    }
    return _cityArray;
}


@end

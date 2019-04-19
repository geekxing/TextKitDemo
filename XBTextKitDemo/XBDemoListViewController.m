
//
//  XBDemoListViewController.m
//  XBTextKitDemo
//
//  Created by 赖霄冰 on 2019/4/19.
//  Copyright © 2019 赖霄冰. All rights reserved.
//

#import "XBDemoListViewController.h"

@interface XBDemoListViewController ()

@property (nonatomic, copy) NSArray <NSString *>*dataList;

@end

@implementation XBDemoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationItem.title = @"TextKit";
    _dataList = @[@"ExclusionPaths", @"Demo 2", @"mutiple containers", @"Core Text", @"Custom Container & ExclusionPaths"];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = _dataList[indexPath.row];
    
    return cell;
}

#pragma mark -
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *title = _dataList[indexPath.row];
    if (indexPath.row == 0) {
        UIStoryboard *st = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        UIViewController *vc = [st instantiateViewControllerWithIdentifier:@"XBViewController1"];
        vc.title = title;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        NSString *vcClassStr = [NSString stringWithFormat:@"XBViewController%zd", indexPath.row+1];
        Class vcClass = NSClassFromString(vcClassStr);
        if (vcClass) {
            UIViewController *vc = [[vcClass alloc] init];
            vc.title = title;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}

@end

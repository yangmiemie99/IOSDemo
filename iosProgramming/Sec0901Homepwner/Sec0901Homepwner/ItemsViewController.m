//
//  ItemsViewController.m
//  Sec0801Homepwner
//
//  Created by brook on 2020/9/17.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "ItemsViewController.h"
#import "Item.h"
#import "ItemStore.h"
#import "HeaderView.h"
@interface ItemsViewController () <HeaderViewDelegte>

@property (nonatomic,strong) HeaderView *headerView;

@end

@implementation ItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置代理
    self.headerView.delegte = self;
    //表视图中注册使用过的tableview
    [self.tableView registerClass:[UITableViewCell class]forCellReuseIdentifier:@"UITableViewCell"];
    
    //加载头部
    [self.tableView setTableHeaderView:self.headerView];
    
}
#pragma mark --Init
//保证两种初始化方法都调用到相同的style
- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if(self){
        for(int i =0; i < 5; ++i){
            [[ItemStore sharedStore] createItem];
        }
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}
#pragma mark --UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //数组计数
    return [[[ItemStore sharedStore] allItems] count];
}
//根据index获取tableView中的对象
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    //创建或重用对象,根据出入的识别器判断能否重用，一样就可以
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    //获取allItems的第n个Item对象，然后将Item对象的描述信息赋给cell的textlable对象
    NSArray *items = [[ItemStore sharedStore] allItems];
    Item *item = items[indexPath.row];
    cell.textLabel.text = [item description];
    return  cell;
}
//可以插入或者删除
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        NSArray *items = [[ItemStore sharedStore] allItems];
        Item *item = items[indexPath.row];
        [[ItemStore sharedStore] removeItem:item];
        //还要删除表哥视图中相应行,动画
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
//移动行
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[ItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row toIndex:destinationIndexPath.row];
}
#pragma mark - delegte header view 按钮消息
- (void)edditButonBeTouched{
    if (self.isEditing) {
        [_headerView.edditButton setTitle:@"Edit" forState:UIControlStateNormal];
        [self setEditing:NO animated:YES];
    }else{
        [_headerView.edditButton setTitle:@"Done" forState:UIControlStateNormal];
        [self setEditing:YES animated:YES];
    }
}

- (void)addButtonBeTouched {
    //新建item
    Item *newItem = [[ItemStore sharedStore] createItem];
    //新建item在数组中的位置
    NSInteger lastRow = [[[ItemStore sharedStore] allItems] indexOfObject:newItem];
    //根据位置去决定插入位置
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

//#pragma mark - 自定义headerView
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 60)];
//    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 80, 60)];
//    lab.text = [NSString stringWithFormat:@"----我是%ldheader呀---",(long)section];
//    lab.textAlignment = NSTextAlignmentCenter;
//    [header addSubview:lab];
//    header.backgroundColor = [UIColor blueColor];
//
//    return header;
//
//}
#pragma mark --property
- (HeaderView *)headerView
{
    if(!_headerView)
    {
        _headerView = [[HeaderView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, 60)];
    }
    return _headerView;
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

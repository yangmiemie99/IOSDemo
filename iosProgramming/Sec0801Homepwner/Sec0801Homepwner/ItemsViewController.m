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
@interface ItemsViewController ()

@end

@implementation ItemsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //表视图中注册使用过的tableview
    [self.tableView registerClass:[UITableViewCell class]forCellReuseIdentifier:@"UITableViewCell"];
}
//保证两种初始化方法都调用到相同的style
- (instancetype)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if(self){
        for(int i =0; i < 25; ++i){
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

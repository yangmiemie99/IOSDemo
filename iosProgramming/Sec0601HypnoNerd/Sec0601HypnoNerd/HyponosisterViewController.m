//
//  HyponosisterViewController.m
//  HypnoNerd
//
//  Created by brook on 2020/9/15.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "HyponosisterViewController.h"
#import "Hyponosister.h"
@implementation HyponosisterViewController

- (void)loadView
{
    [super loadView];
    //创建一个Hypono对象
    Hyponosister* backgroudView = [[Hyponosister alloc] init];
    //将Hypono对象赋给视图控制器view的属性
    self.view = backgroudView;
    

}

- (instancetype)init
{
    self = [super init];
    if(self){
        //设置tabbar的样式
        self.tabBarItem.title = @"Hyponise";
        //从文件中创建一个UIImage对象
        self.tabBarItem.image = [UIImage imageNamed:@"Hypno.png"];
    }
    return self;
}
@end

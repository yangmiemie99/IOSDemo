//
//  ReminderViewController.m
//  HypnoNerd
//
//  Created by brook on 2020/9/15.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "ReminderViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface ReminderViewController ()

@end

@implementation ReminderViewController

//防止日期设置为过去的时间
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.datePicker.minimumDate = [NSDate dateWithTimeIntervalSinceNow:60];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.datePicker];
    CGRect pickerRect = self.view.bounds;
    NSLog(@"%g,%g",pickerRect.origin.x,pickerRect.size.height);
    pickerRect.size.height /= 2.f;
    pickerRect.origin.y = pickerRect.size.height / 4.f;
    _datePicker.frame = pickerRect;
    
    [self.view addSubview:self.buRemiander];
    CGRect buRemRect = self.view.bounds;
    buRemRect.origin.x += buRemRect.size.width / 2.f - 40.f;
    buRemRect.origin.y = buRemRect.size.height / 4.f *3;
    buRemRect.size.height = 40;
    buRemRect.size.width = 80;
    _buRemiander.frame = buRemRect;
    
    [_buRemiander addTarget:self action:@selector(addBuRemiander) forControlEvents:UIControlEventTouchUpInside];
    
}
- (instancetype)init
{
    self = [super init];
    if(self){
        //设置tabbar的样式
        self.tabBarItem.title = @"Time";
        //从文件中创建一个UIImage对象
        UIImage *i = [UIImage imageNamed:@"Time.png"];
        self.tabBarItem.image = [UIImage imageNamed:@"Time.png"];
    }
    return self;
}
#pragma mark -action
- (void)addBuRemiander
{
    NSDate *data = self.datePicker.date;
    NSLog(@"Setting a reminder for%@",data);
    //创建普通的通知
    UNMutableNotificationContent * content = [UNMutableNotificationContent new];
    //设置通知请求时，app图标上显示的数字
    content.body = @"1";
    //设置通知的内容
    content.body =@"Hyponosis!";
    //设置副标题
    content.subtitle = @"Hyponosis me..";
    //设置时间触发器,data的interval和当前时间的比较
    UNTimeIntervalNotificationTrigger *timeTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:data.timeIntervalSinceNow repeats:NO];
    //设置通知请求
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"UNNotificationDefault" content:content trigger:timeTrigger];
    
    //添加通知请求
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"添加通知成功");
        }
    }];
    

}

-(void)datePickerValueChanged:(id)sender{

    UIDatePicker* control = (UIDatePicker*)sender;
    NSDate* date = control.date;
    _datePicker.date = date;
}

#pragma mark -property
- (UIButton*)buRemiander
{
    if(!_buRemiander){
        _buRemiander = [[UIButton alloc] initWithFrame:CGRectZero];
        [_buRemiander setTitle:@"Remind me!" forState:UIControlStateNormal];
        _buRemiander.titleLabel.font = [UIFont systemFontOfSize:12.f];
        [_buRemiander setTitleColor:[UIColor systemBlueColor] forState:UIControlStateNormal];
        _buRemiander.backgroundColor = [UIColor whiteColor];
    }
    return _buRemiander;
}

- (UIDatePicker *)datePicker
{
    if (!_datePicker) {
        _datePicker = [[UIDatePicker alloc] init];
        [_datePicker setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [_datePicker addTarget:self action:@selector(datePickerValueChanged:)forControlEvents:UIControlEventValueChanged];
    }
    return _datePicker;

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

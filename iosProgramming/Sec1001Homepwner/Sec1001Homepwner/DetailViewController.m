//
//  DetailViewController.m
//  Sec1001Homepwner
//
//  Created by brook on 2020/9/18.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "DetailViewController.h"
#include "Item.h"
@interface DetailViewController ()

@end

@implementation DetailViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    Item *item = self.item;
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d",item.valueInDollars];
    static NSDateFormatter *dateFormatter = nil;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }
    self.dataLabel.text = [dateFormatter stringFromDate:item.dateCreated];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //取消第一响应对象
    [self.view endEditing:YES];
    //将修改保存至item对象
    self.item.itemName = self.nameField.text;
    self.item.serialNumber = self.serialNumberField.text;
    self.item.valueInDollars = [self.valueField.text intValue];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    CGFloat startX = self.view.frame.origin.x + self.view.frame.size.width / 4.f;
    CGFloat startY = self.view.frame.origin.y + self.view.frame.size.height / 4.f;
    CGFloat fieldWidth = self.view.frame.size.width / 2.f;
    
    [self.view addSubview:self.nameField];
    _nameField.frame = CGRectMake(startX, startY, fieldWidth, 30.f);
    _nameField.placeholder = @"input your name";
    _nameField.font = [UIFont systemFontOfSize:14.f];
    
    [self.view addSubview:self.serialNumberField];
    _serialNumberField.frame = CGRectMake(startX, startY + 50.f, fieldWidth, 30.f);
    _serialNumberField.placeholder = @"input your serial";
    _serialNumberField.font = [UIFont systemFontOfSize:14.f];

    [self.view addSubview:self.valueField];
    _valueField.frame = CGRectMake(startX, startY + 100.f, fieldWidth, 30.f);
    _valueField.placeholder = @"input your value";
    _valueField.font = [UIFont systemFontOfSize:14.f];
    
    startX = self.view.frame.size.width / 4.f - 50.f;
    
    [self.view addSubview:self.nameLabel];
    _nameLabel.frame = CGRectMake(startX, startY, 40, 30);

    [self.view addSubview:self.serialNumberLabel];
    _serialNumberLabel.frame = CGRectMake(startX, startY +50, 40, 30);

    [self.view addSubview:self.valueLabel];
    _valueLabel.frame = CGRectMake(startX, startY + 100, 40, 30);

    [self.view addSubview:self.dataLabel];
    _dataLabel.frame = CGRectMake(startX, startY +150, 200, 30);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark --method
- (void)setItem:(Item *)item
{
    _item = item;
    self.navigationItem.title = _item.itemName;
}

#pragma mark --property
- (UITextField *)nameField
{
    if(!_nameField){
        _nameField = [[UITextField alloc] initWithFrame:CGRectZero];
        
    }
    return _nameField;
}
- (UITextField *)serialNumberField
{
    if(!_serialNumberField){
        _serialNumberField = [[UITextField alloc] initWithFrame:CGRectZero];
    }
    return _serialNumberField;
}
- (UITextField *)valueField
{
    if(!_valueField){
        _valueField = [[UITextField alloc] initWithFrame:CGRectZero];
    }
    return _valueField;
}

- (UILabel *)dataLabel
{
    if(!_dataLabel){
        _dataLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _dataLabel.backgroundColor = [UIColor systemGray3Color];
        _dataLabel.font = [UIFont systemFontOfSize:14.f];
        _dataLabel.text = @"Text";
        
    }
    return _dataLabel;
}

- (UILabel *)nameLabel
{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.backgroundColor = [UIColor systemGray3Color];
        _nameLabel.font = [UIFont systemFontOfSize:14.f];
        _nameLabel.text = @"Name";
        
    }
    return _nameLabel;
}
- (UILabel *)serialNumberLabel
{
    if(!_serialNumberLabel){
        _serialNumberLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _serialNumberLabel.backgroundColor = [UIColor systemGray3Color];
        _serialNumberLabel.font = [UIFont systemFontOfSize:14.f];
        _serialNumberLabel.text = @"Serial";
        
    }
    return _serialNumberLabel;
}
- (UILabel *)valueLabel
{
    if(!_valueLabel){
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _valueLabel.backgroundColor = [UIColor systemGray3Color];
        _valueLabel.font = [UIFont systemFontOfSize:14.f];
        _valueLabel.text = @"Value";
        
    }
    return _valueLabel;
}
@end

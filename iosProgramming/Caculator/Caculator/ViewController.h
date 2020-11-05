//
//  ViewController.h
//  Caculator
//
//  Created by brook on 2020/9/8.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic,strong) UILabel * display;
@property (nonatomic,strong) UIButton *Button1,*Button2,*Button3,*Button4,*Button5,*Button6,*Button7,*Button8,*Button9,*Button0;
@property (nonatomic,strong) UIButton *ButtonPlus,*ButtonMins,*ButtonMul,*ButtonDiv;
@property (nonatomic,strong) UIButton *ButtonOver,*ButtonEqu,*ButtonClear;

//数值运算
- (void)processDigit:(NSInteger)digit;
- (void)procesOp:(char)theOp;
- (void)storeFracPart;
//数字按键
- (void)clickDigit:(UIButton *)sender;
//算数操作按键
- (void)clickPlus;
- (void)clickPMins;
- (void)clickMul;
- (void)clickDiv;
//其他按键
- (void)clickOver;
- (void)clickEqu;
- (void)clickClear;

@end


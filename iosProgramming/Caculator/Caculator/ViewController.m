//
//  ViewController.m
//  Caculator
//
//  Created by brook on 2020/9/8.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "ViewController.h"
#import "Caculator.h"
@interface ViewController ()

@property (nonatomic, assign) char op;
@property (nonatomic, assign) NSInteger currentNumber;
//第一个操作数，是数字部分
@property (nonatomic, assign) BOOL firstOperand,isNumerator;
@property (nonatomic, strong) Caculator *myCaculator;
@property (nonatomic, strong) NSMutableString *displayString;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _firstOperand = YES;
    _isNumerator = YES;
    //可扩展长度字符串
    _displayString = [NSMutableString stringWithCapacity:40];
    _myCaculator = [[Caculator alloc] init];
    // 展示图标,进行图标的第一次初始化
    [self addCaculatorSubview];
    //链接
    [self addCaculatorTarget];

}
//添加子视图
- (void)addCaculatorSubview
{
    [self.view addSubview:self.display];
    //之后都用在添加子视图中设置位置
    _display.frame = CGRectMake(40.f, 40.f, 230.f, 70.f);
    [self.view addSubview:self.ButtonPlus];
    [self.view addSubview:self.ButtonMul];
    [self.view addSubview:self.Button7];
    [self.view addSubview:self.Button4];
    [self.view addSubview:self.Button1];
    [self.view addSubview:self.Button0];
    [self.view addSubview:self.ButtonMins];
    [self.view addSubview:self.ButtonDiv];
    [self.view addSubview:self.Button8];
    [self.view addSubview:self.Button5];
    [self.view addSubview:self.Button2];
    [self.view addSubview:self.ButtonOver];
    [self.view addSubview:self.ButtonClear];
    [self.view addSubview:self.Button9];
    [self.view addSubview:self.Button6];
    [self.view addSubview:self.Button3];
    [self.view addSubview:self.ButtonEqu];
    
    
}
// 触发事件
- (void)addCaculatorTarget
{
    NSMutableArray* arr = [[NSMutableArray alloc] initWithArray:@[_Button0,_Button1,_Button2,_Button3,_Button4,_Button5,_Button6,_Button7,_Button8,_Button9]];
    //链接按键
    for(UIButton* ButtenTemp in arr){
        [ButtenTemp addTarget:self action:@selector(clickDigit:) forControlEvents:UIControlEventTouchUpInside];
    }
    //链接运算
    [self.ButtonPlus addTarget:self action:@selector(clickPlus) forControlEvents:UIControlEventTouchUpInside];
    [self.ButtonDiv addTarget:self action:@selector(clickDiv) forControlEvents:UIControlEventTouchUpInside];
    [self.ButtonMul addTarget:self action:@selector(clickMul) forControlEvents:UIControlEventTouchUpInside];
    [self.ButtonMins addTarget:self action:@selector(clickPMins) forControlEvents:UIControlEventTouchUpInside];
    
    //链接等于，分数，清空
    [self.ButtonEqu addTarget:self action:@selector(clickEqu) forControlEvents:UIControlEventTouchUpInside];
    [self.ButtonOver addTarget:self action:@selector(clickOver) forControlEvents:UIControlEventTouchUpInside];
    [self.ButtonClear addTarget:self action:@selector(clickClear) forControlEvents:UIControlEventTouchUpInside];
}


#pragma mark - actions
//Text显示过程输出
- (void)processDigit:(NSInteger)digit
{
    _currentNumber = _currentNumber * 10 + digit;
    [_displayString appendFormat: @"%li",digit];
    _display.text = _displayString;
}
//存储数据
- (void)storeFracPart
{
    if(_firstOperand){
        //只是数字
        if(_isNumerator){
            _myCaculator.operand1.number = _currentNumber;
            _myCaculator.operand1.denomation = 1;
        }
        else {
            _myCaculator.operand1.denomation = _currentNumber;
        }
            
    }
    else if(_isNumerator){
        _myCaculator.operand2.number = _currentNumber;
        _myCaculator.operand2.denomation = 1;
    }
    else{
        _myCaculator.operand2.denomation = _currentNumber;
        _firstOperand = YES;
    }
    _currentNumber = 0;
}
//处理算数运算符点击
- (void)procesOp:(char)theOp
{
    NSString * opStr;
    _op = theOp;
    switch (_op) {
        case '+':
            opStr = @ " + ";
            break;
        case '-':
            opStr = @ " - ";
            break;
        case '*':
            opStr = @ " * ";
            break;
        case '/':
            opStr = @ " / ";
            break;
        default:
            break;
    }
    [self storeFracPart];
    _firstOperand = NO;
    _isNumerator = YES;
    [_displayString appendString:opStr];
    self.display.text = _displayString;
}
//数字按键
- (void)clickDigit:(UIButton *)sender
{
    NSInteger digit = sender.tag;
    [self processDigit:digit];
}
//算数操作

////算数操作按键
- (void)clickPlus
{
    [self procesOp: '+'];
}
- (void)clickPMins
{
    [self procesOp:'-'];
}
-(void) clickMul
{
    [self procesOp:'*'];
}
-(void) clickDiv
{
    [self procesOp:'/'];
}
//其他按键
//点击over结束分数的整数部分输入，继续输入分数部分
- (void)clickOver
{
    [self storeFracPart];
    _isNumerator = NO;
    [_displayString appendString:@" / "];
    self.display.text = _displayString;
}
- (void)clickEqu
{
    if(!_firstOperand){
        [self storeFracPart];
        [_myCaculator perFormOperation:_op];
        //加等号和结果
        [_displayString appendString:@" = "];
        [_displayString appendString: [_myCaculator.accumulater convertToString]];
        self.display.text = _displayString;
        
        _currentNumber = 0;
        _isNumerator = YES;
        _firstOperand = YES;
        [_displayString setString:@""];
    }
}
- (void)clickClear
{
    _currentNumber = 0;
    _isNumerator = YES;
    _firstOperand = YES;
    [_myCaculator clear];
    [_displayString setString:@""];
    self.display.text = _displayString;
}


#pragma mark - property
- (UILabel*)display
{
    if(!_display){
        _display = [[UILabel alloc] init];
        _display.backgroundColor = [UIColor lightGrayColor];
        
    }
    return _display;
}


- (UIButton*)ButtonPlus
{
    if(!_ButtonPlus){
        _ButtonPlus = [[UIButton alloc] initWithFrame:CGRectMake(40.0, 120.0, 70.0, 70.0)];
        _ButtonPlus.backgroundColor = [UIColor systemGray3Color];
        [_ButtonPlus setTitle:@"+" forState:UIControlStateNormal];
        _ButtonPlus.titleLabel.font = [UIFont systemFontOfSize:28.0];
    }
    return _ButtonPlus;
}
- (UIButton*)ButtonMul
{
    if(!_ButtonMul){
        _ButtonMul = [[UIButton alloc] initWithFrame:CGRectMake(40.0, 200.0, 70.0, 70.0)];
        _ButtonMul.backgroundColor = [UIColor systemGray3Color];
        [_ButtonMul setTitle:@"*" forState: UIControlStateNormal];
        _ButtonMul.titleLabel.font = [UIFont systemFontOfSize :28.0];
    }
    return _ButtonMul;
}
- (UIButton*)Button7
{
    if(!_Button7){
        _Button7 = [[UIButton alloc] initWithFrame:CGRectMake(40.0, 280.0, 70.0, 70.0)];
        _Button7.tag = 7;
        _Button7.backgroundColor = [UIColor systemGray3Color];
        [_Button7 setTitle:@"7" forState:UIControlStateNormal];
        _Button7.titleLabel.font = [UIFont systemFontOfSize:28.0];
    }
    return _Button7;
}
- (UIButton*)Button4
{
    if(!_Button4){
        _Button4 = [[UIButton alloc] initWithFrame: CGRectMake(40.0, 360.0, 70.0, 70.0)];
        _Button4.backgroundColor = [UIColor systemGray3Color];
        _Button4.tag = 4;
        [_Button4 setTitle:@"4" forState:UIControlStateNormal];
        _Button4.titleLabel.font = [UIFont systemFontOfSize :28.0];
    }
    return _Button4;
}
- (UIButton*)Button1
{
    if(!_Button1){
        _Button1 = [[UIButton alloc] initWithFrame: CGRectMake(40.0, 440.0, 70.0, 70.0)];
        _Button1.backgroundColor = [UIColor systemGray3Color];
        _Button1.tag = 1;
        [_Button1 setTitle:@"1" forState:UIControlStateNormal];
        _Button1.titleLabel.font = [UIFont systemFontOfSize:28.0];
    }
    return _Button1;
}
- (UIButton*)Button0
{
    if(!_Button0){
        _Button0 = [[UIButton alloc] initWithFrame:CGRectMake(40.0, 520.0, 70.0, 70.0)];
        _Button0.backgroundColor = [UIColor systemGray3Color];
        _Button0.tag = 0;
        [_Button0 setTitle:@"0" forState:UIControlStateNormal];
        _Button0.titleLabel.font = [UIFont systemFontOfSize:28.0];
    }
    return _Button0;
}

- (UIButton*)ButtonMins
{
    if(!_ButtonMins){
        _ButtonMins = [[UIButton alloc] initWithFrame:CGRectMake(120, 120.0, 70.0, 70.0)];
        _ButtonMins.backgroundColor = [UIColor systemGray3Color];
        [self.ButtonMins setTitle:@"-" forState:UIControlStateNormal];
        self.ButtonMins.titleLabel.font = [UIFont systemFontOfSize:28.0];
    }
    return _ButtonMins;
}
- (UIButton*)ButtonDiv
{
    if(!_ButtonDiv){
        _ButtonDiv = [[UIButton alloc] initWithFrame:CGRectMake(120, 200.0, 70.0, 70.0)];
        _ButtonDiv.backgroundColor = [UIColor systemGray3Color];
        [_ButtonDiv setTitle:@"/" forState:UIControlStateNormal];
        self.ButtonDiv.titleLabel.font = [UIFont systemFontOfSize:28.0];
    }
    return _ButtonDiv;
}
- (UIButton*)Button8
{
    if(!_Button8){
        _Button8 = [[UIButton alloc] initWithFrame:CGRectMake(120, 280.0, 70.0, 70.0)];
        _Button8.backgroundColor = [UIColor systemGray3Color];
        _Button8.tag = 8;
        [_Button8 setTitle:@"8" forState:UIControlStateNormal];
        _Button8.titleLabel.font = [UIFont systemFontOfSize :28.0];
    }
    return _Button8;
}
- (UIButton*)Button5
{
    if(!_Button5){
        _Button5 = [[UIButton alloc] initWithFrame:CGRectMake(120, 360.0, 70.0, 70.0)];
        _Button5.backgroundColor = [UIColor systemGray3Color];
        _Button5.tag = 5;
        [_Button5 setTitle:@"5" forState:UIControlStateNormal];
        _Button5.titleLabel.font = [UIFont systemFontOfSize:28.0];
    }
    return _Button5;
}
- (UIButton*)Button2
{
    if(!_Button2){
        _Button2 = [[UIButton alloc] initWithFrame:CGRectMake(120, 440.0, 70.0, 70.0)];
        _Button2.backgroundColor = [UIColor systemGray3Color];
        _Button2.tag = 2;
        [_Button2 setTitle:@"2" forState:UIControlStateNormal];
        _Button2.titleLabel.font = [UIFont systemFontOfSize:28.0];
    }
    return _Button2;
}
- (UIButton*)ButtonOver
{
    if(!_ButtonOver){
        _ButtonOver = [[UIButton alloc] initWithFrame:CGRectMake(120, 520.0, 70.0, 70.0)];
        _ButtonOver.backgroundColor = [UIColor systemGray3Color];
        [_ButtonOver setTitle:@"Over" forState:UIControlStateNormal];
        _ButtonOver.titleLabel.font = [UIFont systemFontOfSize:28.0];
    }
    return _ButtonOver;
}
- (UIButton*)ButtonClear
{
    if(!_ButtonClear){
        _ButtonClear = [[UIButton alloc] initWithFrame:CGRectMake(200.0, 120.0, 70.0, 150.0)];
        _ButtonClear.backgroundColor = [UIColor systemGray3Color];
        [_ButtonClear setTitle:@"C" forState:UIControlStateNormal];
        _ButtonClear.titleLabel.font = [UIFont systemFontOfSize:28.0];
    }
    return _ButtonClear;
}
- (UIButton*)Button9
{
    if(!_Button9){
        _Button9 = [[UIButton alloc] initWithFrame:CGRectMake(200.0, 280.0, 70.0, 70.0)];
        _Button9.backgroundColor = [UIColor systemGray3Color];
        _Button9.tag = 9;
        [_Button9 setTitle:@"9" forState:UIControlStateNormal];
        _Button9.titleLabel.font = [UIFont systemFontOfSize:29.0];
    }
    return _Button9;
}
- (UIButton*)Button6
{
    if(!_Button6){
        _Button6 = [[UIButton alloc] initWithFrame:CGRectMake(200.0, 360.0, 70.0, 70.0)];
        _Button6.backgroundColor = [UIColor systemGray3Color];
        _Button6.tag = 6;
        [_Button6 setTitle:@"6" forState:UIControlStateNormal];
        _Button6.titleLabel.font = [UIFont systemFontOfSize:28.0];
    }
    return _Button6;
}
- (UIButton*)Button3
{
    if(!_Button3){
        _Button3 = [[UIButton alloc] initWithFrame:CGRectMake(200.0, 440.0, 70.0, 70.0)];
        _Button3.backgroundColor = [UIColor systemGray3Color];
        _Button3.tag = 3;
        [_Button3 setTitle:@"3" forState:UIControlStateNormal];
        _Button3.titleLabel.font = [UIFont systemFontOfSize:38.0];
    }
    return _Button3;
}
- (UIButton*)ButtonEqu
{
    if(!_ButtonEqu){
        _ButtonEqu = [[UIButton alloc] initWithFrame:CGRectMake(200.f, 520.0, 70.0, 70.0)];
        _ButtonEqu.backgroundColor = [UIColor systemGray3Color];
        [_ButtonEqu setTitle:@"=" forState:UIControlStateNormal];
        _ButtonEqu.titleLabel.font = [UIFont systemFontOfSize:28.f];
    }
    return _ButtonEqu;
}

@end

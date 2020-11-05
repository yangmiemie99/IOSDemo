//
//  ViewController.m
//  showNum
//
//  Created by brook on 2020/9/8.
//  Copyright © 2020 brook. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.display];
    [self.view addSubview:self.clickButen];
    
}

- (UILabel *)display
{
    if (!_display) {
        _display = [[UILabel alloc] initWithFrame:CGRectMake(20.0, 20.0, 200.0, 150.0)];
        _display.backgroundColor = [UIColor blueColor];
    }
    return _display;
}
- (UIButton *) clickButen
{
    if(!_clickButen){
        _clickButen = [[UIButton alloc] initWithFrame:CGRectMake(100.0, 100.0, 20.0, 40.0)];
        _clickButen.backgroundColor = [UIColor redColor];
        [_clickButen addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clickButen;
}

-(void) click1{
    self.display.text = @"1";
}

@end

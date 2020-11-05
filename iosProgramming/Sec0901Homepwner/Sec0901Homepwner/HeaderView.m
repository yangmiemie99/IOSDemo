//
//  HeaderView.m
//  Sec0901Homepwner
//
//  Created by brook on 2020/9/18.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "HeaderView.h"

@implementation HeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

*/
//- (void)drawRect:(CGRect)rect {
//
//}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self addSubview:self.addButton];
        //???????还是涉及绝对位置，想要把不涉及怎么办？
        self.addButton.frame = CGRectMake(frame.origin.x + 5, frame.origin.y + 5, frame.size.width /2.f -20.f, frame.size.height -10.f);
        
        [self addSubview:self.edditButton];
        self.edditButton.frame = CGRectMake(frame.origin.x +  frame.size.width /2.f + 10, frame.origin.y + 5, frame.size.width /2.f -20.f, frame.size.height -10.f);
        
        self.backgroundColor= [UIColor clearColor];
        [_addButton addTarget:self action:@selector(addButtonBeTouchedAction) forControlEvents:UIControlEventTouchUpInside];
        [_edditButton addTarget:self action:@selector(edditButonBeTouchedAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}
- (void)addButtonBeTouchedAction
{
    if([self.delegte respondsToSelector:@selector(addButtonBeTouched)]){
        [self.delegte addButtonBeTouched];
    }
}
- (void)edditButonBeTouchedAction
{
    if([self.delegte respondsToSelector:@selector(edditButonBeTouched)]){
        [self.delegte edditButonBeTouched];
    }
}
#pragma mark --property
- (UIButton*)addButton
{
    if(!_addButton){
        _addButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _addButton.backgroundColor = [UIColor systemGray3Color];
        [_addButton setTitle:@"New" forState:UIControlStateNormal];
        _addButton.titleLabel.font = [UIFont systemFontOfSize:28.0];
    }
    return _addButton;
}
- (UIButton*)edditButton
{
    if(!_edditButton){
        _edditButton = [[UIButton alloc] initWithFrame:CGRectZero];
        _edditButton.backgroundColor = [UIColor systemGray3Color];
        [_edditButton setTitle:@"Edit" forState: UIControlStateNormal];
        _edditButton.titleLabel.font = [UIFont systemFontOfSize :28.0];
    }
    return _edditButton;
}


@end

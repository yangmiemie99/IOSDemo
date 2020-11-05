//
//  HeaderView.h
//  Sec0901Homepwner
//
//  Created by brook on 2020/9/18.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//给button的两个事件添加代理
@protocol HeaderViewDelegte <NSObject>

- (void)addButtonBeTouched;
- (void)edditButonBeTouched;

@end
@interface HeaderView : UIView

@property (nonatomic,strong) UIButton *addButton;
@property (nonatomic,strong) UIButton *edditButton;
//委托回调用接口
@property (nonatomic,weak) id<HeaderViewDelegte> delegte;

- (instancetype)initWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END

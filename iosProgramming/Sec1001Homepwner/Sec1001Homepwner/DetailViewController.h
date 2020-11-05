//
//  DetailViewController.h
//  Sec1001Homepwner
//
//  Created by brook on 2020/9/18.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class Item;
@interface DetailViewController : UIViewController

@property (nonatomic,strong) UITextField *nameField;
@property (nonatomic,strong) UITextField *serialNumberField;
@property (nonatomic,strong) UITextField *valueField;

@property (nonatomic,strong) UILabel *dataLabel;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *serialNumberLabel;
@property (nonatomic,strong) UILabel *valueLabel;

@property (nonatomic,strong) Item *item;
- (void)setItem:(Item *)item;
@end

NS_ASSUME_NONNULL_END

//
//  ReminderViewController.h
//  HypnoNerd
//
//  Created by brook on 2020/9/15.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReminderViewController : UIViewController

@property (nonatomic,strong) UIDatePicker* datePicker;
@property (nonatomic,strong) UIButton* buRemiander;

- (UIDatePicker*)datePicker;
- (UIButton*)buRemiander;
@end

NS_ASSUME_NONNULL_END

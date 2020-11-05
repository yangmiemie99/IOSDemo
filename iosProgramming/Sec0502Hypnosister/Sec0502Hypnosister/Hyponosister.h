//
//  Hyponosister.h
//  Sec0501Hypnosister
//
//  Created by brook on 2020/9/15.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface Hyponosister : UIView
- (void)drawRect:(CGRect)rect;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
@end


NS_ASSUME_NONNULL_END

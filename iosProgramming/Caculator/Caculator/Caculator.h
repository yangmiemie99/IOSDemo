//
//  Caculator.h
//  Caculator
//
//  Created by brook on 2020/9/9.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fraction.h"
NS_ASSUME_NONNULL_BEGIN

@interface Caculator : NSObject
@property (strong,nonatomic) Fraction* operand1;
@property (strong,nonatomic) Fraction* operand2;
@property (strong,nonatomic) Fraction* accumulater;

- (Fraction *)perFormOperation: (char) op;
- (void)clear;
@end

NS_ASSUME_NONNULL_END

//
//  Caculator.m
//  Caculator
//
//  Created by brook on 2020/9/9.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "Caculator.h"

@implementation Caculator

@synthesize operand1,operand2,accumulater;

- (id)init{
    self = [super init];
    if(self){
        operand1 = [[Fraction alloc] init];
        operand2 = [[Fraction alloc] init];
        accumulater = [ [Fraction alloc] init];
    }
    return self;
}

- (Fraction *)perFormOperation: (char) op
{
    Fraction * result;
    switch (op) {
        case '+':
            result = [operand1 add: operand2];
            break;
        case '-':
            result = [operand1 substract: operand2];
            break;
        case '*':
            result = [operand1 multiply: operand2];
            break;
        case '/':
            result = [operand1 divide: operand2];
            break;
        default:
            break;
    }
    accumulater.number = result.number;
    accumulater.denomation = result.denomation;
    return accumulater;
}
- (void)clear
{
    accumulater.number= 0;
    accumulater.denomation = 0;
}

@end

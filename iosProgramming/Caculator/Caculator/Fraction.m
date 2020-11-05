//
//  Fraction.m
//  Caculator
//
//  Created by brook on 2020/9/8.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "Fraction.h"

@implementation Fraction

@synthesize number,denomation;

- (void)print
{
    NSLog(@"%li/%li",number, denomation);
}
- (void)senTo:(NSInteger)n over:(NSInteger)d
{
    number = n;
    denomation = d;
}
- (Fraction *)add:(Fraction *)f
{
    Fraction* result = [[Fraction alloc] init];

    result.number = number * f.denomation +
    denomation * f.number;
    result.denomation = denomation * f.denomation;
    [result reduce];
    return result;
    
}
- (Fraction *)substract:(Fraction *)f
{
    Fraction * result = [[Fraction alloc] init];
    result.number = number * f.denomation - denomation * f.number;
    result.denomation = denomation * f.denomation;
    [result reduce];
    return result;
    
}
- (Fraction *) multiply:(Fraction *)f
{
    Fraction * result = [[Fraction alloc] init];
    result.number = number * f.number;
    result.denomation = denomation * f.denomation;
    [result reduce];
    return result;
}
- (Fraction *) divide:(Fraction *)f
{
    Fraction * result = [[Fraction alloc] init];
    result.number = number * f.denomation;
    result.denomation = denomation * f.number;
    [result reduce];
    return result;
}
- (void) reduce
{
    NSInteger v = denomation;
    NSInteger u = number;
    NSInteger temp;
    if(u == 0 || v == 1)
        return;
    else if(u <0)
        u = -u;
    while(v != 0){
        temp = u % v;
        u =v;
        v = temp;
        
    }
    number /= u;
    denomation /=u;
        
}
- (double)convertToNum
{
    if(denomation != 0)
        return (double)number/denomation;
    else
        return NAN;
}
- (NSString *)convertToString
{
    if(denomation == number){
        if(number == 0)
            return @"0";
        else
            return @"1";
    }
    else if(denomation == 0)
        return @"wrong input!";
    else if(denomation == 1)
        return [NSString stringWithFormat:@"%li",number];
    else
        return [NSString stringWithFormat:@"%g",(double)number/denomation];
}

@end

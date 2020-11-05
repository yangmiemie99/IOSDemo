//
//  Fraction.m
//  FractionTest
//
//  Created by brook on 2020/9/1.
//  Copyright © 2020 brook. All rights reserved.
//

#import "Fraction.h"

static int gCounter;

@implementation Fraction
{
    int numerator;
    int deminator;
}
-(void) print
{
    NSLog(@"%i / %i", numerator,deminator);
}
+(Fraction*) allocF
{
    extern int gCounter;
    ++gCounter;
    return [Fraction alloc];
}
+(int) count
{
    return gCounter;
}
-(void) setNumerator : (int) n
{
    numerator = n;
}
-(void) setDeminator : (int) d
{
    deminator = d;
}
-(int) numerator
{
    return numerator;
}
-(int) deminator
{
    return deminator;
}
-(double) convertToNum
{
    if(deminator != 0)
        return (double) numerator / deminator;
    else
        return NAN;
}
@end

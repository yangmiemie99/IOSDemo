//
//  main.m
//  FractionTest
//
//  Created by brook on 2020/9/1.
//  Copyright © 2020 brook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Fraction.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        Fraction * myFraction = [[Fraction allocF] init];
        [myFraction setNumerator:1];
        [myFraction setDeminator:3];
        NSLog(@"The value of myFrac is");
        [myFraction  print];
        id desd = [myFraction description];
        NSLog(@"%@",desd);
        NSLog(@"Fraction objective number : %i",[Fraction count]);
    }
    return 0;
}

//
//  Fraction.h
//  FractionTest
//
//  Created by brook on 2020/9/1.
//  Copyright © 2020 brook. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Fraction : NSObject
+(Fraction*) allocF;
+(int) count;
-(void) print;
-(void) setNumerator : (int) n;
-(void) setDeminator : (int) d;
-(int) numerator;
-(int) deminator;
-(double) convertToNum;
@end

NS_ASSUME_NONNULL_END

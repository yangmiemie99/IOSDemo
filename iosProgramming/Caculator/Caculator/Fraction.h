//
//  Fraction.h
//  Caculator
//
//  Created by brook on 2020/9/8.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Fraction : NSObject

@property NSInteger number ,denomation;

- (void) print;
- (void) senTo:(NSInteger)n over:(NSInteger)d;
- (Fraction *) add:(Fraction *)f;
- (Fraction *) substract:(Fraction *)f;
- (Fraction *) multiply:(Fraction *)f;
- (Fraction *) divide:(Fraction *)f;
- (void)reduce;
- (double)convertToNum;
- (NSString *)convertToString;
@end

NS_ASSUME_NONNULL_END

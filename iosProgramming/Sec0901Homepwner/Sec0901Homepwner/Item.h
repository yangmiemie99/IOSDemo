//
//  BNRItem.h
//  iOSProgramming
//
//  Created by palance on 15/8/30.
//  Copyright (c) 2015年 binglen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Item : NSObject

@property (nonatomic,strong) NSString *itemName;
@property (nonatomic,strong) NSString *serialNumber;
@property (nonatomic,assign) int valueInDollars;
@property (nonatomic,strong) NSDate *dateCreated;


+(instancetype)randomItem;

-(instancetype)init;
-(instancetype)initWithItemName:(NSString*)itemName serialNumber:(NSString*)serialNumber valueInDollars:(int)valueInDollars;


-(void)setItemName:(NSString*)itemName;
-(NSString*) itemName;

-(void)setSerialNumber:(NSString*)serialName;
-(NSString*)serialNumber;

-(void)setValueInDollars:(int)valueInDollars;
-(int)valueInDollars;

-(NSDate*)dateCreated;

-(NSString*)description;

@end

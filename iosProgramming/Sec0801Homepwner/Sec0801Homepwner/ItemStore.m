//
//  ItemStore.m
//  Sec0801Homepwner
//
//  Created by brook on 2020/9/17.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import "ItemStore.h"
#import "Item.h"

@interface ItemStore()
@property (nonatomic) NSMutableArray* privateItems;
@end

@implementation ItemStore

#pragma mark --初始化
// 只创建一个实例
+ (instancetype)sharedStore
{
    static ItemStore *sharedStore = nil;
    if(!sharedStore)
    {
        sharedStore = [[self alloc] initPrivate];
    }
    return sharedStore;
}
//单例模式，禁止用户init
- (instancetype)init
{
    return [NSException exceptionWithName:@"Sigleton" reason:@"Use +[ItemStore]" userInfo:nil];
}
- (instancetype)initPrivate
{
    self = [super init];
    if(self)
    {
        _privateItems = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark --method
- (Item*)createItem
{
    Item* item = [Item randomItem];
    [self.privateItems addObject:item];
    return item;
}

#pragma mark --property
- (NSArray*)allItems
{
    return [self.privateItems copy];
}
@end

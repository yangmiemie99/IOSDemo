//
//  ItemStore.h
//  Sec0801Homepwner
//
//  Created by brook on 2020/9/17.
//  Copyright © 2020 bytedance. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class Item;
@interface ItemStore : NSObject
//保存所有的item
@property (nonatomic,strong,readonly) NSArray* allItems;
+ (instancetype)sharedStore;
- (Item*)createItem;
- (void)removeItem:(Item *)item;
//移动行
- (void)moveItemAtIndex:(NSUInteger)fromIntex toIndex:(NSUInteger)toIndex;
@end

NS_ASSUME_NONNULL_END

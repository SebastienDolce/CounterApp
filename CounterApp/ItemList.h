//
//  ItemList.h
//  CounterApp
//
//  Created by sebastien dolce on 12/9/15.
//  Copyright (c) 2015 sebastien dolce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

@interface ItemList : NSManagedObject

@property (nonatomic, retain) NSString * itemName;
@property (nonatomic, retain) NSData * theImage;
@property (nonatomic, retain) NSSet *items;
@end

@interface ItemList (CoreDataGeneratedAccessors)

- (void)addItemsObject:(Item *)value;
- (void)removeItemsObject:(Item *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end

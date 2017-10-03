//
//  Item.h
//  CounterApp
//
//  Created by sebastien dolce on 12/10/15.
//  Copyright (c) 2015 sebastien dolce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Count, ItemList;

@interface Item : NSManagedObject

@property (nonatomic, retain) NSString * iName;
@property (nonatomic, retain) NSData * theImage;
@property (nonatomic, retain) NSString * totalCounts;
@property (nonatomic, retain) NSSet *counts;
@property (nonatomic, retain) ItemList *itemList;
@end

@interface Item (CoreDataGeneratedAccessors)

- (void)addCountsObject:(Count *)value;
- (void)removeCountsObject:(Count *)value;
- (void)addCounts:(NSSet *)values;
- (void)removeCounts:(NSSet *)values;

@end

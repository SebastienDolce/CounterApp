//
//  Count.h
//  CounterApp
//
//  Created by sebastien dolce on 12/9/15.
//  Copyright (c) 2015 sebastien dolce. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

@interface Count : NSManagedObject

@property (nonatomic, retain) NSString * theCount;
@property (nonatomic, retain) NSString * lattitude;
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSString * theDate;
@property (nonatomic, retain) NSData * theImage;
@property (nonatomic, retain) Item *item;

@end

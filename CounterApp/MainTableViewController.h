//
//  MainTableViewController.h
//  CounterApp
//
//  Created by sebastien dolce on 12/9/15.
//  Copyright (c) 2015 sebastien dolce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainTableViewController.h"
#import "ChildTableViewController.h"
#import "AppDelegate.h"
#import "ItemList.h"

@interface MainTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

+ (UIColor *)colorFromHexString:(NSString *)hexString;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) ItemList *itemList;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

@end

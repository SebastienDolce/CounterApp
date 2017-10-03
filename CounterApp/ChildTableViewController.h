//
//  ChildTableViewController.h
//  CounterApp
//
//  Created by sebastien dolce on 12/9/15.
//  Copyright (c) 2015 sebastien dolce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemList.h"
#import "Item.h"
#import "AppDelegate.h"
#import "CoreLocation/CoreLocation.h"
#import "MainTableViewController.h"
#import "ChildTableViewController.h"
#import "CountTableViewController.h"
#import "Count.h"
#import "ItemCell.h"

@interface ChildTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>
@property (nonatomic, strong) ItemList *itemList;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) Item *myItem;
@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) CLLocationManager *location;
@property (strong, nonatomic) NSString *lat, *log;

@end

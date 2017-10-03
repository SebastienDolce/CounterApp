//
//  CountTableViewController.h
//  CounterApp
//
//  Created by sebastien dolce on 12/10/15.
//  Copyright (c) 2015 sebastien dolce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Item.h"
#import "Count.h"
#import "MapKit/MapKit.h"
#import "CustomCell.h"
#import "AppDelegate.h"

//#import

@interface CountTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) NSFetchedResultsController * fetchedResultsController;
@property (nonatomic, strong) Item *myItem;

@end

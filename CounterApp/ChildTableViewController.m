//
//  ChildTableViewController.m
//  CounterApp
//
//  Created by sebastien dolce on 12/9/15.
//  Copyright (c) 2015 sebastien dolce. All rights reserved.
//

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#import "ChildTableViewController.h"

@interface ChildTableViewController ()

@end

@implementation ChildTableViewController
@synthesize itemList, managedObjectContext, fetchedResultsController, location,lat , log,myItem;


+ (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

- (void)viewDidLoad {


    [super viewDidLoad];
    self.title = itemList.itemName;
    self.location = [[CLLocationManager alloc] init];
    location.pausesLocationUpdatesAutomatically = NO;
    [location requestWhenInUseAuthorization];
    [location requestAlwaysAuthorization];
    
    
    
    location.delegate = self;
    
    if(IS_OS_8_OR_LATER){
        NSUInteger code = [CLLocationManager authorizationStatus];
        if (code == kCLAuthorizationStatusNotDetermined && ([self.location respondsToSelector:@selector(requestAlwaysAuthorization)] || [self.location respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            // choose one request according to your business.
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                [self.location requestAlwaysAuthorization];
            } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                [self.location  requestWhenInUseAuthorization];
            } else {
                NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
            }
        }
    }
    location.desiredAccuracy = kCLLocationAccuracyBest;
    //location.distanceFilter = kCLDistanceFilterNone;
    [location startUpdatingLocation];
    
    
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    //self.title = myItems.itemName;
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action: @selector(addNewItem:)];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.navigationItem.rightBarButtonItem.tintColor = [ChildTableViewController colorFromHexString:@"3BB5FF"];
    
    self.navigationController.navigationBar.tintColor = [ChildTableViewController colorFromHexString:@"3BB5FF"];
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[ChildTableViewController colorFromHexString:@"3BB5FF"] ,NSForegroundColorAttributeName,[UIColor blackColor], NSBackgroundColorAttributeName, nil ];
    
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    
    //NSLog(@"count: %@", );
    NSError *error = nil;
    if (![[self fetchedResultsController] performFetch:&error])
    {
        NSLog(@"error: %@", error);
        abort();
    }

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void) viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (void) addNewItem:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"New item" message:@"Enter a name for the item" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Add", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // The user created a new item, add it
    if (buttonIndex == 1)
    {
        // Get the input text
       // Item *item = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:[self managedObjectContext]];
        myItem = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:[self managedObjectContext]];
        myItem.itemList = itemList;
        myItem.iName = [[alertView textFieldAtIndex:0] text];
        myItem.totalCounts = [NSString stringWithFormat:@"%d",0];
    
        //[myItems addItem:anItem];
        //NSString *newItem = [[alertView textFieldAtIndex:0] text];
        NSError *error = nil;
        if ([self.managedObjectContext hasChanges])
        {
            if (![self.managedObjectContext save:&error])
            {
                NSLog(@"Save Failed: %@", [error localizedDescription]);
            }
            else
            {
                NSLog(@"Save Succeeded");
            }
        }
        

        [self.tableView reloadData];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSManagedObjectContext *) managedObjectContext
{
    return [(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id<NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCell1" forIndexPath:indexPath];
    
    // Configure the cell...
    Item *item = [self.fetchedResultsController objectAtIndexPath:indexPath];
   // NSLog(@"%@%@\n%@%@",@"name: ", item.iName,@"count", item.totalCounts);
      if(!cell)
    {
        cell = [[ItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ItemCell1"];
    }
    cell.titleLabel.text =item.iName;
    cell.countLabel.text =[NSString stringWithFormat:@"%@", item.totalCounts];

       // cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", item.totalCounts];
      // cell.textLabel.text = item.iName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath

{
    //NSUInteger row = [indexPath row];
    Count *count = [NSEntityDescription insertNewObjectForEntityForName:@"Count" inManagedObjectContext:[self managedObjectContext]];
    Item *item = [self.fetchedResultsController objectAtIndexPath:indexPath];
    count.item =item;
    
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    
    [location startUpdatingLocation];
    
    
    int x = [item.totalCounts intValue];
    x++;
   // NSString *thecount = [NSString stringWithFormat:@"%@" , item.totalCounts+1];
    
    count.theCount = [NSString stringWithFormat:@"%d", x];
    count.theDate = [dateFormatter stringFromDate:today];
    count.longitude = log;
    count.lattitude = lat;
    //NSNumber *yourNumber =
    item.totalCounts = [NSString stringWithFormat:@"%d", x];
    NSError *error = nil;
    if ([self.managedObjectContext hasChanges])
    {
        if (![self.managedObjectContext save:&error])
        {
            NSLog(@"Save Failed: %@", [error localizedDescription]);
        }
        else
        {
            NSLog(@"Save Succeeded");
        }
    }


    [self.tableView reloadData];
}


- (void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger row = [indexPath row];
    Item *item = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //TableViewController *detailview = [[TableViewController alloc] init];
    CountTableViewController *countview = [self.storyboard instantiateViewControllerWithIdentifier:@"countTable"];
    //[self.navigationController pushViewController:controller animated:YES];
    countview.myItem = item;
    [self.navigationController pushViewController:countview animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self managedObjectContext];
        Item *item = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [context deleteObject:item];
        NSError *error = nil;
        if (![context save:&error])
        {
            NSLog(@"error: %@", error);
        }

    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
   // NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        log =[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
        lat =[NSString stringWithFormat:@"%.8f", currentLocation.coordinate.latitude];
        
        
    }
}




#pragma mark - Fetched Results Controller Section
-(NSFetchedResultsController*)fetchedResultsController
{
    if (fetchedResultsController != nil)
    {
        return fetchedResultsController;
    }
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [NSFetchedResultsController deleteCacheWithName:nil];
    NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Item" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"iName" ascending:YES];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"itemList = %@", itemList];
    [fetchRequest setPredicate:predicate];
    
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    fetchRequest.sortDescriptors = sortDescriptors;
    fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    fetchedResultsController.delegate = self;
    return fetchedResultsController;
}


#pragma mark - Fetched Results Controller Delegates

- (void) controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

-(void) controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch (type)
    {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
        {
            Item *item = [self.fetchedResultsController objectAtIndexPath:indexPath];
            ItemCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.titleLabel.text = item.iName;
        }
            break;
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
    }
}

- (void) controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch (type)
    {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationBottom];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationBottom];
            break;
    }
}




@end

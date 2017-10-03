//
//  CountTableViewController.m
//  CounterApp
//
//  Created by sebastien dolce on 12/10/15.
//  Copyright (c) 2015 sebastien dolce. All rights reserved.
//

#import "CountTableViewController.h"

@interface CountTableViewController ()

@end

@implementation CountTableViewController
@synthesize myItem,managedObjectContext,fetchedResultsController;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.title = myItem.iName;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0)
    {
        return 123.0f;
    }
    else if(indexPath.row == 1)
    {
        return 313.0f;
    }
    else
    {
        return 55.0f;
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    // Configure the cell...
    NSString *identifier;
    if (indexPath.row == 0) {
        identifier = @"countCell2";
    } else if (indexPath.row == 1) {
        identifier = @"countCell1";
    }else if (indexPath.row == 2) {
        identifier = @"countCell3";
    }


    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if(!cell)
    {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"item= %@", myItem];
    NSFetchRequest* fetchRequest = [NSFetchRequest new];
    NSManagedObjectContext *context = [self managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Count" inManagedObjectContext:context];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setEntity:entity];
    
    NSError* error = nil;
    NSArray* counts = [context executeFetchRequest: fetchRequest error: &error];

    MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
        NSMutableArray *arrCoordinateStr = [[NSMutableArray alloc] initWithCapacity:[counts count]];
    
    
    for (int i = 0; i <+[counts count]; i++)
    {
        
        MKPointAnnotation *mapPin = [[MKPointAnnotation alloc] init];
        double latdouble = [[[counts objectAtIndex:i] lattitude] doubleValue];
        double longdouble = [[[counts objectAtIndex:i] longitude] doubleValue];
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(latdouble, longdouble);
        mapPin.title =[[counts objectAtIndex:i] theCount];
        mapPin.coordinate = coord;
        
        MKCoordinateRegion region = {coord, span};
                [cell.mapView setRegion:region];
        [cell.mapView addAnnotation:mapPin];
    }
    cell.countLabel.text =[NSString stringWithFormat:@"%lu",(unsigned long)[counts count]];

    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

@end

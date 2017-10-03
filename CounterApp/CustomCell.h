//
//  CustomCell.h
//  CounterApp
//
//  Created by sebastien dolce on 12/10/15.
//  Copyright (c) 2015 sebastien dolce. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapKit/MapKit.h"

@interface CustomCell : UITableViewCell
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;

@end

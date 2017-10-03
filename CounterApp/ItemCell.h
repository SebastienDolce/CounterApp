//
//  ItemCell.h
//  CounterApp
//
//  Created by sebastien dolce on 12/10/15.
//  Copyright (c) 2015 sebastien dolce. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *countLabel;

@end

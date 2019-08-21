//
//  MealListTableViewCell.h
//  KCal
//
//  Created by Pipl014 on 24/07/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MealListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgfood;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblOrderNo;
@property (weak, nonatomic) IBOutlet UILabel *lblTime;

@end

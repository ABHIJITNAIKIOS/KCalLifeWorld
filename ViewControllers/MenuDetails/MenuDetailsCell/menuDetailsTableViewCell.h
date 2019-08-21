//
//  menuDetailsTableViewCell.h
//  KCal
//
//  Created by Pipl-10 on 14/03/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface menuDetailsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lbltitle;
@property (weak, nonatomic) IBOutlet UILabel *lblkcalval;
@property (weak, nonatomic) IBOutlet UILabel *lblfatvalue;
@property (weak, nonatomic) IBOutlet UILabel *lblcarbsvalue;
@property (weak, nonatomic) IBOutlet UILabel *lblproval;
@property (weak, nonatomic) IBOutlet UIImageView *imgfirst;
@property (weak, nonatomic) IBOutlet UIImageView *imgsecond;
@property (weak, nonatomic) IBOutlet UIImageView *imgthird;
@property (weak, nonatomic) IBOutlet UIImageView *imgfour;

@end

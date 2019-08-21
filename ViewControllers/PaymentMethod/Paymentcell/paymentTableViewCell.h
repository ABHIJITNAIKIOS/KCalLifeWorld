//
//  paymentTableViewCell.h
//  KCal
//
//  Created by Pipl014 on 20/07/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface paymentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgCard;
@property (weak, nonatomic) IBOutlet UILabel *lblCardName;
@property (weak, nonatomic) IBOutlet UILabel *lblCarddate;
@property (strong, nonatomic) IBOutlet UIButton *btndeletecard;
@property (strong, nonatomic) IBOutlet UIView *viewnorecord;

@end

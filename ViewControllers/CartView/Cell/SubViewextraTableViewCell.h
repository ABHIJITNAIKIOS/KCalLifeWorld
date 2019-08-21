//
//  SubViewextraTableViewCell.h
//  KCal
//
//  Created by Pipl-06 on 25/07/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubViewextraTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblside;
@property (weak, nonatomic) IBOutlet UILabel *lblsidedetail;
@property (strong, nonatomic) IBOutlet UILabel *lblsideamt;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lblsideTop;

@end

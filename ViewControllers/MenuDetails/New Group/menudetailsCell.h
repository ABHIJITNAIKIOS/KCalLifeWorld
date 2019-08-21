//
//  menudetailsCell.h
//  KCal
//
//  Created by Pipl-10 on 02/07/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface menudetailsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblmenutitle;
@property (strong, nonatomic) IBOutlet UIImageView *imgmenucircle;
@property (weak, nonatomic) IBOutlet UILabel *lblprice;

@end

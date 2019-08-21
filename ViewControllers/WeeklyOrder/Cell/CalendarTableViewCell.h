//
//  CalendarTableViewCell.h
//  RollingPear
//
//  Created by Pipl-06 on 22/02/18.
//  Copyright © 2018 Pipl-06PIPLPanacea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lbltime;

@property (weak, nonatomic) IBOutlet UILabel *lbldate;
@property (strong, nonatomic) IBOutlet UIButton *btnclose;

@end

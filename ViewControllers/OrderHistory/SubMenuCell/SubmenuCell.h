//
//  SubmenuCell.h
//  KCal
//
//  Created by Pipl-10 on 29/06/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubmenuCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *lblname;
@property (strong, nonatomic) IBOutlet UILabel *lblamt;
@property (strong, nonatomic) IBOutlet UIButton *btnqty;
@property (weak, nonatomic) IBOutlet UIView *viewdynamic;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *CHTdynamic;

@end

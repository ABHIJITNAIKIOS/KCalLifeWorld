//
//  ExtraViewCell.h
//  KCal
//
//  Created by Pipl-02 on 06/08/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExtraViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *btnaddcomments;
@property (strong, nonatomic) IBOutlet UIButton *btnaddmoreitems;
@property (strong, nonatomic) IBOutlet UIButton *btnaddcutlery;
@property (strong, nonatomic) IBOutlet UIImageView *imhcutlery;
@property (strong, nonatomic) IBOutlet UILabel *lblsubtotal;
@property (strong, nonatomic) IBOutlet UILabel *lblcutlery;

@end

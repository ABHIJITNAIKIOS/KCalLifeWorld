//
//  SubmenuCell.m
//  KCal
//
//  Created by Pipl-10 on 29/06/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "SubmenuCell.h"
#import "OrderHistoryController.h"
@implementation SubmenuCell

- (void)awakeFromNib
{
    [super awakeFromNib];

    OrderHistoryController *obj=[[OrderHistoryController alloc]initWithNibName:@"OrderHistoryController" bundle:nil];
    obj.height=self.contentView.frame.size.height;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end

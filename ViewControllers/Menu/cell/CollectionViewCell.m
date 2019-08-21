//
//  CollectionViewCell.m
//  KCal
//
//  Created by Apple on 28/02/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
  
    _lblBottom.frame=CGRectMake(_lblName.frame.origin.x, _lblName.frame.origin.y+_lblName.frame.size.height,_lblName.frame.size.width+2, 1.0f);
}



@end

//
//  AccordionHeaderView.h
//  FZAccordionTableViewExample
//
//  Created by Krisjanis Gaidis on 6/7/15.
//  Copyright (c) 2015 Fuzz Productions, LLC. All rights reserved.
//

#import "FZAccordionTableView.h"

static const CGFloat kDefaultAccordionHeaderViewHeight = 100;
static NSString *const kAccordionHeaderViewReuseIdentifier = @"AccordionHeaderViewReuseIdentifier";

@interface AccordionHeaderView : FZAccordionTableViewHeaderView
@property (strong, nonatomic) IBOutlet UILabel *lblname;
@property (strong, nonatomic) IBOutlet UIImageView *imgbackground;
@property (strong, nonatomic) IBOutlet UIImageView *imgdown;
@property (strong, nonatomic) IBOutlet UIImageView *imgUpper;
@property (strong, nonatomic) IBOutlet UILabel *lbltitle;
@property (strong, nonatomic) IBOutlet UILabel *lblline;
@property (strong, nonatomic) IBOutlet UILabel *lblcount;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *lblHeaderleading;



@end

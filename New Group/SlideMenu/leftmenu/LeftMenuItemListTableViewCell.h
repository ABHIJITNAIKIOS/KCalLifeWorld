//
//  LeftMenuItemListTableViewCell.h
//  HelpyProj
//
//  Created by Panacea on 13/10/15.
//  Copyright (c) 2015 Panacea. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftMenuItemListTableViewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *lblBorder;

@property (weak, nonatomic) IBOutlet UIView *imgName;
@property (weak, nonatomic) IBOutlet UIImageView *imgText;

@property (strong, nonatomic) IBOutlet UILabel *lblItemName;
@property (strong, nonatomic) IBOutlet UIImageView *imgitem;
@property (strong, nonatomic) IBOutlet UIImageView *imgProfle;
@property (strong, nonatomic) IBOutlet UILabel *lblNameOfPerson;
@property (strong, nonatomic) IBOutlet UILabel *lblDescription;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;

@property (weak, nonatomic) IBOutlet UILabel *lblcolor;


@end

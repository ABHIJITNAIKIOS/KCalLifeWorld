//
//  MyAccountViewController.h
//  KCal
//
//  Created by Pipl-01 on 29/06/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAccountViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *imgProfile;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic) IBOutlet UITableView *tblListing;
@property (strong, nonatomic) IBOutlet UIButton *btnOrderFood;
- (IBAction)btnOrderFood:(id)sender;

@end

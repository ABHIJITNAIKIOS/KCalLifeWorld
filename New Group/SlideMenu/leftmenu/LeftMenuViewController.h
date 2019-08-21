//
//  MenuViewController.h
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"

@interface LeftMenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *btnsignin;

@property (nonatomic, weak) IBOutlet UITableView *MytableView;

@property (nonatomic, assign) BOOL slideOutAnimationEnabled;

@property (weak, nonatomic) IBOutlet UIImageView *imgprofile;

@property (weak, nonatomic) IBOutlet UILabel *lblname;

@property (weak, nonatomic) IBOutlet UILabel *lblemail;

@end

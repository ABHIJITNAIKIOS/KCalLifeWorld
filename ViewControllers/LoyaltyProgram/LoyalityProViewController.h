//
//  LoyalityProViewController.h
//  KCal
//
//  Created by Pipl-09 on 05/03/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface LoyalityProViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

- (IBAction)btntermsclicked:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *viewpopup;
- (IBAction)btnclosepopup:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblview;


@end

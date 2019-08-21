//
//  PaymentViewController.h
//  KCal
//
//  Created by Pipl-10 on 06/08/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tblCardList;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ChgtCardList;
- (IBAction)btnaddCardTapped:(id)sender;

@end

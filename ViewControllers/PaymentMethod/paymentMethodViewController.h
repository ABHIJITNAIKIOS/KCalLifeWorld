//
//  paymentMethodViewController.h
//  KCal
//
//  Created by Pipl014 on 20/07/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>
@import VisaCheckoutSDK;

@interface paymentMethodViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIScrollView *viewscroll;
@property (weak, nonatomic) IBOutlet UITableView *tblCardList;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ChgtCardList;
@property (strong, nonatomic) NSString *flag;
@property (strong, nonatomic) NSMutableDictionary *dictorder;
@property (weak, nonatomic) IBOutlet VisaCheckoutButton *checkoutButton;
@property (nonatomic, copy) LaunchHandle launchCheckoutHandle;
@property (weak, nonatomic) IBOutlet UIView *viewvisa;
@property (weak, nonatomic) IBOutlet UIView *viewaddcard;
@property (strong, nonatomic) IBOutlet UIView *viewcash;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewheight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *visaheight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewcheckouttop;
- (IBAction)btnCODtapped:(id)sender;
- (IBAction)btnaddCardTapped:(id)sender;


@end

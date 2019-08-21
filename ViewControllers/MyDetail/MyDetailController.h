//
//  MyAccountController.h
//  KCal
//
//  Created by Pipl-10 on 01/03/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownListView.h"
#define mblnoLength 7

@interface MyDetailController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UIButton *btnProfilePic;
- (IBAction)btnProfilePic:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtFullName;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtDob;
@property (strong, nonatomic) IBOutlet UIButton *btnDOB;
- (IBAction)btnDOB:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtnationality;
@property (strong, nonatomic) IBOutlet UITextField *txtmobilenum;
@property (strong, nonatomic) IBOutlet UIView *ViewDatePicker;
@property (strong, nonatomic) IBOutlet UIDatePicker *DatePicker;
@property (strong, nonatomic) IBOutlet UILabel *lblBlur;
@property (weak, nonatomic) IBOutlet UITextField *txtprefix;
@property (weak, nonatomic) IBOutlet UIButton *btnprefix;
@property (weak, nonatomic) IBOutlet UITableView *tblprefix;
@property (strong, nonatomic) IBOutlet UITableView *tblarea;
@property (weak, nonatomic) IBOutlet UIButton *btneditfullname;
@property (weak, nonatomic) IBOutlet UIButton *btneditemail;
@property (weak, nonatomic) IBOutlet UIButton *btneditmobile;
@property (weak, nonatomic) IBOutlet UIButton *btneditDOB;
@property (weak, nonatomic) IBOutlet UIButton *btnupdate;
@property (weak, nonatomic) IBOutlet UIButton *btneditnationality;
@property (weak, nonatomic) IBOutlet UIImageView *imgprofile;
@property (strong, nonatomic) IBOutlet UITextField *txtindustry;
@property (strong, nonatomic) IBOutlet UIButton *btnindustry;
@property (strong, nonatomic) IBOutlet UIButton *btneditindustry;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tblareatop;

@end

//
//  RegisterViewController.h
//  KCal
//
//  Created by Apple on 22/02/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiFHUD.h"
#define mblnoLength 7

@interface RegisterViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *txtNickName;

@property (weak, nonatomic) IBOutlet UITextField *txtFullName;

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;

@property (weak, nonatomic) IBOutlet UITextField *txtMobile;

@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@property (weak, nonatomic) IBOutlet UIButton *btnShowPassword;

@property (weak, nonatomic) IBOutlet UIButton *btnsignin;

@property (weak, nonatomic) IBOutlet UILabel *lblnick;

@property (weak, nonatomic) IBOutlet UILabel *lblfull;

@property (weak, nonatomic) IBOutlet UILabel *lblemail;

@property (weak, nonatomic) IBOutlet UILabel *lblmbl;

@property (weak, nonatomic) IBOutlet UILabel *lblpass;

@property (weak, nonatomic) IBOutlet UIImageView *imgeye;

@property (weak, nonatomic) IBOutlet UITextField *txtprefix;

@property (weak, nonatomic) IBOutlet UIButton *btnprefix;

@property (weak, nonatomic) IBOutlet UIView *viewblur;

@property (weak, nonatomic) IBOutlet UITableView *tblprefix;

@end

//
//  LoViewController.h
//  KCal
//
//  Created by Apple on 22/02/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterViewController.h"

@interface LoViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *lblemail;

@property (weak, nonatomic) IBOutlet UILabel *lblpass;

@property (weak, nonatomic) IBOutlet UIButton *btnsignup;

- (IBAction)btnForgotPassword:(id)sender;

- (IBAction)btnSignIn:(id)sender;

- (IBAction)btnSignUp:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;

@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@property (weak, nonatomic) IBOutlet UIImageView *imgeye;

@property (weak, nonatomic) IBOutlet UIButton *btnShowPassword;


@end

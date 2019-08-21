//
//  ForgotPasswordViewController.h
//  KCal
//
//  Created by Pipl-01 on 28/06/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ForgotPasswordViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIButton *btnSendHelp;
- (IBAction)btnSendHelp:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtForgotPassword;

@end

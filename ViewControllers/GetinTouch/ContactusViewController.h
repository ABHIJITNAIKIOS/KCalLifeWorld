//
//  ContactusViewController.h
//  KCal
//
//  Created by Apple on 09/03/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>
#define mblLength 10

@interface ContactusViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtName;
@property (weak, nonatomic) IBOutlet UITextView *txtviewMessage;

@property (weak, nonatomic) IBOutlet UITextField *txtMobileNumber;

@property (weak, nonatomic) IBOutlet UITextField *txtEmail;

@property (weak, nonatomic) IBOutlet UITextField *txtmessage;
@property (weak, nonatomic) IBOutlet UILabel *lblmsg;

@property (weak, nonatomic) IBOutlet UITextField *txtSubject;

- (IBAction)btnCallNow:(id)sender;

- (IBAction)btnSubmit:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblNmae;
@property (weak, nonatomic) IBOutlet UILabel *lblMobile;
@property (weak, nonatomic) IBOutlet UILabel *lblemail;

@end

//
//  CheckoutViewController.h
//  KCal
//
//  Created by Pipl014 on 20/07/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"
#define mblnoLen 10

@interface CheckoutViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lbladdress;
- (IBAction)btnaddress:(id)sender;
//@property (weak, nonatomic) IBOutlet UILabel *lblphone;
- (IBAction)btnphonenumber:(id)sender;
- (IBAction)btnriderinstr:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewvisa;
@property (weak, nonatomic) IBOutlet UIView *viewcash;
@property (weak, nonatomic) IBOutlet UIButton *btnplaceorder;
- (IBAction)btnplaceorder:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *lblphone;
@property (weak, nonatomic) IBOutlet UIView *viewblur;
@property (weak, nonatomic) IBOutlet UIView *viewpop;
@property (weak, nonatomic) IBOutlet UITextView *txtcomment;
- (IBAction)btnaddcomment:(id)sender;
@property (strong, nonatomic) NSDictionary *dictcard;
@property (strong, nonatomic) NSString *strpaymentmode;
@property (weak, nonatomic) IBOutlet UIImageView *imgcard;
@property (weak, nonatomic) IBOutlet UILabel *lblcardtype;
@property (weak, nonatomic) IBOutlet UILabel *lblcardnumber;
@property (weak, nonatomic) IBOutlet UIButton *btndeletecard;
@property (strong, nonatomic) NSDictionary *dictPayment;
@property (strong, nonatomic) IBOutlet UIImageView *imgvisacheckout;

@end

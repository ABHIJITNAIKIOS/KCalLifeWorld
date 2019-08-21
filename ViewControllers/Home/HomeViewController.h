//
//  HomeViewController.h
//  KCal
//
//  Created by Apple on 28/02/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+AFNetworking.h"
#import "FLAnimatedImage.h"
@interface HomeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UITextViewDelegate,UIAlertViewDelegate>

- (IBAction)btnOrderNOw:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *DeliveryView;
@property (strong, nonatomic) IBOutlet FLAnimatedImageView *imgview;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imgtop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *imgmenutop;
@property (strong, nonatomic) IBOutlet UILabel *lblviewmenu;
@property (strong, nonatomic) IBOutlet UILabel *lblorderhistory;
@property (strong, nonatomic) IBOutlet UILabel *lblloyalty;
@property (strong, nonatomic) IBOutlet UILabel *lblweeklyorder;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *historytop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *menutop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *loyaltytop;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *weeklytop;
@property (strong, nonatomic) IBOutlet UILabel *lblorder;
@property (strong, nonatomic) IBOutlet UITableView *tbladdress;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tbladdressHeight;
@property (strong, nonatomic) IBOutlet UIView *viewredirect;
@property (strong, nonatomic) IBOutlet UIDatePicker *datepicker;
@property (strong, nonatomic) IBOutlet UIView *viewhungry;
@property (strong, nonatomic) IBOutlet UIView *viewpicker;
@property (strong, nonatomic) IBOutlet UITextField *txtdeliveryaddress;
@property (strong, nonatomic) IBOutlet UIView *viewlogin;
@property (weak, nonatomic) IBOutlet UIButton *btnclose;
@property (strong, nonatomic) NSString *flag;
@property (weak, nonatomic) IBOutlet UILabel *lblback;
@property (strong, nonatomic) IBOutlet UIButton *btnASAP;
@property (strong, nonatomic) IBOutlet UIButton *btnlater;
@property (strong, nonatomic) IBOutlet UILabel *lbltap;
@property (strong, nonatomic) IBOutlet UILabel *lbltap2;
@property (strong, nonatomic) IBOutlet UILabel *lbltap3;
@property (weak, nonatomic) IBOutlet UIView *viewpopLastorder;
@property (weak, nonatomic) IBOutlet UIButton *btnbad;
@property (weak, nonatomic) IBOutlet UIButton *btnavg;
@property (weak, nonatomic) IBOutlet UIButton *btngood;
@property (strong, nonatomic) IBOutlet UIView *viewGiverating;
@property (weak, nonatomic) IBOutlet UIButton *btnRatingsmily;
@property (weak, nonatomic) IBOutlet UITextView *txtrateMessage;
@property (strong, nonatomic) NSString *str;
@property (strong, nonatomic) IBOutlet UIView *viewoffer;
@property (strong, nonatomic) IBOutlet UIImageView *imgoffer;
@property (strong, nonatomic) IBOutlet UIButton *btncloseoffer;
@property (strong, nonatomic) IBOutlet UIButton *btnfindoffer;
@property (weak, nonatomic) IBOutlet UILabel *lblbackoffer;


@end

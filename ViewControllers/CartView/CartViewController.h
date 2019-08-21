//
//  CartViewController.h
//  KCal
//
//  Created by Pipl-06 on 24/07/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"

@interface CartViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TopOfviewafterpromocode;
@property (weak, nonatomic) IBOutlet UIButton *btnaddmoreitems;
@property (weak, nonatomic) IBOutlet UIView *viewpromocode;
@property (weak, nonatomic) IBOutlet UIView *viewafterpomocode;
@property (weak, nonatomic) IBOutlet UIButton *btnpaymentmethod;
@property (strong, nonatomic) IBOutlet UIButton *btnpromo;
@property (strong, nonatomic) IBOutlet UILabel *lblprotitle;
@property (weak, nonatomic) IBOutlet UIView *viewmain;
@property (weak, nonatomic) IBOutlet UIView *tempview;
@property (weak, nonatomic) IBOutlet UIImageView *imgselectcutlery;
@property (weak, nonatomic) IBOutlet UIButton *btnselectcutlery;
@property (weak, nonatomic) IBOutlet UIButton *btnselectpaymentmethod;
@property (weak, nonatomic) IBOutlet UILabel *lbldeliveryfee;
@property (weak, nonatomic) IBOutlet UILabel *lbldiscount;
@property (weak, nonatomic) IBOutlet UILabel *lbltotalprice;
@property (weak, nonatomic) IBOutlet UILabel *lblpromotitle;
@property (weak, nonatomic) IBOutlet UILabel *lblsubtotalprice;
@property (weak, nonatomic) IBOutlet UILabel *lbldeliveryfee1;
@property (weak, nonatomic) IBOutlet UILabel *lbltotalprice1;
//- (IBAction)btnaddmoreitem:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lbldiscounttitle;
@property (weak, nonatomic) IBOutlet UIView *lblblurpromo;
- (IBAction)btnpaymentmethod:(id)sender;
@property (strong, nonatomic)NSString *strreorder;
@property (weak, nonatomic) IBOutlet UIView *viewblur;
@property (weak, nonatomic) IBOutlet UIView *viewaddqty;
@property (weak, nonatomic) IBOutlet UILabel *lbltitle;
@property (weak, nonatomic) IBOutlet UILabel *lblside;
@property (weak, nonatomic) IBOutlet UILabel *lblextra;
@property (weak, nonatomic) IBOutlet UILabel *lblqty;
@property (weak, nonatomic) IBOutlet UIButton *btnincrease;
- (IBAction)btnincrease:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btndecrease;
- (IBAction)btndecrease:(id)sender;
- (IBAction)btnupdate:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tblitems;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tblitemHeight;
@property (weak, nonatomic) IBOutlet UITableView *tblselectmenu;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tblselectmenuheight;
@property (strong, nonatomic) IBOutlet UIView *viewcomment;
@property (strong, nonatomic) IBOutlet UIView *viewEnterPromocode;
@property (weak, nonatomic) IBOutlet UILabel *lblcutlery;
- (IBAction)btncutlery:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtpromocode;
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *txtcommentdata;
@property (strong, nonatomic) IBOutlet UIButton *btnaddPromocode;
@property (weak, nonatomic) IBOutlet UIView *lblblurcomment;

@end

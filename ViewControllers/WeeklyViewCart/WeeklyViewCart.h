//
//  WeeklyViewCart.h
//  KCal
//
//  Created by Pipl-10 on 02/08/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZAccordionTableView.h"
#import "UIPlaceHolderTextView.h"
@interface WeeklyViewCart : UIViewController<UITableViewDelegate, UITableViewDataSource,FZAccordionTableViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *viewEnterPromocode;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TopOfviewafterpromocode;
@property (weak, nonatomic) IBOutlet UIView *viewpromocode;
@property (weak, nonatomic) IBOutlet UIView *viewafterpomocode;
@property (strong, nonatomic) IBOutlet UIView *viewfooter;
@property (strong, nonatomic) IBOutlet FZAccordionTableView *tblobj;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tblobjheight;
@property (weak, nonatomic) IBOutlet UILabel *lbldate;
@property (weak, nonatomic) IBOutlet UIImageView *imgdown;
@property (weak, nonatomic) IBOutlet UIButton *btnclickdate;
@property (strong, nonatomic) IBOutlet UIView *viewheader;
@property (strong, nonatomic) IBOutlet UIView *viewqty;
@property(strong,nonatomic)NSString *qtyflag;
@property (strong, nonatomic) IBOutlet UILabel *lblqty;
@property(strong,nonatomic) NSMutableArray *arrweekllydatas;
@property (strong, nonatomic) IBOutlet UILabel *lbltitle;
@property (strong, nonatomic) IBOutlet UITableView *tblselectmenu;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tblselectmenuheight;
@property (strong, nonatomic) IBOutlet UIView *viewcomment;
@property (strong, nonatomic) IBOutlet UIPlaceHolderTextView *txtcomment;
@property (strong, nonatomic) IBOutlet UITextField *txtpromocode;
@property (strong, nonatomic) IBOutlet UILabel *lbldeliveryfees;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewobjheight;
@property (strong, nonatomic) IBOutlet UIView *viewtblobj;
@property (strong, nonatomic) IBOutlet UILabel *lbltotalprice;
@property (strong, nonatomic) IBOutlet UILabel *lblprotitle;
@property (strong, nonatomic) IBOutlet UIButton *btnaddPromocode;
@property (weak, nonatomic) IBOutlet UILabel *lbldeliveryfee;
@property (weak, nonatomic) IBOutlet UILabel *lbldiscount;
@property (weak, nonatomic) IBOutlet UILabel *lbltotalprice1;
@property (weak, nonatomic) IBOutlet UILabel *lblpromotitle;
@property (weak, nonatomic) IBOutlet UILabel *lbldiscounttitle;
@property (strong, nonatomic) IBOutlet UIButton *btnpromo;
@property (weak, nonatomic) IBOutlet UIButton *btnselectpaymentmethod;
@property (weak, nonatomic) IBOutlet UIView *lblblurcomment;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lblviewheight;

@end

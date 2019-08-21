//
//  MenuDetailsController.h
//  KCal
//
//  Created by Pipl-10 on 05/03/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuDetailsController : UIViewController <UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewdescriptionHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *CHtTablesection;
@property (strong, nonatomic) NSString *weeklyorder;
@property (weak, nonatomic) IBOutlet UILabel *lblsideoptions;
@property (strong, nonatomic) IBOutlet UITableView *tblfree;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tblfreeheight;
@property (weak, nonatomic) IBOutlet UIView *viewdescriptiondetail;
@property (weak, nonatomic) IBOutlet UILabel *lblbg;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property(nonatomic,strong)NSString *getMenuid;
@property (weak, nonatomic) IBOutlet UILabel *lblName2;
@property (strong, nonatomic) IBOutlet UIImageView *imghighProtine;
@property (weak, nonatomic) IBOutlet UIImageView *imgnew;
@property (weak, nonatomic) IBOutlet UIImageView *imgpopular;
@property (weak, nonatomic) IBOutlet UIImageView *imgsoldout;
@property (weak, nonatomic) IBOutlet UILabel *lblprice;
@property (weak, nonatomic) IBOutlet UITableView *tblselection;
@property (weak, nonatomic) IBOutlet UILabel *lblKcal;
@property (weak, nonatomic) IBOutlet UILabel *lblFat;
@property (weak, nonatomic) IBOutlet UILabel *lblCarbs;
@property (weak, nonatomic) IBOutlet UILabel *lblPro;
@property (weak, nonatomic) IBOutlet UILabel *lblDescription;
@property (weak, nonatomic) IBOutlet UILabel *lblKiloCalories;
@property (weak, nonatomic) IBOutlet UILabel *lblSaturatedfat;
@property (weak, nonatomic) IBOutlet UILabel *lblTransfat;
@property (weak, nonatomic) IBOutlet UILabel *lblZTotalfat;
@property (weak, nonatomic) IBOutlet UILabel *lbltotalcarbs;
@property (weak, nonatomic) IBOutlet UILabel *lblFatCalories;
@property (weak, nonatomic) IBOutlet UILabel *lblmonosatfat;
@property (weak, nonatomic) IBOutlet UILabel *lblpolysatfat;
@property (weak, nonatomic) IBOutlet UILabel *lblCholestrol;
@property (weak, nonatomic) IBOutlet UILabel *lblSodium;
@property (weak, nonatomic) IBOutlet UILabel *lblPotassium;
@property (weak, nonatomic) IBOutlet UILabel *lblDietryFiber;
@property (weak, nonatomic) IBOutlet UILabel *lblsuger;
@property (weak, nonatomic) IBOutlet UILabel *lblProtien;
@property (weak, nonatomic) IBOutlet UILabel *lblVitaminAval;
@property (weak, nonatomic) IBOutlet UILabel *lblVitaminCval;
@property (weak, nonatomic) IBOutlet UILabel *lblcalciumval;
@property (weak, nonatomic) IBOutlet UILabel *lblironval;
@property (weak, nonatomic) IBOutlet UILabel *lblthiminval;
@property (weak, nonatomic) IBOutlet UILabel *lblvitaminval;
@property (weak, nonatomic) IBOutlet UILabel *lblPhosphorousval;
@property (weak, nonatomic) IBOutlet UILabel *lblmagnesiumval;
@property (weak, nonatomic) IBOutlet UILabel *lblcopperval;
@property (weak, nonatomic) IBOutlet UILabel *lblmanganeseval;
@property (strong, nonatomic) IBOutlet UITableView *tblsideoptions;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tblsideoptionsheight;
@property (weak, nonatomic) IBOutlet UILabel *lblkilocalpercent;
@property (weak, nonatomic) IBOutlet UILabel *lblfatpercent;
@property (weak, nonatomic) IBOutlet UILabel *lbltotalfatpercent;
@property (weak, nonatomic) IBOutlet UILabel *lblsatfatpercent;
@property (weak, nonatomic) IBOutlet UILabel *lbltransfatpercent;
@property (weak, nonatomic) IBOutlet UILabel *lblmonofatpercent;
@property (weak, nonatomic) IBOutlet UILabel *lblpolyfatpercent;
@property (weak, nonatomic) IBOutlet UILabel *lblcholestrolpercent;
@property (weak, nonatomic) IBOutlet UILabel *lblsodiumpercent;
@property (weak, nonatomic) IBOutlet UILabel *lblpotassiumpercent;
@property (weak, nonatomic) IBOutlet UILabel *lbltotalcarbpercent;
@property (weak, nonatomic) IBOutlet UILabel *lbldietrypercent;
@property (weak, nonatomic) IBOutlet UILabel *lblsugarpercent;
@property (weak, nonatomic) IBOutlet UILabel *lblprotienpercent;
@property (weak, nonatomic) IBOutlet UILabel *lbltotalprice;
@property (weak, nonatomic) IBOutlet UIButton *btnaddtocart;
- (IBAction)btnaddtocart:(id)sender;
- (IBAction)btnclose:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ChtTableSelection;
@property (strong, nonatomic) IBOutlet UIView *viewKcalfriday;
@property (weak, nonatomic) IBOutlet UITableView *tbloffers;
@property (weak, nonatomic) IBOutlet UIButton *btndone;
@property (strong, nonatomic) NSMutableArray *arrgroup2;
@property (weak, nonatomic) IBOutlet UILabel *lbloffer;
@property (weak, nonatomic) IBOutlet UILabel *offername;
@property (weak, nonatomic) IBOutlet UILabel *offerline;
@property (strong, nonatomic) NSString *getoffername;
@property (strong, nonatomic) NSString *getofferline;
@property (strong, nonatomic) NSMutableArray *arrmenu;
@property (weak, nonatomic) IBOutlet UIButton *btnvitamindetail;
@property (weak, nonatomic) IBOutlet UIView *viewaddcart;
@property (weak, nonatomic) IBOutlet UIStackView *stacksymbol;
@property (weak, nonatomic) IBOutlet UIButton *btnnutritionclicked;
@property (weak, nonatomic) IBOutlet UILabel *lblline;
@property (weak, nonatomic) IBOutlet UIStackView *stackkcal;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewspace;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewtrailling;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewleading;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lblsideoptionheight;
@property (strong, nonatomic) IBOutlet UILabel *lblOutofStock;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sideoptiontop;



@end

//
//  MenuViewController.h
//  KCal
//
//  Created by Apple on 28/02/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController: UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *filtertblheight;
@property (weak, nonatomic) IBOutlet UIImageView *imgprevious;
@property (weak, nonatomic) IBOutlet UIImageView *imgnext;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionviewheader;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *layout;
@property (weak, nonatomic) IBOutlet UITableView *tableview1;
@property (weak, nonatomic) IBOutlet UITableView *tableviewFilter;
@property (weak, nonatomic) IBOutlet UIView *viewcart;
@property (weak, nonatomic) IBOutlet UIButton *btnviewcart;
@property (weak, nonatomic) IBOutlet UILabel *lblitems;
@property (weak, nonatomic) IBOutlet UILabel *lblprice;
@property (weak, nonatomic) IBOutlet UILabel *lblback;
@property (weak, nonatomic) IBOutlet UILabel *lblnorecord;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewcartheight;
- (IBAction)viewcart:(id)sender;
@property (strong, nonatomic)  NSString *weeklyflag;
@property (strong, nonatomic)  NSArray *arrselecteddate;
@property (weak, nonatomic) IBOutlet UIView *ViewTopWeelyOrder;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ChtWeelyOrder;
@property (weak, nonatomic) IBOutlet UILabel *lblselectedDate;
@property (weak, nonatomic) IBOutlet UIView *viewclear;
@property (weak, nonatomic) IBOutlet UIButton *btnclear;
@property (strong, nonatomic) NSMutableArray *arrpromo;
@property (strong, nonatomic) NSMutableArray *arrpromolist;


@end

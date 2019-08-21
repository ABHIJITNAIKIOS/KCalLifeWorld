//
//  PreOrederDetailsTableViewCell.h
//  Eaterity
//
//  Created by PIPL-03 on 17/02/17.
//  Copyright © 2017 PIPL-03. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubmenuCell.h"
@interface PreOrederDetailsTableViewCell : UITableViewCell<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tblheight;
@property (strong, nonatomic) IBOutlet UITableView *subMenuTableView;
@property (strong, nonatomic) IBOutlet UILabel *lblAdd;
@property (strong, nonatomic) IBOutlet UIButton *btnreOrder;
@property(strong ,nonatomic) NSMutableDictionary *arrdicts1;
@property(strong ,nonatomic) NSMutableArray *arrtemp;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *btnreorderheight;
@end

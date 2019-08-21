//
//  weeklyCell.h
//  KCal
//
//  Created by Pipl-10 on 02/08/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface weeklyCell : UITableViewCell <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tblheight;

@property (strong, nonatomic) IBOutlet UITableView *subMenuTableView;
@property (strong, nonatomic) IBOutlet UILabel *lblAdd;
@property (strong, nonatomic) IBOutlet UIButton *btnreOrder;
@property(strong ,nonatomic) NSMutableDictionary *arrdicts1;
@property(strong ,nonatomic) NSMutableArray *arrtemp111;
@property (weak, nonatomic) IBOutlet UIView *viewqty;
@property(weak ,nonatomic)NSString *strcutlery;

@end

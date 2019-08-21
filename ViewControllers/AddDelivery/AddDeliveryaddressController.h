//
//  AddDeliveryaddressController.h
//  KCal
//
//  Created by Pipl-10 on 06/07/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddDeliveryaddressController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITextField *txttitle;
@property (strong, nonatomic) IBOutlet UITextField *txtaddress1;
@property (strong, nonatomic) IBOutlet UITextField *txtaddress2;
@property (strong, nonatomic) IBOutlet UITextField *txtaddress3;
@property (strong, nonatomic) IBOutlet UITextField *txtarea;
@property (strong, nonatomic) IBOutlet UIButton *btnsaveaddress;
@property (strong, nonatomic) IBOutlet UITableView *tblcity;
@property (strong, nonatomic) IBOutlet UITableView *tblarea;
@property (weak, nonatomic) IBOutlet UIButton *btnnickname;
@property (weak, nonatomic) IBOutlet UIButton *btnaddr1;
@property (weak, nonatomic) IBOutlet UIButton *btnaddr2;
@property (weak, nonatomic) IBOutlet UIButton *btnaddr3;
@property (strong, nonatomic) NSString *fromDeliveryLocation;
@property (strong, nonatomic) NSDictionary *temparray;
@property (strong, nonatomic) NSString *strfromMyaccount;
@property (strong, nonatomic) NSString *fromWeeklyCalendar;
@property (strong, nonatomic) NSString *strtitle;
@property (strong, nonatomic) NSString *flag;
@property (strong, nonatomic) NSString *strfromcheckout;
@property (strong, nonatomic) NSString *strfromsimple;

@end

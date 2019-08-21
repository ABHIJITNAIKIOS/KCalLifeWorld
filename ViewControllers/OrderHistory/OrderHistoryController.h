//
//  OrderHistoryController.h
//  KCal
//
//  Created by Pipl-10 on 28/06/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FZAccordionTableView.h"
#import "SubmenuCell.h"
@interface OrderHistoryController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    
}

@property (strong, nonatomic) IBOutlet UIView *viewredirect;
@property (strong, nonatomic) IBOutlet FZAccordionTableView *tbldata;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, strong) NSString *flag;
@property (strong, nonatomic) IBOutlet UIButton *btnlater;
@property (strong, nonatomic) IBOutlet UILabel *lblnorecords;
@property (strong, nonatomic) IBOutlet UITextField *txtdeliveryaddress;
@property (strong, nonatomic) IBOutlet UITableView *tbladdress;
@property (strong, nonatomic) IBOutlet UIView *viewpicker;
@property (strong, nonatomic) IBOutlet UIDatePicker *datepicker;
@property (strong, nonatomic) IBOutlet UIView *viewhungry;
@property (strong ,nonatomic) NSString *pushflag;
@property (strong, nonatomic) IBOutlet UIButton *btnASAP;
@property (strong, nonatomic) IBOutlet UIButton *btnback;


@end

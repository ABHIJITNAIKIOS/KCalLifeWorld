//
//  CalenderViewController.h
//  Hrmally
//
//  Created by Pipl09 on 17/07/17.
//  Copyright © 2017 Pipl09. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKCalendarView.h"

@interface CalenderViewController : UIViewController <UITableViewDelegate,  UITableViewDataSource, CKCalendarDelegate,UITableViewDelegate,UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *tempcalenderview;
@property (strong, nonatomic) IBOutlet UIView *mainview;
@property (weak, nonatomic) IBOutlet UILabel *LBLNORECORD;
@property (strong, nonatomic) IBOutlet UILabel *lbldeliverydate;
@property (strong, nonatomic) IBOutlet UIButton *btnnext;
@property (strong, nonatomic) IBOutlet UIView *viewpopup;
@property (strong, nonatomic) IBOutlet UILabel *lblcount;
@property (strong, nonatomic) IBOutlet UITableView *tblObj;
@property (strong, nonatomic) IBOutlet UIView *viewredirect;
@property (strong, nonatomic) IBOutlet UIView *viewpicker;
@property (strong, nonatomic) IBOutlet UITableView *tbladdress;
@property (strong, nonatomic) IBOutlet UITextField *txtdeliveryaddress;
@property (strong, nonatomic) IBOutlet UIDatePicker *datepicker;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tblobjheight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tbltop;
@property (strong, nonatomic) NSString *strReorder;
@property (strong, nonatomic) IBOutlet UIView *viewReorder;

@end

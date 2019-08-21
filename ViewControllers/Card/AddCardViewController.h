//
//  AddCardViewController.h
//  KCal
//
//  Created by Pipl014 on 20/07/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddCardViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *txtCardHolderNme;
@property (weak, nonatomic) IBOutlet UITextField *txtCardName;
@property (weak, nonatomic) IBOutlet UITextField *txtExpiryDate;
@property (weak, nonatomic) IBOutlet UITextField *txtCvv;
- (IBAction)btnAddCardTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblCardholdername;
@property (weak, nonatomic) IBOutlet UILabel *lblCardName;
@property (weak, nonatomic) IBOutlet UILabel *lblExpiryDate;
@property (weak, nonatomic) IBOutlet UILabel *lblCvv;
@property (strong, nonatomic) IBOutlet UIView *ViewDatePicker;
@property (strong, nonatomic) IBOutlet UIPickerView *ExpiryPicker;
@property (strong, nonatomic) IBOutlet UIButton *btnexpiry;
@property (weak, nonatomic) IBOutlet UIButton *btnaddcard;
@property (strong, nonatomic) NSString *strflag;


@end

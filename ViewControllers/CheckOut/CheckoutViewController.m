//
//  CheckoutViewController.m
//  KCal
//
//  Created by Pipl014 on 20/07/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "CheckoutViewController.h"
#import "AddDeliveryaddressController.h"
#import "GiFHUD.h"
#import "BaseViewController.h"
#import "AppDelegate.h"
#import "paymentMethodViewController.h"
#import "HomeViewController.h"
#import "orderStatusViewController.h"

@interface CheckoutViewController ()
{
    NSMutableArray *arritemsdata;
    NSString *strcomment, *strcommentcondition;
    NSMutableArray *arrdays;
    NSMutableDictionary *dictoptions;
    NSString *strcallid;
    NSString *strmethod;
//    NSDictionary *dictPayment;
}

@end

@implementation CheckoutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Checkout";
    
    self.navigationItem.hidesBackButton = YES;
    arrdays = [[NSMutableArray alloc]init];
    
    strcallid = @"";
    
    strcallid = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"callid"]];
    
    if ([strcallid isKindOfClass:[NSNull class]])
    {
        strcallid = @"";
    }
    
    else if ([strcallid isEqualToString:@"(null)"])
    {
        strcallid = @"";
    }
    
    _txtcomment.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"riderinstruction"];
    
    _viewvisa.hidden = YES;
    _viewcash.hidden = YES;
    _imgvisacheckout.hidden = YES;
    
    [GiFHUD setGifWithImageName:@"Spinner3.gif"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissTableView)];
    
    [self.viewblur addGestureRecognizer:tap];
    
    strcommentcondition = @"";
    
    NSString *straddress =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"primaryaddress"]];
    
    NSString *strtotalprice = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"grandtotal"]];
    
    [_btnplaceorder setTitle:[NSString stringWithFormat:@"PLACE ORDER (%@)",strtotalprice] forState:UIControlStateNormal];
    
    _txtcomment.layer.cornerRadius = 5.0f;
    _txtcomment.layer.masksToBounds = YES;
    _txtcomment.layer.borderColor = [UIColor grayColor].CGColor;
    _txtcomment.layer.borderWidth = 1.0f;
    
    [_viewpop setHidden:YES];
    [_viewblur setHidden:YES];
    
    if ([straddress isEqualToString:@"(null)"])
    {
        straddress =@"";
    }
    
    _lbladdress.text = straddress;
    
    NSString *strphone =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"user_contactnumber"]];
    
    if ([strphone isEqualToString:@"(null)"])
    {
        strphone =@"";
    }
    
    [_lblphone setUserInteractionEnabled:NO];
    
    _lblphone.text = strphone;
    
    //preorderarray
    
    NSData *dataarraddtocart =[[NSUserDefaults standardUserDefaults] valueForKey:@"posttotalorder"];
    
    arritemsdata =[[NSMutableArray alloc]init];
    
    if (!(dataarraddtocart == nil))
    {
        arritemsdata=[[NSKeyedUnarchiver unarchiveObjectWithData:dataarraddtocart] mutableCopy];
    }
    
    int totalaed = 0;
    
    for (int i = 0; i<arritemsdata.count; i++)
    {
       NSString *strprice =[NSString stringWithFormat:@"%@",[[arritemsdata objectAtIndex:i] valueForKey:@"totalprice"]];
        
        int totalprice =[strprice intValue];
        
        totalaed = totalaed + totalprice;
    }
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    strmethod = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"PaymentMethod"]];
    
//    dictPayment = [defaults valueForKey:@"PaymentCard"];
    
    
    
//    if ([_strpaymentmode isEqualToString:@"Online card payment"] && strcallid.length > 0)
//    {
//        _viewvisa.hidden = YES;
//        _viewcash.hidden = YES;
//    }
//
//    else if ([_strpaymentmode isEqualToString:@"Online card payment"])
//    {
//        _viewvisa.hidden = NO;
//        _viewcash.hidden = YES;
//
//        if ([[_dictcard valueForKey:@"paymentMethod"] isKindOfClass:[NSNull class]])
//        {
//            self.lblcardtype.text = @"";
//        }
//
//        else
//        {
//            self.lblcardtype.text = [_dictcard valueForKey:@"paymentMethod"];
//
//            if ([[_dictcard valueForKey:@"paymentMethod"] isEqualToString:@"Visa"])
//            {
//                self.imgcard.image = [UIImage imageNamed:@"visa"];
//            }
//
//            else if ([[_dictcard valueForKey:@"paymentMethod"] isEqualToString:@"MasterCard"])
//            {
//                self.imgcard.image = [UIImage imageNamed:@"card"];
//            }
//
//            else if ([[_dictcard valueForKey:@"paymentMethod"] isEqualToString:@"Amex"])
//            {
//                self.imgcard.image = [UIImage imageNamed:@"amex"];
//            }
//
//            else if ([[_dictcard valueForKey:@"paymentMethod"] isEqualToString:@"DinersClub"])
//            {
//                self.imgcard.image = [UIImage imageNamed:@"diners_club_credit_card_logo"];
//            }
//
//            else if ([[_dictcard valueForKey:@"paymentMethod"] isEqualToString:@"Discover"])
//            {
//                self.imgcard.image = [UIImage imageNamed:@"discover"];
//            }
//
//            else if ([[_dictcard valueForKey:@"paymentMethod"] isEqualToString:@"JCB"])
//            {
//                self.imgcard.image = [UIImage imageNamed:@"jcb"];
//            }
//        }
//
//        if ([[_dictcard valueForKey:@"last4"] isKindOfClass:[NSNull class]])
//        {
//            self.lblcardnumber.text = @"";
//        }
//
//        else
//        {
//            NSString *cardlength = [NSString stringWithFormat:@"Ending %@",[_dictcard valueForKey:@"last4"]];
//
//            self.lblcardnumber.text = cardlength;
//        }
//    }
//
//    else if ([_strpaymentmode isEqualToString:@"Cash"])
//    {
//        _viewvisa.hidden = YES;
//        _viewcash.hidden = NO;
//    }
    
    
    
    if ([strmethod isEqualToString:@"Online card payment"] && strcallid.length > 0)
    {
        _viewvisa.hidden = YES;
        _viewcash.hidden = YES;
        _imgvisacheckout.hidden = NO;
    }
    
    else if ([strmethod isEqualToString:@"Online card payment"])
    {
        _viewvisa.hidden = NO;
        _viewcash.hidden = YES;
        _imgvisacheckout.hidden = YES;
        
        if ([[_dictPayment valueForKey:@"paymentMethod"] isKindOfClass:[NSNull class]])
        {
            self.lblcardtype.text = @"";
        }
        
        else
        {
            self.lblcardtype.text = [_dictPayment valueForKey:@"card_type"];
            
            if ([[_dictPayment valueForKey:@"card_type"] isEqualToString:@"Visa"])
            {
                self.imgcard.image = [UIImage imageNamed:@"visa"];
            }
            
            else if ([[_dictPayment valueForKey:@"card_type"] isEqualToString:@"MasterCard"])
            {
                self.imgcard.image = [UIImage imageNamed:@"card"];
            }
            
            else if ([[_dictPayment valueForKey:@"card_type"] isEqualToString:@"Amex"])
            {
                self.imgcard.image = [UIImage imageNamed:@"amex"];
            }
            
            else if ([[_dictPayment valueForKey:@"card_type"] isEqualToString:@"DinersClub"])
            {
                self.imgcard.image = [UIImage imageNamed:@"diners_club_credit_card_logo"];
            }
            
            else if ([[_dictPayment valueForKey:@"card_type"] isEqualToString:@"Discover"])
            {
                self.imgcard.image = [UIImage imageNamed:@"discover"];
            }
            
            else if ([[_dictPayment valueForKey:@"card_type"] isEqualToString:@"JCB"])
            {
                self.imgcard.image = [UIImage imageNamed:@"jcb"];
            }
        }
        
        if ([[_dictPayment valueForKey:@"card_last4"] isKindOfClass:[NSNull class]])
        {
            self.lblcardnumber.text = @"";
        }
        
        else
        {
            NSString *cardlength = [NSString stringWithFormat:@"Ending %@",[_dictPayment valueForKey:@"card_last4"]];
            
            self.lblcardnumber.text = cardlength;
        }
    }
    
    else if ([strmethod isEqualToString:@"Cash"])
    {
        _viewvisa.hidden = YES;
        _viewcash.hidden = NO;
        _imgvisacheckout.hidden = YES;
    }
}





-(void)viewDidAppear:(BOOL)animated
{
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame = CGRectMake(12, 15, 18, 18);
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"white_left"] forState:UIControlStateNormal];
    leftbtn.tag=229;
    
    [leftbtn addTarget:self action:@selector(back)
      forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:leftbtn];
    
    for (UIButton *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 134)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 211)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 227)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 234)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 401)
        {
            [view removeFromSuperview];
        }
    }
}


-(void)back
{
    paymentMethodViewController *obj=[[paymentMethodViewController alloc]initWithNibName:@"paymentMethodViewController" bundle:nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.navigationController pushViewController:obj animated:YES];
}


-(void)dismissTableView
{
    [self.view endEditing:YES];
    
    [_viewblur setHidden:YES];
    [_viewpop setHidden:YES];
}



- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    if (textField == _lblphone)
    {
        NSUInteger oldLength = [_lblphone.text length];
        NSUInteger replacementLength = [string length];
        NSUInteger rangeLength = range.length;
        
        NSUInteger newLength = oldLength - rangeLength + replacementLength;
        
        BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
        
        return newLength <= mblnoLen||returnKey;
    }
    
    return YES;
}





- (IBAction)btndeletecard:(id)sender
{
    UIAlertController * alert = [UIAlertController                                                          alertControllerWithTitle:NSLocalizedString(@"Whoops!",nil)
                                                                                                                             message:@"Are you sure you don't want to pay with the card ?"
                                                                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"YES"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    
                                    paymentMethodViewController *obj=[[paymentMethodViewController alloc]initWithNibName:@"paymentMethodViewController" bundle:nil];
                                    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                                    [self.navigationController pushViewController:obj animated:YES];
                                }];
    
    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"NO"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {
                                   
                               }];
    
    
    //Add your buttons to alert controller
    
    [alert addAction:yesButton];
    [alert addAction:noButton];
    
    [self presentViewController:alert animated:YES completion:nil];
}




- (IBAction)btnaddress:(id)sender
{
    AddDeliveryaddressController *address =[[AddDeliveryaddressController alloc]init];
    address.strfromcheckout =@"yes";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.navigationController pushViewController:address animated:YES];
}




- (IBAction)btnphonenumber:(id)sender
{
    if (_lblphone.userInteractionEnabled == YES)
    {
        [_lblphone setUserInteractionEnabled:NO];
        [_lblphone resignFirstResponder];
    }
    
    else
    {
        [_lblphone setUserInteractionEnabled:YES];
        [_lblphone becomeFirstResponder];
        
    }
}

- (IBAction)btnriderinstr:(id)sender
{
    if ([strcommentcondition isEqualToString:@"yes"])
    {
        
    }
    
    else
    {
       _txtcomment.text =[[NSUserDefaults standardUserDefaults] valueForKey:@"riderinstruction"];
    }
   
    [_viewpop setHidden:NO];
    [_viewblur setHidden:NO];
}




- (IBAction)btnplaceorder:(id)sender
{
    if ([_lbladdress.text isEqualToString:@""])
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"Please add the delivery address."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        
                                        
                                    }];
        
        
        //Add your buttons to alert controller
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else if ([_lblphone.text isEqualToString:@""])
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"Please enter the mobile number."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        
                                        
                                    }];
        
        
        //Add your buttons to alert controller
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else if (_lblphone.text.length < 10)
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"Please enter the valid mobile number."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        
                                        
                                    }];
        
        
        //Add your buttons to alert controller
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else
    {
        [GiFHUD showWithOverlay];
        //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self wsplaceorder];
            
        });
    }
}


- (IBAction)btnaddcomment:(id)sender
{
    strcomment =@"";
    
    if ([_txtcomment.text isEqualToString:@""])
    {
        strcommentcondition =@"no";
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"Please add some comments."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        
                                        
                                    }];
        
        
        //Add your buttons to alert controller
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else
    {
        strcommentcondition =@"yes";
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"Comments saved."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        
                                        
                                    }];
        
        
        //Add your buttons to alert controller
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        strcomment = _txtcomment.text;
        
        [[NSUserDefaults standardUserDefaults] setObject:strcomment forKey:@"riderinstruction"];
        
        [_viewpop setHidden:YES];
        [_viewblur setHidden:YES];
    }
}





#pragma mark <---Webservices--->


-(void)wsplaceorder
{
    BaseViewController *base=[[BaseViewController alloc]init];
    NSMutableArray *arritemid =[[NSMutableArray alloc]init];
    
    NSData *dataarraddtocart =[[NSUserDefaults standardUserDefaults] valueForKey:@"posttotalorder"];
    
    arritemsdata =[[NSMutableArray alloc]init];
    
    if (!(dataarraddtocart == nil))
    {
        arritemsdata=[[NSKeyedUnarchiver unarchiveObjectWithData:dataarraddtocart] mutableCopy];
    }
    
    arrdays = [[NSMutableArray alloc]init];
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"weeklyorderclicked"] isEqualToString:@"yes"])
    {
        for (int i = 0; i<arritemsdata.count; i++)
        {
            NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
            
            NSString *date = [NSString stringWithFormat:@"%@",[[arritemsdata objectAtIndex:i] valueForKey:@"delivery_date"]];
            NSString *time = [NSString stringWithFormat:@"%@",[[arritemsdata objectAtIndex:i] valueForKey:@"delivery_time"]];
            NSString *notes = [NSString stringWithFormat:@"%@",[[arritemsdata objectAtIndex:i] valueForKey:@"notes"]];
            
            [dictet setObject:date forKey:@"delivery_date"];
            [dictet setObject:time forKey:@"delivery_time"];
            
            if ([notes isEqualToString:@"(null)"])
            {
                [dictet setObject:@"" forKey:@"notes"];
            }
            
            else
            {
                [dictet setObject:notes forKey:@"notes"];
            }
            
            NSMutableArray *arrproduct =[[arritemsdata objectAtIndex:i]valueForKey:@"products"];
            
            NSMutableArray *arritemid =[[NSMutableArray alloc]init];
            
            for (int j = 0; j<arrproduct.count; j++)
            {
                NSMutableArray *arrtem =[[NSMutableArray alloc]init];
                
                NSMutableDictionary *dicttemp =[[NSMutableDictionary alloc]init];
                
                NSString *itemid = [NSString stringWithFormat:@"%@",[[arrproduct objectAtIndex:j] valueForKey:@"itemID"]];
//                NSString *notes = [NSString stringWithFormat:@"%@",[[arrproduct objectAtIndex:j] valueForKey:@"notes"]];
                NSString *quantity = [NSString stringWithFormat:@"%@",[[arrproduct objectAtIndex:j] valueForKey:@"quantity"]];
                
//                if ([notes isEqualToString:@"(null)"])
//                {
//                    [dicttemp setObject:@"" forKey:@"notes"];
//                }
//
//                else
//                {
//                    [dicttemp setObject:notes forKey:@"notes"];
//                }
                
                [dicttemp setObject:itemid forKey:@"itemID"];
                [dicttemp setObject:quantity forKey:@"quantity"];
                
                dictoptions =[[[arrproduct objectAtIndex:j] valueForKey:@"options"] mutableCopy];
                
                NSMutableDictionary *dicttin =[[NSMutableDictionary alloc]init];
                
                NSMutableArray *arrtemp =[[NSMutableArray alloc]init];
                NSMutableArray *arrtemprorary =[[NSMutableArray alloc]init];
                arrtemp =[[dictoptions allKeys] mutableCopy];
                
                for (int k = 0; k<arrtemp.count; k++)
                {
                    NSMutableArray *arrsecond =[[NSMutableArray alloc]init];
                    
                    arrsecond = [[dictoptions valueForKey:[arrtemp objectAtIndex:k]] mutableCopy];
                    NSString *strtemp =[NSString stringWithFormat:@"%@",[[arrtemp objectAtIndex:k]mutableCopy]];
                    
                    for (int l=0; l<arrsecond.count; l++)
                    {
                        NSMutableDictionary *dictte =[[NSMutableDictionary alloc]init];
                        
                        dictte =[[arrsecond objectAtIndex:l] mutableCopy];
                        
                        [dictte setObject:strtemp forKey:@"nameofarray"];
                        
                        [arrtemprorary addObject:dictte];
                    }
                }
                
                [dicttin setObject:arrtemprorary forKey:@"arrcustom"];
                
                [arrproduct replaceObjectAtIndex:j withObject:dicttin];
                
                NSArray *aerr =[[arrproduct objectAtIndex:j]valueForKey:@"arrcustom"];
                
                for (int m =0; m<aerr.count; m++)
                {
                    NSMutableDictionary *dictt =[[NSMutableDictionary alloc]init];
                    
                    [dictt setObject:[NSString stringWithFormat:@"%@",[[aerr objectAtIndex:m]valueForKey:@"id"]] forKey:@"id"];
                    [dictt setObject:@"1" forKey:@"quantity"];
                    
                    [arrtem addObject:dictt];
                }
                
                [dicttemp setObject:arrtem forKey:@"options"];
                
                [arritemid addObject:dicttemp];
            }
            
            [dictet setObject:arritemid forKey:@"items"];
            
            [arrdays addObject:dictet];
        }
    }
    
    else
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"weeklycount"];
        
        NSMutableArray *arroffer =[[NSMutableArray alloc]init];
        
        NSData *dataarrayoffer =[[NSUserDefaults standardUserDefaults] valueForKey:@"arrayoffer"];
        
        if (!(dataarrayoffer == nil))
        {
            arroffer=[[NSKeyedUnarchiver unarchiveObjectWithData:dataarrayoffer] mutableCopy];
        }
        
        for (int k = 0; k<arroffer.count; k++)
        {
            [arritemid addObject:[arroffer objectAtIndex:k]];
        }
        
        for (int i = 0; i<arritemsdata.count; i++)
        {
            NSMutableArray *arrtem =[[NSMutableArray alloc]init];
            
            NSMutableDictionary *dicttemp =[[NSMutableDictionary alloc]init];
            
            NSString *itemid = [NSString stringWithFormat:@"%@",[[arritemsdata objectAtIndex:i]valueForKey:@"itemID"]];
            NSString *notes = [NSString stringWithFormat:@"%@",[[arritemsdata objectAtIndex:i] valueForKey:@"notes"]];
            NSString *quantity = [NSString stringWithFormat:@"%@",[[arritemsdata objectAtIndex:i]valueForKey:@"quantity"]];
            
            if ([notes isEqualToString:@"(null)"])
            {
                [dicttemp setObject:@"" forKey:@"notes"];
            }
            
            else
            {
                [dicttemp setObject:notes forKey:@"notes"];
            }
            
            [dicttemp setObject:itemid forKey:@"itemID"];
            [dicttemp setObject:quantity forKey:@"quantity"];
            
            NSArray *aerr =[[arritemsdata objectAtIndex:i]valueForKey:@"arrcustom"];
            
            for (int i =0; i<aerr.count; i++)
            {
                NSMutableDictionary *dictt =[[NSMutableDictionary alloc]init];
                
                [dictt setObject:[NSString stringWithFormat:@"%@",[[aerr objectAtIndex:i]valueForKey:@"id"]] forKey:@"id"];
                [dictt setObject:@"1" forKey:@"quantity"];
                
                [arrtem addObject:dictt];
            }
            
            [dicttemp setObject:arrtem forKey:@"options"];
            
            [arritemid addObject:dicttemp];
            
            NSMutableDictionary *dictdate =[[NSMutableDictionary alloc]init];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
            
            NSString *strclick = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"ASAP"]];
            
            if ([strclick isEqualToString:@"ASAP"])
            {
                [dateFormat setDateFormat:@"yyyy-MM-dd"];
                
                NSString *strdate =[NSString stringWithFormat:@"%@",[dateFormat stringFromDate:[NSDate date]]];
                
                [dictdate setObject:strdate forKey:@"delivery_date"];
            }
            
            else
            {
                NSString *strex = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"delivery_time"]];
                [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm a"];
                NSDate *stronlydate =[dateFormat dateFromString:strex];
                
                [dateFormat setDateFormat:@"yyyy-MM-dd"];
                
                NSString *strnewdate = [dateFormat stringFromDate:stronlydate];
                NSDate *stronlydate2 = [dateFormat dateFromString:strnewdate];
                NSString *strdate = [dateFormat stringFromDate:stronlydate2];
                
                [dictdate setObject:strdate forKey:@"delivery_date"];
            }
            
            NSString *strtime = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"delivery_time"]];
            
            [dictdate setObject:arritemid forKey:@"items"];
            [dictdate setObject:strtime forKey:@"delivery_time"];
            
            if (arrdays.count > 0)
            {
                [arrdays replaceObjectAtIndex:0 withObject:dictdate];
            }
            
            else
            {
                [arrdays addObject:dictdate];
            }
            
            NSLog(@"%@",arrdays);
        }
    }
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arrdays options:NSJSONWritingPrettyPrinted error:&error];
    NSString *strarrdata = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter;
    //NSString *addtitle =[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"address_title"]];
    NSString *straddresstype = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"address_type"]];
    
//    NSString *straddressid = @"";
//
//    if ([addtitle isEqualToString:@"Home"])
//    {
//        straddressid =@"0";
//    }
//
//    else if ([addtitle isEqualToString:@"Work"])
//    {
//        straddressid =@"1";
//    }
//
//    else
//    {
//         straddressid =@"2";
//    }
    
    
    if ([_strpaymentmode isEqualToString:@"Cash"] || [strmethod isEqualToString:@"Cash"])
    {
        //COD
        
        //Previous Comments Parameter
        //[[NSUserDefaults standardUserDefaults]valueForKey:@"cartcomment"]
        
        parameter=[NSString stringWithFormat:@"request=%@&action=%@&key=%@&secret=%@&token=%@&payment=%@&user_id=%@&address_type=%@&address_type_id=%@&days=%@&ios=%@&cutlery_qty=%@&contact_number=%@&instruction=%@&comments=%@&number_of_days=%@&promo_code=%@",@"menu",@"order",str_key,str_secret,[[NSUserDefaults standardUserDefaults]valueForKey:@"token"],strmethod,[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],straddresstype,[[NSUserDefaults standardUserDefaults]valueForKey:@"address_id"],strarrdata,@"1",[[NSUserDefaults standardUserDefaults]valueForKey:@"cutlery_selected"],_lblphone.text,_txtcomment.text,@"",[[NSUserDefaults standardUserDefaults] valueForKey:@"weeklycount"],[[NSUserDefaults standardUserDefaults] valueForKey:@"promocode_for_order"]];
    }
    
    else if (([_strpaymentmode isEqualToString:@"Online card payment"] && strcallid.length > 0) || ([strmethod isEqualToString:@"Online card payment"] && strcallid.length > 0))
    {
        //Visa Checkout
        
        //Previous Comments Parameter
        //[[NSUserDefaults standardUserDefaults]valueForKey:@"cartcomment"]
        
        parameter=[NSString stringWithFormat:@"request=%@&action=%@&key=%@&secret=%@&token=%@&payment=%@&user_id=%@&address_type=%@&address_type_id=%@&days=%@&ios=%@&cutlery_qty=%@&contact_number=%@&instruction=%@&comments=%@&number_of_days=%@&callid=%@&promo_code=%@",@"menu",@"order",str_key,str_secret,[[NSUserDefaults standardUserDefaults]valueForKey:@"token"],strmethod,[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],straddresstype,[[NSUserDefaults standardUserDefaults]valueForKey:@"address_id"],strarrdata,@"1",[[NSUserDefaults standardUserDefaults]valueForKey:@"cutlery_selected"],_lblphone.text,_txtcomment.text,@"",[[NSUserDefaults standardUserDefaults] valueForKey:@"weeklycount"],[[NSUserDefaults standardUserDefaults] valueForKey:@"callid"],[[NSUserDefaults standardUserDefaults] valueForKey:@"promocode_for_order"]];
    }
    
    else if ([_strpaymentmode isEqualToString:@"Online card payment"] || [strmethod isEqualToString:@"Online card payment"])
    {
        //Card Payment
        
        //Previous Comments Parameter
        //[[NSUserDefaults standardUserDefaults]valueForKey:@"cartcomment"]
        
        parameter=[NSString stringWithFormat:@"request=%@&action=%@&key=%@&secret=%@&token=%@&payment=%@&user_id=%@&address_type=%@&address_type_id=%@&days=%@&ios=%@&cutlery_qty=%@&contact_number=%@&instruction=%@&comments=%@&number_of_days=%@&card id=%@&card_type=%@&store_card=%@&promo_code=%@",@"menu",@"order",str_key,str_secret,[[NSUserDefaults standardUserDefaults] valueForKey:@"token"],strmethod,[[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"],straddresstype,[[NSUserDefaults standardUserDefaults] valueForKey:@"address_id"],strarrdata,@"1",[[NSUserDefaults standardUserDefaults] valueForKey:@"cutlery_selected"],_lblphone.text,_txtcomment.text,@"",[[NSUserDefaults standardUserDefaults]  valueForKey:@"weeklycount"],[_dictPayment valueForKey:@"id"],@"old",@"true",[[NSUserDefaults standardUserDefaults] valueForKey:@"promocode_for_order"]];
        
        // card id = [_dictPayment valueForKey:@"id"]
    }
    
    NSDictionary *dictionary = [[NSMutableDictionary alloc]init];
    
    dictionary=[base WebParsingMethod:stringWebServicesCompleteUrl :parameter];
    
    [GiFHUD dismiss];
    if(dictionary == (id)[NSNull null] || dictionary == nil)
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"Oops, cannot connect to server."
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        
                                    }];
        
        
        //Add your buttons to alert controller
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        
        //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Oops, cannot connect to server." delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
        //
        //            [alert show];
    }
    
    else
    {
        NSString *errorCode=[NSString stringWithFormat:@"%@",[dictionary  valueForKey:@"code"]];
        NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            if([errorCode isEqualToString:@"1"])
            {
                NSString *strorder_id = [NSString stringWithFormat:@"%@",[dictionary  valueForKey:@"order_id"]];
                
                [[NSUserDefaults standardUserDefaults] setValue:strorder_id forKey:@"order_id"];
                
                if ([_strpaymentmode isEqualToString:@"Cash"] || [strmethod isEqualToString:@"Cash"])
                {
                    UIAlertController * alert = [UIAlertController
                                                 alertControllerWithTitle:nil
                                                 message:@"Your order has been placed successfully." preferredStyle:UIAlertControllerStyleAlert];
                    
                    
                    UIAlertAction* yesButton = [UIAlertAction
                                                actionWithTitle:@"OK"
                                                style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * action) {
                                                    
                                                    NSData *data =[NSData data];
                                                    
                                                    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"arrayoffer"];
                                                    
                                                    [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"arrayaddtocart"];
                                                    
                                                    [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"posttotalorder"];
                                                    
                                                    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"promocode_for_order"];
                                                    
                                                    [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"weeklyorderarray"];
                                                    
                                                    [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"weeklyorderclicked"];
                                                    
                                                    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"weeklycount"];
                                                    
//                                                    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"PaymentMethod"];
                                                    
                                                    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"PaymentCard"];
                                                    
                                                    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"cartcomment"];
                                                    
                                                    [[NSUserDefaults  standardUserDefaults]setObject:@"" forKey:@"riderinstruction"];
                                                    
                                                    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"shopId"];
                                                    
                                                    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"tryAgainPayment"];
                                                    
                                                    NSString *strorder_id = [NSString stringWithFormat:@"%@",[dictionary  valueForKey:@"order_id"]];
                                                    
                                                    orderStatusViewController *obj=[[orderStatusViewController alloc]initWithNibName:@"orderStatusViewController" bundle:nil];
                                                    obj.strorder_id = strorder_id;
                                                    obj.dictorder = dictionary.mutableCopy;
                                                    
                                                    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                                                    [self.navigationController pushViewController:obj animated:YES];
                                                }];
                    
                    
                    //Add your buttons to alert controller
                    
                    [alert addAction:yesButton];
                    
                    [self presentViewController:alert animated:YES completion:nil];
                }
                
                else
                {
                    NSDictionary *dictpayment = [dictionary valueForKey:@"online_payment"];
                    
                    NSString *strcode = [NSString stringWithFormat:@"%@",[dictpayment valueForKey:@"code"]];
                    NSString *messagenew =[NSString stringWithFormat:@"%@",[dictpayment valueForKey:@"message"]];
                    
                    if ([strcode isEqualToString:@"0"])
                    {
                        UIAlertController * alert = [UIAlertController
                                                     alertControllerWithTitle:nil
                                                     message:messagenew
                                                     preferredStyle:UIAlertControllerStyleAlert];
                        
                        //Add Buttons
                        
                        UIAlertAction* yesButton = [UIAlertAction
                                                    actionWithTitle:@"OK"
                                                    style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * action) {
                                                        
                                                        NSString *strflag = @"noBack";
                                                        
                                                        [[NSUserDefaults standardUserDefaults] setValue:strflag forKey:@"tryAgainPayment"];
                                                        
                                                        NSData *data =[NSData data];
                                                        
                                                        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"arrayoffer"];
                                                        
                                                        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"arrayaddtocart"];
                                                        
                                                        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"posttotalorder"];
                                                        
                                                        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"promocode_for_order"];
                                                        
                                                        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"weeklyorderarray"];
                                                        
                                                        [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"weeklyorderclicked"];
                                                        
                                                        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"weeklycount"];
                                                        
//                                                        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"PaymentMethod"];
                                                        
                                                        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"PaymentCard"];
                                                        
                                                        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"cartcomment"];
                                                        
                                                        [[NSUserDefaults  standardUserDefaults]setObject:@"" forKey:@"riderinstruction"];
                                                        
                                                        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"shopId"];
                                                        
                                                        paymentMethodViewController *obj=[[paymentMethodViewController alloc]initWithNibName:@"paymentMethodViewController" bundle:nil];
                                                        obj.dictorder = dictionary.mutableCopy;
                                                        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                                                        [self.navigationController pushViewController:obj animated:YES];
                                                    }];
                        
                        
                        //Add your buttons to alert controller
                        
                        [alert addAction:yesButton];
                        
                        [self presentViewController:alert animated:YES completion:nil];
                    }
                    
                    else if ([strcode isEqualToString:@"1"])
                    {
                        UIAlertController * alert = [UIAlertController
                                                     alertControllerWithTitle:nil
                                                     message:@"Your order has been placed successfully." preferredStyle:UIAlertControllerStyleAlert];
                        
                        
                        UIAlertAction* yesButton = [UIAlertAction
                                                    actionWithTitle:@"OK"
                                                    style:UIAlertActionStyleDefault
                                                    handler:^(UIAlertAction * action) {
                                                        
                                                        NSData *data =[NSData data];
                                                        
                                                        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"arrayoffer"];
                                                        
                                                        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"arrayaddtocart"];
                                                        
                                                        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"posttotalorder"];
                                                        
                                                        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"promocode_for_order"];
                                                        
                                                        [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"weeklyorderarray"];
                                                        
                                                        [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"weeklyorderclicked"];
                                                        
                                                        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"weeklycount"];
                                                        
//                                                        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"PaymentMethod"];
                                                        
                                                        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"PaymentCard"];
                                                        
                                                        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"cartcomment"];
                                                        
                                                        [[NSUserDefaults  standardUserDefaults]setObject:@"" forKey:@"riderinstruction"];
                                                        
                                                        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"shopId"];
                                                        
                                                        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"tryAgainPayment"];
                                                        
                                                        NSString *strorder_id = [NSString stringWithFormat:@"%@",[dictionary  valueForKey:@"order_id"]];
                                                        
                                                        orderStatusViewController *obj=[[orderStatusViewController alloc]initWithNibName:@"orderStatusViewController" bundle:nil];
                                                        obj.strorder_id = strorder_id;
                                                        obj.dictorder = dictionary.mutableCopy;
                                                        
                                                        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                                                        [self.navigationController pushViewController:obj animated:YES];
                                                    }];
                        
                        
                        //Add your buttons to alert controller
                        
                        [alert addAction:yesButton];
                        
                        [self presentViewController:alert animated:YES completion:nil];
                    }
                }
            }
            
            else if ([errorCode isEqualToString:@"0"])
            {
//                NSArray *arr = [[NSArray alloc]init];
//
//                arr = [dictionary valueForKey:@"message"];
//
//                NSString *message1 = [NSString stringWithFormat:@"%@",message];
                
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:message preferredStyle:UIAlertControllerStyleAlert];
                
                
                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                
                                                
                                            }];
                
                
                //Add your buttons to alert controller
                
                [alert addAction:yesButton];
                
                [self presentViewController:alert animated:YES completion:nil];
                
                //                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                //
                //                [alert show];
            }
            
            else if ([errorCode isEqualToString:@"3"])
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:message preferredStyle:UIAlertControllerStyleAlert];
                
                //Add Buttons
                
                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                
                                                
                                            }];
                
                
                //Add your buttons to alert controller
                
                [alert addAction:yesButton];
                
                [self presentViewController:alert animated:YES completion:nil];
                
                //                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                //
                //                [alert show];
            }
            
            else
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:message preferredStyle:UIAlertControllerStyleAlert];
                
                //Add Buttons
                
                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                
                                                
                                            }];
                
                
                //Add your buttons to alert controller
                
                [alert addAction:yesButton];
                
                [self presentViewController:alert animated:YES completion:nil];
                
                //                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                //
                //                [alert show];
            }
        });
    }
}



@end

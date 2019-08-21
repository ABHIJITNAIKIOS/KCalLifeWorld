//
//  AddCardViewController.m
//  KCal
//
//  Created by Pipl014 on 20/07/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "AddCardViewController.h"
#import "BaseViewController.h"
#import "1.h"
#import "KCal-Swift.h"
#import "CheckoutKitObjC.h"
#import "CardTokenResponse.h"
#import "CardProviderResponse.h"
#import "PaymentViewController.h"
#import "AppDelegate.h"
#import "paymentMethodViewController.h"
#import "CheckoutViewController.h"
#import "GiFHUD.h"
#import <IQKeyboardManager.h>
#define ACCEPTABLE_CHARACTERS @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "

@interface AddCardViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
{
    NSDictionary *dictexample;
    NSMutableArray *arrMonth;
    NSMutableArray *arrYear;
    NSString *strcond;
    NSString *strMonth, *strYear, *year;
    NSString *Paymentmethod;
    NSString *strpaymentmode;
    NSString *card_token;
    int currentyear;
    int currentmonth;
    int selectyear;
    int selectmonth;
    NSString *strcardholdernameflag;
    NSString *strcardnumberflag;
    NSString *strcardcvvflag;
    NSString *strcardexpiryflag;
}

@end

@implementation AddCardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _btnaddcard.userInteractionEnabled = NO;
    
    [_btnaddcard setBackgroundColor:[UIColor lightGrayColor]];
    
    strcardholdernameflag = @"no";
    strcardnumberflag = @"no";
    strcardcvvflag = @"no";
    strcardexpiryflag = @"no";
    strpaymentmode = @"";
    Paymentmethod = @"";
    strMonth = @"";
    strYear = @"";
    self.navigationItem.hidesBackButton = YES;
    self.title = @"Add a Card";
    self.txtCardHolderNme.delegate = self;
    _txtExpiryDate.delegate = self;
    _txtCardName.delegate = self;
    _txtCvv.delegate = self;
    
    arrMonth= [[NSMutableArray alloc] init];
    
    for (int i=1; i<=12; i++)
    {
        [arrMonth addObject:[NSString stringWithFormat:@"%02d",i]];
    }
    
    //arrMonth = @[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10",@"11",@"12"];
    
    arrYear= [[NSMutableArray alloc] init];
    NSCalendar *gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSInteger year = [gregorian component:NSCalendarUnitYear fromDate:NSDate.date];
    
    for (NSInteger i=year; i<=2099; i++)
    {
        [arrYear addObject:[NSString stringWithFormat:@"%ld",(long)i]];
    }
    
    [self.view addSubview:self.ViewDatePicker];
    
    self.ViewDatePicker.hidden = YES;
    
    [GiFHUD setGifWithImageName:@"Spinner3.gif"];
    
//    HUD = [[MBProgressHUD alloc] initWithView:self.view];
//    HUD.delegate = self;
//    HUD.labelText = NSLocalizedString(@"Loading..",nil);
//    HUD.dimBackground = YES;
//    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
}




- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [_txtCardHolderNme.keyboardToolbar.doneBarButton setTarget:self action:@selector(doneAction:)];
    [_txtCardName.keyboardToolbar.doneBarButton setTarget:self action:@selector(doneAction:)];
    [_txtCvv.keyboardToolbar.doneBarButton setTarget:self action:@selector(doneAction:)];
}




/*! doneAction. */
-(void)doneAction:(IQBarButtonItem*)barButton
{
    //doneAction
    
    if (_txtCardHolderNme.text.length > 0)
    {
        strcardholdernameflag = @"yes";
    }
    
    else
    {
        strcardholdernameflag = @"no";
    }
    
    
    
    if (_txtCardName.text.length > 0)
    {
        strcardnumberflag = @"yes";
    }
    
    else
    {
        strcardnumberflag = @"no";
    }
    
    
    
    if (_txtExpiryDate.text.length > 0)
    {
        strcardexpiryflag = @"yes";
    }
    
    else
    {
        strcardexpiryflag = @"no";
    }
    
    
    
    if (_txtCvv.text.length > 0)
    {
        strcardcvvflag = @"yes";
    }
    
    else
    {
        strcardcvvflag = @"no";
    }
    
    
    if ([strcardcvvflag isEqualToString:@"yes"]&&[strcardexpiryflag isEqualToString:@"yes"]&&[strcardnumberflag isEqualToString:@"yes"]&&[strcardholdernameflag isEqualToString:@"yes"])
    {
        [_btnaddcard setUserInteractionEnabled:YES];
        [_btnaddcard setBackgroundColor:[UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1.0]];
    }
    
    else
    {
        _btnaddcard.userInteractionEnabled = NO;
        
        [_btnaddcard setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    [_txtCardHolderNme resignFirstResponder];
    [_txtCardName resignFirstResponder];
    [_txtCvv resignFirstResponder];
}




-(void)viewDidAppear:(BOOL)animated
{
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame = CGRectMake(12, 15, 18, 18);
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"white_left"] forState:UIControlStateNormal];
    leftbtn.tag=234;
    
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
        
        if (view.tag == 225)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 227)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 229)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 232)
        {
            [view removeFromSuperview];
        }
    }
}




-(void)back
{
    if ([_strflag isEqualToString:@"yes"])
    {
        paymentMethodViewController *obj=[[paymentMethodViewController alloc]initWithNibName:@"paymentMethodViewController" bundle:nil];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
    
    else
    {
        PaymentViewController *obj=[[PaymentViewController alloc]initWithNibName:@"PaymentViewController" bundle:nil];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
}




-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == _txtCardHolderNme)
    {
        _lblCardholdername.backgroundColor = [UIColor getCopyCustomColor];
        _lblCvv.backgroundColor = [UIColor grayColor];
        _lblCardName.backgroundColor = [UIColor grayColor];
        _lblExpiryDate.backgroundColor = [UIColor grayColor];
    }
    
    else if (textField == _txtCardName)
    {
        _lblCardName.backgroundColor =[UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1.0f];
        _lblCvv.backgroundColor = [UIColor grayColor];
        _lblExpiryDate.backgroundColor = [UIColor grayColor];
        _lblCardholdername.backgroundColor = [UIColor grayColor];
    }
    
    else if (textField == _txtExpiryDate)
    {
        _lblExpiryDate.backgroundColor =[UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1.0f];
        _lblCvv.backgroundColor = [UIColor grayColor];
        _lblCardName.backgroundColor = [UIColor grayColor];
        _lblCardholdername.backgroundColor = [UIColor grayColor];
    }
    
    else
    {
        _lblCvv.backgroundColor =[UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1.0f];
        _lblCardholdername.backgroundColor = [UIColor grayColor];
        _lblCardName.backgroundColor = [UIColor grayColor];
        _lblExpiryDate.backgroundColor = [UIColor grayColor];
    }
    
    return  true;
}




- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _txtCardHolderNme)
    {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        return [string isEqualToString:filtered];
    }
    
//    else if (textField == _txtCardName)
//    {
//
//    }
//
//    else if (textField == _txtCvv)
//    {
//
//    }
    
    return YES;
}





- (BOOL)validateStringWithAlphabet:(NSString *)string
{
    NSString *stringRegex = @"[A-Za-z ]";
    NSPredicate *stringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", stringRegex];
    
    return [stringPredicate evaluateWithObject:string];
}




- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 2;
}




- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0)
    {
        return arrMonth.count;
    }
    
    else
    {
        return arrYear.count;
    }
}



- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == 0)
    {
        NSString *strmonth =[NSString stringWithFormat:@"%@",[arrMonth objectAtIndex:row]];
        
        return strmonth;
    }
    
    else
    {
        NSString *strmonth =[NSString stringWithFormat:@"%@",[arrYear objectAtIndex:row]];
        
        return strmonth;
    }
}




- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if(component == 0)
    {
        strMonth = [arrMonth objectAtIndex:row];
    }
    
    else
    {
        strYear = [arrYear objectAtIndex:row];
        year = [arrYear objectAtIndex:row];
        strYear = [strYear substringFromIndex: [strYear length] - 2];
    }
}





- (IBAction)btnexpiry:(id)sender
{
    [self.view endEditing:YES];
    self.ViewDatePicker.hidden=NO;
}


  


- (IBAction)btndonedate:(id)sender
{
    if ([strMonth isEqualToString:@""])
    {
        strMonth = [arrMonth objectAtIndex:0];
    }
    
    if ([strYear isEqualToString:@""])
    {
        strYear = [arrYear objectAtIndex:0];
        year = [arrYear objectAtIndex:0];
        strYear = [strYear substringFromIndex: [strYear length] - 2];
    }
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    
    NSDate *curentDate=[NSDate date];
    
    [dateFormat setDateFormat:@"yyyy"];
    currentyear = [[dateFormat stringFromDate:curentDate] intValue];
    
    [dateFormat setDateFormat:@"MM"];
    currentmonth = [[dateFormat stringFromDate:curentDate] intValue];
    
    selectyear = year.intValue;
    
    selectmonth = strMonth.intValue;
    
    
    if (selectyear <= currentyear && selectmonth <= currentmonth)
    {
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle:nil
                                    message:@"Your card is expired."
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction
                                 actionWithTitle:@"OK"
                                 style:UIAlertActionStyleDefault
                                 handler:^(UIAlertAction * action)
                                 {
                                     [alert dismissViewControllerAnimated:YES completion:nil];
                                 }];
        
        [alert addAction:cancel];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        strYear=@"";
        
        strMonth=@"";
        
        self.txtExpiryDate.text = @"";
    }
    
    else
    {
        self.txtExpiryDate.text = [NSString stringWithFormat:@"%@/%@",strMonth,strYear];
    }
    
    self.ViewDatePicker.hidden=YES;
    
    
//    if (_txtCardHolderNme.text.length > 0)
//    {
//        strcardholdernameflag = @"yes";
//    }
//
//    else
//    {
//        strcardholdernameflag = @"no";
//    }
//
//
//
//    if (_txtCardName.text.length > 0)
//    {
//        strcardnumberflag = @"yes";
//    }
//
//    else
//    {
//        strcardnumberflag = @"no";
//    }
//
//
//
//    if (_txtExpiryDate.text.length > 0)
//    {
//        strcardexpiryflag = @"yes";
//    }
//
//    else
//    {
//        strcardexpiryflag = @"no";
//    }
//
//
//
//    if (_txtCvv.text.length > 0)
//    {
//        strcardcvvflag = @"yes";
//    }
//
//    else
//    {
//        strcardcvvflag = @"no";
//    }
//
//
//    if ([strcardcvvflag isEqualToString:@"yes"]&&[strcardexpiryflag isEqualToString:@"yes"]&&[strcardnumberflag isEqualToString:@"yes"]&&[strcardholdernameflag isEqualToString:@"yes"])
//    {
//        [_btnaddcard setUserInteractionEnabled:YES];
//        [_btnaddcard setBackgroundColor:[UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1.0]];
//    }
//
//    else
//    {
//        _btnaddcard.userInteractionEnabled = NO;
//
//        [_btnaddcard setBackgroundColor:[UIColor lightGrayColor]];
//    }
}




- (IBAction)btncanceldate:(id)sender
{
    self.ViewDatePicker.hidden=YES;
    
    if (_txtCardHolderNme.text.length > 0)
    {
        strcardholdernameflag = @"yes";
    }
    
    else
    {
        strcardholdernameflag = @"no";
    }
    
    
    
    if (_txtCardName.text.length > 0)
    {
        strcardnumberflag = @"yes";
    }
    
    else
    {
        strcardnumberflag = @"no";
    }
    
    
    
    if (_txtExpiryDate.text.length > 0)
    {
        strcardexpiryflag = @"yes";
    }
    
    else
    {
        strcardexpiryflag = @"no";
    }
    
    
    
    if (_txtCvv.text.length > 0)
    {
        strcardcvvflag = @"yes";
    }
    
    else
    {
        strcardcvvflag = @"no";
    }
    
    
    if ([strcardcvvflag isEqualToString:@"yes"]&&[strcardexpiryflag isEqualToString:@"yes"]&&[strcardnumberflag isEqualToString:@"yes"]&&[strcardholdernameflag isEqualToString:@"yes"])
    {
        [_btnaddcard setUserInteractionEnabled:YES];
        [_btnaddcard setBackgroundColor:[UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1.0]];
    }
    
    else
    {
        _btnaddcard.userInteractionEnabled = NO;
        
        [_btnaddcard setBackgroundColor:[UIColor lightGrayColor]];
    }
}




- (IBAction)btnAddCardTapped:(id)sender
{
    if([_txtCardHolderNme.text isEqualToString:@""])
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"Please enter the card holder name."
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
    
    else if([_txtCardName.text isEqualToString:@""])
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"Please enter the card number."
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
    
    else if([_txtExpiryDate.text isEqualToString:@""])
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"Please enter the card expiry date."
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
    
    else if([_txtCvv.text isEqualToString:@""])
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"Please enter the card CVV number."
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
    
    else if (_txtCvv.text.length < 3)
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"Please enter the correct CVV card number."
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
            [self checkoutfunctionality];
            
        });
    }
}





-(void)checkoutfunctionality
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //NSString *strkey = [defaults valueForKey:@"checkout_pk"];
    
    CheckoutKitObjC *checkoutKitInstance = [[CheckoutKitObjC alloc] init];
    
    [checkoutKitInstance setPublicKey:@"pk_test_304126f0-b557-43ce-8a48-e716416c59fb"];
    
    //[checkoutKitInstance setPublicKey:strkey];
    
    [checkoutKitInstance setEnvironment:@"SANDBOX"];
    
    [checkoutKitInstance getCardProviders:^(CardProviderResponse *providersResponse)
     {
         NSArray *providersArray = providersResponse.data;
         
         int providersCount = providersResponse.count;
         
         for (int i = 0; i < providersCount; i++)
         {
             CardProvider *testProvider = [providersArray objectAtIndex:i];
             
//             NSLog(@"%@", testProvider.name);
//
//             NSLog(@"%@", testProvider.id);
         }
     } failure:^(NSError *error)
     {
         NSLog(@"%@", [error valueForKey:@"errors"]);
         
         NSLog(@"%@", error);
     }];
    
    Card *card = [Card alloc];
    
    [card setNumber:self.txtCardName.text];
    
    [card setName:self.txtCardHolderNme.text];
    
    [card setCvv:self.txtCvv.text];
    
    [card setExpMonth:strMonth];
    
    [card setExpYear:strYear];
    
    bool testCardValidity = [card verify];
    
    if (testCardValidity == false)
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"Invalid Card"
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
        
        [GiFHUD dismiss];
    }
    
    CustomerDetails *customerDetails = [CustomerDetails alloc];
    
//    NSString *street = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"street"]];
//
//    NSString *sublocation = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"sublocation"]];
//
//    NSString *city = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"city"]];
//
//    NSString *strmbl = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"user_contactnumber"]];
//
//    [customerDetails setAddress1:street];
//
//    [customerDetails setAddress2:sublocation];
//
//    [customerDetails setPostCode:@""];
//
//    [customerDetails setCountry:@"UAE"];
//
//    [customerDetails setCity:city];
//
//    [customerDetails setState:@""];
//
//    Phone *phone = [Phone alloc];
//
//    [phone setNumber:strmbl];
//
//    [phone setCountryCode:@"971"];
    
    [customerDetails setAddress1:@"flat 100"];

    [customerDetails setAddress2:@"Oxford Street"];

    [customerDetails setPostCode:@"N12 345"];

    [customerDetails setCountry:@"GB"];

    [customerDetails setCity:@"London"];

    [customerDetails setState:@""];

    Phone *phone = [Phone alloc];

    [phone setNumber:@"0712345678"];

    [phone setCountryCode:@"44"];
    
    
    [customerDetails setPhone:phone];
    
    [card setBillingDetails:customerDetails];
    
    [checkoutKitInstance createCardToken:card success:^(CardTokenResponse *responseDict)
     {
         NSLog(@"card%@",responseDict.cardToken);
         card_token = responseDict.cardToken;
         
         NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
         [defaults setObject:card_token forKey:@"card_token"];
         
         NSLog(@"%@",responseDict.description);
         NSLog(@"%@", responseDict.card);
         
         NSDictionary *dicttemp = responseDict.card.copy;
         dictexample = responseDict.card.copy;
         Paymentmethod = [NSString stringWithFormat:@"%@",[dicttemp valueForKey:@"paymentMethod"]];
         strpaymentmode = @"Online card payment";
         
         dispatch_async(dispatch_get_main_queue(), ^{
        
//             [GiFHUD dismiss];
//             [self sendtocheckoutview];
             
             [self wsAddCard];
         });
         
         
     } failure:^(NSError *error)
     {
         [GiFHUD dismiss];
         NSLog(@"%@", [error valueForKey:@"errors"]);
         NSLog(@"%@", error);
     }];
}




-(void)sendtocheckoutview
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:strpaymentmode forKey:@"PaymentMethod"];
    [defaults setObject:dictexample forKey:@"PaymentCard"];
    
    CheckoutViewController *obj=[[CheckoutViewController alloc]initWithNibName:@"CheckoutViewController" bundle:nil];
    obj.dictcard = dictexample;
    obj.strpaymentmode = strpaymentmode;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.navigationController pushViewController:obj animated:YES];
}





#pragma mark <--Web Services-->


-(void)wsAddCard
{
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *user_id = [[NSUserDefaults standardUserDefaults] valueForKey:@"user_id"];
    NSString *strtoken = [[NSUserDefaults standardUserDefaults] valueForKey:@"token"];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"token=%@&key=%@&secret=%@&clientID=%@&card_token=%@&request=%@&action=%@",strtoken,str_key,str_secret,user_id,card_token,@"client",@"addcard"];
    
    NSDictionary *dictionary =[[NSMutableDictionary alloc]init];
    
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
        
//        dispatch_async(dispatch_get_main_queue(),^{
        
            if([errorCode isEqualToString:@"1"])
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:@"Card is added successfully."
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                //Add Buttons
                
                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {

                                                if ([_strflag isEqualToString:@"yes"])
                                                {
                                                    paymentMethodViewController *obj=[[paymentMethodViewController alloc]initWithNibName:@"paymentMethodViewController" bundle:nil];
                                                    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                                                    [self.navigationController pushViewController:obj animated:YES];
                                                }

                                                else
                                                {
                                                    PaymentViewController *obj=[[PaymentViewController alloc]initWithNibName:@"PaymentViewController" bundle:nil];
                                                    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                                                    [self.navigationController pushViewController:obj animated:YES];
                                                }
                                            }];
                
                
                //Add your buttons to alert controller
                
                [alert addAction:yesButton];
                
                [self presentViewController:alert animated:YES completion:nil];
            }

            else if ([errorCode isEqualToString:@"0"])
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:message preferredStyle:UIAlertControllerStyleAlert];

                //Add Buttons

                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {

                                                if ([_strflag isEqualToString:@"yes"])
                                                {
                                                    paymentMethodViewController *obj=[[paymentMethodViewController alloc]initWithNibName:@"paymentMethodViewController" bundle:nil];
                                                    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                                                    [self.navigationController pushViewController:obj animated:YES];
                                                }
                                                
                                                else
                                                {
                                                    PaymentViewController *obj=[[PaymentViewController alloc]initWithNibName:@"PaymentViewController" bundle:nil];
                                                    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                                                    [self.navigationController pushViewController:obj animated:YES];
                                                }
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
//        });
    }
}



@end

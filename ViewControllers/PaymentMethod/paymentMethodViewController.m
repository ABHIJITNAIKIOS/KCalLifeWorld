//
//  paymentMethodViewController.m
//  KCal
//
//  Created by Pipl014 on 20/07/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "paymentMethodViewController.h"
#import "paymentTableViewCell.h"
#import "AddCardViewController.h"
#import "CheckoutViewController.h"
#import "CartViewController.h"
#import "BaseViewController.h"
#import "AppDelegate.h"
#import "GiFHUD.h"
#import "WeeklyViewCart.h"
#import "orderStatusViewController.h"

@interface paymentMethodViewController ()
{
    NSArray *arrCard;
    NSString *strpaymentmode;
    NSString *strcard_id;
    NSString *strflag;
    NSString *strcallid;
    NSString *strorder_id;
}


@end

@implementation paymentMethodViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    [self initVisaCheckout];
    
    strcard_id = @"";
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    strflag = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"tryAgainPayment"]];
    
    if ([strflag isEqualToString:@"noBack"])
    {
        
    }
    
    else
    {
        UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftbtn.frame = CGRectMake(12, 15, 18, 18);
        [leftbtn setBackgroundImage:[UIImage imageNamed:@"white_left"] forState:UIControlStateNormal];
        leftbtn.tag=227;
        
        [leftbtn addTarget:self action:@selector(back)
          forControlEvents:UIControlEventTouchUpInside];
        
        [self.navigationController.navigationBar addSubview:leftbtn];
    }
    
    
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
        
        if (view.tag == 229)
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
    
    strpaymentmode = @"";
    
    arrCard = [[NSArray alloc]init];
    
    [GiFHUD setGifWithImageName:@"Spinner3.gif"];
    
    _tblCardList.delegate = self;
    
    self.title = @"Payment Method";
    
    NSString *strvisa = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"visacheckout"]];
    
    if ([strvisa isEqualToString:@"visa"])
    {
        
    }
    
    else
    {
        _viewvisa.hidden = YES;
        _visaheight.constant = 0;
    }
    
    NSString *strmethod = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"shoppaymentmethod"]];
    
    if ([strmethod isEqualToString:@"card"])
    {
        if ([strvisa isEqualToString:@"visa"])
        {
            
        }
        
        else
        {
            _viewheight.constant = 0;
        }
        
        [GiFHUD showWithOverlay];
        //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self wsGetCard];
        });
    }
    
    else
    {
        _viewaddcard.hidden = YES;
        _viewheight.constant = 0;
        _tblCardList.hidden = YES;
        
        _ChgtCardList.constant = 0;
        _viewcheckouttop.constant = 0;
    }
}




-(void)back
{
    NSString *flag = [[NSUserDefaults standardUserDefaults] valueForKey:@"back"];
    
    if ([flag isEqualToString:@"weekly"])
    {
        WeeklyViewCart *cart =[[WeeklyViewCart alloc]init];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:cart animated:YES];
    }
    
    else
    {
        CartViewController *obj=[[CartViewController alloc]initWithNibName:@"CartViewController" bundle:nil];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
}




- (IBAction)btnCODtapped:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    strpaymentmode = @"Cash";
    
    [defaults setObject:strpaymentmode forKey:@"PaymentMethod"];
    
    if ([strflag isEqualToString:@"noBack"])
    {
        [GiFHUD showWithOverlay];
        //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self wsPlaceOrderAfterPaymentFailed];
        });
    }
    
    else
    {
        CheckoutViewController *obj=[[CheckoutViewController alloc]initWithNibName:@"CheckoutViewController" bundle:nil];
        obj.strpaymentmode = strpaymentmode;
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
}




- (IBAction)btnaddCardTapped:(id)sender
{
    AddCardViewController *obj=[[AddCardViewController alloc]initWithNibName:@"AddCardViewController" bundle:nil];
    obj.strflag = @"yes";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.navigationController pushViewController:obj animated:YES];
}




- (void)initVisaCheckout
{
    NSString *str = @"RVUMPAAHAKIUSH3XCME2130hBJZwTHVoGtah_rcXUNxKLpFIg";
    //NSString *str = @"P6SI92850Y8YADVQY5HM13silsTWULsHa-uQMF7qshqzMqLB8";
    //NSString *str = [[NSUserDefaults standardUserDefaults] valueForKey:@"visa_checkout_api"];
    
    NSString *strtotalprice = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"grandtotal"]];
    NSString *strcurrent = [strtotalprice stringByReplacingOccurrencesOfString:@"AED" withString:@""];
    double price = [strcurrent doubleValue];
    
    VisaProfile *profile = [[VisaProfile alloc] initWithEnvironment:VisaEnvironmentSandbox apiKey:str profileName:@"KCaliOS"];
    VisaCurrencyAmount *amount = [[VisaCurrencyAmount alloc] initWithDouble:price];
    VisaPurchaseInfo *purchaseInfo = [[VisaPurchaseInfo alloc] initWithTotal:amount currency:VisaCurrencyAed];
    
    __weak typeof (self) _self = self;
    [self.checkoutButton
     onCheckoutWithProfile:profile
     purchaseInfo:purchaseInfo
     presentingViewController:self
     onReady:^(LaunchHandle  _Nonnull launchHandle) {
         _self.launchCheckoutHandle = launchHandle;
     } onButtonTapped:^{
         [_self launchCheckout];
     } completion:[_self resultHandler]];
}




- (VisaCheckoutResultHandler)resultHandler
{
    __weak typeof (self) _self = self;
    return ^(VisaCheckoutResult * _Nonnull result){
        // Make sure to re-init in your result handler
        [_self initVisaCheckout];
        switch (result.statusCode) {
            case VisaCheckoutResultStatusInternalError:
                NSLog(@"ERROR");
                break;
            case VisaCheckoutResultStatusNotConfigured:
                NSLog(@"NOT CONFIGURED");
                break;
            case VisaCheckoutResultStatusDuplicateCheckoutAttempt:
                NSLog(@"DUPLICATE CHECKOUT ATTEMPT");
                break;
            case VisaCheckoutResultStatusUserCancelled:
                NSLog(@"USER CANCELLED");
                break;
            case VisaCheckoutResultStatusSuccess:
            {
                NSLog(@"SUCCESS");
                
                NSString *str = result.callId.copy;
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                strcallid = [NSString stringWithFormat:@"%@",str];
                
                [defaults setObject:strcallid forKey:@"callid"];
                
                strpaymentmode = @"Online card payment";
                
                [defaults setObject:strpaymentmode forKey:@"PaymentMethod"];
                
                if ([strflag isEqualToString:@"noBack"])
                {
                    [GiFHUD showWithOverlay];
                    //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        [self wsPlaceOrderAfterPaymentFailed];
                    });
                }
                
                else
                {
                    CheckoutViewController *obj=[[CheckoutViewController alloc]initWithNibName:@"CheckoutViewController" bundle:nil];
                    obj.strpaymentmode = strpaymentmode;
                    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                    [self.navigationController pushViewController:obj animated:YES];
                }
                
                break;
            }
            case VisaCheckoutResultDefault:
            {
                NSLog(@"SUCCESS");
                
                if ([strflag isEqualToString:@"noBack"])
                {
                    
                }
                
                else
                {
//                    CheckoutViewController *obj=[[CheckoutViewController alloc]initWithNibName:@"CheckoutViewController" bundle:nil];
//                    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
//                    [self.navigationController pushViewController:obj animated:YES];
                }
                
                break;
            }
        }
    };
}





- (void)launchCheckout {
    if (self.launchCheckoutHandle) {
        self.launchCheckoutHandle();
    }
}





#pragma mark <---table method--->

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (arrCard.count > 0)
    {
        if(arrCard.count > 1)
        {
            _ChgtCardList.constant = 150;
        }
        
        else
        {
            _ChgtCardList.constant = 75;
        }
        
        return arrCard.count;
        
    }
    
    else
    {
        return 1;
    }
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 77;
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Method get called");
    
    paymentTableViewCell *cell1 = (paymentTableViewCell *)[self.tblCardList dequeueReusableCellWithIdentifier:@"cell1"];
    
    NSArray *nib;
    nib = [[NSBundle mainBundle] loadNibNamed:@"paymentTableViewCell" owner:self options:nil];
    
    cell1 =[[paymentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
    
    cell1 = [nib objectAtIndex:0];
    
    if (arrCard.count > 0)
    {
        _tblCardList.hidden = NO;
        
        cell1.viewnorecord.hidden = YES;
        
        NSArray *arrtemp = [arrCard objectAtIndex:indexPath.row];
        
        if ([[arrtemp valueForKey:@"card_type"] isKindOfClass:[NSNull class]])
        {
            cell1.lblCardName.text = @"";
        }
        
        else
        {
            cell1.lblCardName.text = [arrtemp valueForKey:@"card_type"];
            
            
            if ([[arrtemp valueForKey:@"card_type"] isEqualToString:@"MasterCard"])
            {
                cell1.imgCard.image = [UIImage imageNamed:@"card"];
            }
            
            else if ([[arrtemp valueForKey:@"card_type"] isEqualToString:@"Visa"])
            {
                cell1.imgCard.image = [UIImage imageNamed:@"visa"];
            }
            
            else if ([[arrtemp valueForKey:@"card_type"] isEqualToString:@"Amex"])
            {
                cell1.imgCard.image = [UIImage imageNamed:@"amex"];
            }
            
            else if ([[arrtemp valueForKey:@"card_type"] isEqualToString:@"DinersClub"])
            {
                cell1.imgCard.image = [UIImage imageNamed:@"diners_club_credit_card_logo"];
            }
            
            else if ([[arrtemp valueForKey:@"card_type"] isEqualToString:@"Discover"])
            {
                cell1.imgCard.image = [UIImage imageNamed:@"discover"];
            }
            
            else if ([[arrtemp valueForKey:@"card_type"] isEqualToString:@"JCB"])
            {
                cell1.imgCard.image = [UIImage imageNamed:@"jcb"];
            }
        }
        
        
        if ([[arrtemp valueForKey:@"card_last4"] isKindOfClass:[NSNull class]])
        {
            cell1.lblCarddate.text = @"";
        }
        
        else
        {
            NSString *newStr = [arrtemp valueForKey:@"card_last4"];
            
            NSString *card = [NSString stringWithFormat:@"Ending %@",newStr];
            
            cell1.lblCarddate.text = card;
            
            //            if (cardlength.length >4)
            //            {
            //                NSString *cardno = [arrtemp valueForKey:@"card_last4"];
            //                NSString *newStr = [cardno substringFromIndex: [cardno length] - 4];
            //
            //                NSString *card = [NSString stringWithFormat:@"Ending %@",newStr];
            //
            //                cell1.lblCarddate.text = card;
            //            }
            //
            //            else
            //            {
            //
            //            }
        }
    }
    
    
    
    
    
    
//    if (arrCard.count > 0)
//    {
//        cell1.viewnorecord.hidden = YES;
//
//        NSArray *arrtemp = [arrCard objectAtIndex:indexPath.row];
//
//        if ([[arrtemp valueForKey:@"card_type"] isKindOfClass:[NSNull class]])
//        {
//            cell1.lblCardName.text = @"";
//        }
//
//        else
//        {
//            cell1.lblCardName.text = [arrtemp valueForKey:@"card_type"];
//
//            if ([[arrtemp valueForKey:@"card_type"] isEqualToString:@"MasterCard"])
//            {
//                cell1.imgCard.image = [UIImage imageNamed:@"card"];
//            }
//
//            else
//            {
//                cell1.imgCard.image = [UIImage imageNamed:@"visa"];
//            }
//        }
//
//
//
//        if ([[arrtemp valueForKey:@"card_no"] isKindOfClass:[NSNull class]])
//        {
//            cell1.lblCarddate.text = @"";
//        }
//
//        else
//        {
//            NSString *cardlength = [arrtemp valueForKey:@"card_no"];
//
//            if (cardlength.length >4)
//            {
//                NSString *cardno = [arrtemp valueForKey:@"card_no"];
//                NSString *newStr = [cardno substringFromIndex: [cardno length] - 4];
//
//                NSString *card = [NSString stringWithFormat:@"Ending %@",newStr];
//
//                cell1.lblCarddate.text = card;
//            }
//
//            else
//            {
//
//            }
//        }
//
//        _ChgtCardList.constant = _tblCardList.contentSize.height;
//
//        _tblCardList.hidden = NO;
//    }
    
    else
    {
        _tblCardList.hidden = YES;
        
        _ChgtCardList.constant = 0;
        _viewcheckouttop.constant = 4;
        
        cell1.viewnorecord.hidden = NO;
    }
    
    cell1.btndeletecard.hidden = YES;
    
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell1;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    strcallid = @"";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setValue:strcallid forKey:@"callid"];
    
    NSString *strpayment = @"Online card payment";
    
    [defaults setObject:strpayment forKey:@"PaymentMethod"];
    
    strcard_id = [NSString stringWithFormat:@"%@",[[arrCard objectAtIndex:indexPath.row] valueForKey:@"id"]];
    
    strpaymentmode = strpayment;
    
    if ([strflag isEqualToString:@"noBack"])
    {
        [GiFHUD showWithOverlay];
        //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self wsPlaceOrderAfterPaymentFailed];
        });
    }
    
    else
    {
        CheckoutViewController *obj=[[CheckoutViewController alloc]initWithNibName:@"CheckoutViewController" bundle:nil];
        obj.strpaymentmode = strpayment;
        obj.dictPayment = [arrCard objectAtIndex:indexPath.row];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
}




#pragma mark <--Web Services-->


-(void)wsGetCard
{
    BaseViewController *base=[[BaseViewController alloc]init];
    NSString *user_id=[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"];
    NSString *strtoken = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"token=%@&key=%@&secret=%@&clientID=%@&action=%@&request=%@",strtoken,str_key,str_secret,user_id,@"cards",@"client"];
    
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
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            if([errorCode isEqualToString:@"1"])
            {
                arrCard = [dictionary valueForKey:@"data"];
                
                NSLog(@"%@", arrCard);
                
                [_tblCardList reloadData];
            }
            
            else if ([errorCode isEqualToString:@"0"])
            {
                [_tblCardList reloadData];

                //                UIAlertController * alert = [UIAlertController
                //                                             alertControllerWithTitle:nil
                //                                             message:message preferredStyle:UIAlertControllerStyleAlert];
                //
                //                //Add Buttons
                //
                //                UIAlertAction* yesButton = [UIAlertAction
                //                                            actionWithTitle:@"OK"
                //                                            style:UIAlertActionStyleDefault
                //                                            handler:^(UIAlertAction * action) {
                //
                //
                //                                            }];
                //
                //
                //                //Add your buttons to alert controller
                //
                //                [alert addAction:yesButton];
                //
                //                [self presentViewController:alert animated:YES completion:nil];

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




-(void)wsPlaceOrderAfterPaymentFailed
{
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    strorder_id = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"order_id"]];
    
    NSString *parameter;
    
    if ([strpaymentmode isEqualToString:@"Cash"])
    {
        //COD
        
        parameter=[NSString stringWithFormat:@"payment=%@&order_id=%@&key=%@&secret=%@&request=%@&action=%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"PaymentMethod"],strorder_id,str_key,str_secret,@"order",@"update-payment"];
    }
    
    else if (([strpaymentmode isEqualToString:@"Online card payment"] && strcallid.length > 0))
    {
        //Visa Checkout
        
        parameter=[NSString stringWithFormat:@"payment=%@&callid=%@&order_id=%@&card_type=%@&key=%@&secret=%@&request=%@&action=%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"PaymentMethod"],strcallid,strorder_id,@"new",str_key,str_secret,@"order",@"update-payment"];
    }
    
    else if ([strpaymentmode isEqualToString:@"Online card payment"])
    {
        //Card Payment
        
        parameter=[NSString stringWithFormat:@"payment=%@&card_id=%@&card_type=%@&order_id=%@&key=%@&secret=%@&request=%@&action=%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"PaymentMethod"],strcard_id,@"old",strorder_id,str_key,str_secret,@"order",@"update-payment"];
        
        //card_id = strcard_id
    }
    
    NSDictionary *dictionary =[[NSMutableDictionary alloc]init];
    
    dictionary=[base WebParsingMethod:stringWebServicesCompleteUrl:parameter];
    
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
                                                
                                                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"PaymentMethod"];
                                                
                                                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"PaymentCard"];
                                                
                                                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"cartcomment"];
                                                
                                                [[NSUserDefaults  standardUserDefaults]setObject:@"" forKey:@"riderinstruction"];
                                                
                                                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"shopId"];
                                                
                                                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"tryAgainPayment"];
                                                
                                                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"order_id"];
                                                
                                                orderStatusViewController *obj=[[orderStatusViewController alloc]initWithNibName:@"orderStatusViewController" bundle:nil];
                                                obj.strorder_id = strorder_id;
                                                obj.dictorder = _dictorder;
                                                self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                                                [self.navigationController pushViewController:obj animated:YES];
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
                                                
                                                
                                            }];
                
                
                //Add your buttons to alert controller
                
                [alert addAction:yesButton];
                
                [self presentViewController:alert animated:YES completion:nil];
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

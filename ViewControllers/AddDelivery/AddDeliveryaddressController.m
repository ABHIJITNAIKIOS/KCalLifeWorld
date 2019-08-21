//
//  AddDeliveryaddressController.m
//  KCal
//
//  Created by Pipl-10 on 06/07/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "AddDeliveryaddressController.h"
#import "HomeViewController.h"
#import "BaseViewController.h"
#import "AppDelegate.h"
#import "AreaViewCell.h"
#import "AreaselectionViewCell.h"
#import "DeliverylocationController.h"
#import "CheckoutViewController.h"

@interface AddDeliveryaddressController ()
{
    AreaViewCell *cell;
    AreaselectionViewCell *cell1;
    NSMutableArray *areadict;
    NSString *category_id,*Strcity,*update_id,*updateflag;
    NSArray *arrarea;
    NSArray *area;
    NSString *strdidselectdata;
    NSMutableArray *result;
    NSString *strfromcheckout2;
    NSString *strdlvr;
    NSDictionary *dictfromcheckout;
    NSMutableArray *arraddress;
}


@end

@implementation AddDeliveryaddressController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arraddress = [[NSMutableArray alloc]init];
    
    strdidselectdata =@"";
    self.tblarea.hidden = YES;
    self.navigationItem.hidesBackButton=YES;
    self.navigationController.navigationBar.hidden=NO;
    self.title=@"Add Delivery Address";
    category_id = @"";
    _txttitle.text= self.strtitle;
    _tblarea.layer.borderWidth=1.0f;
    _tblcity.layer.borderWidth=1.0f;
    _tblarea.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _tblcity.layer.borderColor = [UIColor lightGrayColor].CGColor;
    strfromcheckout2=@"";
    strdlvr = @"";
    
    [GiFHUD setGifWithImageName:@"Spinner3.gif"];
    
    if([_flag isEqualToString:@"0"])
    {
        self.txttitle.userInteractionEnabled = NO;
    }
    
    else if([_flag isEqualToString:@"1"])
    {
        self.txttitle.userInteractionEnabled = NO;
    }
    
    else if([_flag isEqualToString:@"2"])
    {
        self.txttitle.userInteractionEnabled = YES;
    }
    
    
    if([_fromDeliveryLocation isEqualToString:@"yes"])
    {
        strdlvr = @"yes";
        
        self.txttitle.userInteractionEnabled = NO;
        self.txtaddress1.userInteractionEnabled = NO;
        self.txtaddress2.userInteractionEnabled = NO;
        self.txtaddress3.userInteractionEnabled = NO;
        
        self.txttitle.text=[_temparray valueForKey:@"title"];
        self.txtarea.text=[_temparray valueForKey:@"location"];
        self.txtaddress1.text= [_temparray valueForKey:@"street"];
        self.txtaddress2.text =[_temparray valueForKey:@"sublocation"];
        self.txtaddress3.text=[_temparray valueForKey:@"landmark"];
        update_id =[NSString stringWithFormat:@"%@",[_temparray valueForKey:@"id"]];
        updateflag=@"yes";
        NSLog(@"arrtemp=%@",_temparray);
    }
}




-(void)viewWillAppear:(BOOL)animated
{
    [self wsGetArea];
}




-(void)viewDidAppear:(BOOL)animated
{
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame = CGRectMake(12, 15, 18, 18);
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"white_left"] forState:UIControlStateNormal];
    leftbtn.tag=401;
    
    [leftbtn addTarget:self action:@selector(back)
      forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:leftbtn];
    
    for (UIButton *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 221)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 229)
        {
            [view removeFromSuperview];
        }
    }
    
    for (UIImageView *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 201)
        {
            [view removeFromSuperview];
        }
    }
    
    if ([_strfromcheckout isEqualToString:@"yes"])
    {
        [GiFHUD showWithOverlay];
        //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self getparticularaddress];
        });
    }
}




- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    if (textField == _txtarea)
    {
        if ([category_id isEqualToString:@""])
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:nil
                                         message:@"Please select the city first."
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            //Add Buttons
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            
                                            [_txtarea resignFirstResponder];
                                        }];
            
            //Add your buttons to alert controller
            
            [alert addAction:yesButton];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        else
        {
            NSString  *substring = [NSString stringWithString:_txtarea.text];
            substring = [substring
                         stringByReplacingCharactersInRange:range withString:string];
            
            [self searchAutocompleteEntriesWithSubstring:substring];
        }
    }
    
    return YES;
}



- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring
{
    result =[[NSMutableArray alloc]init];
    
    if ([substring length]>2)
    {
        self.tblarea.hidden=NO;
        NSPredicate *resultPredicate = [NSPredicate
                                        predicateWithFormat:@"self BEGINSWITH[cd] %@",
                                        substring];
        
        NSArray *searchResults = [area filteredArrayUsingPredicate:resultPredicate];
        
        if (searchResults.count)
        {
            self.tblarea.hidden=NO;
            
            for (int i=0; i<area.count; i++)
            {
                for (int i1 = 0; i1<[searchResults count];  i1++)
                {
                    if ([[searchResults objectAtIndex: i1] isEqualToString:[area objectAtIndex:i]])
                    {
                        [result addObject:[area objectAtIndex:i]];
                       // strdidselectdata =
                    }
                }
            }
            
            [self.tblarea reloadData];
        }
        
        else
        {
            self.tblarea.hidden=YES;
        }
    }
    
    else
    {
        self.tblarea.hidden=YES;
    }
}




-(void)back
{
    if([strdlvr isEqualToString:@"yes"])
    {
        DeliverylocationController *obj=[[DeliverylocationController alloc]initWithNibName:@"DeliverylocationController" bundle:nil];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
    
    else if([_fromWeeklyCalendar isEqualToString:@"yes"])
    {
        [self.navigationController popViewControllerAnimated:YES];
        
//        DeliverylocationController *obj=[[DeliverylocationController alloc]initWithNibName:@"DeliverylocationController" bundle:nil];
//        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
//        [self.navigationController pushViewController:obj animated:YES];
    }
    
    else if ([strfromcheckout2 isEqualToString:@"yes"])
    {
        _strfromcheckout =@"";
        
        CheckoutViewController *obj=[[CheckoutViewController alloc]initWithNibName:@"CheckoutViewController" bundle:nil];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
    
    else if([_strfromsimple isEqualToString:@"yes"])
    {
        DeliverylocationController *obj=[[DeliverylocationController alloc]initWithNibName:@"DeliverylocationController" bundle:nil];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
    
    else
    {
        HomeViewController *obj=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
}





- (IBAction)btnsubmitClicked:(id)sender
{
    NSString *strcond = @"";
    
    for (int i = 0; i<result.count; i++)
    {
        strdidselectdata =[result objectAtIndex:i];
        
        if([self.txtarea.text containsString:strdidselectdata])
        {
            strcond = strdidselectdata;
        }
    }
    
    if([_flag isEqualToString:@"0"])
    {
        if([self.txttitle.text isEqualToString:@""])
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:nil
                                         message:@"Please enter a valid nickname."
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
        
        else  if ([category_id isEqualToString:@""])
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:nil
                                         message:@"Please select your city."
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
        
        else  if([self.txtarea.text isEqualToString:@""])
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:nil
                                         message:@"Please select your area."
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
        
//        else if([strcond isEqualToString:@""])
//        {
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please select area from the list" delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//
//            [alert show];
//        }
//
        else if([self.txtaddress1.text isEqualToString:@""])
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:nil
                                         message:@"Please enter the Address line1."
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
        
//        else  if([self.txtaddress2.text isEqualToString:@""])
//        {
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter the Address line2." delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//
//            [alert show];
//        }
//
//        else  if([self.txtaddress3.text isEqualToString:@""])
//        {
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter thr special instructions." delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//
//            [alert show];
//        }

        else
        {
            [GiFHUD showWithOverlay];
            //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self wsAddAddress];
                //
            });
        }
    }
    
    else if([_flag isEqualToString:@"1"])
    {
        if([self.txttitle.text isEqualToString:@""])
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:nil
                                         message:@"Please enter a valid nickname."
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
        
        
        else  if ([category_id isEqualToString:@""])
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:nil
                                         message:@"Please select your city."
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
        
        else  if([self.txtarea.text isEqualToString:@""])
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:nil
                                         message:@"Please select your area."
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
        
//        else if([strcond isEqualToString:@""])
//        {
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please select the area from the list." delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//
//            [alert show];
//        }
        
        else if([self.txtaddress1.text isEqualToString:@""])
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:nil
                                         message:@"Please enter the Address line1."
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
        
//        else  if([self.txtaddress2.text isEqualToString:@""])
//        {
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter th Address line2." delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//
//            [alert show];
//        }
//
//        else  if([self.txtaddress3.text isEqualToString:@""])
//        {
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter the special instructions." delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//
//            [alert show];
//        }
        
        else
        {
            [GiFHUD showWithOverlay];
            //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self wsAddAddress];
                //
            });
        }
    }
    
    else if([_flag isEqualToString:@"2"])
    {
        if([self.txttitle.text isEqualToString:@""])
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:nil
                                         message:@"Please enter a valid nickname."
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
        
        else  if ([category_id isEqualToString:@""])
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:nil
                                         message:@"Please select your city."
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
        
        else  if([self.txtarea.text isEqualToString:@""])
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:nil
                                         message:@"Please select your area."
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
//
//        else if([strcond isEqualToString:@""])
//        {
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please select area from the list" delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//
//            [alert show];
//        }
//
        else if([self.txtaddress1.text isEqualToString:@""])
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:nil
                                         message:@"Please enter the Address line1."
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
        
//        else  if([self.txtaddress2.text isEqualToString:@""])
//        {
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter the Address line2." delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//
//            [alert show];
//        }
//
//        else  if([self.txtaddress3.text isEqualToString:@""])
//        {
//            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter the special instructions." delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//
//            [alert show];
//        }
        
        else
        {
            [GiFHUD showWithOverlay];
            //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self wsAddAddress];
                //
            });
        }
    }
    
    else if([updateflag isEqualToString:@"yes"])
    {
        if([[_temparray valueForKey:@"city"] isEqualToString:@""])
        {
            _flag = [_temparray valueForKey:@"type"];
            
            if([self.txttitle.text isEqualToString:@""])
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:@"Please enter a valid nickname."
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
            
            else  if ([category_id isEqualToString:@""])
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:@"Please select your city."
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
            
            else  if([self.txtarea.text isEqualToString:@""])
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:@"Please select your area."
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
            
            //        else if([strcond isEqualToString:@""])
            //        {
            //            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please select the area from the list." delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
            //
            //            [alert show];
            //        }
            
            else if([self.txtaddress1.text isEqualToString:@""])
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:@"Please enter the Address line1."
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
            
            //        else  if([self.txtaddress2.text isEqualToString:@""])
            //        {
            //            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter the Address line2." delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
            //
            //            [alert show];
            //        }
            //
            //        else  if([self.txtaddress3.text isEqualToString:@""])
            //        {
            //            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter the special instructions." delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
            //
            //            [alert show];
            //        }
            
            else
            {
                [GiFHUD showWithOverlay];
                //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [self wsAddAddress];
                    //
                });
            }
        }
        
        else
        {
            if([self.txttitle.text isEqualToString:@""])
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:@"Please enter a valid nickname."
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
            
            else  if ([category_id isEqualToString:@""])
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:@"Please select your city."
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
            
            else  if([self.txtarea.text isEqualToString:@""])
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:@"Please select your area."
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
            
            //        else if([strcond isEqualToString:@""])
            //        {
            //            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please select the area from the list." delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
            //
            //            [alert show];
            //        }
            
            else if([self.txtaddress1.text isEqualToString:@""])
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:@"Please enter the Address line1."
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
            
            //        else  if([self.txtaddress2.text isEqualToString:@""])
            //        {
            //            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter the Address line2." delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
            //
            //            [alert show];
            //        }
            //
            //        else  if([self.txtaddress3.text isEqualToString:@""])
            //        {
            //            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter the special instructions." delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
            //
            //            [alert show];
            //        }
            
            else
            {
                [GiFHUD showWithOverlay];
                //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [self wsUpdateAddress];
                    
                });
            }
        }
    }
}





#pragma  mark <---table view delegate--->


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.tblcity)
    {
        return areadict.count;
    }
    
    else if(tableView == self.tblarea)
    {
        return result.count;
    }
    
    return 0;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.tblcity)
    {
        NSArray *nib;
        
        cell = (AreaViewCell *)[self.tblcity dequeueReusableCellWithIdentifier:@"cell"];
        
        if (cell == nil)
        {
            nib = [[NSBundle mainBundle] loadNibNamed:@"AreaViewCell" owner:self options:nil];
        }
        
        cell = [nib objectAtIndex:0];
        
        NSMutableArray *arrtemp= [areadict objectAtIndex:indexPath.row];
        cell.lblarea.text = [arrtemp valueForKey:@"name"];
        
        if ([[[areadict objectAtIndex:indexPath.row] valueForKey:@"flag"] isEqualToString:@"true"])
        {
            cell.imgcheck.image = [UIImage imageNamed:@"greenCircle"];
        }
        
        else if([_fromDeliveryLocation isEqualToString:@"yes"])
        {
//            if ([[[areadict objectAtIndex:indexPath.row] valueForKey:@"name"] isEqualToString:[_temparray valueForKey:@"city"]])
//            {
//                category_id = [NSString stringWithFormat:@"%@",[[areadict objectAtIndex:indexPath.row]valueForKey:@"id"]];
//                cell.imgcheck.image = [UIImage imageNamed:@"greenCircle"];
//
//                area = [[areadict objectAtIndex:indexPath.row] valueForKey:@"area"];
//            }
//
//
            
            if ([_temparray valueForKey:@"city"])
            {
                if ([[[areadict objectAtIndex:indexPath.row] valueForKey:@"name"] isEqualToString:[_temparray valueForKey:@"city"]])
                {
                    category_id = [NSString stringWithFormat:@"%@",[[areadict objectAtIndex:indexPath.row]valueForKey:@"id"]];
                    cell.imgcheck.image = [UIImage imageNamed:@"greenCircle"];
                    
                    area = [[areadict objectAtIndex:indexPath.row] valueForKey:@"area"];
                }
            }
            
            else
            {
                if ([[[areadict objectAtIndex:indexPath.row] valueForKey:@"flag"] isEqualToString:@"true"])
                {
                    category_id = [NSString stringWithFormat:@"%@",[[areadict objectAtIndex:indexPath.row]valueForKey:@"id"]];
                    cell.imgcheck.image = [UIImage imageNamed:@"greenCircle"];
                    
                    area = [[areadict objectAtIndex:indexPath.row] valueForKey:@"area"];
                }
                
                else
                {
                    cell.imgcheck.image = [UIImage imageNamed:@"grayCircle"];
                }
            }
        }
        
        else if([_strfromcheckout isEqualToString:@"yes"])
        {
            if ([dictfromcheckout valueForKey:@"city"])
            {
                if ([[[areadict objectAtIndex:indexPath.row] valueForKey:@"name"] isEqualToString:[dictfromcheckout valueForKey:@"city"]])
                {
                    category_id = [NSString stringWithFormat:@"%@",[[areadict objectAtIndex:indexPath.row]valueForKey:@"id"]];
                    cell.imgcheck.image = [UIImage imageNamed:@"greenCircle"];
                    
                    area = [[areadict objectAtIndex:indexPath.row] valueForKey:@"area"];
                }
            }
            
            else
            {
                if ([[[areadict objectAtIndex:indexPath.row] valueForKey:@"flag"] isEqualToString:@"true"])
                {
                    category_id = [NSString stringWithFormat:@"%@",[[areadict objectAtIndex:indexPath.row]valueForKey:@"id"]];
                    cell.imgcheck.image = [UIImage imageNamed:@"greenCircle"];
                    
                    area = [[areadict objectAtIndex:indexPath.row] valueForKey:@"area"];
                }
                
                else
                {
                    cell.imgcheck.image = [UIImage imageNamed:@"grayCircle"];
                }
            }
        }
        
        else
        {
            cell.imgcheck.image = [UIImage imageNamed:@"grayCircle"];
        }
        
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    else if(tableView == self.tblarea)
    {
        NSArray *nib;
        cell1 = (AreaselectionViewCell *)[self.tblarea dequeueReusableCellWithIdentifier:@"cell1"];
        
        if (cell1 == nil)
        {
            nib = [[NSBundle mainBundle] loadNibNamed:@"AreaselectionViewCell" owner:self options:nil];
        }
        
        cell1 = [nib objectAtIndex:0];
        
        cell1.lblselectionarea.text = [NSString stringWithFormat:@"%@",[result objectAtIndex:indexPath.row]];
        
        cell1.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell1;
    }
    
    return 0;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.tblcity)
    {
//        _fromDeliveryLocation = @"";
//        strdlvr = @"yes";
//
//        _strfromcheckout = @"";
        dictfromcheckout =[[NSDictionary alloc]init];
        
        _temparray = [[NSDictionary alloc]init];
        
        category_id = [NSString stringWithFormat:@"%@",[[areadict objectAtIndex:indexPath.row]valueForKey:@"id"]];
        Strcity = [NSString stringWithFormat:@"%@",[[areadict objectAtIndex:indexPath.row]valueForKey:@"name"]];
        arrarea = [areadict objectAtIndex:indexPath.row];
        
        area = [arrarea valueForKey:@"area"];
        
        for (int i = 0; i<areadict.count; i++)
        {
            NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
            
            dictet =[[areadict objectAtIndex:i] mutableCopy];
            
            if (i == indexPath.row)
            {
                [dictet setObject:@"true" forKey:@"flag"];
            }
            
            else
            {
                [dictet setObject:@"false" forKey:@"flag"];
            }
            
            [areadict replaceObjectAtIndex:i withObject:dictet];
        }
        
        _tblarea.hidden = YES;
        self.txtarea.text =  @"";
        self.txtaddress1.text = @"";
        self.txtaddress2.text = @"";
        self.txtaddress3.text = @"";
        
        [_tblcity reloadData];
        [_tblarea reloadData];
    }
    
    else if(tableView == self.tblarea)
    {
        _tblarea.hidden = YES;
        strdidselectdata =  [result objectAtIndex:indexPath.row];
        self.txtarea.text = [result objectAtIndex:indexPath.row];
        [self.view endEditing:YES];
    }
}




- (IBAction)btnnickname:(id)sender
{
    if([strdlvr isEqualToString:@"yes"])
    {
        if ([[_temparray valueForKey:@"type"] isEqualToString:@"0"])
        {
            self.txttitle.userInteractionEnabled = NO;
        }
        
        else if([[_temparray valueForKey:@"type"] isEqualToString:@"1"])
        {
            self.txttitle.userInteractionEnabled = NO;
        }
        
        else if([[_temparray valueForKey:@"type"] isEqualToString:@"2"])
        {
            self.txttitle.userInteractionEnabled = YES;
            [_txttitle becomeFirstResponder];
        }
    }
    
    
    
    if ([_strfromcheckout isEqualToString:@"yes"])
    {
        if ([[dictfromcheckout valueForKey:@"type"] isEqualToString:@"0"])
        {
            self.txttitle.userInteractionEnabled = NO;
        }
        
        else if([[dictfromcheckout valueForKey:@"type"] isEqualToString:@"1"])
        {
            self.txttitle.userInteractionEnabled = NO;
        }
        
        else if([[dictfromcheckout valueForKey:@"type"] isEqualToString:@"2"])
        {
            self.txttitle.userInteractionEnabled = YES;
            [_txttitle becomeFirstResponder];
        }
    }
}





- (IBAction)btnaddr1:(id)sender
{
    if([strdlvr isEqualToString:@"yes"])
    {
        self.txttitle.userInteractionEnabled = NO;
        self.txtaddress1.userInteractionEnabled = YES;
        [_txtaddress1 becomeFirstResponder];
        self.txtaddress2.userInteractionEnabled = NO;
        self.txtaddress3.userInteractionEnabled = NO;
    }
    
    
    if ([_strfromcheckout isEqualToString:@"yes"])
    {
        self.txttitle.userInteractionEnabled = NO;
        self.txtaddress1.userInteractionEnabled = YES;
        [_txtaddress1 becomeFirstResponder];
        self.txtaddress2.userInteractionEnabled = NO;
        self.txtaddress3.userInteractionEnabled = NO;
    }
}





- (IBAction)btnaddr2:(id)sender
{
    if([strdlvr isEqualToString:@"yes"])
    {
        self.txttitle.userInteractionEnabled = NO;
        self.txtaddress1.userInteractionEnabled = NO;
        self.txtaddress2.userInteractionEnabled = YES;
        [_txtaddress2 becomeFirstResponder];
        self.txtaddress3.userInteractionEnabled = NO;
    }
    
    
    if ([_strfromcheckout isEqualToString:@"yes"])
    {
        self.txttitle.userInteractionEnabled = NO;
        self.txtaddress1.userInteractionEnabled = NO;
        self.txtaddress2.userInteractionEnabled = YES;
        [_txtaddress2 becomeFirstResponder];
        self.txtaddress3.userInteractionEnabled = NO;
    }
}





- (IBAction)btnaddr3:(id)sender
{
    if([strdlvr isEqualToString:@"yes"])
    {
        self.txttitle.userInteractionEnabled = NO;
        self.txtaddress1.userInteractionEnabled = NO;
        self.txtaddress2.userInteractionEnabled = NO;
        self.txtaddress3.userInteractionEnabled = YES;
        [_txtaddress3 becomeFirstResponder];
    }
    
    
    if ([_strfromcheckout isEqualToString:@"yes"])
    {
        self.txttitle.userInteractionEnabled = NO;
        self.txtaddress1.userInteractionEnabled = NO;
        self.txtaddress2.userInteractionEnabled = NO;
        self.txtaddress3.userInteractionEnabled = YES;
        [_txtaddress3 becomeFirstResponder];
    }
}




#pragma mark <--Web Services-->

-(void)wsAddAddress
{
    BaseViewController *base=[[BaseViewController alloc]init];
    NSUserDefaults  *defaults=[NSUserDefaults standardUserDefaults];
    NSString *user_id=[defaults valueForKey:@"user_id"];
    NSString *token = [defaults valueForKey:@"token"];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"request=%@&user_id=%@&type=%@&action=%@&title=%@&street=%@&sublocation=%@&instruction=%@&location=%@&key=%@&secret=%@&token=%@",@"addresses",user_id,_flag,@"insert",self.txttitle.text,self.txtaddress1.text,self.txtaddress2.text,self.txtaddress3.text,self.txtarea.text,str_key,str_secret,token];
    
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
                                    handler:^(UIAlertAction * action)
                                    {
                                        
                                    }];
        
        //Add your buttons to alert controller
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else
    {
        NSString *errorCode=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"code"]];
        NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
        
        dispatch_async(dispatch_get_main_queue(),^{
            [GiFHUD dismiss];
            if([errorCode isEqualToString:@"1"])
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:@"Address saved successfully."
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                //Add Buttons
                
                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                
                                                HomeViewController *obj=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
                                                self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                                                [self.navigationController pushViewController:obj animated:YES];
                                                
                                            }];
                
                //Add your buttons to alert controller
                
                [alert addAction:yesButton];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
            
            else if ([errorCode isEqualToString:@"0"])
            {
                NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:message
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
            
            else if ([errorCode isEqualToString:@"5"])
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:message
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
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:@"Something went wrong. Please try again later."
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
        });
    }
}





-(void)getparticularaddress
{
    BaseViewController *base=[[BaseViewController alloc]init];
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *user_id = [defaults valueForKey:@"user_id"];
    NSString *token = [defaults valueForKey:@"token"];
    
    NSString *parameter=[NSString stringWithFormat:@"request=%@&action=%@&addressid=%@&key=%@&secret=%@&user_id=%@&token=%@",@"addresses",@"viewspecificaddress",[[NSUserDefaults standardUserDefaults]valueForKey:@"address_id"],str_key,str_secret,user_id,token];
    
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
                                    handler:^(UIAlertAction * action)
                                    {
                                        
                                    }];
        
        //Add your buttons to alert controller
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    else
    {
        NSString *errorCode=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"code"]];
        NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            if([errorCode isEqualToString:@"1"])
            {
                strfromcheckout2 =@"yes";
                
                arraddress = [[NSMutableArray alloc]init];
                
                arraddress = [[dictionary valueForKey:@"data"] mutableCopy];
                
//                areadict = [[dictionary valueForKey:@"data"] mutableCopy];
                
                dictfromcheckout=[[NSDictionary alloc]init];
                
                dictfromcheckout =[arraddress objectAtIndex:0];
                
//                dictfromcheckout =[areadict objectAtIndex:0];
                
                self.txttitle.userInteractionEnabled = NO;
                self.txtaddress1.userInteractionEnabled = NO;
                self.txtaddress2.userInteractionEnabled = NO;
                self.txtaddress3.userInteractionEnabled = NO;
                
                self.txttitle.text=[NSString stringWithFormat:@"%@",[dictfromcheckout valueForKey:@"title"]];
                
                self.txtarea.text=[NSString stringWithFormat:@"%@",[dictfromcheckout valueForKey:@"location"]];
                self.txtaddress1.text= [NSString stringWithFormat:@"%@",[dictfromcheckout valueForKey:@"street"]];
                self.txtaddress2.text=[NSString stringWithFormat:@"%@",[dictfromcheckout valueForKey:@"sublocation"]];
                self.txtaddress3.text=[NSString stringWithFormat:@"%@",[dictfromcheckout valueForKey:@"landmark"]];
                
                update_id =[NSString stringWithFormat:@"%@",[dictfromcheckout valueForKey:@"id"]];
                updateflag=@"yes";
                
                [_tblcity reloadData];
            }
            
            else if ([errorCode isEqualToString:@"0"])
            {
                NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
                
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:message
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
            
            else if ([errorCode isEqualToString:@"5"])
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:message
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
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:@"Something went wrong. Please try again later."
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
        });
    }
}





-(void)wsGetArea
{
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"request=%@&action=%@&key=%@&secret=%@",@"allareas",@"view",str_key,str_secret];
    
    NSDictionary *dictionary =[[NSMutableDictionary alloc]init];
    
    dictionary=[base WebParsingMethod:stringWebServicesCompleteUrl :parameter];
//    [GiFHUD dismiss];
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
                                    handler:^(UIAlertAction * action)
                                    {
                                        
                                    }];
        
        //Add your buttons to alert controller
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else
    {
        NSString *errorCode=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"code"]];
        NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            if([errorCode isEqualToString:@"1"])
            {
                areadict = [[dictionary valueForKey:@"data"] mutableCopy];
                
                for (int i =0; i<areadict.count; i++)
                {
                    NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
                    
                    dictet =[[areadict objectAtIndex:i] mutableCopy];
                    
                    [dictet setObject:@"false" forKey:@"flag"];
                    
                    [areadict replaceObjectAtIndex:i withObject:dictet];
                }
                
                [_tblcity reloadData];
            }
            
            else if ([errorCode isEqualToString:@"0"])
            {
                NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:message
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
            
            else if ([errorCode isEqualToString:@"5"])
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:message
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
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:@"Something went wrong. Please try again later."
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
        });
    }
}





-(void)wsUpdateAddress
{
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url = %@",stringWebServicesCompleteUrl);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *user_id = [defaults valueForKey:@"user_id"];
    NSString *token = [defaults valueForKey:@"token"];
    
    NSString *parameter=[NSString stringWithFormat:@"request=%@&id=%@&action=%@&title=%@&street=%@&sublocation=%@&instruction=%@&location=%@&key=%@&secret=%@&user_id=%@&token=%@",@"addresses",update_id,@"update",self.txttitle.text,self.txtaddress1.text,self.txtaddress2.text,self.txtaddress3.text,self.txtarea.text,str_key,str_secret,user_id,token];
    
    NSDictionary *dictionary = [[NSMutableDictionary alloc]init];
    
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
                                    handler:^(UIAlertAction * action)
                                    {
                                        
                                    }];
        
        //Add your buttons to alert controller
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else
    {
        NSString *errorCode=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"code"]];
        NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            if([errorCode isEqualToString:@"1"])
            {
                NSArray *arradd = [[NSMutableArray alloc]init];
                
                arradd = [dictionary valueForKey:@"data"];
                
                NSDictionary *dictadd = [[NSDictionary alloc]init];
                
                dictadd = [arradd objectAtIndex:0];
                
                NSString *city = [NSString stringWithFormat:@"%@",[dictadd valueForKey:@"city"]];
                NSString *location = [NSString stringWithFormat:@"%@",[dictadd valueForKey:@"location"]];
                NSString *street = [NSString stringWithFormat:@"%@",[dictadd valueForKey:@"street"]];
                NSString *sublocation = [NSString stringWithFormat:@"%@",[dictadd valueForKey:@"sublocation"]];
                //self.txtaddress3.text = [NSString stringWithFormat:@"%@",[dictadd valueForKey:@"landmark"]];
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

//                NSString *street = [NSString stringWithFormat:@"%@",self.txtaddress1.text];
//                NSString *sublocation = [NSString stringWithFormat:@"%@",self.txtaddress2.text];
//                NSString *location = [NSString stringWithFormat:@"%@",self.txtarea.text];
//                NSString *city = [NSString stringWithFormat:@"%@",@""];
                
                NSString *address = @"";
                
                if ([street isEqualToString:@""])
                {
                    address =[NSString stringWithFormat:@"%@, %@, %@",sublocation,location,city];
                }
                
                else if ([sublocation isEqualToString:@""])
                {
                    address =[NSString stringWithFormat:@"%@, %@, %@",street,location,city];
                }
                
                else if ([location isEqualToString:@""])
                {
                    address =[NSString stringWithFormat:@"%@, %@, %@",street,sublocation,city];
                }
                
                else if ([city isEqualToString:@""])
                {
                    address =[NSString stringWithFormat:@"%@, %@, %@",street,sublocation,location];
                }
                
                else
                {
                    address =[NSString stringWithFormat:@"%@, %@, %@, %@",street,sublocation,location,city];
                }
                
                [defaults setValue:address forKey:@"primaryaddress"];
                
                
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:@"Your address is updated successfully."
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                //Add Buttons
                
                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                
                                                if ([strfromcheckout2 isEqualToString:@"yes"])
                                                {
                                                    _strfromcheckout = @"";
                                                    CheckoutViewController *obj=[[CheckoutViewController alloc]initWithNibName:@"CheckoutViewController" bundle:nil];
                                                    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                                                    [self.navigationController pushViewController:obj animated:YES];
                                                }
                                                
                                                else
                                                {
                                                    _fromDeliveryLocation =@"yes";
                                                    DeliverylocationController *obj=[[DeliverylocationController alloc]initWithNibName:@"DeliverylocationController" bundle:nil];
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
                NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:message
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
            
            else if ([errorCode isEqualToString:@"5"])
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:message
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
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:@"Something went wrong. Please try again later."
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
        });
    }
}



@end

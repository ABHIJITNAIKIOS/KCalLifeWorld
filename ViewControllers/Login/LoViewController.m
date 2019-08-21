//
//  LoViewController.m
//  KCal
//
//  Created by Apple on 22/02/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "LoViewController.h"
#import "ForgotPasswordViewController.h"
#import "BaseViewController.h"
#import "AppDelegate.h"
#import "GiFHUD.h"

@interface LoViewController () <UITextFieldDelegate>
{
    NSString *chekAccept;
    NSString *checkPassword;
}

@end

@implementation LoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    _txtEmail.autocorrectionType = UITextAutocorrectionTypeNo;
//    _txtPassword.autocorrectionType = UITextAutocorrectionTypeNo;
    
    self.navigationController.navigationBar.hidden=NO;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"handle_data" object:self];
    
    self.title =@"Sign In";
    chekAccept=@"no";
    checkPassword=@"no";
    self.navigationItem.hidesBackButton=YES;
    _btnsignup.layer.borderColor = [UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:30.0/255.0 alpha:1.0f].CGColor;
    _btnsignup.layer.borderWidth = 2.0f;
    
    [GiFHUD setGifWithImageName:@"Spinner3.gif"];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)viewDidAppear:(BOOL)animated
{
    for (UIButton *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 134)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 213)
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
        
        if (view.tag == 205)
        {
            [view removeFromSuperview];
        }
    }
}




-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _txtEmail)
    {
        self.lblemail.backgroundColor = [UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1.0f];
        self.lblpass.backgroundColor = [UIColor grayColor];
    }
    
    else if(textField == _txtPassword)
    {
        self.lblemail.backgroundColor = [UIColor grayColor];
        self.lblpass.backgroundColor = [UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1.0f];
    }
}




- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}




- (IBAction)btnSignUp:(id)sender
{
    RegisterViewController *obj=[[RegisterViewController alloc] initWithNibName:@"RegisterViewController" bundle:nil];
       self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.navigationController pushViewController:obj animated:YES];
}




- (IBAction)btnForgotPassword:(id)sender
{
    ForgotPasswordViewController *obj=[[ForgotPasswordViewController alloc] initWithNibName:@"ForgotPasswordViewController" bundle:nil];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.navigationController pushViewController:obj animated:YES];
}




- (IBAction)btnShowPassword:(id)sender
{
    if ([checkPassword isEqualToString:@"no"])
    {
        checkPassword=@"yes";
        
        _imgeye.image = [UIImage imageNamed:@"ic__blue_eye"];
        _txtPassword.secureTextEntry = false;
    }
    
    else if ([checkPassword isEqualToString:@"yes"])
    {
        checkPassword=@"no";
        
        _imgeye.image = [UIImage imageNamed:@"ic_eye"];
        _txtPassword.secureTextEntry = true;
    }
}





- (IBAction)btnSignIn:(id)sender
{
    [self.view endEditing:YES];
    
    NSString *emailString = self.txtEmail.text;
    NSString *emailReg = @"^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,4})$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailReg];
    
    if([self.txtEmail.text isEqualToString:@""])
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"Please enter your email address."
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
    
    else if([emailTest evaluateWithObject:emailString] != YES)
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"Please enter a valid email address format."
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
    
    else if([self.txtPassword.text isEqualToString:@""])
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"Please enter your password."
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
            [self WsLogin];
            //
        });
    }
}





#pragma mark <--Web Services-->

-(void)WsLogin
{
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"request=%@&action=%@&key=%@&secret=%@&email_address=%@&password=%@",@"client",@"login",str_key,str_secret,self.txtEmail.text,self.txtPassword.text];
    
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
        NSString *gettoken = [NSString stringWithFormat:@"%@",[dictionary valueForKey:@"token"]];
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            if([errorCode isEqualToString:@"1"])
            {
                NSArray *arrUser=[dictionary valueForKey:@"data"];
                
                NSString *user_id=[NSString stringWithFormat:@"%@",[arrUser valueForKey:@"clientID"]];
                
                NSString *first_name=[NSString stringWithFormat:@"%@",[arrUser valueForKey:@"first_name"]];
                
                NSString *user_email=[NSString stringWithFormat:@"%@",[arrUser valueForKey:@"email_address"]];
                
                NSString *user_contact=[NSString stringWithFormat:@"%@",[arrUser valueForKey:@"mobile"]];
                
                NSString *pic=[NSString stringWithFormat:@"%@",[arrUser valueForKey:@"profile_pic"]];
                
                NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                
                [defaults setObject:user_id forKey:@"user_id"];
                [defaults setObject:first_name forKey:@"first_name"];
                [defaults setObject:user_email forKey:@"user_email"];
                [defaults setObject:gettoken forKey:@"token"];
                [defaults setObject:user_contact forKey:@"user_contactnumber"];
                [defaults setObject:pic forKey:@"profile_pic"];
                [defaults setObject:@"login" forKey:@"status"];
                
                [defaults synchronize];
                
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"handle_data" object:self];
                
                HomeViewController *obj=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
                
                obj.flag = @"login";
                
                self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                
                [self.navigationController pushViewController:obj animated:YES];
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

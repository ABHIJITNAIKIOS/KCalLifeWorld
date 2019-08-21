//
//  RegisterViewController.m
//  KCal
//
//  Created by Apple on 22/02/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "RegisterViewController.h"
#import "BaseViewController.h"
#import "AppDelegate.h"
#import "LoViewController.h"
#define ACCEPTABLE_CHARACTERS @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "

@interface RegisterViewController ()
{
    NSString *chekAccept;
    NSString *checkPassword,*checkConfirmPassword;
    NSArray *arrcode;
}

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for (UIButton *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 134)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 215)
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
    
    self.navigationItem.hidesBackButton=YES;
    
    _txtprefix.layer.borderColor = [UIColor colorWithRed:198.0/255.0 green:197.0/255.0 blue:197.0/255.0 alpha:1.0f].CGColor;
    _txtprefix.layer.borderWidth = 1.0f;
    
    _btnsignin.layer.borderColor = [UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:30.0/255.0 alpha:1.0f].CGColor;
    _btnsignin.layer.borderWidth = 2.0f;
    
    _txtprefix.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Prefix" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:198.0/255.0 green:197.0/255.0 blue:197.0/255.0 alpha:1.0f], NSFontAttributeName : [UIFont fontWithName:@"AvenirNext-Italic" size:12.0]}];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissTableView)];
    
    [self.viewblur addGestureRecognizer:tap];
    
    self.viewblur.hidden = YES;
    self.tblprefix.hidden = YES;
    
    arrcode = @[@"050", @"051", @"052", @"053", @"054", @"055", @"056", @"057", @"058", @"059"];
    
    [GiFHUD setGifWithImageName:@"Spinner3.gif"];
    
    checkPassword=@"no";
    chekAccept=@"no";
    checkConfirmPassword=@"no";
    self.title=@"Sign Up";
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)dismissTableView
{
    self.viewblur.hidden = YES;
    self.tblprefix.hidden = YES;
}





-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == _txtNickName)
    {
        self.lblnick.backgroundColor = [UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1.0f];
        self.lblfull.backgroundColor = [UIColor grayColor];
        self.lblemail.backgroundColor = [UIColor grayColor];
        self.lblmbl.backgroundColor = [UIColor grayColor];
        self.lblpass.backgroundColor = [UIColor grayColor];
    }
    
    else if(textField == _txtFullName)
    {
        self.lblnick.backgroundColor = [UIColor grayColor];
        self.lblfull.backgroundColor = [UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1.0f];
        self.lblemail.backgroundColor = [UIColor grayColor];
        self.lblmbl.backgroundColor = [UIColor grayColor];
        self.lblpass.backgroundColor = [UIColor grayColor];
    }
    
    else if(textField == _txtEmail)
    {
        self.lblnick.backgroundColor = [UIColor grayColor];
        self.lblfull.backgroundColor = [UIColor grayColor];
        self.lblemail.backgroundColor = [UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1.0f];
        self.lblmbl.backgroundColor = [UIColor grayColor];
        self.lblpass.backgroundColor = [UIColor grayColor];
    }
    
    else if(textField == _txtMobile)
    {
        self.lblnick.backgroundColor = [UIColor grayColor];
        self.lblfull.backgroundColor = [UIColor grayColor];
        self.lblemail.backgroundColor = [UIColor grayColor];
        self.lblmbl.backgroundColor = [UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1.0f];
        self.lblpass.backgroundColor = [UIColor grayColor];
    }
    
    else if(textField == _txtPassword)
    {
        self.lblnick.backgroundColor = [UIColor grayColor];
        self.lblfull.backgroundColor = [UIColor grayColor];
        self.lblemail.backgroundColor = [UIColor grayColor];
        self.lblmbl.backgroundColor = [UIColor grayColor];
        self.lblpass.backgroundColor = [UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1.0f];
    }
}




- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _txtFullName)
    {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        return [string isEqualToString:filtered];
    }
    
    else if (textField == _txtMobile)
    {
        NSUInteger oldLength = [_txtMobile.text length];
        NSUInteger replacementLength = [string length];
        NSUInteger rangeLength = range.length;
        
        NSUInteger newLength = oldLength - rangeLength + replacementLength;
        
        BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
        
        return newLength <= mblnoLength||returnKey;
    }
    
    return YES;
}




- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}




#pragma  mark <--table view delegate-->


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrcode.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [_tblprefix dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell ==nil)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSString *strid =[NSString stringWithFormat:@"%@",[arrcode objectAtIndex:indexPath.row]];
    cell.textLabel.text = strid;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.font=[UIFont fontWithName:@"AvenirNext-Regular" size:10];
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    cell.textLabel.numberOfLines = 0;
    
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _txtprefix.text = [NSString stringWithFormat:@"%@",[arrcode objectAtIndex:indexPath.row]];
    
    self.viewblur.hidden = YES;
    self.tblprefix.hidden = YES;
}






- (IBAction)btnprefix:(id)sender
{
    self.viewblur.hidden = NO;
    self.tblprefix.hidden = NO;
    
    [_tblprefix reloadData];
}




- (IBAction)btnSignUp:(id)sender
{
    [self.view endEditing:YES];
    
    NSString *emailString = self.txtEmail.text;

    NSString *emailReg = @"^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,4})$";

    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailReg];
    
    
    if([self.txtFullName.text isEqualToString:@""])
    {
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:nil message:@"Please enter your full name." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Ok"
                                    
                                                            style:UIAlertActionStyleDefault
                                    
                                                          handler:^(UIAlertAction * action)
                                    
                                    {
                                        
                                        
                                        
                                    }];
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else if([self.txtEmail.text isEqualToString:@""])
    {
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:nil message:@"Please enter your email address." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Ok"
                                    
                                                            style:UIAlertActionStyleDefault
                                    
                                                          handler:^(UIAlertAction * action)
                                    
                                    {
                                        
                                        
                                        
                                    }];
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else if([emailTest evaluateWithObject:emailString] != YES)
    {
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:nil message:@"Please enter a valid email address."preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Ok"

                                                            style:UIAlertActionStyleDefault

                                                          handler:^(UIAlertAction * action)

                                    {



                                    }];

        [alert addAction:yesButton];

        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else if([self.txtprefix.text isEqualToString:@""])
    {
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:nil message:@"Please select the prefix."
                                   
                                                               preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Ok"
                                    
                                                            style:UIAlertActionStyleDefault
                                    
                                                          handler:^(UIAlertAction * action)
                                    
                                    {
                                        
                                        
                                        
                                    }];
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else if([self.txtMobile.text isEqualToString:@""])
    {
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:nil message:@"Please enter your mobile number."
                                   
                                                               preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Ok"
                                    
                                                            style:UIAlertActionStyleDefault
                                    
                                                          handler:^(UIAlertAction * action)
                                    
                                    {
                                        
                                        
                                        
                                    }];
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else if(([self.txtMobile.text length]) < 7)
    {
        UIAlertController * alert=   [UIAlertController

                                      alertControllerWithTitle:nil

                                      message:@"Please enter a valid mobile number."

                                      preferredStyle:UIAlertControllerStyleAlert];

        UIAlertAction* cancel = [UIAlertAction

                                 actionWithTitle:@"OK"

                                 style:UIAlertActionStyleDefault

                                 handler:^(UIAlertAction * action)

                                 {

                                     [alert dismissViewControllerAnimated:YES completion:nil];



                                 }];

        [alert addAction:cancel];

        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else if([self.txtPassword.text isEqualToString:@""])
    {
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:nil message:@"Please enter your password."
                                   
                                                               preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Ok"
                                    
                                                            style:UIAlertActionStyleDefault
                                    
                                                          handler:^(UIAlertAction * action)
                                    
                                    {
                                        
                                        
                                        
                                    }];
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else if(self.txtPassword.text.length < 6)
    {
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:nil message:@"Password should have atleast 6 characters." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Ok"
                                    
                                                            style:UIAlertActionStyleDefault
                                    
                                                          handler:^(UIAlertAction * action)
                                    
                                    {
                                        
                                        
                                        
                                    }];
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else
    {
        [GiFHUD showWithOverlay];
        //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self Wsregister];
            //
        });
    }
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




- (IBAction)btnsignin:(id)sender
{
    LoViewController *obj=[[LoViewController alloc]initWithNibName:@"LoViewController" bundle:nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.navigationController pushViewController:obj animated:YES];
}





#pragma mark <--Web Services-->


-(void)Wsregister
{
    NSString *strmbl = [NSString stringWithFormat:@"%@%@", self.txtprefix.text,self.txtMobile.text];

    BaseViewController *base=[[BaseViewController alloc]init];

    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);

    NSString *parameter=[NSString stringWithFormat:@"key=%@&secret=%@&first_name=%@&email_address=%@&mobile=%@&password=%@&request=%@&action=%@",str_key,str_secret,self.txtFullName.text,self.txtEmail.text,strmbl,self.txtPassword.text,@"client",@"new"];
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
                NSDictionary *arrUser=[dictionary valueForKey:@"data"];

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

                //[[NSNotificationCenter defaultCenter] postNotificationName:@"handle_data" object:self];

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




//-(void)Wsregister
//{
//    NSString *strmbl = [NSString stringWithFormat:@"%@%@", self.txtprefix.text,self.txtMobile.text];
//
//    BaseViewController *base=[[BaseViewController alloc]init];
//
//    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
//    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
//
//    NSString *parameter=[NSString stringWithFormat:@"key=%@&secret=%@&first_name=%@&email_address=%@&mobile=%@&password=%@&request=%@&action=%@",str_key,str_secret,self.txtFullName.text,self.txtEmail.text,strmbl,self.txtPassword.text,@"client",@"new"];
//
//    NSDictionary *dictionary = [[NSMutableDictionary alloc]init];
//
//    dictionary=[base WebParsingMethod:stringWebServicesCompleteUrl :parameter];
//
//    if(dictionary == (id)[NSNull null] || dictionary == nil)
//    {
//        UIAlertController * alert = [UIAlertController
//                                     alertControllerWithTitle:nil
//                                     message:@"Oops, cannot connect to server."
//                                     preferredStyle:UIAlertControllerStyleAlert];
//
//        //Add Buttons
//
//        UIAlertAction* yesButton = [UIAlertAction
//                                    actionWithTitle:@"OK"
//                                    style:UIAlertActionStyleDefault
//                                    handler:^(UIAlertAction *action) {
//
//
//                                    }];
//
//
//        //Add your buttons to alert controller
//
//        [alert addAction:yesButton];
//
//        [self presentViewController:alert animated:YES completion:nil];
//    }
//
//    else
//    {
//        NSString *errorCode=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"code"]];
//        NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
//
//        dispatch_async(dispatch_get_main_queue(),^{
//            [GiFHUD dismiss];
//            if([errorCode isEqualToString:@"1"])
//            {
//                UIAlertController * alert = [UIAlertController
//                                             alertControllerWithTitle:nil
//                                             message:@"You have been successfully registered. You can now login."
//                                             preferredStyle:UIAlertControllerStyleAlert];
//
//                //Add Buttons
//
//                UIAlertAction* yesButton = [UIAlertAction
//                                            actionWithTitle:@"OK"
//                                            style:UIAlertActionStyleDefault
//                                            handler:^(UIAlertAction * action) {
//
//                                                LoViewController *obj=[[LoViewController alloc]initWithNibName:@"LoViewController" bundle:nil];
//                                                self.navigationController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationController.navigationItem.backBarButtonItem.style target:nil action:nil];
//                                                [self.navigationController pushViewController:obj animated:YES];
//
//                                            }];
//
//
//                //Add your buttons to alert controller
//
//                [alert addAction:yesButton];
//
//                [self presentViewController:alert animated:YES completion:nil];
//            }
//
//            else if ([errorCode isEqualToString:@"0"])
//            {
//                UIAlertController * alert = [UIAlertController
//                                             alertControllerWithTitle:nil
//                                             message:message
//                                             preferredStyle:UIAlertControllerStyleAlert];
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
//            }
//
//            else if ([errorCode isEqualToString:@"5"])
//            {
//                UIAlertController * alert = [UIAlertController
//                                             alertControllerWithTitle:nil
//                                             message:message
//                                             preferredStyle:UIAlertControllerStyleAlert];
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
//            }
//
//            else
//            {
//                UIAlertController * alert = [UIAlertController
//                                             alertControllerWithTitle:nil
//                                             message:@"Something went wrong. Please try again later."
//                                             preferredStyle:UIAlertControllerStyleAlert];
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
//            }
//        });
//    }
//}



@end

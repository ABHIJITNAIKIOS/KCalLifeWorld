//
//  ContactusViewController.m
//  KCal
//
//  Created by Apple on 09/03/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "ContactusViewController.h"
#import "BaseViewController.h"
#import "AppDelegate.h"
#import "GiFHUD.h"
#define ACCEPTABLE_CHARACTERS @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "

@interface ContactusViewController ()
{
    UITextField *myTextField;
}

@end

@implementation ContactusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Get in touch";
    
//    _txtviewMessage.layer.borderWidth = 1.0f;
//
//    _txtviewMessage.layer.borderColor = [[UIColor grayColor] CGColor];
    
    [GiFHUD setGifWithImageName:@"Spinner3.gif"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"handle_data" object:self];
}




- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}




-(void)viewDidAppear:(BOOL)animated
{
    for (UIImageView *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 111)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 120)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 134)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 222)
        {
            [view removeFromSuperview];
        }
    }
}




-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField == _txtName)
    {
        _lblNmae.backgroundColor = [UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1.0f];
        self.lblemail.backgroundColor = [UIColor grayColor];
        self.lblMobile.backgroundColor = [UIColor grayColor];
        self.lblmsg.backgroundColor = [UIColor grayColor];
        _txtviewMessage.layer.borderColor =  [[UIColor grayColor]CGColor];
    }
    
    else if (textField == _txtEmail)
    {
        self.lblemail.backgroundColor = [UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1.0f];
        self.lblNmae.backgroundColor = [UIColor grayColor];
        self.lblMobile.backgroundColor = [UIColor grayColor];
        self.lblmsg.backgroundColor = [UIColor grayColor];
        _txtviewMessage.layer.borderColor = [[UIColor grayColor]CGColor];
    }
    
    else if (textField == _txtMobileNumber)
    {
        _lblMobile.backgroundColor = [UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1.0f];
        self.lblemail.backgroundColor = [UIColor grayColor];
        _lblNmae.backgroundColor = [UIColor grayColor];
        self.lblmsg.backgroundColor = [UIColor grayColor];
        _txtviewMessage.layer.borderColor = [[UIColor grayColor]CGColor];
    }
    
    else
    {
        self.lblmsg.backgroundColor = [UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1.0f];
        self.lblNmae.backgroundColor = [UIColor grayColor];
        self.lblemail.backgroundColor = [UIColor grayColor];
        self.lblMobile.backgroundColor = [UIColor grayColor];
        _txtviewMessage.layer.borderColor = [[UIColor grayColor]CGColor];
    }
}





//- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
//{
//    self.txtviewMessage.text = @"";
//    _txtviewMessage.layer.borderColor = [[UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1.0f] CGColor];
//    _lblMobile.backgroundColor = [UIColor grayColor];
//    self.lblemail.backgroundColor = [UIColor grayColor];
//    _lblNmae.backgroundColor = [UIColor grayColor];
//    self.txtviewMessage.textColor = [UIColor blackColor];
//
//    return YES;
//}




//-(void)textViewDidChange:(UITextView *)textView
//{
//    if(self.txtviewMessage.text.length == 0)
//    {
//        self.txtviewMessage.textColor = [UIColor lightGrayColor];
//        self.txtviewMessage.text = @"Your message";
//        [self.txtviewMessage resignFirstResponder];
//    }
//}




//-(BOOL)textViewShouldEndEditing:(UITextView *)textView
//{
//    if(self.txtviewMessage.text.length == 0)
//    {
//        self.txtviewMessage.textColor = [UIColor lightGrayColor];
//        self.txtviewMessage.text = @"Your message";
//        _txtviewMessage.layer.borderColor = [[UIColor grayColor]CGColor];
//        [self.txtviewMessage resignFirstResponder];
//    }
//
//    return YES;
//}




-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    _lblNmae.backgroundColor = [UIColor grayColor];
    self.lblemail.backgroundColor = [UIColor grayColor];
    _lblMobile.backgroundColor = [UIColor grayColor];
    self.lblmsg.backgroundColor = [UIColor grayColor];
    
    return YES;
}




- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == _txtName)
    {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        return [string isEqualToString:filtered];
    }
    
    else if (textField == _txtMobileNumber)
    {
        NSUInteger oldLength = [_txtMobileNumber.text length];
        NSUInteger replacementLength = [string length];
        NSUInteger rangeLength = range.length;
        
        NSUInteger newLength = oldLength - rangeLength + replacementLength;
        
        BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
        
        return newLength <= mblLength||returnKey;
    }
    
    return YES;
}





- (IBAction)btnMessage:(id)sender
{
//    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"New List Item", @"new_list_dialog")
//                                                          message:@"this gets covered" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
//    myTextField = [[UITextField alloc] initWithFrame:CGRectMake(12.0, 45.0, 260.0, 25.0)];
//    [myTextField setBackgroundColor:[UIColor whiteColor]];
//    [myAlertView addSubview:myTextField];
//    [myAlertView show];
    
    
    UIAlertController * alertController = [UIAlertController alertControllerWithTitle: @"Login"
                                                                              message: @"Input username and password."
                                                                       preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"name";
        textField.textColor = [UIColor blueColor];
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        textField.borderStyle = UITextBorderStyleRoundedRect;
    }];
 
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSArray * textfields = alertController.textFields;
        UITextField * namefield = textfields[0];
     
        NSLog(@"%@",namefield.text);
        
    }]];
    
    [self presentViewController:alertController animated:YES completion:nil];
}





- (IBAction)btnCallNow:(id)sender
{
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:@"tel://600595955"];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Opened url");
        }
    }];
}




- (IBAction)btnSubmit:(id)sender
{
    NSString *emailString = self.txtEmail.text;

    NSString *emailReg = @"^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,4})$";

    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailReg];
    
    
    if([self.txtName.text isEqualToString:@""])
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"Please enter your name."
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
    
    else  if([self.txtEmail.text isEqualToString:@""])
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"Please enter the email address."
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
                                     message:@"Please enter valid email address format."
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
    
    else  if([self.txtMobileNumber.text isEqualToString:@""])
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
    
    else if(([self.txtMobileNumber.text length]) < 10)
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"Please enter valid mobile number."
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
    
    else  if([self.txtmessage.text isEqualToString:@""])
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"Please enter the message."
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
  
//    else  if([self.txtviewMessage.text isEqualToString:@"Your Message"]||[self.txtviewMessage.text isEqualToString:@""])
//    {
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Please enter message" delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//
//        [alert show];
//    }
    
    else
    {
        [GiFHUD showWithOverlay];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self wsContactus];
        });
    }
}




- (IBAction)btnBack:(id)sender
{
    
}




#pragma mark <--Web Services-->

-(void)wsContactus
{
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"key=%@&secret=%@&name=%@&email=%@&phone=%@&subject=%@&message=%@&request=%@",str_key,str_secret,self.txtName.text,_txtEmail.text,_txtMobileNumber.text,@"",self.txtviewMessage.text,@"message"];
    
    NSDictionary *dictionary =[[NSMutableDictionary alloc]init];
    
    dictionary=[base WebParsingMethod:stringWebServicesCompleteUrl :parameter];
    
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
            [GiFHUD dismiss];
            
            if([errorCode isEqualToString:@"1"])
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:@"Your request has been sent successfully."
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                //Add Buttons
                
                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                
                                                self.txtName.text = @"";
                                                _txtEmail.text = @"";
                                                _txtMobileNumber.text = @"";
                                                self.txtviewMessage.text = @"";
                                                self.txtmessage.text = @"";
                                            }];
                
                
                //Add your buttons to alert controller
                
                [alert addAction:yesButton];
                
                [self presentViewController:alert animated:YES completion:nil];
                
                
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message: @"Your request has been sent successfully" delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil, nil];
//
//                [alert show];
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

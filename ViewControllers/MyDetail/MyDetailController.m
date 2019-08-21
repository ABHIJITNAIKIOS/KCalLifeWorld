//
//  MyAccountController.m
//  KCal
//
//  Created by Pipl-10 on 01/03/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "MyDetailController.h"
#import "SlideNavigationController.h"
#import "MyDetailController.h"
#import "BaseViewController.h"
#import "AppDelegate.h"
#import "MyAccountViewController.h"
#import "ChangeProfileViewController.h"
#import "AreaselectionViewCell.h"
#import "GiFHUD.h"

@interface MyDetailController ()
{
    AreaselectionViewCell *cell1;
    UIButton *btnCustom2;
    NSMutableArray *arrProducts;
    NSString *customer_name;
    NSString *strcustomer_id;
    NSString *custId12;
    DropDownListView *Dropobj;
    NSMutableArray *abcd;
    NSMutableArray *xyz;
    NSArray *arrcode;
    NSArray *arrIndustry;
    NSMutableArray *result, *industryarray;
    NSString *strDOB;
    NSString *strindstry;
}

@end

@implementation MyDetailController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"My Details";
    strDOB = @"";
    self.navigationItem.hidesBackButton = YES;
    
    strindstry=@"";
    
    _imgprofile.layer.masksToBounds = YES;
    _imgprofile.layer.cornerRadius = _imgprofile.frame.size.width/2;
    
    _tblarea.layer.borderWidth=1.0f;
    _tblarea.layer.borderColor=[UIColor grayColor].CGColor;
    
    _txtprefix.layer.borderColor = [UIColor colorWithRed:198.0/255.0 green:197.0/255.0 blue:197.0/255.0 alpha:1.0f].CGColor;
    _txtprefix.layer.borderWidth = 1.0f;
    
    _txtprefix.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Prefix" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:198.0/255.0 green:197.0/255.0 blue:197.0/255.0 alpha:1.0f], NSFontAttributeName : [UIFont fontWithName:@"AvenirNext-Italic" size:12.0]}];
    
    self.tblprefix.hidden = YES;
    self.tblarea.hidden = YES;
    
    arrcode = @[@"050", @"051", @"052", @"053", @"054", @"055", @"056", @"057", @"058", @"059"];
    
    //date picker
    self.DatePicker.datePickerMode = UIDatePickerModeDate;
    [self.DatePicker setTintColor:[UIColor whiteColor]];
    [self.view addSubview:self.ViewDatePicker];
    self.ViewDatePicker.hidden = YES;
    
    [GiFHUD setGifWithImageName:@"Spinner3.gif"];
    
//    HUD = [[MBProgressHUD alloc] initWithView:self.view];
//    HUD.delegate = self;
//    HUD.labelText = NSLocalizedString(@"Loading..",nil);
//    HUD.dimBackground = YES;
//    [[UIApplication sharedApplication].keyWindow addSubview:HUD];
    
    self.lblBlur.hidden=YES;
    self.lblBlur.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissTableView1)];
    [self.lblBlur addGestureRecognizer:tap1];
}


-(void)dismissTableView1
{
    self.lblBlur.hidden=YES;
    self.tblprefix.hidden = YES;
    [Dropobj fadeOut];
    [self.view endEditing:YES];
}




-(void)save
{
    NSString *emailString = self.txtEmail.text;
    NSString *emailReg = @"^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,4})$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailReg];
    
    
    if([_txtFullName.text isEqualToString:@""])
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
    
    else if([_txtEmail.text isEqualToString:@""])
    {
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:nil message:@"Please enter your email." preferredStyle:UIAlertControllerStyleAlert];
        
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
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:nil message:@"Please enter valid email address format." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Ok"
                                    
                                                            style:UIAlertActionStyleDefault
                                    
                                                          handler:^(UIAlertAction * action)
                                    
                                    {
                                        
                                        
                                        
                                    }];
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else if([_txtmobilenum.text isEqualToString:@""])
    {
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:nil message:@"Please enter your mobile number." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Ok"
                                    
                                                            style:UIAlertActionStyleDefault
                                    
                                                          handler:^(UIAlertAction * action)
                                    
                                    {
                                        
                                        
                                        
                                    }];
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
     }
    
     else if([_txtDob.text isEqualToString:@""])
     {
         UIAlertController * alert=[UIAlertController alertControllerWithTitle:nil message:@"Please enter your date of birth." preferredStyle:UIAlertControllerStyleAlert];
         
         UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Ok"
                                     
                                                             style:UIAlertActionStyleDefault
                                     
                                                           handler:^(UIAlertAction * action)
                                     
                                     {
                                         
                                         
                                         
                                     }];
         
         [alert addAction:yesButton];
         
         [self presentViewController:alert animated:YES completion:nil];
     }
    
     else if([_txtnationality.text isEqualToString:@""])
     {
         UIAlertController * alert=[UIAlertController alertControllerWithTitle:nil message:@"Please enter your nationality." preferredStyle:UIAlertControllerStyleAlert];
         
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
         _txtFullName.userInteractionEnabled=NO;
         _txtEmail.userInteractionEnabled=NO;
         _txtmobilenum.userInteractionEnabled=NO;
         _txtDob.userInteractionEnabled=NO;
         _txtnationality.userInteractionEnabled=NO;
        
         [btnCustom2 setTitle:@"Edit" forState:UIControlStateNormal];
         [self wsUpdate];
     }
}



-(void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
//    NSString *strimg = [NSString stringWithFormat:@"%@%@",str_global_domain_pic,[defaults valueForKey:@"profile_pic"]];
    
    NSString *strimg = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"profile_pic"]];
    
    NSURL *url = [NSURL URLWithString:strimg];
    
    [_imgprofile setImageWithURL:url placeholderImage:[UIImage imageNamed:@"ic_user"]];
    
    [GiFHUD showWithOverlay];
    //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //[self wsGetPic];
        [self wsGetAccount];
        [self wosCountryName];
        [self wsGetIndustry];
    });
    
    
    UIButton *leftbtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn1.frame = CGRectMake(12, 15, 18, 18);
    [leftbtn1 setBackgroundImage:[UIImage imageNamed:@"white_left"] forState:UIControlStateNormal];
    leftbtn1.tag=219;
    
    [leftbtn1 addTarget:self action:@selector(back)
      forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:leftbtn1];
    
    
    for (UIImageView *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 111)
        {
            [view removeFromSuperview];
        }
    }
    
    for (UIButton *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 134)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 222)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 302)
        {
            [view removeFromSuperview];
        }
    }
}




-(void)viewWillAppear:(BOOL)animated
{
    _txtFullName.userInteractionEnabled=NO;
    _txtEmail.userInteractionEnabled=NO;
    _txtprefix.userInteractionEnabled=NO;
    _btnprefix.userInteractionEnabled=NO;
    _txtmobilenum.userInteractionEnabled=NO;
    _btnDOB.userInteractionEnabled=NO;
    _txtDob.userInteractionEnabled=NO;
    _txtnationality.userInteractionEnabled=NO;
    _txtindustry.userInteractionEnabled=NO;
    _btnindustry.userInteractionEnabled=NO;
}



-(void)back
{
    MyAccountViewController *obj=[[MyAccountViewController alloc]initWithNibName:@"MyAccountViewController" bundle:nil];
    [self.navigationController pushViewController:obj animated:YES];
}




- (void)didReceiveMemoryWarning
{
   [super didReceiveMemoryWarning];
}




- (BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    if (textField == _txtnationality)
    {
        NSString  *substring = [NSString stringWithString:_txtnationality.text];
        substring = [substring
                     stringByReplacingCharactersInRange:range withString:string];
        
        [self searchAutocompleteEntriesWithSubstring:substring];
    }
    
    else if (textField == _txtmobilenum)
    {
        NSUInteger oldLength = [_txtmobilenum.text length];
        NSUInteger replacementLength = [string length];
        NSUInteger rangeLength = range.length;
        
        NSUInteger newLength = oldLength - rangeLength + replacementLength;
        
        BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
        
        return newLength <= mblnoLength||returnKey;
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
        
        NSArray *searchResults = [abcd filteredArrayUsingPredicate:resultPredicate];
        
        if (searchResults.count)
        {
            self.tblarea.hidden=NO;
            
            for (int i=0; i<abcd.count; i++)
            {
                for (int i1 = 0; i1<[searchResults count];  i1++)
                {
                    if ([[searchResults objectAtIndex:i1] isEqualToString:[abcd objectAtIndex:i]])
                    {
                        [result addObject:[abcd objectAtIndex:i]];
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




-(IBAction)btnDonedate:(id)sender
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yy-MM-dd"];
    
    strDOB = [NSString stringWithFormat:@"%@ ",[dateFormatter stringFromDate:self.DatePicker.date]];
    
    [dateFormatter setDateFormat:@"dd/MM/yy"];
    
    self.txtDob.text=[NSString stringWithFormat:@"%@ ",[dateFormatter stringFromDate:self.DatePicker.date]];
    
    self.ViewDatePicker.hidden=YES;
}


- (IBAction)btnCanceldate:(id)sender
{
    self.ViewDatePicker.hidden=YES;
}



- (IBAction)btnStartDate:(id)sender
{
//    
//   // Flagdate=@"StartDate";
//   
//    
//    [self.view endEditing:YES];
//    self.ViewDatePicker.hidden=NO;
//      self.ViewDatePicker.frame=CGRectMake(self.ViewDatePicker.frame.origin.x, self.txtDob.frame.origin.y+40, self.ViewDatePicker.frame.size.width, self.ViewDatePicker.frame.size.height);
//    self.ViewDatePicker.layer.borderWidth=2.5f;
//    self.ViewDatePicker.layer.borderColor=[UIColor darkGrayColor].CGColor;
//    //self.DatePicker.minimumDate=[NSDate date];
}



- (IBAction)btnprefix:(id)sender
{
    //self.viewblur.hidden = NO;
    _lblBlur.hidden = NO;
    self.tblprefix.hidden = NO;
    [_txtmobilenum resignFirstResponder];
    
    [_tblprefix reloadData];
}




- (IBAction)btnDOB:(id)sender
{
    // Flagdate=@"StartDate";
    
    [self.view endEditing:YES];
    self.ViewDatePicker.hidden=NO;
    self.ViewDatePicker.frame=CGRectMake(self.ViewDatePicker.frame.origin.x, self.txtDob.frame.origin.y-220, self.ViewDatePicker.frame.size.width, self.ViewDatePicker.frame.size.height);
    self.ViewDatePicker.layer.borderWidth=1.0f;
    self.ViewDatePicker.layer.borderColor=[UIColor lightGrayColor].CGColor;
    
    [_DatePicker setMaximumDate:[NSDate date]];
}




- (IBAction)btnindustry:(id)sender
{
    [self.view endEditing:YES];
    _lblBlur.hidden=NO;
    
    NSMutableArray *abcd =[[NSMutableArray alloc]init];
    
    for (int i= 0; i<arrIndustry.count; i++)
    {
        [abcd addObject:[NSString stringWithFormat:@"%@",[[arrIndustry objectAtIndex:i] valueForKey:@"industry"]]];
    }
    
    [self showPopUpWithTitle:@"Select Industry" withOption:abcd xy:CGPointMake(self.view.frame.origin.x+12,self.view.frame.origin.y+80) size:CGSizeMake(self.view.frame.size.width-25,self.view.frame.size.height-258) isMultiple:NO];
}





- (IBAction)btnProfilePic:(id)sender
{
    ChangeProfileViewController *obj = [[ChangeProfileViewController alloc]initWithNibName:@"ChangeProfileViewController" bundle:nil];
    [self.navigationController pushViewController:obj animated:YES];
}




#pragma mark <---DropDownList--->


-(void)showPopUpWithTitle:(NSString*)popupTitle withOption:(NSArray*)arrOptions xy:(CGPoint)point size:(CGSize)size isMultiple:(BOOL)isMultiple
{
    Dropobj = [[DropDownListView alloc] initWithTitle:popupTitle options:arrOptions xy:point size:size isMultiple:isMultiple];
    Dropobj.delegate = self;
    [Dropobj showInView:self.view animated:YES];
    Dropobj.layer.borderColor = [UIColor lightGrayColor].CGColor;
    Dropobj.layer.borderWidth = 1.0;
    
    /*----------------Set DropDown backGroundColor-----------------*/
    [Dropobj SetBackGroundDropDown_R:119.0 G:189.0 B:29.0 alpha:1.0];
}




- (void)DropDownListView:(DropDownListView *)dropdownListView didSelectedIndex:(NSInteger)anIndex
{
    _lblBlur.hidden=YES;
    
    self.txtindustry.text=[NSString stringWithFormat:@"%@",[[arrIndustry objectAtIndex:anIndex]valueForKey:@"industry"]];
    
    
//    _lblBlur.hidden=YES;
//
//    self.txtnationality.text= [abcd objectAtIndex:anIndex];
//
//    custId12=[xyz objectAtIndex:anIndex];
//    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"customerid == %@", custId12];
}




//- (IBAction)btnNationality:(id)sender
//{
//    [self wosCountryName];
//    _lblBlur.hidden=NO;
//    [Dropobj fadeOut];
//
//    abcd =[[NSMutableArray alloc]init];
//    xyz =[[NSMutableArray alloc]init];
//
//    for (int i= 0; i<arrProducts.count; i++)
//    {
//        [abcd addObject:[NSString stringWithFormat:@"%@",[[arrProducts objectAtIndex:i] valueForKey:@"name"]]];
//        [xyz addObject:[NSString stringWithFormat:@"%@",[[arrProducts objectAtIndex:i] valueForKey:@"id"]]];
//    }
//
//    [self showPopUpWithTitle:@"Select Country Name" withOption:abcd xy:CGPointMake(10, 100) size:CGSizeMake(300,400) isMultiple:NO];
//}





- (IBAction)btneditfullname:(id)sender
{
    _txtFullName.userInteractionEnabled = YES;
    [_txtFullName becomeFirstResponder];
    _txtEmail.userInteractionEnabled = NO;
    _txtprefix.userInteractionEnabled=NO;
    _btnprefix.userInteractionEnabled = NO;
    _txtmobilenum.userInteractionEnabled = NO;
    _txtDob.userInteractionEnabled = NO;
    _btnDOB.userInteractionEnabled = NO;
    _txtnationality.userInteractionEnabled=NO;
    _txtindustry.userInteractionEnabled=NO;
    _btnindustry.userInteractionEnabled=NO;
}




- (IBAction)btneditemail:(id)sender
{
    _txtEmail.userInteractionEnabled = YES;
    [_txtEmail becomeFirstResponder];
    _txtFullName.userInteractionEnabled = NO;
    _txtprefix.userInteractionEnabled=NO;
    _btnprefix.userInteractionEnabled = NO;
    _txtmobilenum.userInteractionEnabled = NO;
    _btnDOB.userInteractionEnabled = NO;
    _txtDob.userInteractionEnabled = NO;
    _txtnationality.userInteractionEnabled=NO;
    _txtindustry.userInteractionEnabled=NO;
    _btnindustry.userInteractionEnabled=NO;
}




- (IBAction)btneditmobile:(id)sender
{
    _txtprefix.userInteractionEnabled = YES;
    _btnprefix.userInteractionEnabled = YES;
    _txtmobilenum.userInteractionEnabled = YES;
    [_txtmobilenum becomeFirstResponder];
    _txtFullName.userInteractionEnabled = NO;
    _txtEmail.userInteractionEnabled = NO;
    _btnDOB.userInteractionEnabled = NO;
    _txtDob.userInteractionEnabled = NO;
    _txtnationality.userInteractionEnabled=NO;
    _txtindustry.userInteractionEnabled=NO;
    _btnindustry.userInteractionEnabled=NO;
}





- (IBAction)btneditDOB:(id)sender
{
    _btnDOB.userInteractionEnabled = YES;
    _txtDob.userInteractionEnabled = YES;
    _txtFullName.userInteractionEnabled = NO;
    _txtEmail.userInteractionEnabled = NO;
    _txtprefix.userInteractionEnabled = NO;
    _btnprefix.userInteractionEnabled = NO;
    _txtmobilenum.userInteractionEnabled = NO;
    _txtnationality.userInteractionEnabled=NO;
    _txtindustry.userInteractionEnabled=NO;
    _btnindustry.userInteractionEnabled=NO;
}

- (IBAction)btneditnationality:(id)sender
{
    _txtnationality.userInteractionEnabled=YES;
    [_txtnationality becomeFirstResponder];
    _btnDOB.userInteractionEnabled = NO;
    _txtDob.userInteractionEnabled = NO;
    _txtFullName.userInteractionEnabled = NO;
    _txtEmail.userInteractionEnabled = NO;
    _txtprefix.userInteractionEnabled = NO;
    _btnprefix.userInteractionEnabled = NO;
    _txtmobilenum.userInteractionEnabled = NO;
    _txtindustry.userInteractionEnabled=NO;
    _btnindustry.userInteractionEnabled=NO;
    strindstry =@"no";
    _tblarea.frame = CGRectMake(_tblarea.frame.origin.x, _txtnationality.frame.origin.y - _tblarea.frame.size.height-5, _tblarea.frame.size.width, _tblarea.frame.size.height);
}

- (IBAction)btneditindustry:(id)sender
{
    _txtindustry.userInteractionEnabled=YES;
    _btnindustry.userInteractionEnabled=YES;
    _txtnationality.userInteractionEnabled=NO;
    _btnDOB.userInteractionEnabled = NO;
    _txtDob.userInteractionEnabled = NO;
    _txtFullName.userInteractionEnabled = NO;
    _txtEmail.userInteractionEnabled = NO;
    _txtprefix.userInteractionEnabled = NO;
    _btnprefix.userInteractionEnabled = NO;
    _txtmobilenum.userInteractionEnabled = NO;
    
    _tblarea.frame = CGRectMake(_tblarea.frame.origin.x, _txtindustry.frame.origin.y - _tblarea.frame.size.height-5, _tblarea.frame.size.width, _tblarea.frame.size.height);
    
    for (int i= 0; i<arrIndustry.count; i++)
    {
        [abcd addObject:[NSString stringWithFormat:@"%@",[[arrIndustry objectAtIndex:i] valueForKey:@"industry"]]];
    }
    strindstry =@"yes";
}





- (IBAction)btnupdate:(id)sender
{
    [self.view endEditing:YES];
    
    NSString *emailString = self.txtEmail.text;

    NSString *emailReg = @"^[_A-Za-z0-9-]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z]{2,4})$";

    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailReg];
    
    
    if([self.txtFullName.text isEqualToString:@""])
    {
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:nil message:@"Please enter your full name."preferredStyle:UIAlertControllerStyleAlert];
        
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
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:nil message:@"Please enter the email address."preferredStyle:UIAlertControllerStyleAlert];
        
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
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:nil message:@"Please enter a valid email address." preferredStyle:UIAlertControllerStyleAlert];

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
    
    else if([self.txtmobilenum.text isEqualToString:@""])
    {
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:nil message:@"Please enter the mobile number."
                                   
                                                               preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Ok"
                                    
                                                            style:UIAlertActionStyleDefault
                                    
                                                          handler:^(UIAlertAction * action)
                                    
                                    {
                                        
                                        
                                        
                                    }];
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else if(([self.txtmobilenum.text length]) < 7)
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
    
    else if([self.txtDob.text isEqualToString:@""])
    {
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:nil message:@"Please select the date of birth."
                                   
                                                               preferredStyle:UIAlertControllerStyleAlert];
        
        
        UIAlertAction* yesButton = [UIAlertAction actionWithTitle:@"Ok"
                                    
                                                            style:UIAlertActionStyleDefault
                                    
                                                          handler:^(UIAlertAction * action)
                                    
                                    {
                                        
                                        
                                        
                                    }];
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else if([self.txtnationality.text isEqualToString:@""])
    {
        UIAlertController * alert=[UIAlertController alertControllerWithTitle:nil message:@"Please select the nationality." preferredStyle:UIAlertControllerStyleAlert];
        
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
            [self wsUpdate];
            //
        });
        
        
        //        [HUD showWhileExecuting:@selector(Wsregister) onTarget:self withObject:nil animated:YES];
    }
}





#pragma  mark <--table view delegate-->


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.tblprefix)
    {
        return 25;
    }
    
    else if(tableView == self.tblarea)
    {
        return 40;
    }
    
    return 0;
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.tblprefix)
    {
        return arrcode.count;
    }
    
    else if(tableView == self.tblarea)
    {
        return result.count;
    }
    
    return 0;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.tblprefix)
    {
        static NSString *CellIdentifier = @"cellIdentifier";
        
        UITableViewCell *cell = [_tblprefix dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell ==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        NSString *strid =[NSString stringWithFormat:@"%@",[arrcode objectAtIndex:indexPath.row]];
        cell.textLabel.text = strid;
        // cell.textLabel.backgroundColor = [UIColor blackColor];
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.font=[UIFont fontWithName:@"AvenirNext-Regular" size:10];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.numberOfLines = 0;
        
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
  
      cell1.lblselectionarea.text = [result objectAtIndex:indexPath.row];
        
        cell1.selectionStyle =UITableViewCellSelectionStyleNone;
        
        return cell1;
    }
    
    return 0;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.tblprefix)
    {
        _txtprefix.text = [NSString stringWithFormat:@"%@",[arrcode objectAtIndex:indexPath.row]];
        
        self.lblBlur.hidden=YES;
        self.tblprefix.hidden = YES;
    }
    
    else if(tableView == self.tblarea)
    {
        
        if([strindstry isEqualToString:@"yes"]){
            
            _tblarea.hidden = YES;
            self.txtindustry.text = [result objectAtIndex:indexPath.row];
            [self.view endEditing:YES];
            
        }else{
            _tblarea.hidden = YES;
            self.txtnationality.text = [result objectAtIndex:indexPath.row];
            [self.view endEditing:YES];
        }
        
    }
}






#pragma mark <--Web Services-->


-(void)wsGetAccount
{
    BaseViewController *base=[[BaseViewController alloc]init];
    NSString *user_id=[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"];
    NSString *token=[[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"key=%@&secret=%@&clientID=%@&token=%@&request=%@",str_key,str_secret,user_id,token,@"client"];
    
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
                NSDictionary *arrProfile = [dictionary valueForKey:@"data"];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                if ([[arrProfile valueForKey:@"first_name"] isKindOfClass:[NSNull class]])
                {
                    self.txtFullName.text = @"";
                }
                
                else
                {
                    self.txtFullName.text = [arrProfile valueForKey:@"first_name"];
                    
                    NSString *fname = [arrProfile valueForKey:@"first_name"];
                    
                    [defaults setObject:fname forKey:@"first_name"];
                }
                
                
                if ([[arrProfile valueForKey:@"email_address"] isKindOfClass:[NSNull class]])
                {
                    self.txtEmail.text = @"";
                }
                
                else
                {
                    self.txtEmail.text = [arrProfile valueForKey:@"email_address"];
                    
                    NSString *email = [arrProfile valueForKey:@"email_address"];
                    
                    [defaults setObject:email forKey:@"user_email"];
                }
                
                
                if ([[arrProfile valueForKey:@"mobile"] isKindOfClass:[NSNull class]])
                {
                    self.txtmobilenum.text = @"";
                }
                
                else
                {
                    NSString *mbllength = [arrProfile valueForKey:@"mobile"];
                    
                    [defaults setObject:mbllength forKey:@"user_contactnumber"];
                    
                    if (mbllength.length >3)
                    {
                        NSString *mblno = [arrProfile valueForKey:@"mobile"];
                        NSString *newStr = [mblno substringWithRange:NSMakeRange(3, [mblno length]-3)];
                        
                        NSString *mystr = [arrProfile valueForKey:@"mobile"];
                        mystr = [mystr substringToIndex:3];
                        
                        self.txtprefix.text = mystr;
                        self.txtmobilenum.text = newStr;
                    }
                    
                    else
                    {
                        self.txtmobilenum.text = @"";
                    }
                }
                
                
                if ([[arrProfile valueForKey:@"birthday"] isKindOfClass:[NSNull class]])
                {
                    self.txtDob.text=@"";
                }
                
                else
                {
                    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
                    NSString *strDAte =[arrProfile valueForKey:@"birthday"];
                    
                    [formatter setDateFormat:@"yy-MM-dd"];
                    
                    NSDate *dateDOB = [formatter dateFromString:strDAte];
                    
                    strDOB = [NSString stringWithFormat:@"%@ ",[formatter stringFromDate:dateDOB]];
                    
                    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
                    [formatter setLocale:usLocale];
                    
                    [formatter setDateFormat:@"yyyy-MM-dd"];
                    NSDate *date = [formatter dateFromString:strDAte];
                    
                    NSDateFormatter* datef = [[NSDateFormatter alloc]init];
                    [datef setDateFormat:@"dd/MM/yy"];
                    NSString *depResult = [datef stringFromDate:date];
                    
                    self.txtDob.text=depResult;
                }
                
                
                if ([[arrProfile valueForKey:@"nationality"] isKindOfClass:[NSNull class]])
                {
                    self.txtnationality.text=@"";
                }
                
                else
                {
                    self.txtnationality.text=[arrProfile valueForKey:@"nationality"];
                }
                
                
                if ([[arrProfile valueForKey:@"industry"] isKindOfClass:[NSNull class]])
                {
                    self.txtindustry.text = @"";
                }
                
                else
                {
                    self.txtindustry.text = [arrProfile valueForKey:@"industry"];
                }
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




//-(void)wsGetPic
//{
//    BaseViewController *base=[[BaseViewController alloc]init];
//    NSString *user_id=[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"];
//
//    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
//    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
//
//    NSString *parameter=[NSString stringWithFormat:@"userid=%@&action=%@&request=%@",user_id,@"view",@"profile"];
//
//    NSDictionary *dictionary =[[NSMutableDictionary alloc]init];
//
//    dictionary=[base WebParsingMethod:stringWebServicesCompleteUrl:parameter];
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
//                                    handler:^(UIAlertAction * action) {
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
//
//
//        //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Oops, cannot connect to server." delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//        //
//        //            [alert show];
//    }
//
//    else
//    {
//        NSString *errorCode=[NSString stringWithFormat:@"%@",[dictionary  valueForKey:@"code"]];
//        NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
//
//        dispatch_async(dispatch_get_main_queue(),^{
//            [GiFHUD dismiss];
//            if([errorCode isEqualToString:@"1"])
//            {
//                NSArray *arrProfile = [dictionary valueForKey:@"data"];
//
//                if ([[[arrProfile objectAtIndex:0] valueForKey:@"image"] isKindOfClass:[NSNull class]])
//                {
//
//                }
//
//                else
//                {
//                    NSString *strimg = [NSString stringWithFormat:@"%@%@",str_global_domain_pic,[[arrProfile objectAtIndex:0] valueForKey:@"image"]];
//
//                    NSURL *url = [NSURL URLWithString:strimg];
//
//                    [_imgprofile setImageWithURL:url placeholderImage:[UIImage imageNamed:@"ic_user"]];
//                }
//            }
//
//            else if ([errorCode isEqualToString:@"0"])
//            {
//
//            }
//
//            else if ([errorCode isEqualToString:@"3"])
//            {
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
//
//                //                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//                //
//                //                [alert show];
//            }
//
//            else
//            {
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
//
//                //                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
//                //
//                //                [alert show];
//            }
//        });
//    }
//}




-(void)wsUpdate
{
    NSString *strmbl = [NSString stringWithFormat:@"%@%@", self.txtprefix.text,self.txtmobilenum.text];
    
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *user_id=[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"];
    NSString *token=[[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"key=%@&secret=%@&clientID=%@&first_name=%@&email_address=%@&birthday=%@&mobile=%@&nationality=%@&industry=%@&token=%@&request=%@&action=%@",str_key,str_secret,user_id,self.txtFullName.text,self.txtEmail.text,strDOB,strmbl,self.txtnationality.text,self.txtindustry.text,token,@"client",@"update"];
    
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
            
            if([errorCode isEqualToString:@"1"])
            {
                _txtFullName.userInteractionEnabled=NO;
                _txtEmail.userInteractionEnabled=NO;
                _txtprefix.userInteractionEnabled=NO;
                _btnprefix.userInteractionEnabled=NO;
                _txtmobilenum.userInteractionEnabled=NO;
                _btnDOB.userInteractionEnabled=NO;
                _txtDob.userInteractionEnabled=NO;
                _txtnationality.userInteractionEnabled=NO;
                _txtindustry.userInteractionEnabled=NO;
                _btnindustry.userInteractionEnabled=NO;
                
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:@"Profile is updated successfully."
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
                
                [self wsGetAccount];
            }

            else if ([errorCode isEqualToString:@"0"])
            {
                [GiFHUD dismiss];
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





-(void)wosCountryName
{
    BaseViewController *obj=[[BaseViewController alloc]init];
//    NSString *strWebservice = @"?request=nationality&action=view";
    NSString *strWebserviceCompleteURL = [NSString stringWithFormat:@"%@",str_global_domain];
    
    NSString *parameter=[NSString stringWithFormat:@"request=%@&action=%@&key=%@&secret=%@",@"nationality",@"view",str_key,str_secret];
    
    NSDictionary *dict=[obj WebParsingMethod:strWebserviceCompleteURL:parameter];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if([[[dict valueForKey:@"code"] stringValue] isEqualToString:@"1"])
        {
            abcd =[[NSMutableArray alloc]init];
            
            arrProducts = [dict valueForKey:@"data"];
            
            for (int i= 0; i<arrProducts.count; i++)
            {
                [abcd addObject:[NSString stringWithFormat:@"%@",[[arrProducts objectAtIndex:i] valueForKey:@"name"]]];
            }
        }
        
        else if([[[dict valueForKey:@"code"] stringValue] isEqualToString:@"0"])
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




-(void)wsGetIndustry
{
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"request=%@&action=%@&key=%@&secret=%@",@"industry",@"view",str_key,str_secret];
    
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
                arrIndustry = [[NSArray alloc]init];
                
                arrIndustry=[dictionary valueForKey:@"data"];
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

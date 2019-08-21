//
//  MyAccountViewController.m
//  KCal
//
//  Created by Pipl-01 on 29/06/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "MyAccountViewController.h"
#import "ListTableViewCell.h"
#import "MyDetailController.h"
#import "DeliverylocationController.h"
#import "LoyalityProViewController.h"
#import "OrderHistoryController.h"
#import "BaseViewController.h"
#import "AppDelegate.h"
#import "GiFHUD.h"
#import "AddCardViewController.h"
#import "PaymentViewController.h"
#import "HomeViewController.h"

@interface MyAccountViewController ()
{
    NSArray *arrList;
}

@end

@implementation MyAccountViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    _lblName.text = [defaults valueForKey:@"first_name"];
    
    _lblEmail.text = [defaults valueForKey:@"user_email"];
    
    self.title = @"My Account";
    
    arrList=@[@"Order History",@"My Details",@"Payment Methods",@"Loyalty Program",@"My Delivery Locations"];
    
    _imgProfile.layer.masksToBounds = YES;
    _imgProfile.layer.cornerRadius = _imgProfile.frame.size.width/2;
    
    [GiFHUD setGifWithImageName:@"Spinner3.gif"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"handle_data" object:self];
}



-(void)viewDidAppear:(BOOL)animated
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
//    NSString *strimg = [NSString stringWithFormat:@"%@%@",str_global_domain_pic,[defaults valueForKey:@"profile_pic"]];
    
    NSString *strimg = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"profile_pic"]];
    
    NSURL *url = [NSURL URLWithString:strimg];
    
    [_imgProfile setImageWithURL:url placeholderImage:[UIImage imageNamed:@"ic_user"]];
    
//    [GiFHUD showWithOverlay];
//    //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        [self wsGetPic];
//    });
    
    for (UIButton *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 134)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 219)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 222)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 221)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 232)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 302)
        {
            [view removeFromSuperview];
        }
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrList.count;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
    {
        CGSize screenSize = [[UIScreen mainScreen] bounds].size;
        if (screenSize.height == 812)
        {
            return 60;
        }
        
        return 55;
    }
    
    return 0;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListTableViewCell";
    ListTableViewCell *cell1 = (ListTableViewCell *)[self.tblListing dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSArray *nib;
    
    nib = [[NSBundle mainBundle] loadNibNamed:@"ListTableViewCell" owner:self options:nil];
    cell1 = [nib objectAtIndex:0];
    
    cell1.lblListName.text=[arrList objectAtIndex:indexPath.row];
    
    if (indexPath.row==4)
    {
        cell1.lblLine.hidden=YES;
    }
    
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell1;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        OrderHistoryController *obj = [[OrderHistoryController alloc]initWithNibName:@"OrderHistoryController" bundle:nil];
        obj.pushflag = @"yes";
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
    
    else if (indexPath.row==1)
    {
        MyDetailController *obj = [[MyDetailController alloc]initWithNibName:@"MyDetailController" bundle:nil];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
    
    else if (indexPath.row==2)
    {
        PaymentViewController *obj = [[PaymentViewController alloc]initWithNibName:@"PaymentViewController" bundle:nil];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
    
    else if (indexPath.row==3)
    {
        LoyalityProViewController *obj = [[LoyalityProViewController alloc]initWithNibName:@"LoyalityProViewController" bundle:nil];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
    
    else if (indexPath.row==4)
    {
        DeliverylocationController *obj = [[DeliverylocationController alloc]initWithNibName:@"DeliverylocationController" bundle:nil];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
}





- (IBAction)btnOrderFood:(id)sender
{
    HomeViewController *obj=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    obj.str = @"yes";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.navigationController pushViewController:obj animated:YES];


//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message: @"Functionality under development" delegate:nil cancelButtonTitle:NSLocalizedString(@"OK",nil) otherButtonTitles:nil, nil];
//
//    [alert show];
    
}




//#pragma mark <--Web Services-->
//
//
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
//                    [_imgProfile setImageWithURL:url placeholderImage:[UIImage imageNamed:@"ic_user"]];
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



@end

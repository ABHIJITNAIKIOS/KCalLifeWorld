//
//  HomeViewController.m
//  KCal
//
//  Created by Apple on 28/02/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//


#import "HomeViewController.h"
#import "SlideNavigationController.h"
#import "MenuViewController.h"
#import "BaseViewController.h"
#import "AppDelegate.h"
#import "LoViewController.h"
#import "OrderHistoryController.h"
#import "AddressTableViewCell.h"
#import "HomeTableViewCell.h"
#import "WorkTableViewCell.h"
#import "AddDeliveryaddressController.h"
#import "CalenderViewController.h"
#import "AreaViewCell.h"
#import "OffersViewController.h"
#import "AreaselectionViewCell.h"
#import "LoyalityProViewController.h"
#import "GiFHUD.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Crashlytics/Crashlytics.h>

@interface HomeViewController ()
{
    UIButton *leftbtn1;
    UIImageView *leftbtn;
    CGFloat screenWidth;
    CGFloat screenHeight;
    NSString *status;
    NSString*strrating;
    NSURL *url1;
    NSString *str_date,*str_date1;
    AddressTableViewCell *cell3;
    HomeTableViewCell *cell2;
    WorkTableViewCell *cell1;
    NSMutableArray *arrdata;
    NSMutableArray *arrdata1;
    NSArray *arrtemp;
    NSString *strlocation,*strcity;
    NSString *strtime;
    AreaViewCell  *cellarea;
    AreaselectionViewCell  *cellsSelectArea;
    NSString *strflag,*strflagSelect;
    NSMutableArray *areadict;
    NSString *category_id,*Strcity;
    NSArray *arrarea, *area;
    NSDictionary *dictime, *dictshop, *dictavailable;
    NSString *strEndTime,*strStartTime,*flagTimer,*mintime, *strstart, *strend;
    NSInteger minute;
    int endtime,starttime,startday,startmonth,startyear,endday,endmonth,endyear;
    NSTimer *time;
    NSMutableArray *result;
    NSString *strdidselectdata,*strOrderId;
    UIImageView *img;
    NSDate *startDate;
}

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self wsTemp];
    
    for (UIButton *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 205)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 213)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 215)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 217)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 134)
        {
            [view removeFromSuperview];
        }
    }
    
    for (UIImageView *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 401)
        {
            [view removeFromSuperview];
        }
    }
    
    url1 = [[NSBundle mainBundle] URLForResource:@"KL_APP_Home-Banner(GIF)" withExtension:@"gif"];
    
    NSData *data1 = [NSData dataWithContentsOfURL:url1];
    FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:data1];
    self.imgview.animatedImage = animatedImage1;
    
    [time invalidate];
    time = nil;
    
    self.navigationController.navigationBarHidden = NO;
    
    startDate = [NSDate date];
    
    dictshop = [[NSDictionary alloc] init];
    dictime = [[NSDictionary alloc] init];
    dictavailable = [[NSDictionary alloc] init];
    
    screenWidth = [UIScreen mainScreen].bounds.size.width;
    screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    [self.view addSubview:_viewoffer];
    
    _viewoffer.hidden = YES;
    
    _viewoffer.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, screenWidth, screenHeight);
    self.txtrateMessage.textColor = [UIColor blackColor];
    self.txtrateMessage.delegate = self;
    
    [self.view addSubview:_viewpopLastorder];
    self.viewpopLastorder.hidden = YES;
    [self.view addSubview:_viewlogin];
    
    self.viewlogin.hidden = YES;
    self.lblback.hidden = YES;
    strflag=@"no";
    strflagSelect=@"no";
    flagTimer =@"no";
    
    NSData *data = [NSData data];
    
    [[NSUserDefaults standardUserDefaults] setValue:data forKey:@"arrinsertdate"];
    
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismisstap4)];
    
    [self.lblbackoffer addGestureRecognizer:tap4];
    
    [GiFHUD setGifWithImageName:@"Spinner3.gif"];
    
    self.DeliveryView.hidden=YES;
    _viewredirect.hidden=YES;
    self.viewhungry.hidden=YES;
    _viewpicker.hidden=YES;
    
    category_id = @"";
    
    _datepicker.minuteInterval = 15;
}




-(void)viewDidAppear:(BOOL)animated
{
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    
    if (screenSize.height == 812)
    {
        _imgtop.constant=44.0;
        _imgmenutop.constant=75.0;
        _lblorderhistory.font=[UIFont fontWithName:@"AvenirNext-DemiBold" size:15];
        _lblviewmenu.font=[UIFont fontWithName:@"AvenirNext-DemiBold" size:15];
        _lblloyalty.font=[UIFont fontWithName:@"AvenirNext-DemiBold" size:15];
        _lblweeklyorder.font=[UIFont fontWithName:@"AvenirNext-DemiBold" size:15];
        _historytop.constant=10.0;
        _menutop.constant=2.0;
        _loyaltytop.constant=10.0;
        _weeklytop.constant=13.0;
        _lblorder.font=[UIFont fontWithName:@"AvenirNext-Medium" size:21];
    }
    
    UIColor *color = [UIColor colorWithRed:108/255.0f green:108/255.0f blue:110/255.0f alpha:1];
    
    self.txtdeliveryaddress.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Where are we delivering?" attributes:@{NSForegroundColorAttributeName: color}];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    status = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"status"]];
    
    if ([_flag isEqualToString:@"login"])
    {
        self.viewlogin.hidden = NO;
        self.lblback.hidden = NO;
    }
    
    else
    {
        self.viewlogin.hidden = YES;
        self.lblback.hidden = YES;
    }
    
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"weeklyorderclicked"] isEqualToString:@"yes"])
    {
        // For Weekly Order Scenario
        
        if ([status isEqualToString:@"login"])
        {
            [self wsgetRating];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            NSString *firsttime = [defaults valueForKey:@"firsttime"];
            
            if ([firsttime isEqualToString:@"first"])
            {
                _viewoffer.hidden = YES;
            }
            
            else
            {
                [GiFHUD showWithOverlay];
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [self wsGetOfferImage];
                });
            }
        }
        
        else
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            NSString *firsttime = [defaults valueForKey:@"firsttime"];
            
            if ([firsttime isEqualToString:@"first"])
            {
                _viewoffer.hidden = YES;
            }
            
            else
            {
                [GiFHUD showWithOverlay];
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [self wsGetOfferImage];
                });
            }
        }
    }
    
    else
    {
        // For Single Order Scenario
        
        if ([status isEqualToString:@"login"])
        {
            if ([_str isEqualToString:@"order"])
            {
                [GiFHUD showWithOverlay];
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [self wsGetAddress];
                });
            }
            
            else if ([_str isEqualToString:@"yes"])
            {
                [GiFHUD showWithOverlay];
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [self wsGetAddress];
                });
            }
            
            else
            {
                if ([_flag isEqualToString:@"login"])
                {
                    
                }
                
                else
                {
                    [self wsgetRating];
                    
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    
                    NSString *firsttime = [defaults valueForKey:@"firsttime"];
                    
                    if ([firsttime isEqualToString:@"first"])
                    {
                        _viewoffer.hidden = YES;
                    }
                    
                    else
                    {
                        [GiFHUD showWithOverlay];
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                            [self wsGetOfferImage];
                        });
                    }
                }
            }
        }
        
        else
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            NSString *firsttime = [defaults valueForKey:@"firsttime"];
            
            if ([firsttime isEqualToString:@"first"])
            {
                _viewoffer.hidden = YES;
            }
            
            else
            {
                [GiFHUD showWithOverlay];
                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [self wsGetOfferImage];
                });
            }
        }
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"handle_data" object:self];
}




-(void)viewDidDisappear:(BOOL)animated
{
    [time invalidate];
    time = nil;
}




-(void)dismisstap4
{
    _viewoffer.hidden=YES;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    [time invalidate];
    time = nil;
    
    return YES;
}




- (IBAction)btnOrderNOw:(id)sender
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    [defaults setValue:@"" forKey:@"city"];
    [defaults setValue:@"" forKey:@"location"];
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"weeklyorderclicked"] isEqualToString:@"yes"])
    {
        [time invalidate];
        time = nil;
        
        MenuViewController *obj=[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
    
    else
    {
        if ([status isEqualToString:@"login"])
        {
            [GiFHUD showWithOverlay];
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                //[self wsGetPic];
                [self wsGetAddress];
            });
        }
        
        else
        {
            [time invalidate];
            time = nil;
            
            MenuViewController *obj=[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
            [self.navigationController pushViewController:obj animated:YES];
        }
    }
}




- (IBAction)btnorderHistory:(id)sender
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSString *status=[defaults valueForKey:@"status"];
    
    if ([status isEqualToString:@"login"])
    {
        OrderHistoryController *obj=[[OrderHistoryController alloc]initWithNibName:@"OrderHistoryController" bundle:nil];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
    
    else
    {
        LoViewController *obj=[[LoViewController alloc]initWithNibName:@"LoViewController" bundle:nil];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
}





- (IBAction)btnviewmenuclicked:(id)sender
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    [defaults setValue:@"" forKey:@"city"];
    [defaults setValue:@"" forKey:@"location"];
    
    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"weeklyorderclicked"] isEqualToString:@"yes"])
    {
        [time invalidate];
        time = nil;
        
        MenuViewController *obj=[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
    
    else
    {
        if ([status isEqualToString:@"login"])
        {
            [GiFHUD showWithOverlay];
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self wsGetAddress];
            });
        }
        
        else
        {
            [time invalidate];
            time = nil;
            
            MenuViewController *obj=[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
            [self.navigationController pushViewController:obj animated:YES];
        }
    }
}




- (IBAction)btnloyaltyprogramclicked:(id)sender
{
    if ([status isEqualToString:@"login"])
    {
        LoyalityProViewController *obj=[[LoyalityProViewController alloc]initWithNibName:@"LoyalityProViewController" bundle:nil];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
    
    else
    {
        LoViewController *obj=[[LoViewController alloc]initWithNibName:@"LoViewController" bundle:nil];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
}




- (IBAction)btnweeklyOrderClicked:(id)sender
{
    if ([status isEqualToString:@"login"])
    {
        CalenderViewController *obj=[[CalenderViewController alloc]initWithNibName:@"CalenderViewController" bundle:nil];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
    
    else
    {
        LoViewController *obj=[[LoViewController alloc]initWithNibName:@"LoViewController" bundle:nil];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
}




- (IBAction)btnaddnewdeliverylocation:(id)sender
{
    [time invalidate];
    time = nil;
    
    MenuViewController *obj=[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.navigationController pushViewController:obj animated:YES];
}




- (IBAction)btnASAPclicked:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setValue:@"ASAP" forKey:@"ASAP"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *strcurrent =[NSString stringWithFormat:@"%@",[formatter stringFromDate:[NSDate date]]];
    
    strcurrent =[strcurrent stringByReplacingOccurrencesOfString:@"PM" withString:@"pm"];
    
    strcurrent =[strcurrent stringByReplacingOccurrencesOfString:@"AM" withString:@"am"];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *startdatenew =[dateFormat dateFromString:strstart];
    NSDate *enddatenew =[dateFormat dateFromString:strend];
    
    [dateFormat setDateFormat:@"hh:mm a"];
    
    NSString *startdat = [dateFormat stringFromDate:startdatenew];
    NSString *enddat = [dateFormat stringFromDate:enddatenew];
    
    startdat =[startdat stringByReplacingOccurrencesOfString:@"PM" withString:@"pm"];
    
    startdat =[startdat stringByReplacingOccurrencesOfString:@"AM" withString:@"am"];
    
    enddat =[enddat stringByReplacingOccurrencesOfString:@"PM" withString:@"pm"];
    
    enddat =[enddat stringByReplacingOccurrencesOfString:@"AM" withString:@"am"];
    
    NSString *string = [NSString stringWithFormat:@"This branch is not open yet. Delivery hours are between %@ and %@.",startdat, enddat];
    
    NSDate *date1= [formatter dateFromString:strstart];
    NSDate *date2 = [formatter dateFromString:strcurrent];
    
    NSComparisonResult result = [date1 compare:date2];
    if(result == NSOrderedDescending)
    {
        NSLog(@"date1 is later than date2");
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:string
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
    
    else if(result == NSOrderedAscending)
    {
        NSLog(@"date2 is later than date1");
    }
    
    else
    {
        NSLog(@"date1 is equal to date2");
    }
    
    NSString *str = [NSString stringWithFormat:@"Sorry, this branch is now closed. Delivery hours are between %@ and %@.",startdat, enddat];
    
    NSString *strshop = [NSString stringWithFormat:@"%@",[dictime valueForKey:@"shop"]];
    
    NSString *shopname = [NSString stringWithFormat:@"Your order will be sent from %@",strshop];
    
    NSDate *enddate= [formatter dateFromString:strend];
    NSDate *currentdate = [formatter dateFromString:strcurrent];
    
    NSComparisonResult resultdate = [enddate compare:currentdate];
    if(resultdate == NSOrderedDescending)
    {
        [time invalidate];
        time = nil;
        
        NSLog(@"enddate is later than currentdate");
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:shopname
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        MenuViewController *obj=[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
                                        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                                        [self.navigationController pushViewController:obj animated:YES];
                                    }];
        
        //Add your buttons to alert controller
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else if(result == NSOrderedAscending)
    {
        NSLog(@"currentdate is later than enddate");
        
        //_btnASAP.userInteractionEnabled = NO;
        _btnlater.userInteractionEnabled = NO;
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:str
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
        [time invalidate];
        time = nil;
        
        NSLog(@"enddate is equal to currentdate");
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:shopname
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        MenuViewController *obj=[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
                                        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                                        [self.navigationController pushViewController:obj animated:YES];
                                    }];
        
        //Add your buttons to alert controller
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}





- (IBAction)btnletterclicked:(id)sender
{
    [self wsGetTime];
}




#pragma  mark <---table view delegate--->

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.tbladdress)
    {
        return arrdata.count;
    }
    
    return 0;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.tbladdress)
    {
        [GiFHUD dismiss];
        
        if(arrdata.count>2)
        {
            arrtemp = [arrdata objectAtIndex:indexPath.row];
        }
        
        if(indexPath.row == 0)
        {
            NSArray *nib;
            
            cell1 = (WorkTableViewCell *)[self.tbladdress dequeueReusableCellWithIdentifier:@"cell1"];
            
            if (cell1 == nil)
            {
                nib = [[NSBundle mainBundle] loadNibNamed:@"WorkTableViewCell" owner:self options:nil];
            }
            
            cell1 = [nib objectAtIndex:0];
            cell1.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell1;
        }
        
        else if(indexPath.row == 1)
        {
            NSArray *nib;
            
            cell2 = (HomeTableViewCell *)[self.tbladdress dequeueReusableCellWithIdentifier:@"cell2"];
            
            if (cell2 == nil) {
                nib = [[NSBundle mainBundle] loadNibNamed:@"HomeTableViewCell" owner:self options:nil];
            }
            
            cell2 = [nib objectAtIndex:0];
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell2;
        }
        
        else
        {
            NSArray *nib;
            
            cell3 = (AddressTableViewCell *)[self.tbladdress dequeueReusableCellWithIdentifier:@"cell3"];
            
            if (cell3 == nil) {
                nib = [[NSBundle mainBundle] loadNibNamed:@"AddressTableViewCell" owner:self options:nil];
            }
            
            cell3 = [nib objectAtIndex:0];
            
            cell3.lbladdress.text = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"title"]];
            
            cell3.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell3;
        }
    }
    
    return 0;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _tbladdress)
    {
        NSString *strid = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"id"]];
        
        NSString *straddresstype = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"type"]];
        
        [[NSUserDefaults standardUserDefaults] setObject:straddresstype forKey:@"address_type"];
        
        NSString *street = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"street"]];
        
        [[NSUserDefaults standardUserDefaults] setObject:street forKey:@"street"];
        
        NSString *sublocation = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"sublocation"]];
        
        [[NSUserDefaults standardUserDefaults] setObject:sublocation forKey:@"sublocation"];
        
        NSString *location = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"location"]];
        
        NSString *city = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"city"]];
        
        [[NSUserDefaults standardUserDefaults] setObject:city forKey:@"city"];
        
        NSString *title = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"title"]];
        
        NSString *strmin_amount = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"min_amount"]];
        
        [[NSUserDefaults standardUserDefaults] setValue:strmin_amount forKey:@"min_amount"];
        
        NSString *strBranchId = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"shopId"]];
        
        [[NSUserDefaults standardUserDefaults] setValue:strBranchId forKey:@"shopId"];
        
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
        
        [[NSUserDefaults standardUserDefaults] setObject:title forKey:@"address_title"];
        [[NSUserDefaults standardUserDefaults] setObject:strid forKey:@"address_id"];
        [[NSUserDefaults standardUserDefaults] setObject:address forKey:@"primaryaddress"];
        
        
        if (indexPath.row==0)
        {
            if([[[arrdata objectAtIndex:indexPath.row] valueForKey:@"type"] isEqualToString:@"1"])
            {
                NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                
                strlocation = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"location"]];
                strcity = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"city"]];
                NSString *strdelivery_time = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"delivery_time"]];
                
                [defaults setValue:strcity forKey:@"city"];
                [defaults setValue:strlocation forKey:@"location"];
                [defaults setValue:strdelivery_time forKey:@"delivery_time"];
                
                NSString *straddresstype = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"type"]];
                
                [[NSUserDefaults standardUserDefaults] setObject:straddresstype forKey:@"address_type"];
                
                NSString *street = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"street"] ];
                
                [[NSUserDefaults standardUserDefaults] setObject:street forKey:@"street"];
                
                NSString *sublocation = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"sublocation"] ];
                
                [[NSUserDefaults standardUserDefaults] setObject:sublocation forKey:@"sublocation"];
                
                NSString *location = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"location"] ];
                
                NSString *city = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"city"] ];
                
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
                
                
                if ([strlocation isEqualToString:@""])
                {
                    AddDeliveryaddressController *obj=[[AddDeliveryaddressController alloc]initWithNibName:@"AddDeliveryaddressController" bundle:nil];
                    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                    obj.strtitle = @"Work";
                    obj.flag = @"1";
                    [self.navigationController pushViewController:obj animated:YES];
                }
                
                else
                {
                    [self wsGetTimeforASAP];
                    
                    _viewhungry.hidden=NO;
                    
                    _viewredirect.hidden=YES;
                }
            }
        }
        
        else if (indexPath.row==1)
        {
            if([[[arrdata objectAtIndex:indexPath.row] valueForKey:@"type"] isEqualToString:@"0"])
            {
                NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                
                strlocation = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"location"]];
                strcity = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"city"]];
                NSString *strdelivery_time = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"delivery_time"]];
                
                [defaults setValue:strdelivery_time forKey:@"delivery_time"];
                [defaults setValue:strcity forKey:@"city"];
                [defaults setValue:strlocation forKey:@"location"];
                
                NSString *straddresstype = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"type"]];
                
                [[NSUserDefaults standardUserDefaults] setObject:straddresstype forKey:@"address_type"];
                
                NSString *street = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"street"]];
                NSString *sublocation = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"sublocation"]];
                NSString *location = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"location"]];
                NSString *city = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"city"]];
                
                [[NSUserDefaults standardUserDefaults] setObject:street forKey:@"street"];
                [[NSUserDefaults standardUserDefaults] setObject:sublocation forKey:@"sublocation"];
                
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
                
                
                if ([strlocation isEqualToString:@""])
                {
                    AddDeliveryaddressController *obj=[[AddDeliveryaddressController alloc]initWithNibName:@"AddDeliveryaddressController" bundle:nil];
                    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                    obj.strtitle = @"Home";
                    obj.flag = @"0";
                    [self.navigationController pushViewController:obj animated:YES];
                }
                
                else
                {
                    [self wsGetTimeforASAP];
                    
                    _viewhungry.hidden=NO;
                    _viewredirect.hidden=YES;
                }
            }
        }
        
        else
        {
//            NSString *strtype =[NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"type"]];
//
//            if([strtype isEqualToString:@"2"])
//            {
                NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                
                strlocation = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"location"]];
                strcity = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"city"]];
                NSString *street = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"street"]];
                NSString *sublocation = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"sublocation"]];
                NSString *location = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"location"]];
                NSString *city = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"city"]];
                NSString *strdelivery_time = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"delivery_time"]];
                NSString *straddresstype = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"type"]];
                
                [[NSUserDefaults standardUserDefaults] setObject:straddresstype forKey:@"address_type"];
                [[NSUserDefaults standardUserDefaults] setObject:street forKey:@"street"];
                [[NSUserDefaults standardUserDefaults] setObject:sublocation forKey:@"sublocation"];
                
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
                
                [defaults setValue:strdelivery_time forKey:@"delivery_time"];
                [defaults setValue:address forKey:@"primaryaddress"];
                [defaults setValue:strcity forKey:@"city"];
                [defaults setValue:strlocation forKey:@"location"];
                
                [self wsGetTimeforASAP];
                
                _viewhungry.hidden=NO;
                _viewredirect.hidden=YES;
//            }
        }
    }
}





- (IBAction)btnsettimeclicked:(id)sender
{
    flagTimer =@"no";
    [time invalidate];
    time = nil;
    
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"ASAP"];
    
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormat setLocale:usLocale];
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    //[dateFormat setDateFormat:@"hh:mm a"];
    [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm a"];
    str_date=[NSString stringWithFormat:@"%@",[dateFormat stringFromDate:_datepicker.date]];
    
    str_date =[str_date stringByReplacingOccurrencesOfString:@"PM" withString:@"pm"];
    
    str_date =[str_date stringByReplacingOccurrencesOfString:@"AM" withString:@"am"];
    
    self.viewpicker.hidden=YES;
//    NSDate *date = [NSDate date];
//    [dateFormat setDateFormat:@"yyyy-MM-dd"];
//
//    NSString *str_day=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:date]];
    
    NSString *savedate = [NSString stringWithFormat:@"%@",str_date];
    
    [[NSUserDefaults standardUserDefaults] setObject:savedate forKey:@"delivery_time"];
    
    MenuViewController *obj=[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.navigationController pushViewController:obj animated:YES];
}





- (IBAction)btnaddAddress:(id)sender
{
    AddDeliveryaddressController *obj=[[AddDeliveryaddressController alloc]initWithNibName:@"AddDeliveryaddressController" bundle:nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    
    obj.flag = @"2";
    [self.navigationController pushViewController:obj animated:YES];
}




- (IBAction)btnsubmitClicked:(id)sender
{
    _viewredirect.hidden=YES;
}




- (IBAction)btnclose:(id)sender
{
    self.viewlogin.hidden = YES;
    self.lblback.hidden = YES;
    
    [self wsgetRating];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *firsttime = [defaults valueForKey:@"firsttime"];
    
    if ([firsttime isEqualToString:@"first"])
    {
        _viewoffer.hidden = YES;
    }
    
    else
    {
        [GiFHUD showWithOverlay];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self wsGetOfferImage];
        });
    }
}



-(void)ratingpara:(NSString*)ratevalue ratingstr1:(NSString*)imgstr
{
    strrating = ratevalue;
    
    if ([strrating isEqualToString:@"5"])
    {
        [GiFHUD showWithOverlay];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
            _viewpopLastorder.hidden = YES;
            [self wsgiverating];
        });
    }
    
    else
    {
        self.viewGiverating.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        [self.view addSubview:_viewGiverating];
        [self.btnRatingsmily setBackgroundImage:[UIImage imageNamed:imgstr] forState:UIControlStateNormal];
    }
}




- (IBAction)btnsmilyclicked:(id)sender
{
    if ([sender tag] == 1)
    {
        [self ratingpara:@"1" ratingstr1:@"smily1"];
    }
    
    else if([sender tag] == 2)
    {
        strrating = @"3";
        [self ratingpara:@"3" ratingstr1:@"smily2"];
    }
    
    else if([sender tag] == 3)
    {
        strrating = @"5";
        [self ratingpara:@"5" ratingstr1:@"smily3"];
    }
    
    else
    {
        
    }
}




- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.txtrateMessage.text = @"";
    
    return YES;
}




-(void)textViewDidChange:(UITextView *)textView
{
    if(self.txtrateMessage.text.length == 0)
    {
        self.txtrateMessage.textColor = [UIColor blackColor];
        [self.txtrateMessage resignFirstResponder];
    }
}




- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if(self.txtrateMessage.text.length == 0)
    {
        self.txtrateMessage.textColor = [UIColor blackColor];
        _txtrateMessage.layer.borderColor = [[UIColor grayColor]CGColor];
        [self.txtrateMessage resignFirstResponder];
    }
    
    return YES;
}





- (IBAction)btnRateNothank:(id)sender
{
    [GiFHUD showWithOverlay];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        _viewpopLastorder.hidden = YES;
        [self wsgiverating];
    });
}




- (IBAction)btnsubmitrate:(id)sender
{
    if([self.txtrateMessage.text isEqualToString:@""])
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"Please tell us what happened."
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
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            _viewpopLastorder.hidden = YES;
            
            [self wsgiverating];
        });
    }
}




- (IBAction)btncloseoffer:(id)sender
{
    _viewoffer.hidden = YES;
}





- (IBAction)btnfindoffer:(id)sender
{
    if ([status isEqualToString:@"login"])
    {
        OffersViewController *obj=[[OffersViewController alloc]initWithNibName:@"OffersViewController" bundle:nil];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
    
    else
    {
        LoViewController *obj=[[LoViewController alloc]initWithNibName:@"LoViewController" bundle:nil];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
}




-(void)funcTime1
{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormat setLocale:usLocale];
    
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    NSString *strex = [NSString stringWithFormat:@"%@", mintime];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *startdatweb =[dateFormat dateFromString:strex];
    
//    NSString *startdatsystem =[dateFormat stringFromDate:[NSDate date]];
//
//    NSDate *startdatsys =[dateFormat dateFromString:startdatsystem];
//
//    NSDate *datefinal = startdatweb;
//    NSComparisonResult result = [startdatsys compare:datefinal];
//
//    if (result == NSOrderedDescending)
//    {
//        datefinal = startdatsys;
//    }
    
//    [dateFormat setDateFormat:@"HH:mm"];
//
//    //strStartTime=[NSString stringWithFormat:@"%@",[dateFormat stringFromDate:datefinal]];
    
    [dateFormat setDateFormat:@"HH:mm"];
    
    strStartTime=[NSString stringWithFormat:@"%@",[dateFormat stringFromDate:startdatweb]];
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//
//    NSString *straddtime = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"delivery_time"]];
//
//    straddtime = [straddtime stringByReplacingOccurrencesOfString:@"mins" withString:@""];
//
//    int addmin = straddtime.intValue;
//
//    NSTimeInterval seconds = addmin * 60;
//
//    NSDate *datetemp2 = [datetemp dateByAddingTimeInterval:seconds];
//
//    strStartTime=[NSString stringWithFormat:@"%@",[dateFormat stringFromDate:datetemp2]];
    
    
    starttime = strStartTime.intValue;
    
    NSDate *startmin =[dateFormat dateFromString:strStartTime];
    
    [dateFormat setDateFormat:@"mm"];
    
    NSString *strmin1 = [dateFormat stringFromDate:startmin];
    
    minute = strmin1.integerValue;
    
    [dateFormat setDateFormat:@"dd"];
    
    NSString *strday = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:startdatweb]];
    
    startday = strday.intValue;
    
    [dateFormat setDateFormat:@"MM"];
    
    NSString *strmonth = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:startdatweb]];
    
    startmonth = strmonth.intValue;
    
    [dateFormat setDateFormat:@"yyyy"];
    
    NSString *stryear = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:startdatweb]];
    
    startyear = stryear.intValue;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:datetemp2];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:startdatweb];

//    NSInteger minute1 = [components minute];
//
//    if ((0 <= minute1) && (minute1 <= 15))
//    {
//        minute = 15;
//    }
//
//    else  if( (16 <= minute1) && (minute1 <= 30))
//    {
//        minute = 30;
//    }
//
//    else  if((31 <= minute1) && (minute1 <= 45))
//    {
//        minute = 45;
//    }
//
//    else  if ((46 <= minute1) && (minute1 <= 60))
//    {
//        minute = 00;
//
//        if (starttime <23)
//        {
//            starttime = starttime + 1;
//        }
//
//        else
//        {
//            starttime = 0;
//        }
//    }
    
    strEndTime = [dictavailable valueForKey:@"end"];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *enddatweb =[dateFormat dateFromString:strEndTime];
    
    [dateFormat setDateFormat:@"HH:mm"];
    
    NSString *enddat = [dateFormat stringFromDate:enddatweb];
    
//    NSDate *endfinaldate =[dateFormat dateFromString:enddat];
    
    endtime = enddat.intValue;
    
    NSDate *endmin =[dateFormat dateFromString:enddat];
    
    [dateFormat setDateFormat:@"mm"];
    
    NSString *endmin1 = [dateFormat stringFromDate:endmin];
    
    NSInteger minute2 = endmin1.integerValue;
    
    [dateFormat setDateFormat:@"dd"];
    
    NSString *strendday = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:enddatweb]];
    
    endday = strendday.intValue;
    
    [dateFormat setDateFormat:@"MM"];
    
    NSString *strendmonth = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:enddatweb]];
    
    endmonth = strendmonth.intValue;
    
    [dateFormat setDateFormat:@"yyyy"];
    
    NSString *strendyear = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:enddatweb]];
    
    endyear = strendyear.intValue;
    
//    NSDateComponents *components1 = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:endfinaldate];
//
//    NSInteger minute2 = [components1 minute];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    [components setDay:startday];
    [components setMonth:startmonth];
    [components setYear:startyear];
    [components setHour: starttime];
    [components setMinute: minute];
    [components setSecond: 0];
    startDate = [gregorian dateFromComponents: components];
    
    [components setDay:endday];
    [components setMonth:endmonth];
    [components setYear:endyear];
    [components setHour: endtime];
    [components setMinute: minute2];
    [components setSecond: 0];
    
    NSDate *endDate = [gregorian dateFromComponents:components];
    
    _datepicker.datePickerMode=UIDatePickerModeDateAndTime;
    
    _datepicker.backgroundColor = [UIColor whiteColor];
    [_datepicker setValue:[UIColor colorWithRed:119.0/255.0f green:189.0/255.0f blue:29.0/255.0f alpha:1] forKey:@"textColor"];
    
    if (startDate == NULL || startDate == nil)
    {
        startDate = [NSDate date];
    }
    
    else
    {
        
    }
    
    [_datepicker setMinimumDate:startDate];
    [_datepicker setMaximumDate:endDate];
    [_datepicker setDate:startDate animated:YES];
}




#pragma mark <--Web Services-->


-(void)wsTemp
{
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"request=%@&key=%@&secret=%@",@"weather",str_key,str_secret];
    
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
        
        //dispatch_async(dispatch_get_main_queue(),^{
            
            if([errorCode isEqualToString:@"1"])
            {
                NSArray *arrWeather=[dictionary valueForKey:@"data"];
                
                NSString * greeting=[NSString stringWithFormat:@"%@",[arrWeather valueForKey:@"salutation"]];
                self.title= greeting;
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
        //});
    }
}





-(void)wsGetAddress
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *user_id = [defaults valueForKey:@"user_id"];
    NSString *token = [defaults valueForKey:@"token"];
    
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *strWebserviceCompleteURL = [NSString stringWithFormat:@"%@",str_global_domain] ;
    [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"isgetmethod"];
    
    NSString *parameter=[NSString stringWithFormat:@"user_id=%@&request=%@&action=%@&key=%@&secret=%@&token=%@",user_id,@"addresses",@"view",str_key,str_secret,token];
    
    NSDictionary *dictionary = [[NSMutableDictionary alloc]init];
    
    dictionary = [base WebParsingMethod:strWebserviceCompleteURL:parameter];
    
    if(dictionary == (id)[NSNull null] || dictionary == nil)
    {
        [GiFHUD dismiss];
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
                arrdata = [[NSMutableArray alloc]init];
                arrdata1 = [[NSMutableArray alloc]init];
                
                arrdata1 = [[dictionary valueForKey:@"data"] mutableCopy];
                
                NSMutableDictionary *work = [[NSMutableDictionary alloc]init];
                
                [work setObject:@"" forKey:@"address_title"];
                [work setObject:@"" forKey:@"city"];
                [work setObject:@"" forKey:@"delivery_time"];
                [work setObject:@"" forKey:@"id"];
                [work setObject:@"" forKey:@"landmark"];
                [work setObject:@"" forKey:@"lat"];
                [work setObject:@"" forKey:@"lng"];
                [work setObject:@"" forKey:@"location"];
                [work setObject:@"" forKey:@"min_amount"];
                [work setObject:@"" forKey:@"number"];
                [work setObject:@"" forKey:@"shopId"];
                [work setObject:@"" forKey:@"shop_alias"];
                [work setObject:@"" forKey:@"street"];
                [work setObject:@"" forKey:@"sublocation"];
                [work setObject:@"Work" forKey:@"title"];
                [work setObject:@"1" forKey:@"type"];
                [work setObject:user_id forKey:@"user_id"];
                
                [arrdata addObject:work];
                
                
                NSMutableDictionary *home = [[NSMutableDictionary alloc]init];
                
                [home setObject:@"" forKey:@"address_title"];
                [home setObject:@"" forKey:@"city"];
                [home setObject:@"" forKey:@"delivery_time"];
                [home setObject:@"" forKey:@"id"];
                [home setObject:@"" forKey:@"landmark"];
                [home setObject:@"" forKey:@"lat"];
                [home setObject:@"" forKey:@"lng"];
                [home setObject:@"" forKey:@"location"];
                [home setObject:@"" forKey:@"min_amount"];
                [home setObject:@"" forKey:@"number"];
                [home setObject:@"" forKey:@"shopId"];
                [home setObject:@"" forKey:@"shop_alias"];
                [home setObject:@"" forKey:@"street"];
                [home setObject:@"" forKey:@"sublocation"];
                [home setObject:@"Home" forKey:@"title"];
                [home setObject:@"0" forKey:@"type"];
                [home setObject:user_id forKey:@"user_id"];
                
                [arrdata addObject:home];
                
                
                for (int i =0; i<arrdata1.count; i++)
                {
                    NSString *temptitle = [NSString stringWithFormat:@"%@",[[arrdata1 objectAtIndex:i] valueForKey:@"title"]];
                    
                    if ([temptitle isEqualToString:@"Work"])
                    {
                        [arrdata replaceObjectAtIndex:0 withObject:[arrdata1 objectAtIndex:i]];
                    }
                    
                    else if ([temptitle isEqualToString:@"Home"])
                    {
                        [arrdata replaceObjectAtIndex:1 withObject:[arrdata1 objectAtIndex:i]];
                    }
                    
                    else
                    {
                        [arrdata addObject:[arrdata1 objectAtIndex:i]];
                    }
                }
                
                [self.tbladdress reloadData];
                
                NSLog(@"arrdata=%@",arrdata);
                
                _viewredirect.hidden=NO;
                self.viewredirect.frame = CGRectMake(0, 0, screenWidth, screenHeight);
                [self.view addSubview:self.viewredirect];
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





-(void)wsGetTime
{
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *token = [defaults valueForKey:@"token"];
    NSString *strloc = [defaults valueForKey:@"location"];
    
    NSString *parameter=[NSString stringWithFormat:@"request=%@&area=%@&action=%@&key=%@&secret=%@&token=%@",@"allareas",strloc,@"getshop",str_key,str_secret,token];
    
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
        
        //dispatch_async(dispatch_get_main_queue(),^{
            
            if([errorCode isEqualToString:@"1"])
            {
                dictshop = [dictionary valueForKey:@"data"];
                
                dictavailable = [dictshop valueForKey:@"available_times"];
                
                //mintime = [dictshop valueForKey:@"start_new"];
                mintime = [dictavailable valueForKey:@"start"];
                
                //strEndTime =[dictshop valueForKey:@"end_new"];
                strEndTime = [dictavailable valueForKey:@"end"];
                
                NSString *strshop = [NSString stringWithFormat:@"%@",[dictshop valueForKey:@"shop"]];
                
                NSString *shopname = [NSString stringWithFormat:@"Your order will be sent from %@",strshop];
                
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:shopname
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                //Add Buttons
                
                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action)
                                            {
                                                strtime = @"1";
                                                _viewhungry.hidden=YES;
                                                _viewredirect.hidden=YES;
                                                _viewpicker.hidden=NO;
                                                [_viewpicker bringSubviewToFront:self.view];

                                                _datepicker.backgroundColor = [UIColor whiteColor];
                                                [_datepicker setValue:[UIColor colorWithRed:119.0/255.0f green:189.0/255.0f blue:29.0/255.0f alpha:1] forKey:@"textColor"];
                                                
                                                [self funcTime1];
                                                
//                                                time =  [NSTimer scheduledTimerWithTimeInterval:60.0
//                                                                                         target:self
//                                                                                       selector:@selector(funcTime1)
//                                                                                       userInfo:nil
//                                                                                        repeats:YES];
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
        //});
    }
}





-(void)wsGetTimeforASAP
{
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSString *token = [defaults valueForKey:@"token"];
    NSString *strloc = [defaults valueForKey:@"location"];
    
    NSString *parameter=[NSString stringWithFormat:@"request=%@&area=%@&action=%@&key=%@&secret=%@&token=%@",@"allareas",strloc,@"getshop",str_key,str_secret,token];
    
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
        
        //dispatch_async(dispatch_get_main_queue(),^{
            
            if([errorCode isEqualToString:@"1"])
            {
                dictime = [dictionary valueForKey:@"data"];
                
                //strstart = [[arr objectAtIndex:0] valueForKey:@"start"];
                strstart = [dictime valueForKey:@"start_new"];
                
                //strend = [[arr objectAtIndex:0] valueForKey:@"end"];
                strend = [dictime valueForKey:@"end_new"];
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
        //});
    }
}




-(void)wsgetRating
{
    BaseViewController *base=[[BaseViewController alloc]init];
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSString *user_id = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"user_id"]];
    
    if ([user_id isEqualToString:@"(null)"])
    {
        user_id = @"";
    }
    
    else
    {
        user_id = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"user_id"]];
    }
    
    NSString *token = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"token"]];
    
    if ([token isEqualToString:@"(null)"])
    {
        token = @"";
    }
    
    else
    {
        token = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"token"]];
    }
    
    NSString *parameter=[NSString stringWithFormat:@"request=%@&action=%@&user_id=%@&key=%@&secret=%@&token=%@",@"ratings",@"view",user_id,str_key,str_secret,token];
    
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
                                  handler:^(UIAlertAction * action)
                                  {
                                    
                                  }];
        
        
        [alert addAction:yesButton];
      
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else
    {
        NSString *errorCode=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"code"]];
      
        //dispatch_async(dispatch_get_main_queue(),^{
        
        if([errorCode isEqualToString:@"1"])
        {
            NSMutableArray *arrrating = [[NSMutableArray alloc]init];
            arrrating = [dictionary valueForKey:@"data"];
            
            if (arrrating.count>0)
            {
                strOrderId = [[arrrating objectAtIndex:0]valueForKey:@"order_id"];
                
                self.viewpopLastorder.frame = CGRectMake(0, 0, screenWidth, screenHeight);
                _viewpopLastorder.hidden = NO;
            }
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
        //});
    }
}





- (void)wsgiverating
{
    BaseViewController *base=[[BaseViewController alloc]init];
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSString *user_id=[defaults valueForKey:@"user_id"];
    NSString *token = [defaults valueForKey:@"token"];
    
    NSString *parameter=[NSString stringWithFormat:@"request=%@&action=%@&user_id=%@&feedback=%@&stars=%@&order_id=%@&key=%@&secret=%@&token=%@",@"ratings",@"insert",user_id,_txtrateMessage.text,strrating,strOrderId,str_key,str_secret,token];
    
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
        
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else
    {
        NSString *errorCode=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"code"]];
    
        //dispatch_async(dispatch_get_main_queue(),^{
        
        if([errorCode isEqualToString:@"1"])
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:nil
                                         message:@"Thanks for your feedback."
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            //Add Buttons
            
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {
                                            _viewGiverating.hidden = YES;
                                            
                                            
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
    //});
  }
}




-(void)wsGetOfferImage
{
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"request=%@&language=%@&action=%@&key=%@&secret=%@",@"menu",@"en",@"autopromotion",str_key,str_secret];
    
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
        
        //dispatch_async(dispatch_get_main_queue(),^{
            
            if([errorCode isEqualToString:@"1"])
            {
                NSMutableArray *arroffers = [[NSMutableArray alloc]init];
                
                arroffers = [dictionary valueForKey:@"promotions"];
                
                if (arroffers.count > 0)
                {
                    //popup_image is for PORTRAIT Image
                    NSString *strimg = [NSString stringWithFormat:@"%@",[[arroffers objectAtIndex:0] valueForKey:@"popup_image"]];
                    
                    NSURL *url = [NSURL URLWithString:strimg];
                    
                    SDImageCache *cache = [SDImageCache sharedImageCache];
                    [cache clearMemory];
                    [cache clearDiskOnCompletion:nil];
                    [cache removeImageForKey:strimg fromDisk:YES withCompletion:nil];
                    
                    //NSData *data = [NSData dataWithContentsOfURL:url];
                    
                    [self.imgoffer sd_setImageWithURL:url
                                placeholderImage:[UIImage imageNamed:@"placeholderfood"] options:SDWebImageRefreshCached];
                    
                    //_imgoffer.image = [UIImage imageWithData:data];
                    
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    
                    NSString *firsttime = [defaults valueForKey:@"firsttime"];
                    
                    if ([firsttime isEqualToString:@"first"])
                    {
                        _viewoffer.hidden = YES;
                    }
                    
                    else
                    {
                        _viewoffer.hidden = NO;
                        [defaults setObject:@"first" forKey:@"firsttime"];
                        [defaults synchronize];
                    }
                }
                
                else
                {
                    
                }
            }
            
            else if ([errorCode isEqualToString:@"0"])
            {
//                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//
//                [defaults setObject:@"first" forKey:@"firsttime"];
//                [defaults synchronize];
                
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
        //});
    }
}



@end

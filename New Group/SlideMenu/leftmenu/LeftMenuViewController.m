//
//  MenuViewController.m
//  SlideMenu
//
//  Created by Aryan Gh on 4/24/13.
//  Copyright (c) 2013 Aryan Ghassemi. All rights reserved.
//

#import "LeftMenuViewController.h"
#import "SlideNavigationContorllerAnimatorFade.h"
#import "SlideNavigationContorllerAnimatorSlide.h"
#import "SlideNavigationContorllerAnimatorScale.h"
#import "SlideNavigationContorllerAnimatorScaleAndFade.h"
#import "SlideNavigationContorllerAnimatorSlideAndFade.h"
#import "LeftMenuItemListTableViewCell.h"
#import "LoViewController.h"
#import "AboutUsController.h"
#import "MyDetailController.h"
#import "HomeViewController.h"
#import "MenuViewController.h"
#import "FindRestaurantViewController.h"
#import "LoyalityProViewController.h"
#import "ContactusViewController.h"
#import "Leftmenu1TableViewCell.h"
#import "SignOutViewController.h"
#import "OffersViewController.h"
#import "MyAccountViewController.h"
#import "OrderHistoryController.h"
#import "AppDelegate.h"
#import "BaseViewController.h"
#import "CalenderViewController.h"
#import "SelectCountryToRestaurantViewController.h"

@implementation LeftMenuViewController
{
    NSArray * arrItemName;
    NSArray * arrItemName1;
    NSArray * arrItemName2;
    NSArray * imageitem;
    NSArray *imageitem2;
    NSString *loginStatus;
    NSArray *arrofshopbycat;
    NSArray *arrofshopbyoffers;
    NSArray *arrofstaticname;
    NSArray *arrlink;
    NSArray *arrofshopfrom;
    NSArray *arrImages;
    NSArray *arrSlideMenu;
    NSArray *arrLogin;
}



#pragma mark - UIViewController Methods -

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self.slideOutAnimationEnabled = YES;
	
	return [super initWithCoder:aDecoder];
}




- (void)viewDidLoad
{
	[super viewDidLoad];
    
    [self.MytableView setContentOffset:CGPointMake(0,0)];
    
    _imgprofile.layer.masksToBounds = YES;
    _imgprofile.layer.cornerRadius = _imgprofile.frame.size.width/2;
}




-(void)viewDidAppear:(BOOL)animated
{
    [self.MytableView setContentOffset:CGPointMake(0,0)];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
//    NSString *strimg = [NSString stringWithFormat:@"%@%@",str_global_domain_pic,[defaults valueForKey:@"profile_pic"]];
    
    NSString *strimg = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"profile_pic"]];
    
    NSURL *url = [NSURL URLWithString:strimg];
    
    [_imgprofile setImageWithURL:url placeholderImage:[UIImage imageNamed:@"ic_user"]];
    
    NSString *status=[defaults valueForKey:@"status"];
    
    if ([status isEqualToString:@"login"])
    {
        arrLogin=@[@"Home",@"ORDER NOW",@"Weekly Order",@"Offers",@"Order History",@"My Account",@"Loyalty Program",@"Find a Restaurant",@"Get in Touch",@"About Us",@"Follow us",@"Sign Out"];
    }
    
    else
    {
        arrSlideMenu=@[@"Home",@"ORDER NOW",@"Weekly Order",@"Offers",@"Order History",@"My Account",@"Loyalty Program",@"Find a Restaurant",@"Get in Touch",@"About Us",@"Follow us",@"Sign Out"];
    }
    
    
    [self.MytableView reloadData];
    
    _btnsignin.hidden = YES;
    
    NSString *fname = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"first_name"]];
    NSString *email=[defaults valueForKey:@"user_email"];
    
    if ([fname isEqualToString:@""]||[fname isEqualToString:@"(null)"])
    {
        _btnsignin.hidden = NO;
        self.lblname.text = @"";
        self.lblemail.text = @"";
    }
    
    else
    {
        NSArray *items = [fname componentsSeparatedByString:@" "];   //take the one array for split the string
        
        NSString *str1=[items objectAtIndex:0];   //shows Description
        
        if (str1 == nil)
        {
            _btnsignin.hidden = NO;
            self.lblname.text = @"";
            self.lblemail.text = @"";
        }
        
        else if ([str1 isEqualToString:@""])
        {
            _btnsignin.hidden = NO;
            self.lblname.text = @"";
            self.lblemail.text = @"";
        }
        
        else
        {
            self.lblname.text = str1;
            self.lblemail.text = email;
        }
    }
    
    
    if ([[UIScreen mainScreen] bounds].size.height == 480)
    {
        self.MytableView.frame = CGRectMake(self.MytableView.frame.origin.x, self.MytableView.frame.origin.y, self.MytableView.frame.size.width, 480);
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handle_data) name:@"handle_data" object:nil];
    
    [self.MytableView reloadData];
}




#pragma mark - UITableView Delegate & Datasrouce -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSString *status=[defaults valueForKey:@"status"];
    
    if ([status isEqualToString:@"login"])
    {
        return arrLogin.count;
    }
    
    else
    {
        return arrSlideMenu.count;
    }
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 10)
    {
        return 77.0f;
    }
    
    else
    {
        return 39.0f;
    }
}





- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *v = (UITableViewHeaderFooterView *)view;
    v.backgroundView.backgroundColor = [UIColor whiteColor];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 10)
    {
        Leftmenu1TableViewCell *cell2;
        
        NSArray *nib;
        
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        defaults=[NSUserDefaults standardUserDefaults];
        loginStatus=[defaults objectForKey:@"status"];
        
        cell2 = [self.MytableView dequeueReusableCellWithIdentifier:@"cell2"];
        
        nib = [[NSBundle mainBundle] loadNibNamed:@"Leftmenu1TableViewCell" owner:self options:nil];
        
        cell2 = [nib objectAtIndex:0];
        
        [cell2.btninsta addTarget:self action:@selector(btnopeninsta:) forControlEvents:UIControlEventTouchUpInside];
        
        cell2.btninsta.tag = indexPath.row;
        
        [cell2.btntwitter addTarget:self action:@selector(btnopentwitter:) forControlEvents:UIControlEventTouchUpInside];
        
        cell2.btninsta.tag = indexPath.row;
        
        [cell2.btnfb addTarget:self action:@selector(btnopenfb:) forControlEvents:UIControlEventTouchUpInside];
        
        cell2.btninsta.tag = indexPath.row;
        
        NSString *status=[defaults valueForKey:@"status"];
        
        if ([status isEqualToString:@"login"])
        {
            cell2.lblborder1.hidden=NO;
        }
        
        else
        {
            cell2.lblborder1.hidden=YES;
        }
        
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell2.preservesSuperviewLayoutMargins=NO;
        
        return cell2;
    }
    
    else
    {
        LeftMenuItemListTableViewCell *cell;
        
        NSArray *nib;
        
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        
        defaults=[NSUserDefaults standardUserDefaults];
        loginStatus=[defaults objectForKey:@"status"];
        
        cell = [self.MytableView dequeueReusableCellWithIdentifier:@"cell"];
        
        nib = [[NSBundle mainBundle] loadNibNamed:@"LeftMenuItemListTableViewCell" owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
        
        if (indexPath.row == 1)
        {
            cell.lblItemName.textColor = [UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1.0f];
        }
        
        else
        {
            cell.lblItemName.textColor = [UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:110.0/255.0 alpha:1.0f];
        }
        
        
        NSString *status=[defaults valueForKey:@"status"];
        
        if ([status isEqualToString:@"login"])
        {
            if (indexPath.row == 11)
            {
                cell.lblBorder.hidden=YES;
            }
            
            else
            {
                cell.lblBorder.hidden=NO;
            }
        }
        
        else
        {
            if (indexPath.row == 11)
            {
                cell.lblItemName.hidden = YES;
                cell.lblBorder.hidden = YES;
            }
            
            else
            {
                cell.lblBorder.hidden=NO;
                cell.lblItemName.hidden = NO;
            }
        }
        
        
        
        if ([status isEqualToString:@"login"])
        {
            cell.lblItemName.text=[arrLogin objectAtIndex:indexPath.row];
        }
        
        else
        {
            cell.lblItemName.text=[arrSlideMenu objectAtIndex:indexPath.row];
        }
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.preservesSuperviewLayoutMargins=NO;
        
        return cell;
    }
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *status=[defaults valueForKey:@"status"];
    
    if ([status isEqualToString:@"login"])
    {
        if (indexPath.row==0)
        {
            HomeViewController *obj=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:obj
                                                                     withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                             andCompletion:nil];
        }
        
        else if (indexPath.row==1)
        {
//            NSData *data =[NSData data];
//
//            [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"weeklyorderarray"];
//            [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"weeklyorderclicked"];
            
            HomeViewController *obj=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
            obj.str = @"order";
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:obj
                                                                     withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                             andCompletion:nil];
        }
        
        else if (indexPath.row==2)
        {
            CalenderViewController *obj=[[CalenderViewController alloc]initWithNibName:@"CalenderViewController" bundle:nil];
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:obj
                                                                     withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                             andCompletion:nil];
        }
        
        else if (indexPath.row==3)
        {
            OffersViewController *obj=[[OffersViewController alloc]initWithNibName:@"OffersViewController" bundle:nil];
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:obj
                                                                     withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                             andCompletion:nil];
        }
        
        else if (indexPath.row==4)
        {
            OrderHistoryController *obj=[[OrderHistoryController alloc]initWithNibName:@"OrderHistoryController" bundle:nil];
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:obj
                                                                                             withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                                                     andCompletion:nil];
        }
        
        else if (indexPath.row==5)
        {
            MyAccountViewController *obj=[[MyAccountViewController alloc]initWithNibName:@"MyAccountViewController" bundle:nil];
                        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                        [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:obj
                                                                                 withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                                         andCompletion:nil];
        }
        
        else if (indexPath.row==6)
        {
            LoyalityProViewController *obj=[[LoyalityProViewController alloc]initWithNibName:@"LoyalityProViewController" bundle:nil];
                self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:obj
                                                                                 withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                                         andCompletion:nil];
        }
        
        else if (indexPath.row==7)
        {
            SelectCountryToRestaurantViewController *obj=[[SelectCountryToRestaurantViewController alloc]initWithNibName:@"SelectCountryToRestaurantViewController" bundle:nil];
                self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:obj
                                                                                 withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                                         andCompletion:nil];
        }
        
        else if (indexPath.row==8)
        {
            ContactusViewController *obj=[[ContactusViewController alloc]initWithNibName:@"ContactusViewController" bundle:nil];
                self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:obj
                                                                                             withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                                                     andCompletion:nil];
        }
        
        else if (indexPath.row==9)
        {
            AboutUsController *obj=[[AboutUsController alloc]initWithNibName:@"AboutUsController" bundle:nil];
                self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:obj
                                                                                 withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                                         andCompletion:nil];
        }
        
        else if (indexPath.row==11)
        {
            SignOutViewController *obj=[[SignOutViewController alloc]initWithNibName:@"SignOutViewController" bundle:nil];
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
            
            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:obj
                                                                     withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                             andCompletion:nil];
        }
    }
    
    else
    {
        if (indexPath.row==0)
        {
            HomeViewController *obj=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:obj
                                                                     withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                             andCompletion:nil];
        }
        
        else if (indexPath.row==1)
        {
            MenuViewController *obj=[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:obj
                                                                     withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                             andCompletion:nil];
        }
        
        else if (indexPath.row==2)
        {
            LoViewController *obj=[[LoViewController alloc]initWithNibName:@"LoViewController" bundle:nil];
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:obj
                                                                     withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                             andCompletion:nil];
        }
        
        else if (indexPath.row==3)
        {
            LoViewController *obj=[[LoViewController alloc]initWithNibName:@"LoViewController" bundle:nil];
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
            [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:obj
                                                                     withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                             andCompletion:nil];
        }
        
        else if (indexPath.row==4)
        {
            LoViewController *obj=[[LoViewController alloc]initWithNibName:@"LoViewController" bundle:nil];
                self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:obj
                                                                                 withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                                         andCompletion:nil];
        }
        
        else if (indexPath.row==5)
        {
            LoViewController *obj=[[LoViewController alloc]initWithNibName:@"LoViewController" bundle:nil];
                self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:obj
                                                                                 withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                                         andCompletion:nil];
        }
        
        else if (indexPath.row==6)
        {
            LoViewController *obj=[[LoViewController alloc]initWithNibName:@"LoViewController" bundle:nil];
                self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:obj
                                                                                 withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                                         andCompletion:nil];
        }
        
        else if (indexPath.row==7)
        {
            SelectCountryToRestaurantViewController *obj=[[SelectCountryToRestaurantViewController alloc]initWithNibName:@"SelectCountryToRestaurantViewController" bundle:nil];
                self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:obj
                                                                                 withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                                         andCompletion:nil];
        }
        
        else if (indexPath.row==8)
        {
            ContactusViewController *obj=[[ContactusViewController alloc]initWithNibName:@"ContactusViewController" bundle:nil];
                self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:obj
                                                                                 withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                                         andCompletion:nil];
        }
        
        else if (indexPath.row==9)
        {
            AboutUsController *obj=[[AboutUsController alloc]initWithNibName:@"AboutUsController" bundle:nil];
                self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:obj
                                                                                 withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                                         andCompletion:nil];
        }
        
        else if (indexPath.row==11)
        {
            
        }
    }
}




-(IBAction)btnopeninsta:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.instagram.com/thekcallife/"] options:@{} completionHandler:nil];
}



-(IBAction)btnopentwitter:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/KcalWorld"] options:@{} completionHandler:nil];
}



-(IBAction)btnopenfb:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/kcallife/"] options:@{} completionHandler:nil];
}




- (IBAction)btnsignin:(id)sender
{
    LoViewController *obj=[[LoViewController alloc]initWithNibName:@"LoViewController" bundle:nil];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    
    [[SlideNavigationController sharedInstance] popToRootAndSwitchToViewController:obj
                                                             withSlideOutAnimation:self.slideOutAnimationEnabled
                                                                     andCompletion:nil];
}




-(void)handle_data
{
    [self.MytableView setContentOffset:CGPointMake(0,0)];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
//    NSString *strimg = [NSString stringWithFormat:@"%@%@",str_global_domain_pic,[defaults valueForKey:@"profile_pic"]];
    
    NSString *strimg = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"profile_pic"]];
    
    NSURL *url = [NSURL URLWithString:strimg];
    
    [_imgprofile setImageWithURL:url placeholderImage:[UIImage imageNamed:@"ic_user"]];
    
    NSString *status=[defaults valueForKey:@"status"];
    
    if ([status isEqualToString:@"login"])
    {
        arrLogin=@[@"Home",@"ORDER NOW",@"Weekly Order",@"Offers",@"Order History",@"My Account",@"Loyalty Program",@"Find a Restaurant",@"Get in Touch",@"About Us",@"Follow us",@"Sign Out"];
    }
    
    else
    {
        arrSlideMenu=@[@"Home",@"ORDER NOW",@"Weekly Order",@"Offers",@"Order History",@"My Account",@"Loyalty Program",@"Find a Restaurant",@"Get in Touch",@"About Us",@"Follow us",@"Sign Out"];
    }
    
    [self.MytableView reloadData];
    
    _btnsignin.hidden = YES;
    
    NSString *fname = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"first_name"]];
    NSString *email=[defaults valueForKey:@"user_email"];
    
    if ([fname isEqualToString:@""]||[fname isEqualToString:@"(null)"])
    {
        _btnsignin.hidden = NO;
        self.lblname.text = @"";
        self.lblemail.text = @"";
    }
    
    else
    {
        NSArray *items = [fname componentsSeparatedByString:@" "];   //take the one array for split the string
        
        NSString *str1=[items objectAtIndex:0];   //shows Description
        
        if (str1 == nil)
        {
            _btnsignin.hidden = NO;
            self.lblname.text = @"";
            self.lblemail.text = @"";
        }
        
        else if ([str1 isEqualToString:@""])
        {
            _btnsignin.hidden = NO;
            self.lblname.text = @"";
            self.lblemail.text = @"";
        }
        
        else
        {
            self.lblname.text = str1;
            self.lblemail.text = email;
        }
    }
    
    
    if ([[UIScreen mainScreen]bounds].size.height == 480)
    {
        self.MytableView.frame = CGRectMake(self.MytableView.frame.origin.x, self.MytableView.frame.origin.y, self.MytableView.frame.size.width, 480);
    }
    
    NSLog(@"notification is working >>>>>>>");
}




@end

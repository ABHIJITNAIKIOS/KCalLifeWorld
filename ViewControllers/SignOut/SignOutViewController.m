//
//  SignOutViewController.m
//  KCal
//
//  Created by Pipl-02 on 29/06/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "SignOutViewController.h"
#import "LoViewController.h"
#import "HomeViewController.h"
#import "SignOut2ViewController.h"

@interface SignOutViewController ()

@end

@implementation SignOutViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame = CGRectMake(12, 15, 18, 18);
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"white_left"] forState:UIControlStateNormal];
    leftbtn.tag=205;
    
    [leftbtn addTarget:self action:@selector(back)
      forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:leftbtn];
    
    for (UIButton *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 134)
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
    
    self.title =@"Sign Out";
    
    self.navigationItem.hidesBackButton=YES;
}





-(void)back
{
    HomeViewController *obj=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.navigationController pushViewController:obj animated:YES];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}




- (IBAction)btnyes:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *data =[NSData data];
    
    [defaults setObject:@"" forKey:@"user_id"];
    [defaults setObject:@"" forKey:@"first_name"];
    [defaults setObject:@"" forKey:@"last_name"];
    [defaults setObject:@"" forKey:@"user_name"];
    [defaults setObject:@"" forKey:@"user_email"];
    [defaults setObject:@"" forKey:@"token"];
    [defaults setObject:@"" forKey:@"profile_pic"];
    [defaults setObject:data forKey:@"arrayoffer"];
    [defaults setObject:data forKey:@"arrayaddtocart"];
    [defaults setObject:data forKey:@"posttotalorder"];
    [defaults setObject:data forKey:@"weeklyorderarray"];
    [defaults setObject:@"no" forKey:@"weeklyorderclicked"];
    [defaults setObject:@"" forKey:@"status"];
    [defaults setObject:@"" forKey:@"firsttime"];
    [defaults setObject:@"" forKey:@"shopId"];
    [defaults setObject:@"" forKey:@"tryAgainPayment"];
    
    [defaults synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"handle_data" object:self];
    
    SignOut2ViewController *obj=[[SignOut2ViewController alloc]initWithNibName:@"SignOut2ViewController" bundle:nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.navigationController pushViewController:obj animated:YES];
}




- (IBAction)btnno:(id)sender
{
    HomeViewController *obj=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    
    [self.navigationController pushViewController:obj animated:YES];
}




@end

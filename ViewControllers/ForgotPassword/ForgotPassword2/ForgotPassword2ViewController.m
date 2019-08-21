//
//  ForgotPassword2ViewController.m
//  KCal
//
//  Created by Pipl-01 on 28/06/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "ForgotPassword2ViewController.h"
#import "LoViewController.h"

@interface ForgotPassword2ViewController ()

@end

@implementation ForgotPassword2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
        
        if (view.tag == 205)
        {
            [view removeFromSuperview];
        }
    }
    
    self.title = @"Forgot Password";
    
    self.navigationItem.hidesBackButton = YES;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}





- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}




- (IBAction)btnsignin:(id)sender
{
    LoViewController *obj=[[LoViewController alloc]initWithNibName:@"LoViewController" bundle:nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.navigationController pushViewController:obj animated:YES];
}



@end

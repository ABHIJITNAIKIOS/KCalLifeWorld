//
//  SignOut2ViewController.m
//  KCal
//
//  Created by Pipl-02 on 03/07/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "SignOut2ViewController.h"
#import "LoViewController.h"

@interface SignOut2ViewController ()

@end

@implementation SignOut2ViewController

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
    
    self.title =@"Sign Out";
    
    self.navigationItem.hidesBackButton=YES;
    
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

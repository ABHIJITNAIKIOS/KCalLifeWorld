//
//  AboutUsController.m
//  KCal
//
//  Created by Pipl-10 on 23/02/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "AboutUsController.h"
#import "AboutUsController.h"
#import "BaseViewController.h"
#import "AppDelegate.h"
#import "UIImageView+AFNetworking.h"
#import "SlideNavigationController.h"
#import "GiFHUD.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface AboutUsController ()

@end

@implementation AboutUsController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"About Us";
    
    [GiFHUD setGifWithImageName:@"Spinner3.gif"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"handle_data" object:self];
}




-(void)viewDidAppear:(BOOL)animated
{
    [GiFHUD showWithOverlay];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self wsAboutus];
    });
    
    for (UIImageView *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 111)
        {
            [view removeFromSuperview];
        }
    }
    
    for (UIButton *view in self.navigationController.navigationBar.subviews)
    {
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





- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)btnBack:(id)sender
{
    HomeViewController *obj=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.navigationController pushViewController:obj animated:YES];
}




- (IBAction)btnKal_Life:(id)sender
{
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:@"https://kcallife.com/?utm_source=Kcal%20Life%20App&utm_medium=Link&utm_campaign=App%20traffic"];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Opened url");
        }
    }];
}



- (IBAction)btnKal_Extra:(id)sender
{
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:@"https://kcalextra.com/?utm_source=Kcal%20Life%20App&utm_medium=Link&utm_campaign=App%20traffic"];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Opened url");
        }
    }];
}




- (IBAction)btnKal_fuelUP:(id)sender
{
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:@"https://fueluplife.com/?utm_source=Kcal%20Life%20App&utm_medium=Link&utm_campaign=App%20traffic"];
    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"Opened url");
        }
    }];
}




//- (IBAction)btnKalGourmet:(id)sender
//{
//    UIApplication *application = [UIApplication sharedApplication];
//    NSURL *URL = [NSURL URLWithString:@"https://gourmetbykcal.com/"];
//    [application openURL:URL options:@{} completionHandler:^(BOOL success) {
//        if (success) {
//            NSLog(@"Opened url");
//        }
//    }];
//}




#pragma mark <--Web Services-->


-(void)wsAboutus
{
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"request=%@&page=%@&key=%@&secret=%@",@"pages",@"aboutus",str_key,str_secret];
    
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
                NSArray *arrAboutus=[dictionary valueForKey:@"page"];
                
                self.lblaboutusContent.text=[arrAboutus valueForKey:@"text"];
                
                NSArray *arrImage=[arrAboutus valueForKey:@"images"];
                
                NSString *strimg =[NSString stringWithFormat:@"%@",[arrImage  objectAtIndex:0]];
                
                NSURL *url =[NSURL URLWithString:strimg];
                
                SDImageCache *cache = [SDImageCache sharedImageCache];
                [cache clearMemory];
                [cache clearDiskOnCompletion:nil];
                [cache removeImageForKey:strimg fromDisk:YES withCompletion:nil];
                
                [self.imgAbout sd_setImageWithURL:url
                            placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRefreshCached];
                
                //[self.imgAbout setImageWithURL:url placeholderImage:[UIImage imageNamed:@"user.png"]];
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

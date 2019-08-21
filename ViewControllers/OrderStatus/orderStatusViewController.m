//
//  orderStatusViewController.m
//  KCal
//
//  Created by Pipl014 on 02/08/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//


#import "orderStatusViewController.h"
#import "FLAnimatedImage.h"

@interface orderStatusViewController ()

@end

@implementation orderStatusViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *url1 = [[NSBundle mainBundle] URLForResource:@"App_DRIVER2" withExtension:@"gif"];
    
    NSData *data1 = [NSData dataWithContentsOfURL:url1];
    FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:data1];
    self.imggif.animatedImage = animatedImage1;
    
    self.title =@"Order Status";
    
    self.navigationItem.hidesBackButton = YES;
    
    self.lblorderno.text = [NSString stringWithFormat:@"Order #%@",_strorder_id];
    
    NSMutableDictionary *dictdata = [_dictorder valueForKey:@"data"];
    
    NSMutableArray *arrdays = [dictdata valueForKey:@"days"];
    
    if (arrdays.count > 1)
    {
//        self.lblmessage.text = @"Your order have been scheduled. Check your email for confirmation.";
        
        self.lblmessage.text = @"You're all set, order is in! Check your email for the details and enjoy.";
    }
    
    else
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *strdeliverytime = [defaults valueForKey:@"delivery_time"];
        
        if ([strdeliverytime isEqualToString:@"ASAP"] || [strdeliverytime isEqualToString:@"45 mins"] || [strdeliverytime isEqualToString:@"60 mins"])
        {
            self.lblmessage.text = @"Your order will be with you in no thyme!";
        }
        
        else
        {
//            self.lblmessage.text = @"Your order have been scheduled. Check your email for confirmation.";
            
            self.lblmessage.text = @"You're all set, order is in! Check your email for the details and enjoy.";
        }
    }
    
    
    
    for (UIButton *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 229)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 227)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 230)
        {
            [view removeFromSuperview];
        }
    }
}




- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}




@end

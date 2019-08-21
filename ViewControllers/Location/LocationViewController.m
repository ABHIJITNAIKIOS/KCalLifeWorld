//
//  LocationViewController.m
//  KCal
//
//  Created by Apple on 06/03/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "LocationViewController.h"
#import "BaseViewController.h"
#import "AppDelegate.h"
#import "MenuViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface LocationViewController ()
{
    NSString *lat;
    NSString *lang;
    NSString *map_link;
}

@end

@implementation LocationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *strCityname = [NSString stringWithFormat:@"%@ %@",[_dictResInfo valueForKey:@"name"],@"Locations"];
    
    strCityname = [strCityname stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    self.title= strCityname;
    
    NSLog(@"%@",_dictResInfo);
    
    self.navigationItem.hidesBackButton = YES;
}




-(void)viewDidAppear:(BOOL)animated
{
    self.lblAddress.text = [NSString stringWithFormat:@"%@",[_dictResInfo valueForKey:@"address"]];
    self.lblOpening.text = [NSString stringWithFormat:@"%@",[_dictResInfo valueForKey:@"opening_hours"]];
    NSString * strphone = [NSString stringWithFormat:@"%@",[_dictResInfo valueForKey:@"phone"]];
    lat = [NSString stringWithFormat:@"%@",[_dictResInfo valueForKey:@"latitude"]];
    lang = [NSString stringWithFormat:@"%@",[_dictResInfo valueForKey:@"longitude"]];
    map_link = [NSString stringWithFormat:@"%@",[_dictResInfo valueForKey:@"map_link"]];
    
    if ([strphone isEqualToString:@""]||[strphone isEqualToString:@"<null>"])
    {
        
    }
    
    else
    {
        _lblphoneNum.text = strphone;
    }
    
    NSString *strimg = [NSString stringWithFormat:@"%@",[_dictResInfo valueForKey:@"image"]];
    if ([strimg isEqualToString:@""]||[strimg isEqualToString:@"<null>"])
    {
        
    }
    
    else
    {
        NSURL *url = [NSURL URLWithString:strimg];
        
        SDImageCache *cache = [SDImageCache sharedImageCache];
        [cache clearMemory];
        [cache clearDiskOnCompletion:nil];
        [cache removeImageForKey:strimg fromDisk:YES withCompletion:nil];
        
        [_imgOutlet sd_setImageWithURL:url
                    placeholderImage:[UIImage imageNamed:@"placeholderfood"] options:SDWebImageRefreshCached];
        
        //[_imgOutlet setImageWithURL:url placeholderImage:[UIImage imageNamed:@"office"]];
    }
}





- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}




- (IBAction)btnCall:(id)sender
{
    NSString *number=[NSString stringWithFormat:@"tel://%@",[_dictResInfo valueForKey:@"phone"]];
    
    if ([number isEqualToString:@"tel://"])
    {
        
    }
    
    else
    {
        NSString *number1= [number stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSURL *url = [NSURL URLWithString:number1];
        [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
    }
}




- (IBAction)btnviewlocation:(id)sender
{
    NSString *strlink = map_link;
    
    strlink =[strlink stringByReplacingOccurrencesOfString:@"www.google" withString:@"maps.google"];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strlink] options:@{} completionHandler:nil];
}




@end

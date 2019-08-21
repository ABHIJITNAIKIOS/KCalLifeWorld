//
//  SplashScreenViewController.m
//  KCal
//
//  Created by Pipl-06 on 14/01/19.
//  Copyright © 2019 Panaceatek. All rights reserved.
//

#import "SplashScreenViewController.h"
#import "HomeViewController.h"

@interface SplashScreenViewController ()
{
    NSURL *url;
    NSTimer *time;
}

@end

@implementation SplashScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationController.navigationBarHidden = YES;
}




-(void)viewWillAppear:(BOOL)animated
{
    url = [[NSBundle mainBundle] URLForResource:@"Vegetables" withExtension:@"gif"];
    
    NSData *data1 = [NSData dataWithContentsOfURL:url];
    FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:data1];
    self.imgsplash.animatedImage = animatedImage1;
    
    time =  [NSTimer scheduledTimerWithTimeInterval:1.5
                                             target:self
                                           selector:@selector(funcTime1)
                                           userInfo:nil
                                            repeats:NO];
}




-(void)funcTime1
{
    [time invalidate];
    time = nil;
    
    HomeViewController *obj=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.navigationController pushViewController:obj animated:NO];
}



-(void)viewDidDisappear:(BOOL)animated
{
    [time invalidate];
    time = nil;
}




@end

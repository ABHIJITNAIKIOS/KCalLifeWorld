//
//  AppDelegate.m
//  KCal
//
//  Created by Apple on 22/02/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "AppDelegate.h"
#import "LoViewController.h"
#import "LeftMenuViewController.h"
#import "OrderHistoryController.h"
#import "WeeklyViewCart.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
@import VisaCheckoutSDK;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [VisaCheckoutSDK configure];
    
    [Fabric with:@[[Crashlytics class]]];
    
//    [FIRApp configure];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; //whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    
    if(IS_OS_8_OR_LATER)
    {
        [locationManager requestWhenInUseAuthorization]; // Add This Line
    }
    
    [locationManager startUpdatingLocation];
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    
//    _home=[[HomeViewController alloc] initWithNibName:@"HomeViewController" bundle:nil];
    
    _splash=[[SplashScreenViewController alloc] initWithNibName:@"SplashScreenViewController" bundle:nil];
    self.navigationController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationController.navigationItem.backBarButtonItem.style target:nil action:nil];
    _navigationController=[[SlideNavigationController alloc]initWithRootViewController:_splash];
    
    
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor whiteColor],NSForegroundColorAttributeName, [UIFont fontWithName:@"AvenirLTStd-Medium" size:13.0], NSFontAttributeName,nil];
    
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    
    [_navigationController.navigationBar setTranslucent:NO];
    
    
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:71/255.0f green:118/255.0f blue:59/255.0f alpha:1]];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init]
                                      forBarPosition:UIBarPositionAny
                                          barMetrics:UIBarMetricsDefault];
    
    _button  = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, 35)];
    
    _button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 2, 10);
    
    [_button setImage:[UIImage imageNamed:@"Side_tab"] forState:UIControlStateNormal];
    [_button addTarget:[SlideNavigationController sharedInstance] action:@selector(toggleLeftMenu) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_button];
    
    LeftMenuViewController *leftmenu=[[LeftMenuViewController alloc]initWithNibName:@"LeftMenuViewController" bundle:nil];
    
    [SlideNavigationController sharedInstance].leftMenu=leftmenu;
    [SlideNavigationController sharedInstance].leftBarButtonItem = rightBarButtonItem;
    
    
    [self.window setRootViewController:_navigationController];
    
    [self.window setBackgroundColor:[UIColor whiteColor]];
    [self.window makeKeyAndVisible];
    
    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:@"" forKey:@"firsttime"];
    
    NSLog(@"applicationWillResignActive");
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    NSLog(@"applicationDidEnterBackground");
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:@"first" forKey:@"firsttime"];
    
    NSLog(@"applicationWillEnterForeground");
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    NSLog(@"active");
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:@"" forKey:@"firsttime"];
    
    NSLog(@"Application Terminate");
}



@end

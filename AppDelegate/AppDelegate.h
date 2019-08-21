//
//  AppDelegate.h
//  KCal
//
//  Created by Apple on 22/02/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"
#import "LoViewController.h"
#import "HomeViewController.h"
#import "MenuViewController.h"
#import "SplashScreenViewController.h"
#import <CoreLocation/CoreLocation.h>

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)


//#define str_global_domain @"http://182.72.79.154/p1137/api/v1/"
//#define str_global_domain_pic @"http://182.72.79.154/p1137/img/app/profile/"
//#define str_key @"wg4THdWu2nHv1B7YNgLI"
//#define str_secret @"fa003e1fd6a896113"



//#define str_global_domain @"http://52.89.133.113/p1137/api/v1/"
//#define str_global_domain_pic @"http://52.89.133.113/p1137/img/app/profile/"
//#define str_key @"wg4THdWu2nHv1B7YNgLI"
//#define str_secret @"fa003e1fd6a896113"



//#define str_global_domain @"http://34.215.202.119/p1137/api/v1/"
//#define str_global_domain_pic @"http://34.215.202.119/p1137/img/app/profile/"
//#define str_key @"wg4THdWu2nHv1B7YNgLI"
//#define str_secret @"fa003e1fd6a896113"



#define str_global_domain @"https://devp.kcallife.com/api/v2/"
#define str_global_domain_pic @"https://devp.kcallife.com/img/app/v2/profile/"
#define str_key @"EQ7ZDS5Vi5sHi5l6VBsb7CVc"
#define str_secret @"cm9BOdjmNNeksEfIHPOtIXfz"

//#define str_key @"qScbfkrYTMmM8liBxJ7LpGKY"
//#define str_secret @"L1JdMhtfchtsX5vK1bRWZMjD"


@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navigationController;
@property (nonatomic, strong) LoViewController *login;
@property (nonatomic, strong) HomeViewController *home;
@property (nonatomic, strong) SplashScreenViewController *splash;
@property (nonatomic, strong) MenuViewController *menu;
@property (nonatomic, strong) UIButton *button;


@end

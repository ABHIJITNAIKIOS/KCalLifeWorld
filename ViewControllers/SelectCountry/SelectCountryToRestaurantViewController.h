//
//  SelectCountryToRestaurantViewController.h
//  KCal
//
//  Created by Pipl014 on 24/07/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface SelectCountryToRestaurantViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>
{
    CLLocationManager *clLocationObj;
    CLLocationManager *locationManager;
    CLLocationCoordinate2D Curerentcoordinate;
    double latitude;
    double longitude;
}

@property (weak, nonatomic) IBOutlet UITableView *tableview1;

@property (weak, nonatomic) IBOutlet UIButton *btnFindlocation;



@end

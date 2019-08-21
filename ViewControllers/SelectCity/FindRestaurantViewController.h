//
//  FindRestaurantViewController.h
//  KCal
//
//  Created by Apple on 28/02/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

@interface FindRestaurantViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableview1;

@property (weak, nonatomic) IBOutlet UIButton *btnFindlocation;

@property (strong, nonatomic) NSString*getname;


@end

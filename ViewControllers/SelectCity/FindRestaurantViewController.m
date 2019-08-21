//
//  FindRestaurantViewController.m
//  KCal
//
//  Created by Apple on 28/02/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "FindRestaurantViewController.h"
#import "FindTableViewCell.h"
#import "FindRestaurantViewController.h"
#import "SelectAreaViewController.h"
#import "BaseViewController.h"
#import "AppDelegate.h"
#import "GiFHUD.h"

@interface FindRestaurantViewController ()
{
    NSMutableArray *arrCity,*arrImages;
    NSArray *arrResto;
    CLLocationManager *clLocationObj;
    CLLocationManager *locationManager;
    CLLocationCoordinate2D Curerentcoordinate;
    double latitude;
    double longitude;
}

@end

@implementation FindRestaurantViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"UAE Locations";
    
    [self.tableview1 reloadData];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone; //whenever we move
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    
    if(IS_OS_8_OR_LATER)
    {
        [locationManager requestWhenInUseAuthorization]; // Add This Line
    }
    
    [locationManager startUpdatingLocation];
    latitude = locationManager.location.coordinate.latitude;
    longitude = locationManager.location.coordinate.longitude;
    
    [GiFHUD setGifWithImageName:@"Spinner3.gif"];
}




-(void)viewDidAppear:(BOOL)animated
{
    [GiFHUD showWithOverlay];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self wsCity];
    });
    
    for (UIImageView *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 111)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 222)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 120)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 134)
        {
            [view removeFromSuperview];
        }
    }
}



- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}




#pragma  mark table view delegate-->



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrCity.count;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib;
    NSString *tableIdentifier = @"Cell";
    
    FindTableViewCell *cell = (FindTableViewCell*)[self.tableview1 dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil)
    {
        nib = [[NSBundle mainBundle] loadNibNamed:@"FindTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSString *strCityname = [NSString stringWithFormat:@"%@",[[arrCity objectAtIndex:indexPath.row] valueForKey:@"name"]];
    
    strCityname = [strCityname stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    
    cell.lblName1.text = strCityname;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectAreaViewController *obj=[[SelectAreaViewController alloc]initWithNibName:@"SelectAreaViewController" bundle:nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    NSMutableDictionary *nsdata1 = [arrCity objectAtIndex:indexPath.row];
    obj.dictarea = nsdata1;
    [self.navigationController pushViewController:obj animated:YES];
}




- (IBAction)btnfindlocation:(id)sender
{
    [GiFHUD showWithOverlay];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self wsNearestResto];
    });
}




#pragma mark <--Web Services-->

-(void)wsCity
{
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"request=%@&language=%@&country=%@&key=%@&secret=%@",@"branches",@"en",_getname,str_key,str_secret];
    
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
    }
    
    else
    {
        NSString *errorCode=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"code"]];
      //  NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            
            if([errorCode isEqualToString:@"1"])
            {
                arrCity   = [dictionary objectForKey:@"response"];
                
                //NSString *cityname = [[arrCity objectAtIndex:0] valueForKey:@"name"];
              
              
             //   NSArray *arrCit   =[dictionary objectForKey:@"response"];
                
                // NSArray *arrTemp=[arrWWw objectAtIndex:0];
                
                //                for (int i=0; i<arrCat.count; i++)
                //                {
                //                    if ([[[arrCat objectAtIndex:i]valueForKey:@"categoryID"] isEqualToString:catid])
                //                    {
                //                         arrProducts =[arrCat objectAtIndex:i];
                //                    }
                //                }
                //               NSArray *arrTemp=[arrCat objectAtIndex:0];
                //
                //                 arrProducts=[arrTemp valueForKey:@"items"];
                
               [self.tableview1 reloadData];
            }
            
            else if ([errorCode isEqualToString:@"0"])
            {
                NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:message
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
            }
            else if ([errorCode isEqualToString:@"5"])
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:@""
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
            }
            
            else
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:@"Something went wrong. Please try again later."
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
            }
        });
    }
}




-(void)wsNearestResto
{
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"request=%@&action=%@&latitude=%f&longitude=%f&key=%@&secret=%@",@"client",@"location",latitude,longitude,str_key,str_secret];
    
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
    }
    
    else
    {
        NSString *errorCode=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"code"]];
        //  NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            
            if([errorCode isEqualToString:@"1"])
            {
                arrResto=[dictionary valueForKey:@"data"];
                
                NSString *lat = [[arrResto objectAtIndex:0] valueForKey:@"latitude"];
                NSString *lang = [[arrResto objectAtIndex:0] valueForKey:@"longitude"];
                
                NSString *strmap = [NSString stringWithFormat:@"comgooglemaps://?center=%@,%@&zoom=14&views=traffic&q=%@,%@",lat,lang, lat,lang];
                
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strmap] options:@{} completionHandler:nil];
            }
            
            else if ([errorCode isEqualToString:@"0"])
            {
                NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:message
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
            }
            
            else if ([errorCode isEqualToString:@"5"])
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:@""
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
            }
            
            else
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:@"Something went wrong. Please try again later."
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
            }
        });
    }
}





@end

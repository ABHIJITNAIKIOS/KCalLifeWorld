//
//  DeliverylocationController.m
//  KCal
//
//  Created by Pipl-10 on 20/07/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "DeliverylocationController.h"
#import "deliveryaddressCell.h"
#import "BaseViewController.h"
#import "AppDelegate.h"
#import "AddDeliveryaddressController.h"
#import "MyAccountViewController.h"

@interface DeliverylocationController ()
{
    deliveryaddressCell  *cell;
    NSMutableArray *arrdata;
    NSMutableArray *arrdata1;
    NSDictionary *dicttemp;
}

@end

@implementation DeliverylocationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"My Delivery Locations";
    self.navigationItem.hidesBackButton = YES;
}




-(void)viewDidAppear:(BOOL)animated
{
    [self wsGetAddress];
    
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame = CGRectMake(12, 15, 18, 18);
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"white_left"] forState:UIControlStateNormal];
    leftbtn.tag=221;
    
    [leftbtn addTarget:self action:@selector(back)
      forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:leftbtn];
    
    for (UIButton *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 401)
        {
            [view removeFromSuperview];
        }
    }
}




-(void)back
{
    MyAccountViewController *obj=[[MyAccountViewController alloc]initWithNibName:@"MyAccountViewController" bundle:nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.navigationController pushViewController:obj animated:YES];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}




#pragma  mark <--table view delegate-->

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return arrdata.count;
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib;
    
    cell = (deliveryaddressCell *)[self.tbldata dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil)
    {
        nib = [[NSBundle mainBundle] loadNibNamed:@"deliveryaddressCell" owner:self options:nil];
    }
    
    cell = [nib objectAtIndex:0];
    
   
    NSString * temptitle = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"title"]];
    
    if([temptitle isEqualToString:@"<null>"])
    {
        temptitle =@"";
        
        cell.lbltitle.text = temptitle;
    }
    
    else
    {
         cell.lbltitle.text = temptitle;
    }
    
    
    NSString *street = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"street"] ];
    NSString *sublocation = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"sublocation"] ];
    NSString *location = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"location"] ];
    NSString *city = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"city"] ];
    
    NSString *address = @"";
    
    if ([street isEqualToString:@""] && [sublocation isEqualToString:@""] && [location isEqualToString:@""] && [city isEqualToString:@""])
    {
        address = @"";
    }
    
    else if ([street isEqualToString:@""])
    {
        address =[NSString stringWithFormat:@"%@, %@, %@",sublocation,location,city];
    }
    
    else if ([sublocation isEqualToString:@""])
    {
        address =[NSString stringWithFormat:@"%@, %@, %@",street,location,city];
    }
    
    else if ([location isEqualToString:@""])
    {
        address =[NSString stringWithFormat:@"%@, %@, %@",street,sublocation,city];
    }
    
    else if ([city isEqualToString:@""])
    {
        address =[NSString stringWithFormat:@"%@, %@, %@",street,sublocation,location];
    }
    
    else
    {
        address =[NSString stringWithFormat:@"%@, %@, %@, %@",street,sublocation,location,city];
    }
    
    
    cell.lbladdress.text = address;
    //cell.btnedit.tag = indexPath.row;
    cell.btneditbig.tag = indexPath.row;
    
    [cell.btneditbig addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    return cell;
}




-(void)edit:(UIButton *)sender
{
    AddDeliveryaddressController *obj=[[AddDeliveryaddressController alloc]initWithNibName:@"AddDeliveryaddressController" bundle:nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    
    dicttemp = [arrdata objectAtIndex:sender.tag];
    obj.fromDeliveryLocation = @"yes";
    obj.temparray = dicttemp;
    [self.navigationController pushViewController:obj animated:YES];
}




- (IBAction)btnaddAddress:(id)sender
{
    AddDeliveryaddressController *obj=[[AddDeliveryaddressController alloc]initWithNibName:@"AddDeliveryaddressController" bundle:nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    
    obj.flag = @"2";
    obj.strfromsimple = @"yes";
    [self.navigationController pushViewController:obj animated:YES];
    
    //    _viewaddress.hidden=NO;
    //    [self.view addSubview:self.viewaddress];
    //    self.viewaddress.frame = CGRectMake(0, 0, screenWidth, screenHeight);
}




#pragma mark <---Webservices--->

-(void)wsGetAddress
{
    NSUserDefaults  *defaults=[NSUserDefaults standardUserDefaults];
    NSString *user_id=[defaults valueForKey:@"user_id"];
    NSString *token = [defaults valueForKey:@"token"];
    BaseViewController *base=[[BaseViewController alloc]init];
    NSString *strWebserviceCompleteURL = [NSString stringWithFormat:@"%@",str_global_domain];
    [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"isgetmethod"];
    
    NSString *parameter=[NSString stringWithFormat:@"user_id=%@&request=%@&action=%@&key=%@&secret=%@&token=%@",user_id,@"addresses",@"view",str_key,str_secret,token];
    
    NSDictionary *dictionary =[[NSMutableDictionary alloc]init];
    
    dictionary=[base WebParsingMethod:strWebserviceCompleteURL :parameter];
    
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
                                    handler:^(UIAlertAction * action)
                                    {
                                        
                                    }];
        
        //Add your buttons to alert controller
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else
    {
        NSString *errorCode=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"code"]];
        NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            if([errorCode isEqualToString:@"1"])
            {
                arrdata = [[NSMutableArray alloc]init];
                arrdata1 = [[NSMutableArray alloc]init];
                
                arrdata1 = [[dictionary valueForKey:@"data"] mutableCopy];
                
                NSMutableDictionary *work = [[NSMutableDictionary alloc]init];
                
                [work setObject:@"" forKey:@"address_title"];
                [work setObject:@"" forKey:@"city"];
                [work setObject:@"" forKey:@"delivery_time"];
                [work setObject:@"" forKey:@"id"];
                [work setObject:@"" forKey:@"landmark"];
                [work setObject:@"" forKey:@"lat"];
                [work setObject:@"" forKey:@"lng"];
                [work setObject:@"" forKey:@"location"];
                [work setObject:@"" forKey:@"min_amount"];
                [work setObject:@"" forKey:@"number"];
                [work setObject:@"" forKey:@"shop_alias"];
                [work setObject:@"" forKey:@"street"];
                [work setObject:@"" forKey:@"sublocation"];
                [work setObject:@"Work" forKey:@"title"];
                [work setObject:@"1" forKey:@"type"];
                [work setObject:user_id forKey:@"user_id"];
                
                [arrdata addObject:work];
                
                NSMutableDictionary *home = [[NSMutableDictionary alloc]init];

                [home setObject:@"" forKey:@"address_title"];
                [home setObject:@"" forKey:@"city"];
                [home setObject:@"" forKey:@"delivery_time"];
                [home setObject:@"" forKey:@"id"];
                [home setObject:@"" forKey:@"landmark"];
                [home setObject:@"" forKey:@"lat"];
                [home setObject:@"" forKey:@"lng"];
                [home setObject:@"" forKey:@"location"];
                [home setObject:@"" forKey:@"min_amount"];
                [home setObject:@"" forKey:@"number"];
                [home setObject:@"" forKey:@"shop_alias"];
                [home setObject:@"" forKey:@"street"];
                [home setObject:@"" forKey:@"sublocation"];
                [home setObject:@"Home" forKey:@"title"];
                [home setObject:@"0" forKey:@"type"];
                [home setObject:user_id forKey:@"user_id"];
                
                [arrdata addObject:home];
                
//                for (int i =0; i<arrdata1.count; i++)
//                {
//                    NSString *temptitle = [NSString stringWithFormat:@"%@",[[arrdata1 objectAtIndex:i] valueForKey:@"title"]];
//                    
//                    if ([temptitle isEqualToString:@"Home"])
//                    {
//                        NSString *templocation = [NSString stringWithFormat:@"%@",[[arrdata1 objectAtIndex:i] valueForKey:@"location"]];
//                        
//                        if ([templocation isEqualToString:@""])
//                        {
// 
//                        }
//                        
//                        else
//                        {
//                            [arrdata addObject:home];
//                            // [arrdata replaceObjectAtIndex:0 withObject:[arrdata1 objectAtIndex:i]];
//                        }
//                    }
//                }
                
                for (int i =0; i<arrdata1.count; i++)
                {
                    NSString *temptitle = [NSString stringWithFormat:@"%@",[[arrdata1 objectAtIndex:i] valueForKey:@"title"]];
                    
                    if ([temptitle isEqualToString:@"Work"])
                    {
                        [arrdata replaceObjectAtIndex:0 withObject:[arrdata1 objectAtIndex:i]];
                    }
                    
                    else if ([temptitle isEqualToString:@"Home"])
                    {
                        [arrdata replaceObjectAtIndex:1 withObject:[arrdata1 objectAtIndex:i]];
                    }
                    
                    else
                    {
                        [arrdata addObject:[arrdata1 objectAtIndex:i]];
                    }
                }
                
                [self.tbldata reloadData];
                NSLog(@"arrdata=%@",arrdata);
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

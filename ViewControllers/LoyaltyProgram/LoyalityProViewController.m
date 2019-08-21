//
//  LoyalityProViewController.m
//  KCal
//
//  Created by Pipl-09 on 05/03/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "LoyalityProViewController.h"
#import "SlideNavigationController.h"
#import "MealListTableViewCell.h"
#import "GiFHUD.h"
#import "TableViewCell1.h"
#import "BaseViewController.h"
#import "AppDelegate.h"

@interface LoyalityProViewController ()
{
    NSArray *arrorderList;
    NSMutableArray *arrnew;
    CGFloat screenWidth;
    CGFloat screenHeight;
    CGFloat screenX;
    CGFloat screenY;
}

@end

@implementation LoyalityProViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title=@"Loyalty Program";
    self.viewpopup.hidden = YES;
    
    screenWidth = [UIScreen mainScreen].bounds.size.width;
    screenHeight = [UIScreen mainScreen].bounds.size.height;
    screenX = [UIScreen mainScreen].bounds.origin.x;
    screenY = [UIScreen mainScreen].bounds.origin.y;
    
    arrorderList = [[NSArray alloc] init];
    arrnew = [[NSMutableArray alloc] init];
    [GiFHUD setGifWithImageName:@"Spinner3.gif"];
}



-(void)viewDidAppear:(BOOL)animated
{
    [GiFHUD showWithOverlay];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self wsLocalityProgramm];
    });
    
    for (UIButton *view in self.navigationController.navigationBar.subviews)
    {
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




- (IBAction)btntermsclicked:(id)sender
{
    self.viewpopup.hidden = NO;
    
    _viewpopup.frame=CGRectMake(0, 0, screenWidth, screenHeight);
    
    [self.view addSubview:_viewpopup];
}




- (IBAction)btnclosepopup:(id)sender
{
    self.viewpopup.hidden = YES;
}





# pragma Mark : tableview methods

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrnew.count;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib;
    NSString *tableIdentifier = @"Cell";
    
    MealListTableViewCell*cell = (MealListTableViewCell*)[self.tblview dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil)
    {
        nib = [[NSBundle mainBundle] loadNibNamed:@"MealListTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    if (indexPath.row == 4)
    {
        cell.imgfood.image = [UIImage imageNamed:@"free-1"];
        
//        NSString *string1 = [NSString stringWithFormat:@"%@",[[arrnew objectAtIndex:indexPath.row] valueForKey:@"order_date"]];
//
//        if ([string1 isKindOfClass:[NSNull class]])
//        {
//            cell.lblDate.text = @"";
//        }
//
//        else if ([string1 isEqualToString:@""])
//        {
//            cell.lblDate.text = @"";
//        }
//
//        else
//        {
//            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
//            NSString *strDAte = string1;
//
//            [formatter setLocale:[NSLocale systemLocale]];
//            [formatter setDateFormat:@"yyyy-MM-dd"];
//            NSDate *date = [formatter dateFromString:strDAte];
//
//            NSDateFormatter* datef = [[NSDateFormatter alloc]init];
//            [datef setDateFormat:@"MM/dd/yy"];
//            NSString *depResult = [datef stringFromDate:date];
//
//            cell.lblDate.text=depResult;
//        }
//
//
//
//        NSString *strorder_id = [NSString stringWithFormat:@"%@",[[arrnew objectAtIndex:indexPath.row] valueForKey:@"order_id"]];
//
//        if ([strorder_id isKindOfClass:[NSNull class]])
//        {
//            cell.lblOrderNo.text = @"";
//        }
//
//        else if ([strorder_id isEqualToString:@""])
//        {
//            cell.lblOrderNo.text = @"";
//        }
//
//        else
//        {
//            cell.lblOrderNo.text = [NSString stringWithFormat:@"Order No. %@",strorder_id];
//
//            cell.imgfood.image = [UIImage imageNamed:@"free-1"];
//        }
//
//
//
//        NSString *strorder_time = [NSString stringWithFormat:@"%@",[[arrnew objectAtIndex:indexPath.row] valueForKey:@"order_time"]];
//
//        if ([strorder_time isKindOfClass:[NSNull class]])
//        {
//            cell.lblTime.text = @"";
//        }
//
//        else if ([strorder_time isEqualToString:@""])
//        {
//            cell.lblTime.text = @"";
//        }
//
//        else
//        {
//            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
//            NSString *strDAte = strorder_time;
//
//            [formatter setLocale:[NSLocale systemLocale]];
//            [formatter setDateFormat:@"HH:mm:ss"];
//            NSDate *date = [formatter dateFromString:strDAte];
//
//            NSDateFormatter* datef = [[NSDateFormatter alloc]init];
//            [datef setDateFormat:@"HH:mm"];
//            NSString *depResult = [datef stringFromDate:date];
//
//            cell.lblTime.text = [NSString stringWithFormat:@"Time %@",depResult];
//        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    else
    {
        NSString *string1 = [NSString stringWithFormat:@"%@",[[arrnew objectAtIndex:indexPath.row] valueForKey:@"order_date"]];
        
        if ([string1 isKindOfClass:[NSNull class]])
        {
            cell.lblDate.text = @"";
        }
        
        else if ([string1 isEqualToString:@""])
        {
            cell.lblDate.text = @"";
        }
        
        else
        {
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            NSString *strDAte = string1;
            
            NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
            [formatter setLocale:usLocale];
            
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSDate *date = [formatter dateFromString:strDAte];
            
            NSDateFormatter* datef = [[NSDateFormatter alloc]init];
            [datef setDateFormat:@"MM/dd/yy"];
            NSString *depResult = [datef stringFromDate:date];
            
            cell.lblDate.text=depResult;
        }
        
        
        
        NSString *strorder_id = [NSString stringWithFormat:@"%@",[[arrnew objectAtIndex:indexPath.row] valueForKey:@"order_id"]];
        
        if ([strorder_id isKindOfClass:[NSNull class]])
        {
            cell.lblOrderNo.text = @"";
        }
        
        else if ([strorder_id isEqualToString:@""])
        {
            cell.lblOrderNo.text = @"";
        }
        
        else
        {
            cell.lblOrderNo.text = [NSString stringWithFormat:@"Order No. %@",strorder_id];
            
            cell.imgfood.image = [UIImage imageNamed:@"radish"];
        }
        
        
        
        NSString *strorder_time = [NSString stringWithFormat:@"%@",[[arrnew objectAtIndex:indexPath.row] valueForKey:@"order_time"]];
        
        if ([strorder_time isKindOfClass:[NSNull class]])
        {
            cell.lblTime.text = @"";
        }
        
        else if ([strorder_time isEqualToString:@""])
        {
            cell.lblTime.text = @"";
        }
        
        else
        {
            NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
            NSString *strDAte = strorder_time;
            
            NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
            [formatter setLocale:usLocale];
            
            [formatter setDateFormat:@"HH:mm:ss"];
            NSDate *date = [formatter dateFromString:strDAte];
            
            NSDateFormatter* datef = [[NSDateFormatter alloc]init];
            [datef setDateFormat:@"HH:mm"];
            NSString *depResult = [datef stringFromDate:date];
            
            cell.lblTime.text = [NSString stringWithFormat:@"Time %@",depResult];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    return 0;
}





- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//  orderStatusViewController*obj = [[orderStatusViewController alloc]initWithNibName:@"orderStatusViewController" bundle:nil];
//  [self.navigationController pushViewController:obj animated:YES];
  
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}




#pragma mark <--Web Services-->


-(void)wsLocalityProgramm
{
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *user_id=[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"];
    NSString *token=[[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"key=%@&secret=%@&request=%@&action=%@&token=%@&clientID=%@",str_key,str_secret,@"client",@"loyaltystamp",token,user_id];
    
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
        NSString *errorCode=[NSString stringWithFormat:@"%@",[dictionary  valueForKey:@"code"]];
        NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            if([errorCode isEqualToString:@"1"])
            {
                arrorderList=[dictionary valueForKey:@"orders"];
                NSString *strStampCnt =[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"stamps"]];
                
                int cnt = strStampCnt.intValue;
                
                if(cnt > 5)
                {
                    cnt = 5;
                }
                
                else
                {
                    cnt = cnt;
                }
                
                
                for (int i = 0;i<5;i++)
                {
                    if (i < cnt)
                    {
                        NSString *order_date =[NSString stringWithFormat:@"%@",[[arrorderList objectAtIndex:i] valueForKey:@"order_date"]];
                        
                        NSString *order_time =[NSString stringWithFormat:@"%@",[[arrorderList objectAtIndex:i] valueForKey:@"order_time"]];
                        
                        NSString *order_id =[NSString stringWithFormat:@"%@",[[arrorderList objectAtIndex:i] valueForKey:@"order_id"]];
                        
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                        
                        [dict setObject:order_date forKey:@"order_date"];
                        [dict setObject:order_time forKey:@"order_time"];
                        [dict setObject:order_id forKey:@"order_id"];
                        [arrnew addObject:dict];
                    }
                    
                    else
                    {
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                        [dict setObject:@"" forKey:@"order_date"];
                        [dict setObject:@"" forKey:@"order_time"];
                        [dict setObject:@"" forKey:@"order_id"];
                        [arrnew addObject:dict];
                    }
                    
                    NSLog(@"arrnew=%@",arrnew);
                }
                
                [_tblview reloadData];
            }
            
            else if ([errorCode isEqualToString:@"0"])
            {
                for (int i = 0; i < 5; i++)
                {
                    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                    [dict setObject:@"" forKey:@"order_date"];
                    [dict setObject:@"" forKey:@"order_time"];
                    [dict setObject:@"" forKey:@"order_id"];
                    [arrnew addObject:dict];
                }
                
                [_tblview reloadData];
                
//                UIAlertController * alert = [UIAlertController
//                                             alertControllerWithTitle:nil
//                                             message:message preferredStyle:UIAlertControllerStyleAlert];
//
//                //Add Buttons
//
//                UIAlertAction* yesButton = [UIAlertAction
//                                            actionWithTitle:@"OK"
//                                            style:UIAlertActionStyleDefault
//                                            handler:^(UIAlertAction * action) {
//
//
//                                            }];
//
//
//                //Add your buttons to alert controller
//
//                [alert addAction:yesButton];
//
//                [self presentViewController:alert animated:YES completion:nil];
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
                
            }
        });
    }
}




@end

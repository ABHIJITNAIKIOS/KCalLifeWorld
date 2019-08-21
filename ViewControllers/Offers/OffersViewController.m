//
//  OffersViewController.m
//  KCal
//
//  Created by Pipl-02 on 21/09/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "OffersViewController.h"
#import "OffersTableViewCell.h"
#import "BaseViewController.h"
#import "AppDelegate.h"
#import "GiFHUD.h"
#import "HomeViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface OffersViewController ()
{
    NSMutableArray *arroffers;
}

@end

@implementation OffersViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    
    _viewoffer.hidden = YES;
    _tblObj.hidden = YES;
    self.title = @"Offers";
    
    [GiFHUD setGifWithImageName:@"Spinner3.gif"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"handle_data" object:self];
    
    //[_tblObj reloadData];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}




-(void)viewDidAppear:(BOOL)animated
{
    [GiFHUD showWithOverlay];
    //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self wsGetOffers];
    });
    
    for (UIButton *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 134)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 219)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 222)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 221)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 232)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 302)
        {
            [view removeFromSuperview];
        }
    }
}




- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}




#pragma mark <--UITableView Delegates-->


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arroffers.count;
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"OffersTableViewCell";
    OffersTableViewCell *cell1 = (OffersTableViewCell *)[self.tblObj dequeueReusableCellWithIdentifier:CellIdentifier];
    
    NSArray *nib;
    nib = [[NSBundle mainBundle] loadNibNamed:@"OffersTableViewCell" owner:self options:nil];
    cell1 = [nib objectAtIndex:0];
    
    //main_image is for LANDSCAPE Image
    NSString *strimg = [NSString stringWithFormat:@"%@",[[arroffers objectAtIndex:indexPath.row] valueForKey:@"main_image"]];
    
    if ([strimg isEqualToString:@""])
    {
        cell1.img.image = [UIImage imageNamed:@"placeholderfood"];
    }
    
    else
    {
        NSURL *url = [NSURL URLWithString:strimg];
        
        SDImageCache *cache = [SDImageCache sharedImageCache];
        [cache clearMemory];
        [cache clearDiskOnCompletion:nil];
        [cache removeImageForKey:strimg fromDisk:YES withCompletion:nil];
        
        //NSData *data = [NSData dataWithContentsOfURL:url];
        
        [cell1.img sd_setImageWithURL:url
                    placeholderImage:[UIImage imageNamed:@"placeholderfood"] options:SDWebImageRefreshCached];
        
        //cell1.img.image = [UIImage imageWithData:data];
    }
    
    cell1.lbltext.text = [[arroffers objectAtIndex:indexPath.row] valueForKey:@"promo_popup"];
    
    cell1.btnorder.tag = indexPath.row;
    [cell1.btnorder addTarget:self action:@selector(btnorder:) forControlEvents:UIControlEventTouchUpInside];
    
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell1;
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}



-(IBAction)btnorder:(id)sender
{
    HomeViewController *obj=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    obj.str = @"order";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.navigationController pushViewController:obj animated:YES];
}




- (IBAction)btnordernow:(id)sender
{
    HomeViewController *obj=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
    obj.str = @"order";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.navigationController pushViewController:obj animated:YES];
}



#pragma mark <--Web Services-->


-(void)wsGetOffers
{
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"request=%@&language=%@&action=%@&key=%@&secret=%@",@"menu",@"en",@"autopromotion",str_key,str_secret];
    
    NSDictionary *dictionary =[[NSMutableDictionary alloc]init];
    
    dictionary=[base WebParsingMethod:stringWebServicesCompleteUrl:parameter];
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
        
        
        //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Oops, cannot connect to server." delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
        //
        //            [alert show];
    }
    
    else
    {
        NSString *errorCode=[NSString stringWithFormat:@"%@",[dictionary  valueForKey:@"code"]];
        NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            if([errorCode isEqualToString:@"1"])
            {
                arroffers = [[NSMutableArray alloc]init];
                
                arroffers = [dictionary valueForKey:@"promotions"];
                
                if (arroffers.count == 0)
                {
                    _tblObj.hidden = YES;
                    _viewoffer.hidden = NO;
                }
                
                else
                {
                    _tblObj.hidden = NO;
                    _viewoffer.hidden = YES;
                }
                
                [_tblObj reloadData];
            }
            
            else if ([errorCode isEqualToString:@"0"])
            {
                _tblObj.hidden = YES;
                _viewoffer.hidden = NO;
                
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
                
                //                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                //
                //                [alert show];
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
                
                //                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                //
                //                [alert show];
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
                
                //                UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
                //
                //                [alert show];
            }
        });
    }
}




@end

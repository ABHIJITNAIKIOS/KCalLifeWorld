//
//  PaymentViewController.m
//  KCal
//
//  Created by Pipl-10 on 06/08/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "PaymentViewController.h"
#import "MyAccountViewController.h"
#import "AddCardViewController.h"
#import "paymentTableViewCell.h"
#import "BaseViewController.h"
#import "AddCardTableViewCell.h"
#import "AppDelegate.h"
#import "GiFHUD.h"

@interface PaymentViewController ()
{
    NSArray *arrCard;
    NSString *strcard_id;
}

@end

@implementation PaymentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame = CGRectMake(12, 15, 18, 18);
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"white_left"] forState:UIControlStateNormal];
    leftbtn.tag=232;
    
    [leftbtn addTarget:self action:@selector(back)
      forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:leftbtn];
    
    for (UIButton *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 134)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 211)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 225)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 229)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 234)
        {
            [view removeFromSuperview];
        }
    }
    
    self.navigationItem.hidesBackButton = YES;
    
    _tblCardList.delegate = self;
    self.title = @"Payment Methods";
    
    [GiFHUD setGifWithImageName:@"Spinner3.gif"];
    
    [_tblCardList reloadData];
}




-(void)viewDidAppear:(BOOL)animated
{
    [GiFHUD showWithOverlay];
    //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self wsGetCard];
        
    });
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





- (IBAction)btnaddCardTapped:(id)sender
{
    AddCardViewController *obj=[[AddCardViewController alloc]initWithNibName:@"AddCardViewController" bundle:nil];
    obj.strflag = @"no";
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.navigationController pushViewController:obj animated:YES];
}




#pragma mark <---table method--->

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (arrCard.count > 0)
    {
        return arrCard.count + 1;
    }
    
    else
    {
        return 1;
    }
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == arrCard.count)
    {
        return 78;
    }
    
    else
    {
        return 76;
    }
}




- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == arrCard.count)
    {
        AddCardTableViewCell *cell1 = (AddCardTableViewCell *)[self.tblCardList dequeueReusableCellWithIdentifier:@"cell1"];
        
        NSArray *nib;
        nib = [[NSBundle mainBundle] loadNibNamed:@"AddCardTableViewCell" owner:self options:nil];
        
        cell1 =[[AddCardTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        
        cell1 = [nib objectAtIndex:0];
        
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell1;
    }
    
    else
    {
        paymentTableViewCell *cell1 = (paymentTableViewCell *)[self.tblCardList dequeueReusableCellWithIdentifier:@"cell1"];
        
        NSArray *nib;
        nib = [[NSBundle mainBundle] loadNibNamed:@"paymentTableViewCell" owner:self options:nil];
        
        cell1 =[[paymentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        
        cell1 = [nib objectAtIndex:0];
        
        if (arrCard.count > 0)
        {
            cell1.viewnorecord.hidden = YES;
            
            NSArray *arrtemp = [arrCard objectAtIndex:indexPath.row];
            
            if ([[arrtemp valueForKey:@"card_type"] isKindOfClass:[NSNull class]])
            {
                cell1.lblCardName.text = @"";
            }
            
            else
            {
                cell1.lblCardName.text = [arrtemp valueForKey:@"card_type"];
                
                
                if ([[arrtemp valueForKey:@"card_type"] isEqualToString:@"MasterCard"])
                {
                    cell1.imgCard.image = [UIImage imageNamed:@"card"];
                }
                
                else if ([[arrtemp valueForKey:@"card_type"] isEqualToString:@"Visa"])
                {
                    cell1.imgCard.image = [UIImage imageNamed:@"visa"];
                }
                
                else if ([[arrtemp valueForKey:@"card_type"] isEqualToString:@"Amex"])
                {
                    cell1.imgCard.image = [UIImage imageNamed:@"amex"];
                }
                
                else if ([[arrtemp valueForKey:@"card_type"] isEqualToString:@"DinersClub"])
                {
                    cell1.imgCard.image = [UIImage imageNamed:@"diners_club_credit_card_logo"];
                }
                
                else if ([[arrtemp valueForKey:@"card_type"] isEqualToString:@"Discover"])
                {
                    cell1.imgCard.image = [UIImage imageNamed:@"discover"];
                }
                
                else if ([[arrtemp valueForKey:@"card_type"] isEqualToString:@"JCB"])
                {
                    cell1.imgCard.image = [UIImage imageNamed:@"jcb"];
                }
            }
            
            
            if ([[arrtemp valueForKey:@"card_last4"] isKindOfClass:[NSNull class]])
            {
                cell1.lblCarddate.text = @"";
            }
            
            else
            {
                NSString *newStr = [arrtemp valueForKey:@"card_last4"];
                
                NSString *card = [NSString stringWithFormat:@"Ending %@",newStr];
                
                cell1.lblCarddate.text = card;
                
                //            if (cardlength.length >4)
                //            {
                //                NSString *cardno = [arrtemp valueForKey:@"card_last4"];
                //                NSString *newStr = [cardno substringFromIndex: [cardno length] - 4];
                //
                //                NSString *card = [NSString stringWithFormat:@"Ending %@",newStr];
                //
                //                cell1.lblCarddate.text = card;
                //            }
                //
                //            else
                //            {
                //
                //            }
            }
            
            //        if ([[arrtemp valueForKey:@"card_no"] isKindOfClass:[NSNull class]])
            //        {
            //            cell1.lblCarddate.text = @"";
            //        }
            //
            //        else
            //        {
            //            NSString *cardlength = [arrtemp valueForKey:@"card_no"];
            //
            //            if (cardlength.length >4)
            //            {
            //                NSString *cardno = [arrtemp valueForKey:@"card_no"];
            //                NSString *newStr = [cardno substringFromIndex: [cardno length] - 4];
            //
            //                NSString *card = [NSString stringWithFormat:@"Ending %@",newStr];
            //
            //                cell1.lblCarddate.text = card;
            //            }
            //
            //            else
            //            {
            //
            //            }
            //        }
            
            
            cell1.btndeletecard.tag=indexPath.row;
            
            [cell1.btndeletecard addTarget:self action:@selector(deletecard:) forControlEvents:UIControlEventTouchUpInside];
            
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        else
        {
            //_ChgtCardList.constant = 76;
            
            cell1.viewnorecord.hidden = NO;
            
            cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        
        //_ChgtCardList.constant = _tblCardList.contentSize.height+500;
        
        return cell1;
    }
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == arrCard.count)
    {
        AddCardViewController *obj=[[AddCardViewController alloc]initWithNibName:@"AddCardViewController" bundle:nil];
        obj.strflag = @"no";
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
    
    else
    {
        
    }
}




-(void)deletecard:(UIButton *)sender
{
    strcard_id = [NSString stringWithFormat:@"%@",[[arrCard objectAtIndex:sender.tag] valueForKey:@"id"]];
    
    UIAlertController * alert = [UIAlertController                                                          alertControllerWithTitle:NSLocalizedString(@"Whoops!",nil)
                                                                                                                             message:@"Are you sure you want to delete this card ?"
                                                                                                                      preferredStyle:UIAlertControllerStyleAlert];

    //Add Buttons

    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"YES"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {

                                    [GiFHUD showWithOverlay];
                                    //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
                                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
                                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                                        [self wsDeleteCard];
                                        
                                    });

                                }];

    UIAlertAction* noButton = [UIAlertAction
                               actionWithTitle:@"NO"
                               style:UIAlertActionStyleDefault
                               handler:^(UIAlertAction * action) {


                               }];


    //Add your buttons to alert controller

    [alert addAction:yesButton];
    [alert addAction:noButton];

    [self presentViewController:alert animated:YES completion:nil];
}




#pragma mark <--Web Services-->


-(void)wsGetCard
{
    BaseViewController *base=[[BaseViewController alloc]init];
    NSString *user_id=[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"];
    NSString *strtoken = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"token=%@&key=%@&secret=%@&clientID=%@&action=%@&request=%@",strtoken,str_key,str_secret,user_id,@"cards",@"client"];
    
    NSDictionary *dictionary =[[NSMutableDictionary alloc]init];
    
    dictionary=[base WebParsingMethod:stringWebServicesCompleteUrl :parameter];
    [GiFHUD dismiss];
    if(dictionary == (id)[NSNull null] || dictionary == nil)
    {
        [_tblCardList reloadData];
        
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
                arrCard = [[NSArray alloc]init];
                arrCard = [dictionary valueForKey:@"data"];
                
                [_tblCardList reloadData];
            }
            
            else if ([errorCode isEqualToString:@"0"])
            {
                [_tblCardList reloadData];

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




-(void)wsDeleteCard
{
    BaseViewController *base=[[BaseViewController alloc]init];
    NSString *user_id=[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"];
    NSString *strtoken = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"token=%@&key=%@&secret=%@&card_id=%@&action=%@&request=%@&clientID=%@",strtoken,str_key,str_secret,strcard_id,@"removecard",@"client",user_id];
    
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


        //        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:nil message:@"Oops, cannot connect to server." delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil, nil];
        //
        //            [alert show];
    }
    
    else
    {
        NSString *errorCode=[NSString stringWithFormat:@"%@",[dictionary  valueForKey:@"code"]];
        NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
        
//        dispatch_async(dispatch_get_main_queue(),^{
        
            if([errorCode isEqualToString:@"1"])
            {
                [self wsGetCard];
            }

            else if ([errorCode isEqualToString:@"0"])
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
//        });
    }
}



@end

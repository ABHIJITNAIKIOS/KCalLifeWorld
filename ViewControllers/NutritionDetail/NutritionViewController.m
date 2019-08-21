//
//  NutritionViewController.m
//  KCal
//
//  Created by Pipl-10 on 04/07/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "NutritionViewController.h"
#import "MenuDetailsController.h"
#import "NutritionCollectionViewCell.h"
#import "BaseViewController.h"
#import "AppDelegate.h"

@interface NutritionViewController ()
{
    NutritionCollectionViewCell *cell1;
    NSArray *arrnutrition;
}

@end

@implementation NutritionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Nutrition Guide";
    
    self.navigationController.navigationBar.hidden=NO;
    self.navigationItem.hidesBackButton = YES;
    
    self.neutritionCollection.translatesAutoresizingMaskIntoConstraints = NO;
    [self.neutritionCollection registerNib:[UINib nibWithNibName:@"NutritionCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"NutritionCollectionViewCell"];
    
    [self.neutritionCollection reloadData];
}



-(void)viewDidAppear:(BOOL)animated
{
    [self wsGetNutrition];
    
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame = CGRectMake(12, 15, 18, 18);
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"white_left"] forState:UIControlStateNormal];
    leftbtn.tag=211;
    
    [leftbtn addTarget:self action:@selector(back)
      forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:leftbtn];
    
    for (UIButton *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 134)
        {
            [view removeFromSuperview];
        }
    }
    
    for (UIImageView *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 134)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 201)
        {
            [view removeFromSuperview];
        }
    }
}



-(void)back
{
//    MenuDetailsController *obj=[[MenuDetailsController alloc]initWithNibName:@"MenuDetailsController" bundle:nil];
    [self.navigationController popViewControllerAnimated:YES];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrnutrition.count;
}



-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    cell1 = (NutritionCollectionViewCell *)[_neutritionCollection dequeueReusableCellWithReuseIdentifier:@"NutritionCollectionViewCell" forIndexPath:indexPath];
    _ChtcollectionView.constant = _neutritionCollection.contentSize.height;
    
    NSString *name = [NSString stringWithFormat:@"%@",[[arrnutrition objectAtIndex:indexPath.row] valueForKey:@"name"]];
    
    if ([name isKindOfClass:[NSNull class]])
    {
        cell1.lbltitle.text=@"";
    }
    
    else if ([name isEqualToString:@""])
    {
        cell1.lbltitle.text=@"";
    }
    
    else
    {
        cell1.lbltitle.text=name;
    }
    
    
    
    NSString *imgname = [NSString stringWithFormat:@"%@",[[arrnutrition objectAtIndex:indexPath.row] valueForKey:@"image"]];
    
    if ([imgname isKindOfClass:[NSNull class]])
    {
        NSURL *url =[NSURL URLWithString:imgname];
        
        [cell1.imgview setImageWithURL:url placeholderImage:[UIImage imageNamed:@""]];
    }
    
    else if ([imgname isEqualToString:@""])
    {
        NSURL *url =[NSURL URLWithString:imgname];
        
        [cell1.imgview setImageWithURL:url placeholderImage:[UIImage imageNamed:@"1"]];
    }
    
    else
    {
        NSURL *url =[NSURL URLWithString:imgname];
        
        [cell1.imgview setImageWithURL:url placeholderImage:[UIImage imageNamed:@""]];
    }
    
    return cell1;
}





- (IBAction)btnback:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}




#pragma mark <--Web Services-->

-(void)wsGetNutrition
{
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"request=%@&key=%@&secret=%@",@"menu-symbols",str_key,str_secret];
    
    NSDictionary *dictionary =[[NSMutableDictionary alloc]init];
    
    dictionary=[base WebParsingMethod:stringWebServicesCompleteUrl :parameter];
    
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
        NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            if([errorCode isEqualToString:@"1"])
            {
                arrnutrition = [dictionary valueForKey:@"symbols"];
                
                [self.neutritionCollection reloadData];
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

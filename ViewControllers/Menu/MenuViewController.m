//
//  MenuViewController.m
//  KCal
//
//  Created by Apple on 28/02/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "MenuViewController.h"
#import "CollectionViewCell.h"
#import "ProductTableViewCell.h"
#import "SlideNavigationController.h"
#import "FilterTableViewCell.h"
#import "BaseViewController.h"
#import "AppDelegate.h"
#import "UIImageView+AFNetworking.h"
#import "MenuDetailsController.h"
#import "CartViewController.h"
#import "GiFHUD.h"
#import "WeeklyViewCart.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SlideNavigationController.h"
@interface MenuViewController ()
{
    CollectionViewCell *cell1;
    NSMutableArray *arrweeklydata;
    NSString *filterchk;
    UIButton *leftbtn1;
    NSMutableArray *arrProducts;
    NSMutableArray *arrgroup2;
    NSMutableArray *arrFilter;
    NSMutableArray *arrCat;
    NSString *catid;
    NSString *proid;
    NSString *category_id;
    int catnumber;
    int currentindex;
    int containstrue;
    NSMutableArray *arrID;
    NSString *stroffername;
    NSString *strofferline;
    NSString *flagistruecopndititon;
    NSString *strBranchId;
}

@end

@implementation MenuViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    for (UIImageView *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 111)
        {
            [view removeFromSuperview];
        }
    }
    
    for (UIButton *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 120)
        {
            [view removeFromSuperview];
        }
        
        if(view.tag == 230)
        {
            [view removeFromSuperview];
        }
        if (view.tag == 209)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 222)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 225)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 227)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 229)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 401)
        {
            [view removeFromSuperview];
        }
    }
    
    self.navigationController.navigationBar.translucent = NO;
    currentindex = 0;
    
    strBranchId = @"";
    stroffername = @"";
    strofferline = @"";
    catid = @"";
    filterchk=@"no";
    catnumber=0;
    self.tableviewFilter.hidden=YES;
    self.lblnorecord.hidden = YES;
    _ChtWeelyOrder.constant = 0;
    self.ViewTopWeelyOrder.hidden=YES;
    _lblback.hidden = YES;
    _viewclear.hidden = YES;
    
    arrProducts = [[NSMutableArray alloc]init];
    arrID = [[NSMutableArray alloc]init];
    arrgroup2 = [[NSMutableArray alloc]init];
    
    NSLog(@"%@",_arrselecteddate);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"" forKey:@"index"];
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"promocode_for_order"];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissTableView)];
    
    [self.lblback addGestureRecognizer:tap];
    
    self.collectionviewheader.translatesAutoresizingMaskIntoConstraints = NO;
    [_collectionviewheader registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
    
    self.viewcart.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
    
    self.viewcart.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    
    self.viewcart.layer.shadowRadius = 2.0f;
    
    self.viewcart.layer.shadowOpacity = 1.0f;
    
    _viewcart.hidden = YES;
    
    self.title=@"Menu";
    
    [GiFHUD setGifWithImageName:@"Spinner3.gif"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"handle_data" object:self];
    
    [SlideNavigationController sharedInstance].enableSwipeGesture = NO;
    
    [GiFHUD showWithOverlay];
    //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self wsGetCategories];
    });
    
    
    [self wsFilter];
}





-(void)dismissTableView
{
    filterchk=@"no";
    _lblback.hidden = YES;
    _viewclear.hidden = YES;
    self.tableviewFilter.hidden=YES;
    [leftbtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}






-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=NO;
}





- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}





-(void)viewDidAppear:(BOOL)animated
{
    if ([_weeklyflag isEqualToString:@"yes"]||[[[NSUserDefaults standardUserDefaults]valueForKey:@"weeklyorderclicked"]isEqualToString:@"yes"])
    {
        if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"weeklyorderclicked"]isEqualToString:@"yes"])
        {
            _ChtWeelyOrder.constant = 77;
            _ViewTopWeelyOrder.hidden=NO;
            arrweeklydata =[[NSMutableArray alloc]init];
            NSData *dataarraddtocart = [[NSUserDefaults standardUserDefaults]valueForKey:@"weeklyorderarray"];
            
            if (!(dataarraddtocart == nil))
            {
                arrweeklydata=[[NSKeyedUnarchiver unarchiveObjectWithData:dataarraddtocart] mutableCopy];
            }
            
            
            for (int i =0; i<arrweeklydata.count; i++)
            {
                NSMutableDictionary *dicttemp=[[NSMutableDictionary alloc]init];
                dicttemp =[[arrweeklydata objectAtIndex:i] mutableCopy];
                
                if (i == 0)
                {
                    [dicttemp setObject:@"yes" forKey:@"isclicked"];
                }
                
                else
                {
                    [dicttemp setObject:@"no" forKey:@"isclicked"];
                }
                
                [arrweeklydata replaceObjectAtIndex:i withObject:dicttemp];
            }
            
            containstrue = 0;
            flagistruecopndititon =@"";
            
            for (int i = 0; i< arrweeklydata.count; i++)
            {
                NSString *strflag = [NSString stringWithFormat:@"%@",[[arrweeklydata objectAtIndex:i]valueForKey:@"flag"]];
                
                if ([strflag isEqualToString:@"true"])
                {
                    flagistruecopndititon =@"yes";
                    
                    currentindex = i;
                    
                    containstrue = i;
                    
                    break;
                }
            }
            
            
            if ([flagistruecopndititon isEqualToString:@"yes"])
            {
                flagistruecopndititon =@"";
                
                _imgnext.image =[UIImage imageNamed:@"KL_APP_About_Us.jpg"];
                _imgprevious.image =[UIImage imageNamed:@"left_arrow_green"];
                
                if (currentindex == 0)
                {
                    _imgprevious.image =[UIImage imageNamed:@"left-arrow.png"];
                    _imgnext.image =[UIImage imageNamed:@"KL_APP_About_Us.jpg"];
                }
                
                if (arrweeklydata.count <=1)
                {
                    _imgprevious.image =[UIImage imageNamed:@"left-arrow.png"];
                    _imgnext.image =[UIImage imageNamed:@"right-arrow.png"];
                }
                
                else if (currentindex >= arrweeklydata.count-1)
                {
                    _imgprevious.image =[UIImage imageNamed:@"left_arrow_green"];
                    _imgnext.image =[UIImage imageNamed:@"right-arrow.png"];
                }
               
                else if (currentindex  == arrweeklydata.count)
                {
                    _imgprevious.image =[UIImage imageNamed:@"left_arrow_green"];
                    _imgnext.image =[UIImage imageNamed:@"KL_APP_About_Us.jpg"];
                }
                
                else
                {
                    
                }
                
                
                for (int i =0; i<arrweeklydata.count; i++)
                {
                    if (currentindex == i)
                    {
                        NSString *datelength = [NSString stringWithFormat:@"%@",[[arrweeklydata objectAtIndex:currentindex]valueForKey:@"SelectedDate"]];
                        
                        datelength =[datelength stringByReplacingOccurrencesOfString:@"Sunday" withString:@"Sun"];
                        datelength =[datelength stringByReplacingOccurrencesOfString:@"Monday" withString:@"Mon"];
                        datelength =[datelength stringByReplacingOccurrencesOfString:@"Tuesday" withString:@"Tue"];
                        datelength =[datelength stringByReplacingOccurrencesOfString:@"Wednesday" withString:@"Wed"];
                        datelength =[datelength stringByReplacingOccurrencesOfString:@"Thursday" withString:@"Thu"];
                        datelength =[datelength stringByReplacingOccurrencesOfString:@"Friday" withString:@"Fri"];
                        datelength =[datelength stringByReplacingOccurrencesOfString:@"Saturday" withString:@"Sat"];
                        
                        _lblselectedDate.text = datelength;
                        
                        NSMutableDictionary *dictemp =[[NSMutableDictionary alloc]init];
                        
                        dictemp =[[arrweeklydata objectAtIndex:i] mutableCopy];
                        
                        NSArray *arrpro = [[NSArray alloc]init];
                        
                        arrpro = [dictemp valueForKey:@"products"];
                        
                        if (arrpro.count == 0)
                        {
                            [_viewcart setHidden:YES];
                            _viewcartheight.constant = 0;
                        }
                        
                        else
                        {
                            [_viewcart setHidden:NO];
                            _viewcartheight.constant = 75;
                        }
                        
                        [dictemp setObject:@"yes" forKey:@"isclicked"];
                        
                        [arrweeklydata replaceObjectAtIndex:i withObject:dictemp];
                    }
                    
                    else
                    {
                        NSMutableDictionary *dictemp =[[NSMutableDictionary alloc]init];
                        dictemp =[[arrweeklydata objectAtIndex:i] mutableCopy];
                        
                        [dictemp setObject:@"no" forKey:@"isclicked"];
                        
                        [arrweeklydata replaceObjectAtIndex:i withObject:dictemp];
                    }
                }
            }
            
            else
            {
                if (arrweeklydata.count <=1)
                {
                    _imgprevious.image =[UIImage imageNamed:@"left-arrow.png"];
                    _imgnext.image =[UIImage imageNamed:@"right-arrow.png"];
                }
                
                else if (currentindex == 0)
                {
                    _imgprevious.image =[UIImage imageNamed:@"left-arrow.png"];
                    _imgnext.image =[UIImage imageNamed:@"KL_APP_About_Us.jpg"];
                }
                
                else if (currentindex == arrweeklydata.count)
                {
                    _imgprevious.image =[UIImage imageNamed:@"left_arrow_green"];
                    _imgnext.image =[UIImage imageNamed:@"right-arrow.png"];
                }
                
                NSString *datelength = [NSString stringWithFormat:@"%@",[[arrweeklydata objectAtIndex:currentindex]valueForKey:@"SelectedDate"]];
                
                datelength =[datelength stringByReplacingOccurrencesOfString:@"Sunday" withString:@"Sun"];
                datelength =[datelength stringByReplacingOccurrencesOfString:@"Monday" withString:@"Mon"];
                datelength =[datelength stringByReplacingOccurrencesOfString:@"Tuesday" withString:@"Tue"];
                datelength =[datelength stringByReplacingOccurrencesOfString:@"Wednesday" withString:@"Wed"];
                datelength =[datelength stringByReplacingOccurrencesOfString:@"Thursday" withString:@"Thu"];
                datelength =[datelength stringByReplacingOccurrencesOfString:@"Friday" withString:@"Fri"];
                datelength =[datelength stringByReplacingOccurrencesOfString:@"Saturday" withString:@"Sat"];
                
                _lblselectedDate.text = datelength;
            }
            
            
            for (int i =0; i<arrweeklydata.count; i++)
            {
                if (currentindex == i)
                {
                    NSMutableDictionary *dictemp =[[NSMutableDictionary alloc]init];
                    
                    dictemp =[[arrweeklydata objectAtIndex:i] mutableCopy];
                    
                    NSArray *arrpro = [[NSArray alloc]init];
                    
                    arrpro = [dictemp valueForKey:@"products"];
                    
                    if (arrpro.count == 0)
                    {
                        [_viewcart setHidden:YES];
                        _viewcartheight.constant = 0;
                    }
                    
                    else
                    {
                        [_viewcart setHidden:NO];
                        _viewcartheight.constant = 75;
                    }
                }
            }
        }
        
        else
        {
            _ChtWeelyOrder.constant = 77;
            _ViewTopWeelyOrder.hidden=NO;
            arrweeklydata=[[NSMutableArray alloc]init];
            
            for (int i =0; i<_arrselecteddate.count; i++)
            {
                NSMutableDictionary *dicttemp=[[NSMutableDictionary alloc]init];
                dicttemp =[[_arrselecteddate objectAtIndex:i] mutableCopy];
                NSMutableArray *srrproducts =[[NSMutableArray alloc]init];
                [dicttemp setObject:srrproducts forKey:@"products"];
                
                if (i == 0)
                {
                    [dicttemp setObject:@"yes" forKey:@"isclicked"];
                }
                
                else
                {
                    [dicttemp setObject:@"no" forKey:@"isclicked"];
                }
                
                [arrweeklydata addObject:dicttemp];
            }
            
            if (arrweeklydata.count>0)
            {
                if (arrweeklydata.count <=1)
                {
                    _imgprevious.image =[UIImage imageNamed:@"left-arrow.png"];
                    _imgnext.image =[UIImage imageNamed:@"right-arrow.png"];
                }
                
                else if (currentindex == 0)
                {
                    _imgprevious.image =[UIImage imageNamed:@"left-arrow.png"];
                    _imgnext.image =[UIImage imageNamed:@"KL_APP_About_Us.jpg"];
                }
                
                else if (currentindex == arrweeklydata.count)
                {
                    _imgprevious.image =[UIImage imageNamed:@"left_arrow_green"];
                    _imgnext.image =[UIImage imageNamed:@"right-arrow.png"];
                }
                
                
                NSString *datelength = [NSString stringWithFormat:@"%@",[[arrweeklydata objectAtIndex:currentindex]valueForKey:@"SelectedDate"]];
                
                datelength =[datelength stringByReplacingOccurrencesOfString:@"Sunday" withString:@"Sun"];
                datelength =[datelength stringByReplacingOccurrencesOfString:@"Monday" withString:@"Mon"];
                datelength =[datelength stringByReplacingOccurrencesOfString:@"Tuesday" withString:@"Tue"];
                datelength =[datelength stringByReplacingOccurrencesOfString:@"Wednesday" withString:@"Wed"];
                datelength =[datelength stringByReplacingOccurrencesOfString:@"Thursday" withString:@"Thu"];
                datelength =[datelength stringByReplacingOccurrencesOfString:@"Friday" withString:@"Fri"];
                datelength =[datelength stringByReplacingOccurrencesOfString:@"Saturday" withString:@"Sat"];
                
                _lblselectedDate.text = datelength;
            }
        }
    }
    
    else
    {
        _ChtWeelyOrder.constant = 0;
        _ViewTopWeelyOrder.hidden=YES;
    }
    
    
    
    NSData *dataarraddtocart =[[NSUserDefaults standardUserDefaults] valueForKey:@"arrayaddtocart"];
    
    NSArray *arraddtocart=[[NSArray alloc]init];
    
    if (!(dataarraddtocart.bytes == 0))
    {
        arraddtocart=[[NSKeyedUnarchiver unarchiveObjectWithData:dataarraddtocart] mutableCopy];
    }
    
    
    if (arraddtocart.count >0)
    {
        _viewcartheight.constant = 75.0f;
        
        NSString *strquantity =[NSString stringWithFormat:@"%lu",(unsigned long) arraddtocart.count];
        
        int totalcount =0;
        
        for (int i = 0; i<arraddtocart.count; i++)
        {
            NSString *price =[NSString stringWithFormat:@"%@",[[arraddtocart objectAtIndex:i]valueForKey:@"totalprice"]];
            
            int cswjf =[price intValue];
            
            totalcount = totalcount + cswjf;
        }
        
        
        if (arraddtocart.count == 1)
        {
            _lblitems.text =[NSString stringWithFormat:@"%@ Item", strquantity];
        }
        
        else
        {
            _lblitems.text =[NSString stringWithFormat:@"%@ Items", strquantity];
        }
        
        _lblprice.text =[NSString stringWithFormat:@"AED %d", totalcount];
        
        [_viewcart setHidden:NO];
    }
    
    else if (arrweeklydata.count > 0)
    {
        _viewcartheight.constant = 75.0f;
        
        int totalcount =0;
        int totalquantity = 0;
        
        for (int i = 0; i<arrweeklydata.count; i++)
        {
            if (currentindex == i)
            {
                if ([[arrweeklydata objectAtIndex:i]valueForKey:@"products"])
                {
                    NSMutableDictionary *dictemp =[[NSMutableDictionary alloc]init];
                    
                    dictemp =[[arrweeklydata objectAtIndex:i] mutableCopy];
                    
                    NSArray *arrpro = [[NSArray alloc]init];
                    
                    arrpro = [dictemp valueForKey:@"products"];
                    
                    for (int j =0; j<arrpro.count; j++)
                    {
                        totalquantity = totalquantity +1;
                        
                        NSString *price =[NSString stringWithFormat:@"%@",[[arrpro objectAtIndex:j]valueForKey:@"totalprice"]];
                        
                        int cswjf =[price intValue];
                        
                        totalcount = totalcount + cswjf;
                    }
                    
                    if (arrpro.count == 1)
                    {
                        _lblitems.text =[NSString stringWithFormat:@"%d Item", totalquantity];
                    }
                    
                    else
                    {
                        _lblitems.text =[NSString stringWithFormat:@"%d Items", totalquantity];
                    }
                }
            }
        }
        
        
//        if (arrweeklydata.count == 1)
//        {
//            _lblitems.text =[NSString stringWithFormat:@"%d Item", totalquantity];
//        }
//
//        else
//        {
//            _lblitems.text =[NSString stringWithFormat:@"%d Items", totalquantity];
//        }
        
        _lblprice.text =[NSString stringWithFormat:@"AED %d", totalcount];
    }
    
    else
    {
        _viewcartheight.constant = 0.0f;
        [_viewcart setHidden:YES];
    }
    
    
    for (int i =0; i<arrweeklydata.count; i++)
    {
        if (currentindex == i)
        {
            NSMutableDictionary *dictemp =[[NSMutableDictionary alloc]init];
            
            dictemp =[[arrweeklydata objectAtIndex:i] mutableCopy];
            
            NSArray *arrpro = [[NSArray alloc]init];
            
            arrpro = [dictemp valueForKey:@"products"];
            
            if (arrpro.count == 0)
            {
                [_viewcart setHidden:YES];
                _viewcartheight.constant = 0;
            }
            
            else
            {
                [_viewcart setHidden:NO];
                _viewcartheight.constant = 75;
            }
        }
    }
    
    
    leftbtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn1.frame = CGRectMake(self.view.frame.size.width-60, 12, 60, 25);
    [leftbtn1 setTitle:@"Filters" forState:UIControlStateNormal];
    
    [leftbtn1.titleLabel setFont:[UIFont fontWithName:@"AvenirLTStd-Medium" size:12.0]];
    leftbtn1.tag=134;
    [leftbtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftbtn1 addTarget:self action:@selector(filterMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:leftbtn1];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    int index = 0;
    
    NSString *strindex = [defaults valueForKey:@"index"];
    
    index = strindex.intValue;
    
    if ([[arrCat objectAtIndex:index] valueForKey:@"categoryID"])
    {
        leftbtn1.hidden = NO;
    }
    
    else
    {
        leftbtn1.hidden = YES;
    }
}



// collection view
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return arrCat.count;
}





- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *temp=[[arrCat objectAtIndex:indexPath.row]valueForKey:@"name"];
    NSLog(@"length=%lu",(unsigned long)temp.length);
    
    CGSize frameSize = CGSizeMake(358, 50);
    UIFont *font = [UIFont systemFontOfSize:12];
    
    CGRect idealFrame = [temp boundingRectWithSize:frameSize
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{ NSFontAttributeName:font }
                                           context:nil];
    
    NSLog(@"width: %0.1f", idealFrame.size.width);
    
    //return CGSizeMake((temp.length*13), (45));
    
    //    CGSize size = [temp sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"system" size:20]}];
    
//    if (temp.length <35 && temp.length >31)
//    {
//        return CGSizeMake((idealFrame.size.width), (45));
//    }
//    else if (temp.length >35)
//    {
//        return CGSizeMake((idealFrame.size.width), (45));
//    }
//    else if (temp.length >17 && temp.length <31 )
//    {
//        return CGSizeMake((idealFrame.size.width), (45));
//    }
//
//    else
//    {
//        return CGSizeMake((idealFrame.size.width), (45));
//
//    }
    
    return CGSizeMake((idealFrame.size.width+20), (45));
}




- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier1 = @"CollectionViewCell";
    
    cell1 = (CollectionViewCell *)[_collectionviewheader dequeueReusableCellWithReuseIdentifier:CellIdentifier1 forIndexPath:indexPath];
    
    cell1.lblName.textAlignment=NSTextAlignmentCenter;
    cell1.lblName.text =[[arrCat objectAtIndex:indexPath.row] valueForKey:@"name"];
    cell1.lblBottom.frame=CGRectMake(cell1.lblName.frame.origin.x, cell1.lblName.frame.origin.y+cell1.lblName.frame.size.height, cell1.lblName.frame.size.width, 3.0f);
    
    
    if ([[[arrCat objectAtIndex:indexPath.row] valueForKey:@"flag"] isEqualToString:@"true"])
    {
        cell1.lblBottom.hidden=NO;
    }
    
    else
    {
        cell1.lblBottom.hidden=YES;
    }
    
    return cell1;
}




- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[arrCat objectAtIndex:indexPath.row] valueForKey:@"categoryID"])
    {
        int index = 0;
        index = (int) indexPath.row;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *strindex = [NSString stringWithFormat:@"%d",index];
        [defaults setObject:strindex forKey:@"index"];
        
        //leftbtn1.hidden = NO;
        catid = [[arrCat objectAtIndex:indexPath.row]valueForKey:@"categoryID"];
        
        for (int i =0; i<arrCat.count; i++)
        {
            NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
            
            dictet =[[arrCat objectAtIndex:i] mutableCopy];
            
            if (i == indexPath.row)
            {
                [dictet setObject:@"true" forKey:@"flag"];
            }
            
            else
            {
                [dictet setObject:@"false" forKey:@"flag"];
            }
            
            [arrCat replaceObjectAtIndex:i withObject:dictet];
        }
        
        
        for (int i =0; i<arrFilter.count; i++)
        {
            NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
            
            dictet =[[arrFilter objectAtIndex:i] mutableCopy];
            
            [dictet setObject:@"false" forKey:@"flag"];
            
            [arrFilter replaceObjectAtIndex:i withObject:dictet];
        }
        
        [self.tableviewFilter reloadData];
        
        [_tableview1 setContentOffset:CGPointMake(0,0)];
        
        [GiFHUD showWithOverlay];
        //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self wsGetListing];
            
        });
        
        //    [HUD showWhileExecuting:@selector(wsGetListing) onTarget:self withObject:nil animated:YES];
    }
    
    else
    {
        int index = 0;
        index = (int) indexPath.row;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *strindex = [NSString stringWithFormat:@"%d",index];
        [defaults setObject:strindex forKey:@"index"];
        
        //leftbtn1.hidden = YES;
        proid = [[arrCat objectAtIndex:indexPath.row] valueForKey:@"promotionID"];
        
        stroffername = [[arrCat objectAtIndex:indexPath.row] valueForKey:@"name"];
        strofferline = [[arrCat objectAtIndex:indexPath.row] valueForKey:@"group2_name"];
        
        for (int i =0; i<arrCat.count; i++)
        {
            NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
            
            dictet =[[arrCat objectAtIndex:i] mutableCopy];
            
            if (i == indexPath.row)
            {
                [dictet setObject:@"true" forKey:@"flag"];
            }
            
            else
            {
                [dictet setObject:@"false" forKey:@"flag"];
            }
            
            [arrCat replaceObjectAtIndex:i withObject:dictet];
        }
        
        
        for (int i =0; i<arrFilter.count; i++)
        {
            NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
            
            dictet =[[arrFilter objectAtIndex:i] mutableCopy];
            
            [dictet setObject:@"false" forKey:@"flag"];
            
            [arrFilter replaceObjectAtIndex:i withObject:dictet];
        }
        
        [self.tableviewFilter reloadData];
        
        [_tableview1 setContentOffset:CGPointMake(0,0)];
        
        [GiFHUD showWithOverlay];
        //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self wsGetPromotionListing];
            
        });
        
        //    [HUD showWhileExecuting:@selector(wsGetPromotionListing) onTarget:self withObject:nil animated:YES];
    }
}




#pragma  mark <--table view delegate-->


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView ==self.tableview1)
    {
         return 183;
    }
    
    else if (tableView ==self.tableviewFilter)
    {
        return 30;
    }
    
    return 0;
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView ==self.tableview1)
    {
        return arrProducts.count;
    }
    
    else if (tableView ==self.tableviewFilter)
    {
        return arrFilter.count;
    }
    
    return 0;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView ==self.tableview1)
    {
        NSArray *nib;
        NSString *tableIdentifier = @"Cell";
        
        ProductTableViewCell *cell = (ProductTableViewCell*)[self.tableview1 dequeueReusableCellWithIdentifier:tableIdentifier];
        
        if (cell == nil)
        {
            nib = [[NSBundle mainBundle] loadNibNamed:@"ProductTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        NSArray *arrTemp=[arrProducts objectAtIndex:indexPath.row];
        
        NSString *strimg = [NSString stringWithFormat:@"%@",[[[arrProducts objectAtIndex:indexPath.row] valueForKey:@"images"] valueForKey:@"normal"]];
        
        NSURL *url = [NSURL URLWithString:strimg];
        
        //NSData *data = [NSData dataWithContentsOfURL:url];
        
        SDImageCache *cache = [SDImageCache sharedImageCache];
        [cache clearMemory];
        [cache clearDiskOnCompletion:nil];
        [cache removeImageForKey:strimg fromDisk:YES withCompletion:nil];
        
        [cell.imgProduct sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRefreshCached];
        
        //cell.imgProduct.image = [UIImage imageWithData:data];
        
        if ([[arrTemp valueForKey:@"popular_item"] isEqualToString:@"Y"])
        {
            cell.imgpopular.hidden = YES;
        }
        
        else
        {
            cell.imgpopular.hidden = YES;
        }
        
        
        if ([[arrTemp valueForKey:@"new"] isEqualToString:@"Y"])
        {
            cell.imgnew.hidden = YES;
        }
        
        else
        {
            cell.imgnew.hidden = YES;
        }
        
        
        if ([[arrTemp valueForKey:@"outOfStock"] isEqualToString:@"Y"])
        {
            cell.imgsoldout.hidden = YES;
        }
        
        else
        {
            cell.imgsoldout.hidden = YES;
        }
        
        cell.lblProductName.text = [arrTemp valueForKey:@"name"];
        
        if ([[arrTemp valueForKey:@"type"] isEqualToString:@"1"])
        {
            NSString *strprice = [arrTemp valueForKey:@"fixed_price"];
            
            NSString *type= [strprice stringByReplacingOccurrencesOfString:@".00" withString:@""];
            
            cell.lblPrice.text=[NSString stringWithFormat:@"%@ %@",[[arrProducts objectAtIndex:indexPath.row] valueForKey:@"currency"],type];
        }
        
        else if ([[arrTemp valueForKey:@"type"] isEqualToString:@"2"])
        {
            NSString *strprice = [arrTemp valueForKey:@"price"];
            
            NSString *type= [strprice stringByReplacingOccurrencesOfString:@".00" withString:@""];
            
            cell.lblPrice.text=[NSString stringWithFormat:@"%@ %@",[[arrProducts objectAtIndex:indexPath.row] valueForKey:@"currency"],type];
        }
        
        else
        {
            NSString *strprice = [arrTemp valueForKey:@"price"];
            
            NSString *type= [strprice stringByReplacingOccurrencesOfString:@".00" withString:@""];
            
            cell.lblPrice.text=[NSString stringWithFormat:@"%@ %@",[[arrProducts objectAtIndex:indexPath.row] valueForKey:@"currency"],type];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    else if (tableView ==self.tableviewFilter)
    {
        NSArray *nib;
        NSString *tableIdentifier = @"Cell";
        
        FilterTableViewCell *cell = (FilterTableViewCell*)[self.tableviewFilter dequeueReusableCellWithIdentifier:tableIdentifier];
        
        if (cell == nil)
        {
            nib = [[NSBundle mainBundle] loadNibNamed:@"FilterTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        cell.lblNameFilter.text = [[arrFilter objectAtIndex:indexPath.row]valueForKey:@"name"];
        
        if ([[[arrFilter objectAtIndex:indexPath.row] valueForKey:@"flag"] isEqualToString:@"true"])
        {
            cell.imgselect.image = [UIImage imageNamed:@"greenCircle"];
            cell.lblNameFilter.textColor = [UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1.0f];
            //category_id = [[arrFilter objectAtIndex:indexPath.row]valueForKey:@"id"];
        }
        
        else
        {
            cell.imgselect.image = [UIImage imageNamed:@"grayCircle"];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    return 0;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView ==self.tableview1)
    {
        NSMutableArray *arrTemp = [arrProducts objectAtIndex:indexPath.row];
        
        if ([arrTemp valueForKey:@"type"])
        {
            MenuDetailsController *obj=[[MenuDetailsController alloc]initWithNibName:@"MenuDetailsController" bundle:nil];
            obj.arrmenu=arrTemp;
            obj.getoffername=stroffername;
            obj.getofferline=strofferline;
            obj.arrgroup2=arrgroup2;
            
            if ([_weeklyflag isEqualToString:@"yes"]||[[[NSUserDefaults standardUserDefaults]valueForKey:@"weeklyorderclicked"] isEqualToString:@"yes"])
            {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrweeklydata];
                
                [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"weeklyorderarray"];
                
                [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"weeklyorderclicked"];
                
                obj.weeklyorder =@"yes";
            }
            
            else
            {
                obj.weeklyorder =@"no";
            }
            
            [self.navigationController pushViewController:obj animated:YES];
        }
        
        else
        {
            NSString *menuid=[[arrProducts objectAtIndex:indexPath.row] valueForKey:@"itemID"];
            
            MenuDetailsController *obj=[[MenuDetailsController alloc]initWithNibName:@"MenuDetailsController" bundle:nil];
            obj.getMenuid=menuid;
            
            if ([_weeklyflag isEqualToString:@"yes"]||[[[NSUserDefaults standardUserDefaults]valueForKey:@"weeklyorderclicked"]isEqualToString:@"yes"])
            {
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrweeklydata];
                
                [[NSUserDefaults standardUserDefaults]setObject:data forKey:@"weeklyorderarray"];
                
                [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"weeklyorderclicked"];
                
                obj.weeklyorder =@"yes";
            }
            
            else
            {
                obj.weeklyorder =@"no";
            }
            
            [self.navigationController pushViewController:obj animated:YES];
        }
    }
    
    else if (tableView ==self.tableviewFilter)
    {
        if ([[[arrFilter objectAtIndex:indexPath.row] valueForKey:@"flag"] isEqualToString:@"true"])
        {
            if (arrID.count == 1)
            {
                category_id = @"";
                
                arrID = [[NSMutableArray alloc]init];
            }
            
            else
            {
                NSString *strnumber =[NSString stringWithFormat:@"%@",[[arrFilter objectAtIndex:indexPath.row] valueForKey:@"id"]];
                
                NSMutableArray *arrTemp = [[NSMutableArray alloc]init];
                
                for (int z = 0; z<arrID.count; z++)
                {
                    if ([[arrID objectAtIndex:z] isEqualToString:strnumber])
                    {
                        //[arrID removeObjectAtIndex:z];
                    }
                    
                    else
                    {
                        [arrTemp addObject:[arrID objectAtIndex:z]];
                    }
                }
                
                arrID = [arrTemp mutableCopy];
            }
            
            NSMutableArray *arrTemp = [[NSMutableArray alloc]init];
            NSMutableDictionary *dictTemp = [[NSMutableDictionary alloc]init];
            arrTemp =arrFilter.mutableCopy;
            
            dictTemp = [[arrTemp objectAtIndex:indexPath.row] mutableCopy];
            [dictTemp setObject:@"false" forKey:@"flag"];
            
            [arrTemp replaceObjectAtIndex:indexPath.row withObject:dictTemp];
            
            arrFilter = [[NSMutableArray alloc]init];
            
            arrFilter =arrTemp.mutableCopy;
            
            [_tableviewFilter reloadData];
        }
        
        else
        {
            category_id = [[arrFilter objectAtIndex:indexPath.row]valueForKey:@"id"];
            
            [arrID addObject:[NSString stringWithFormat:@"%@",category_id]];
            
            NSArray *arrTempId=arrID.copy;
            
            //            NSOrderedSet *orderedSet1 = [NSOrderedSet orderedSetWithArray:arrTempId];
            //            arrTempId = [orderedSet1 array];
            arrID=[[NSMutableArray alloc]init];
            
            arrID=arrTempId.mutableCopy;
            
            NSMutableArray *arrTemp = [[NSMutableArray alloc]init];
            NSMutableDictionary *dictTemp = [[NSMutableDictionary alloc]init];
            arrTemp =arrFilter.mutableCopy;
            
            dictTemp = [[arrTemp objectAtIndex:indexPath.row] mutableCopy];
            [dictTemp setObject:@"true" forKey:@"flag"];
            
            [arrTemp replaceObjectAtIndex:indexPath.row withObject:dictTemp];
            
            arrFilter = [[NSMutableArray alloc]init];
            
            arrFilter =arrTemp.mutableCopy;
            
            [_tableviewFilter reloadData];
        }
        
        
        //        category_id = [[arrFilter objectAtIndex:indexPath.row]valueForKey:@"id"];
        //
        //        for (int i =0; i<arrFilter.count; i++)
        //        {
        //            NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
        //
        //            dictet =[[arrFilter objectAtIndex:i] mutableCopy];
        //
        ////            if (i == indexPath.row)
        ////            {
        ////                [dictet setObject:@"true" forKey:@"flag"];
        ////            }
        ////
        ////            else
        ////            {
        ////                [dictet setObject:@"false" forKey:@"flag"];
        ////            }
        //
        //            [arrFilter replaceObjectAtIndex:i withObject:dictet];
        //        }
        //
        //        [_tableviewFilter reloadData];
        //
        //        [GiFHUD showWithOverlay];
        //        //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
        //        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
        //        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        //            [self wsGetFilterListing];
        //            //
        //        });
        
        //        [HUD showWhileExecuting:@selector(wsGetFilterListing) onTarget:self withObject:nil animated:YES];
    }
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    SDImageCache *cache = [SDImageCache sharedImageCache];
    [cache clearMemory];
    [cache clearDiskOnCompletion:nil];
}



-(void)filterMethod:(UIButton *)sender
{
    if ([filterchk isEqualToString:@"no"])
    {
        [_tableviewFilter setContentOffset:CGPointMake(0,0)];
        
        filterchk=@"yes";
        _lblback.hidden = NO;
        _viewclear.hidden = NO;
        self.tableviewFilter.hidden=NO;
        
     //   _filtertblheight.constant= self.tableviewFilter.contentSize.height;
        //[self wsFilter];
       // [self.tableviewFilter reloadData];
        [leftbtn1 setTitleColor:[UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
    }
    
    else if ([filterchk isEqualToString:@"yes"])
    {
        filterchk=@"no";
        _lblback.hidden = YES;
        _viewclear.hidden = YES;
        self.tableviewFilter.hidden=YES;
        [leftbtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
}





- (IBAction)btnclear:(id)sender
{
//    for (int i =0; i<arrCat.count; i++)
//    {
//        NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
//
//        dictet =[[arrCat objectAtIndex:i] mutableCopy];
//
//        if (i == indexPath.row)
//        {
//            [dictet setObject:@"true" forKey:@"flag"];
//        }
//
//        else
//        {
//            [dictet setObject:@"false" forKey:@"flag"];
//        }
//
//        [arrCat replaceObjectAtIndex:i withObject:dictet];
//    }
    
//    [_collectionviewheader reloadData];
//
//    [_tableview1 setContentOffset:CGPointMake(0,0)];
//
//    [GiFHUD showWithOverlay];
//    //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        [self wsGetListing];
//        //
//    });
    
//    [HUD showWhileExecuting:@selector(wsGetListing) onTarget:self withObject:nil animated:YES];
    
    
    [GiFHUD showWithOverlay];
    //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self wsGetFilterListing];
        
    });
    
    
    
    
//    for (int i =0; i<arrFilter.count; i++)
//    {
//        NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
//
//        dictet =[[arrFilter objectAtIndex:i] mutableCopy];
//
//        [dictet setObject:@"false" forKey:@"flag"];
//
//        //                    if (i == 0)
//        //                    {
//        //                        [dictet setObject:@"true" forKey:@"flag"];
//        //                    }
//        //
//        //                    else
//        //                    {
//        //                        [dictet setObject:@"false" forKey:@"flag"];
//        //                    }
//
//        [arrFilter replaceObjectAtIndex:i withObject:dictet];
//    }
//
//    [self.tableviewFilter reloadData];
}




- (IBAction)viewcart:(id)sender
{
    if (arrweeklydata.count > 0)
    {
//        WeeklyViewCart *cart =[[WeeklyViewCart alloc]init];
//        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
//        [self.navigationController pushViewController:cart animated:YES];
        
        NSString *str;
        NSMutableArray *arrcount = [[NSMutableArray alloc]init];
        for (int i = 0; i<arrweeklydata.count; i++)
        {
            NSArray *arr = [[arrweeklydata objectAtIndex:i] valueForKey:@"products"];
            
            if (arr.count == 0)
            {
                str = [NSString stringWithFormat:@"Don't forget to select your meals for %@",[[arrweeklydata objectAtIndex:i] valueForKey:@"SelectedDate"]];

                int temp = i;

                [arrcount addObject:[NSString stringWithFormat:@"%d",temp]];
                
                break;
            }
        }

        if (arrcount.count == 0)
        {
            WeeklyViewCart *cart =[[WeeklyViewCart alloc]init];
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
            [self.navigationController pushViewController:cart animated:YES];
        }

        else if (arrcount.count == 1)
        {
            UIAlertController *alert = [UIAlertController
                                         alertControllerWithTitle:nil
                                         message:str
                                         preferredStyle:UIAlertControllerStyleAlert];
            
            //Add Buttons
            
            UIAlertAction *yesButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {

                                            WeeklyViewCart *cart =[[WeeklyViewCart alloc]init];
                                            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                                            [self.navigationController pushViewController:cart animated:YES];
                                        }];
            
            
            //Add your buttons to alert controller
            
            [alert addAction:yesButton];
            
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        else if (arrcount.count > 1)
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:nil
                                         message:@"Please add products for remaining days."
                                         preferredStyle:UIAlertControllerStyleAlert];

            //Add Buttons

            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:@"OK"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action) {

                                            WeeklyViewCart *cart =[[WeeklyViewCart alloc]init];
                                            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                                            [self.navigationController pushViewController:cart animated:YES];
                                        }];


            //Add your buttons to alert controller

            [alert addAction:yesButton];

            [self presentViewController:alert animated:YES completion:nil];
        }
    }
    
    else
    {
        CartViewController *cart =[[CartViewController alloc]init];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:cart animated:YES];
    }
}




- (IBAction)btnpreviousDate:(id)sender
{
    int totalcount = 0;
    int totalquantity = 0;
    
    _imgnext.image =[UIImage imageNamed:@"KL_APP_About_Us.jpg"];
    _imgprevious.image =[UIImage imageNamed:@"left_arrow_green"];
    
    if (currentindex >=1 )
    {
        currentindex --;
    }
    
    
    if (arrweeklydata.count <=1)
    {
        _imgprevious.image =[UIImage imageNamed:@"left-arrow.png"];
        _imgnext.image =[UIImage imageNamed:@"right-arrow.png"];
    }
    
    else if (currentindex == 0)
    {
        _imgprevious.image =[UIImage imageNamed:@"left-arrow.png"];
        _imgnext.image =[UIImage imageNamed:@"KL_APP_About_Us.jpg"];
    }
    
    else if (currentindex == arrweeklydata.count)
    {
        _imgprevious.image =[UIImage imageNamed:@"left_arrow_green"];
        _imgnext.image =[UIImage imageNamed:@"right-arrow.png"];
    }
    
    else if (currentindex <arrweeklydata.count)
    {
        _imgprevious.image =[UIImage imageNamed:@"left_arrow_green"];
        _imgnext.image =[UIImage imageNamed:@"KL_APP_About_Us.jpg"];
    }
    
    else
    {
        _imgprevious.image =[UIImage imageNamed:@"left_arrow_green"];
    }
    
    for (int i =0; i<arrweeklydata.count; i++)
    {
        if (currentindex == i)
        {
            NSString *datelength = [NSString stringWithFormat:@"%@",[[arrweeklydata objectAtIndex:currentindex]valueForKey:@"SelectedDate"]];
            
            datelength =[datelength stringByReplacingOccurrencesOfString:@"Sunday" withString:@"Sun"];
            datelength =[datelength stringByReplacingOccurrencesOfString:@"Monday" withString:@"Mon"];
            datelength =[datelength stringByReplacingOccurrencesOfString:@"Tuesday" withString:@"Tue"];
            datelength =[datelength stringByReplacingOccurrencesOfString:@"Wednesday" withString:@"Wed"];
            datelength =[datelength stringByReplacingOccurrencesOfString:@"Thursday" withString:@"Thu"];
            datelength =[datelength stringByReplacingOccurrencesOfString:@"Friday" withString:@"Fri"];
            datelength =[datelength stringByReplacingOccurrencesOfString:@"Saturday" withString:@"Sat"];
            
            _lblselectedDate.text = datelength;
            
            NSMutableDictionary *dictemp =[[NSMutableDictionary alloc]init];
            dictemp =[[arrweeklydata objectAtIndex:i] mutableCopy];
            
            NSArray *arrpro = [[NSArray alloc]init];
            
            arrpro = [dictemp valueForKey:@"products"];
            
            for (int j =0; j<arrpro.count; j++)
            {
                totalquantity = totalquantity +1;
                
                NSString *price =[NSString stringWithFormat:@"%@",[[arrpro objectAtIndex:j]valueForKey:@"totalprice"]];
                
                int cswjf =[price intValue];
                
                totalcount = totalcount + cswjf;
            }
            
            if (arrpro.count == 0)
            {
                [_viewcart setHidden:YES];
                _viewcartheight.constant = 0;
            }
            
            else
            {
                [_viewcart setHidden:NO];
                _viewcartheight.constant = 75;
            }
            
            
            if (arrpro.count == 1)
            {
                _lblitems.text =[NSString stringWithFormat:@"%d Item", totalquantity];
            }
            
            else
            {
                _lblitems.text =[NSString stringWithFormat:@"%d Items", totalquantity];
            }
            
            [dictemp setObject:@"yes" forKey:@"isclicked"];
            
            [arrweeklydata replaceObjectAtIndex:i withObject:dictemp];
        }
        
        else
        {
            NSMutableDictionary *dictemp =[[NSMutableDictionary alloc]init];
            dictemp =[[arrweeklydata objectAtIndex:i] mutableCopy];
            
            [dictemp setObject:@"no" forKey:@"isclicked"];
            
            [arrweeklydata replaceObjectAtIndex:i withObject:dictemp];
        }
    }
    
//    if (arrweeklydata.count == 1)
//    {
//        _lblitems.text =[NSString stringWithFormat:@"%d Item", totalquantity];
//    }
//
//    else
//    {
//        _lblitems.text =[NSString stringWithFormat:@"%d Items", totalquantity];
//    }
    
    _lblprice.text =[NSString stringWithFormat:@"AED %d", totalcount];
}





- (IBAction)btnnextDate:(id)sender
{
    int totalcount = 0;
    int totalquantity = 0;
    
    
    if (currentindex <arrweeklydata.count-1)
    {
        currentindex ++;
    }
    
    
    _imgnext.image =[UIImage imageNamed:@"KL_APP_About_Us.jpg"];
    _imgprevious.image =[UIImage imageNamed:@"left_arrow_green"];
    
    
    if (arrweeklydata.count <=1)
    {
        _imgprevious.image =[UIImage imageNamed:@"left-arrow.png"];
        _imgnext.image =[UIImage imageNamed:@"right-arrow.png"];
    }
    
    else if (currentindex == 0)
    {
        _imgprevious.image =[UIImage imageNamed:@"left_arrow_green"];
        _imgnext.image =[UIImage imageNamed:@"KL_APP_About_Us.jpg"];
    }
    
    else if (currentindex >= arrweeklydata.count-1)
    {
        _imgprevious.image =[UIImage imageNamed:@"left_arrow_green"];
        _imgnext.image =[UIImage imageNamed:@"right-arrow.png"];
    }
    
    else if (currentindex <arrweeklydata.count)
    {
        _imgprevious.image =[UIImage imageNamed:@"left_arrow_green"];
        _imgnext.image =[UIImage imageNamed:@"KL_APP_About_Us.jpg"];
    }
    
    else
    {
        
    }
    
    for (int i =0; i<arrweeklydata.count; i++)
    {
        if (currentindex == i)
        {
            NSString *datelength = [NSString stringWithFormat:@"%@",[[arrweeklydata objectAtIndex:currentindex]valueForKey:@"SelectedDate"]];
            
            datelength =[datelength stringByReplacingOccurrencesOfString:@"Sunday" withString:@"Sun"];
            datelength =[datelength stringByReplacingOccurrencesOfString:@"Monday" withString:@"Mon"];
            datelength =[datelength stringByReplacingOccurrencesOfString:@"Tuesday" withString:@"Tue"];
            datelength =[datelength stringByReplacingOccurrencesOfString:@"Wednesday" withString:@"Wed"];
            datelength =[datelength stringByReplacingOccurrencesOfString:@"Thursday" withString:@"Thu"];
            datelength =[datelength stringByReplacingOccurrencesOfString:@"Friday" withString:@"Fri"];
            datelength =[datelength stringByReplacingOccurrencesOfString:@"Saturday" withString:@"Sat"];
            
            _lblselectedDate.text = datelength;
            
            NSMutableDictionary *dictemp =[[NSMutableDictionary alloc]init];
            
            dictemp =[[arrweeklydata objectAtIndex:i] mutableCopy];
            
            NSArray *arrpro = [[NSArray alloc]init];
            
            arrpro = [dictemp valueForKey:@"products"];
            
            for (int j =0; j<arrpro.count; j++)
            {
                totalquantity = totalquantity +1;
                
                NSString *price =[NSString stringWithFormat:@"%@",[[arrpro objectAtIndex:j]valueForKey:@"totalprice"]];
                
                int cswjf =[price intValue];
                
                totalcount = totalcount + cswjf;
            }
            
            if (arrpro.count == 0)
            {
                [_viewcart setHidden:YES];
                _viewcartheight.constant = 0;
            }
            
            else
            {
                [_viewcart setHidden:NO];
                _viewcartheight.constant = 75;
            }
            
            
            if (arrpro.count == 1)
            {
                _lblitems.text =[NSString stringWithFormat:@"%d Item", totalquantity];
            }
            
            else
            {
                _lblitems.text =[NSString stringWithFormat:@"%d Items", totalquantity];
            }
            
            [dictemp setObject:@"yes" forKey:@"isclicked"];
            
            [arrweeklydata replaceObjectAtIndex:i withObject:dictemp];
        }
        
        else
        {
            NSMutableDictionary *dictemp =[[NSMutableDictionary alloc]init];
            dictemp =[[arrweeklydata objectAtIndex:i] mutableCopy];
            
            [dictemp setObject:@"no" forKey:@"isclicked"];
            
            [arrweeklydata replaceObjectAtIndex:i withObject:dictemp];
        }
    }
    
//    if (arrweeklydata.count == 1)
//    {
//        _lblitems.text =[NSString stringWithFormat:@"%d Item", totalquantity];
//    }
//
//    else
//    {
//        _lblitems.text =[NSString stringWithFormat:@"%d Items", totalquantity];
//    }
    
    _lblprice.text =[NSString stringWithFormat:@"AED %d", totalcount];
}




#pragma mark <--Web Services-->

-(void)wsFilter
{
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"request=%@&key=%@&secret=%@",@"menu-filter-options",str_key,str_secret];
    
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
        
        //dispatch_async(dispatch_get_main_queue(),^{
            
            if([errorCode isEqualToString:@"1"])
            {
                arrFilter = [[dictionary valueForKey:@"data"] mutableCopy];
                
                for (int i =0; i<arrFilter.count; i++)
                {
                    NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
                    
                    dictet =[[arrFilter objectAtIndex:i] mutableCopy];
                    
                    [dictet setObject:@"false" forKey:@"flag"];
                    
//                    if (i == 0)
//                    {
//                        [dictet setObject:@"true" forKey:@"flag"];
//                    }
//
//                    else
//                    {
//                        [dictet setObject:@"false" forKey:@"flag"];
//                    }
                    
                    [arrFilter replaceObjectAtIndex:i withObject:dictet];
                }
                
                [self.tableviewFilter reloadData];
                
//                _filtertblheight.constant = self.tableviewFilter.contentSize.height-80;
                
                _filtertblheight.constant = 210;
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
        //});
    }
}




-(void)wsGetCategories
{
    BaseViewController *base=[[BaseViewController alloc]init];
    strBranchId = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"shopId"]];
    
    if ([strBranchId isEqualToString:@"(null)"])
    {
        strBranchId = @"";
    }
    
    else
    {
        
    }
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"request=%@&language=%@&branchID=%@&key=%@&secret=%@",@"menu",@"en",strBranchId,str_key,str_secret];
    
    NSDictionary *dictionary = [[NSMutableDictionary alloc]init];
    
    dictionary=[base WebParsingMethod:stringWebServicesCompleteUrl :parameter];
    //[HUD hide:YES];
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
        NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            if([errorCode isEqualToString:@"1"])
            {
                NSMutableArray *arrpro = [[NSMutableArray alloc]init];
                NSMutableArray *arrcategory = [[NSMutableArray alloc]init];
                arrCat = [[NSMutableArray alloc]init];
                
                if (_arrpromolist.count > 0)
                {
                    for (int i = 0; i<_arrpromolist.count; i++)
                    {
                        NSMutableDictionary *dictet = [[NSMutableDictionary alloc]init];
                        
                        dictet = [[_arrpromolist objectAtIndex:i] mutableCopy];
                        
                        [arrCat addObject:dictet];
                        
                        
                        if (arrCat.count > 0)
                        {
                            for (int i = 0; i<arrCat.count; i++)
                            {
                                NSMutableDictionary *dictet = [[NSMutableDictionary alloc]init];
                                
                                dictet = [[arrCat objectAtIndex:i] mutableCopy];
                                
                                if (i == 0)
                                {
                                    [dictet setObject:@"true" forKey:@"flag"];
                                }
                                
                                else
                                {
                                    [dictet setObject:@"false" forKey:@"flag"];
                                }
                                
                                [arrCat replaceObjectAtIndex:i withObject:dictet];
                            }
                        }
                        
                        
                        arrProducts = [[arrCat objectAtIndex:0] valueForKey:@"group1_products"];
                        
                        arrgroup2 = [[arrCat objectAtIndex:0] valueForKey:@"group2_products"];
                        
                        stroffername = [[arrCat objectAtIndex:0] valueForKey:@"name"];
                        strofferline = [[arrCat objectAtIndex:0] valueForKey:@"group2_name"];
                        
                        leftbtn1.hidden = YES;
                        
                        if (arrProducts.count == 0)
                        {
                            [_lblnorecord setHidden:NO];
                            _tableview1.hidden = YES;
                        }
                        
                        else
                        {
                            [_lblnorecord setHidden:YES];
                            _tableview1.hidden = NO;
                        }
                        
                        NSMutableArray *arrter =[[NSMutableArray alloc]init];
                        
                        for (int j = 0; j<arrProducts.count; j++)
                        {
                            NSString *str = [NSString stringWithFormat:@"%@",[arrProducts objectAtIndex:j]];
                            
                            if (![str isEqualToString:@"0"])
                            {
                                [arrter addObject:[arrProducts objectAtIndex:j]];
                            }
                        }
                        
                        arrProducts = [[NSMutableArray alloc]init];
                        
                        arrProducts =[arrter mutableCopy];
                        
                        [self.tableview1 reloadData];
                        [_collectionviewheader reloadData];
                        
                        _collectionviewheader.userInteractionEnabled = NO;
                    }
                }
                
                else
                {
                    if ([[[NSUserDefaults standardUserDefaults]valueForKey:@"weeklyorderclicked"]isEqualToString:@"yes"])
                    {
                        
                    }
                    
                    else
                    {
                        arrpro = [[dictionary valueForKey:@"promotions"] mutableCopy];
                        
                        if (arrpro.count > 0)
                        {
                            for (int i = 0; i<arrpro.count; i++)
                            {
                                NSMutableDictionary *dictet = [[NSMutableDictionary alloc]init];
                                
                                dictet = [[arrpro objectAtIndex:i] mutableCopy];
                                
                                //                        if (i == 0)
                                //                        {
                                //                            [dictet setObject:@"true" forKey:@"flag"];
                                //                        }
                                //
                                //                        else
                                //                        {
                                //                            [dictet setObject:@"false" forKey:@"flag"];
                                //                        }
                                
                                [arrpro replaceObjectAtIndex:i withObject:dictet];
                                
                                [arrCat addObject:dictet];
                            }
                        }
                        
                        else
                        {
                            
                        }
                    }
                    
                    
                    arrcategory=[[dictionary valueForKey:@"categories"] mutableCopy];
                    
                    if (arrcategory.count > 0)
                    {
                        for (int i =0; i<arrcategory.count; i++)
                        {
                            NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
                            
                            dictet =[[arrcategory objectAtIndex:i] mutableCopy];
                            
                            //                        if (i == 0)
                            //                        {
                            //                            [dictet setObject:@"true" forKey:@"flag"];
                            //                        }
                            //
                            //                        else
                            //                        {
                            //                            [dictet setObject:@"false" forKey:@"flag"];
                            //                        }
                            //
                            //                        [arrcategory replaceObjectAtIndex:i withObject:dictet];
                            
                            [arrCat addObject:dictet];
                        }
                    }
                    
                    else
                    {
                        
                    }
                    
                    
                    if (arrCat.count > 0)
                    {
                        for (int i = 0; i<arrCat.count; i++)
                        {
                            NSMutableDictionary *dictet = [[NSMutableDictionary alloc]init];
                            
                            dictet = [[arrCat objectAtIndex:i] mutableCopy];
                            
                            if (i == 0)
                            {
                                [dictet setObject:@"true" forKey:@"flag"];
                            }
                            
                            else
                            {
                                [dictet setObject:@"false" forKey:@"flag"];
                            }
                            
                            [arrCat replaceObjectAtIndex:i withObject:dictet];
                        }
                    }
                    
                    
                    [self.collectionviewheader reloadData];
                    
                    if ([[arrCat objectAtIndex:0] valueForKey:@"categoryID"])
                    {
                        catid = [[arrCat objectAtIndex:0] valueForKey:@"categoryID"];
                        leftbtn1.hidden = NO;
                        int index = 0;
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        
                        NSString *strindex = [NSString stringWithFormat:@"%d",index];
                        [defaults setObject:strindex forKey:@"index"];
                        [self wsGetListing];
                    }
                    
                    else
                    {
                        proid = [[arrCat objectAtIndex:0] valueForKey:@"promotionID"];
                        stroffername = [[arrCat objectAtIndex:0] valueForKey:@"name"];
                        strofferline = [[arrCat objectAtIndex:0] valueForKey:@"group2_name"];
                        leftbtn1.hidden = YES;
                        
                        int index = 0;
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        
                        NSString *strindex = [NSString stringWithFormat:@"%d",index];
                        [defaults setObject:strindex forKey:@"index"];
                        [self wsGetPromotionListing];
                    }
                }
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




-(void)wsGetListing
{
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"request=%@&language=%@&categoryID=%@&branchID=%@&key=%@&secret=%@",@"menu",@"en",catid,strBranchId,str_key,str_secret];
    
    NSDictionary *dictionary = [[NSMutableDictionary alloc]init];
    
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
        NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
        
        //dispatch_async(dispatch_get_main_queue(),^{
            
            if([errorCode isEqualToString:@"1"])
            {
                arrgroup2 = [[NSMutableArray alloc]init];
                
                NSArray *arrCat=[dictionary valueForKey:@"category"];
                
                arrProducts=[arrCat valueForKey:@"items"];
                
                if (arrProducts.count == 0)
                {
                    [_lblnorecord setHidden:NO];
                    _tableview1.hidden = YES;
                }
                
                else
                {
                    [_lblnorecord setHidden:YES];
                    _tableview1.hidden = NO;
                }
                
                [self.tableview1 reloadData];
                [_collectionviewheader reloadData];
                leftbtn1.hidden = NO;
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
        //});
    }
}





-(void)wsGetPromotionListing
{
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"request=%@&language=%@&promotionID=%@&branchID=%@&key=%@&secret=%@",@"menu",@"en",proid,strBranchId,str_key,str_secret];
    
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
        NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
        
        //dispatch_async(dispatch_get_main_queue(),^{
            
            if([errorCode isEqualToString:@"1"])
            {
                arrProducts = [[dictionary valueForKey:@"group1_products"] mutableCopy];
                
                arrgroup2 = [[dictionary valueForKey:@"group2_products"] mutableCopy];
                
                NSMutableArray *arrrtempo = [[NSMutableArray alloc]init];
                
                for (int u = 0; u<arrProducts.count; u++)
                {
                    NSMutableDictionary *dictemp =[[NSMutableDictionary alloc]init];
                    
                    NSString *strtemp =[NSString stringWithFormat:@"%@",[arrProducts objectAtIndex:u]];
                    
                    if ([strtemp containsString:@"{"])
                    {
                        dictemp = [arrProducts objectAtIndex:u];
                        
                        [arrrtempo addObject:dictemp];
                    }
                }
                
                arrProducts = [arrrtempo mutableCopy];
                
                
                NSMutableArray *arrgrp2 = [[NSMutableArray alloc]init];
                
                for (int z = 0; z<arrgroup2.count; z++)
                {
                    NSMutableDictionary *dictemp =[[NSMutableDictionary alloc]init];
                    
                    NSString *strtemp =[NSString stringWithFormat:@"%@",[arrgroup2 objectAtIndex:z]];
                    
                    if ([strtemp containsString:@"{"])
                    {
                        dictemp = [arrgroup2 objectAtIndex:z];
                        
                        [arrgrp2 addObject:dictemp];
                    }
                }
                
                arrgroup2 = [arrgrp2 mutableCopy];
                
                
                if (arrProducts.count == 0)
                {
                    [_lblnorecord setHidden:NO];
                    _tableview1.hidden = YES;
                }
                
                else
                {
                    [_lblnorecord setHidden:YES];
                    _tableview1.hidden = NO;
                }
                
                [self.tableview1 reloadData];
                [_collectionviewheader reloadData];
                leftbtn1.hidden = YES;
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
        //});
    }
}




-(void)wsGetFilterListing
{
    NSString *joinedComponents = @"";
    
    if (arrID.count == 1)
    {
        joinedComponents = [NSString stringWithFormat:@"%@",[arrID objectAtIndex:0]];
    }
    
    else if (arrID.count > 1)
    {
        joinedComponents = [arrID componentsJoinedByString:@","];
    }
    
    else
    {
        
    }
    
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"request=%@&language=%@&categoryID=%@&symbols=%@&key=%@&secret=%@",@"menu",@"en",catid,joinedComponents,str_key,str_secret];
    
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
        NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
        
        //dispatch_async(dispatch_get_main_queue(),^{
            
            if([errorCode isEqualToString:@"1"])
            {
                NSArray *arrCat=[dictionary valueForKey:@"category"];
                
                arrProducts=[arrCat valueForKey:@"items"];
                
                if (arrProducts.count == 0)
                {
                    [_lblnorecord setHidden:NO];
                    _tableview1.hidden = YES;
                }
                
                else
                {
                    [_lblnorecord setHidden:YES];
                    _tableview1.hidden = NO;
                    
                }
                
                [self.tableview1 reloadData];
                
                filterchk=@"no";
                _lblback.hidden = YES;
                _viewclear.hidden = YES;
                self.tableviewFilter.hidden=YES;
                [leftbtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
            
            else if ([errorCode isEqualToString:@"2"])
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
                
                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                
                                                
                                            }];
                
                [alert addAction:yesButton];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
        //});
    }
}




@end

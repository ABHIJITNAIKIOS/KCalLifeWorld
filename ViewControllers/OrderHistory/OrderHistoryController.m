//
//  OrderHistoryController.m
//  KCal
//
//  Created by Pipl-10 on 28/06/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "OrderHistoryController.h"
#import "AccordionHeaderView.h"
#import "PreOrederDetailsTableViewCell.h"
#import "SubmenuCell.h"
#import "MenuViewController.h"
#import "BaseViewController.h"
#import "AppDelegate.h"
#import "GiFHUD.h"
#import "CartViewController.h"
#import "AddDeliveryaddressController.h"
#import "HomeTableViewCell.h"
#import "WorkTableViewCell.h"
#import "AddressTableViewCell.h"
#import "CalenderViewController.h"
#import "SlideNavigationController.h"
#import "LeftMenuViewController.h"
#import "MyAccountViewController.h"

static NSString *const kTableViewCellReuseIdentifier = @"TableViewCellReuseIdentifier";

@interface OrderHistoryController ()
{
    NSString *flagopencondtion;
    PreOrederDetailsTableViewCell *cell;
    SubmenuCell *cell1;
    NSString *str_date,*str_date1;
    NSMutableArray *arrdict,*arritems;
    AccordionHeaderView* headerCell;
    int sectionnum;
    NSMutableArray *arrdays;
    NSMutableDictionary *dictoptions;
    NSMutableArray *arrtemp;
    AddressTableViewCell *cell3;
    HomeTableViewCell *cell2;
    WorkTableViewCell *cell11;
    NSMutableArray *arrdata;
    NSMutableArray *arrdata1;
    NSArray *area;
    NSDictionary *dictime,*dictshop, *dictavailable;
    NSString *strlocation,*strcity,*selecteddate;
    NSString *strtime;
    NSString *strEndTime,*strStartTime,*flagTimer,*mintime, *strstart, *strend;
    NSInteger minute;
    int endtime,starttime,startday,startmonth,startyear,endday,endmonth,endyear;
    CGFloat screenWidth;
    CGFloat screenHeight;
    NSString *flagminiumdate,*status;
    NSTimer *time;
}

@end

@implementation OrderHistoryController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [time invalidate];
    time = nil;
    
    dictshop = [[NSDictionary alloc] init];
    dictime = [[NSDictionary alloc] init];
    dictavailable = [[NSDictionary alloc] init];
    
    flagminiumdate =@"yes";
    arrdays = [[NSMutableArray alloc]init];
    arrdict = [[NSMutableArray alloc]init];
    self.tbldata.delegate = self;
    _lblnorecords.hidden=YES;
    _tbldata.hidden=YES;
    self.tbldata.dataSource = self;
    self.title = @"Order History";
    self.navigationItem.hidesBackButton = YES;
    self.tbldata.allowMultipleSectionsOpen=YES;
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    defaults = [NSUserDefaults standardUserDefaults];
    self.tbldata.allowMultipleSectionsOpen=NO;
    screenWidth = [UIScreen mainScreen].bounds.size.width;
    screenHeight = [UIScreen mainScreen].bounds.size.height;
    status=[defaults valueForKey:@"status"];
    [self.view addSubview:_viewpicker];
    [self.view addSubview:_viewhungry];
    [self.view addSubview:_viewredirect];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"cartcomment"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"riderinstruction"];
    
    _viewredirect.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, screenWidth, screenHeight);
    
    _viewhungry.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, screenWidth, screenHeight);
    
    _viewpicker.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, screenWidth, screenHeight);
    
    self.viewredirect.hidden=YES;
    _viewhungry.hidden = YES;
    _viewpicker.hidden = YES;
    
    UIColor *color = [UIColor colorWithRed:108/255.0f green:108/255.0f blue:110/255.0f alpha:1];
    
    self.txtdeliveryaddress.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Where are we delivering?" attributes:@{NSForegroundColorAttributeName: color}];
    
    _datepicker.backgroundColor = [UIColor whiteColor];
    [_datepicker setValue:[UIColor colorWithRed:119.0/255.0f green:189.0/255.0f blue:29.0/255.0f alpha:1] forKey:@"textColor"];
    
//    if([self.flag isEqualToString:@"yes"])
//    {
//        self.viewredirect.hidden=NO;
//    }
//
//    else
//    {
//        self.viewredirect.hidden=YES;
//    }
    
    [GiFHUD setGifWithImageName:@"Spinner3.gif"];
    
    self.viewhungry.hidden=YES;
    _viewpicker.hidden=YES;
    [self.tbldata registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewCellReuseIdentifier];
    [self.tbldata registerNib:[UINib nibWithNibName:@"AccordionHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:kAccordionHeaderViewReuseIdentifier];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"handle_data" object:self];
    
    [self wsGetAddress];
    
    _tbldata.estimatedRowHeight = UITableViewAutomaticDimension;
    _tbldata.rowHeight = UITableViewAutomaticDimension;
}




-(void)viewDidAppear:(BOOL)animated
{
    [GiFHUD showWithOverlay];
    //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self wsGetOrderHistory];
    });
    
    
    for (UIButton *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 134)
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
        
        if (view.tag == 230)
        {
            [view removeFromSuperview];
        }
    }
}



-(void)viewDidDisappear:(BOOL)animated
{
    [time invalidate];
    time = nil;
}






- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.tbladdress)
    {
        return arrdata.count;
    }
    
    else
    {
        return 1;
    }
    
    return 0;
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==self.tbladdress)
    {
        return 1;
    }
    
    else
    {
        return arrdict.count;
    }
}





- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==self.tbldata)
    {
        return 44;
    }
    
    else
    {
        return 0;
    }
    
    return 0;
}





-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _tbldata)
    {
        NSMutableArray *temp1 = [[NSMutableArray alloc]init];
        NSLog(@"indexPath.row=%ld",(long)indexPath.row);
        NSLog(@"cell1.CHTdynamic.constant=%f",cell1.CHTdynamic.constant);
        
        NSMutableArray *arrlist = [[NSMutableArray alloc]init];
        
        NSMutableArray *temp = [[arrdict objectAtIndex:sectionnum] valueForKey:@"days"];
        
        
        if (temp.count > 1)
        {
            for (int i = 0; i<temp.count; i++)
            {
                NSMutableArray *arr = [[NSMutableArray alloc]init];
                NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];

                arr = [[[temp objectAtIndex:i] valueForKey:@"items"] mutableCopy];

                for (int j = 0; j<arr.count; j++)
                {
                    dict = [[arr objectAtIndex:j] mutableCopy];

                    [arrlist addObject:dict];
                }
            }

            NSMutableArray *ttt = [[NSMutableArray alloc]init];

            for(int i=0;i<arrlist.count;i++)
            {
                ttt = [[arrlist objectAtIndex:i] valueForKey:@"options"];

                if(ttt.count > 0)
                {
                    temp1 = [[arrlist objectAtIndex:i] valueForKey:@"options"];
                }
            }

            NSInteger height;

            NSString *str = [NSString stringWithFormat:@"%@",[[arrlist objectAtIndex:0] valueForKey:@"name"]];

            if ([str rangeOfString:@"+"].location == NSNotFound)
            {
                NSLog(@"string does not contain +");

                cell.btnreOrder.hidden = NO;

                cell.btnreorderheight.constant = 45;

//                if(arrlist.count == 2)
//                {
//                    if (temp1.count == 1)
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*60));
//                    }
//
//                    else if (temp1.count == 2)
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*80));
//                    }
//
//                    else if (temp1.count == 3)
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*90));
//                    }
//
//                    else if (temp1.count > 3)
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*100));
//                    }
//
//                    else
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*50));
//                    }
//                }
//
//                else if(arrlist.count == 3)
//                {
//                    if (temp1.count == 1)
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*120));
//                    }
//
//                    else if (temp1.count == 2)
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*115));
//                    }
//
//                    else if (temp1.count == 3)
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*100));
//                    }
//
//                    else if (temp1.count > 3)
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*120));
//                    }
//
//                    else
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*70));
//                    }
//                }
//
//                else if(arrlist.count == 4)
//                {
//                    if (temp1.count == 1)
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*60));
//                    }
//
//                    else if (temp1.count == 2)
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*150));
//                    }
//
//                    else if (temp1.count == 3)
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*160));
//                    }
//
//                    else if (temp1.count > 3)
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*170));
//                    }
//
//                    else
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*50));
//                    }
//                }
//
//                else if(arrlist.count > 4)
//                {
//                    if (temp1.count == 1)
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*60));
//                    }
//
//                    else if (temp1.count == 2)
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*140));
//                    }
//
//                    else if (temp1.count == 3)
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*170));
//                    }
//
//                    else if (temp1.count > 3)
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*180));
//                    }
//
//                    else
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*50));
//                    }
//                }
//
//                else
//                {
//                    if (temp1.count == 1)
//                    {
//                        height = ( arrlist.count *30)+70+(((arrlist.count+1)*50));
//                    }
//
//                    else if (temp1.count == 2)
//                    {
//                        height = ( arrlist.count *30)+70+(((arrlist.count+1)*70));
//                    }
//
//                    else if (temp1.count == 3)
//                    {
//                        height = ( arrlist.count *30)+70+(((arrlist.count+1)*90));
//                    }
//
//                    else if (temp1.count > 3)
//                    {
//                        height = ( arrlist.count *30)+70+(((arrlist.count+1)*125));
//                    }
//
//                    else
//                    {
//                        height = ( arrlist.count *30)+70+(((arrlist.count+1)*30));
//                    }
//                }
                
                height = ( arrlist.count *30)+70+(((arrlist.count+1)*60));
            }

            else
            {
                NSLog(@"string contains +!");

                cell.btnreOrder.hidden = NO;

                cell.btnreorderheight.constant = 45;

//                if(arrlist.count == 2)
//                {
//                    if (temp1.count == 1)
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*45))-50;
//                    }
//
//                    else if (temp1.count == 2)
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*45))-40;
//                    }
//
//                    else if (temp1.count == 3)
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*45))-30;
//                    }
//
//                    else if (temp1.count > 3)
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*45))-20;
//                    }
//
//                    else
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*45))-60;
//                    }
//                }
//
//                else if(arrlist.count > 2)
//                {
//                    if (temp1.count == 1)
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*45))-50;
//                    }
//
//                    else if (temp1.count == 2)
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*45))-40;
//                    }
//
//                    else if (temp1.count == 3)
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*45))-30;
//                    }
//
//                    else if (temp1.count > 3)
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*45))-20;
//                    }
//
//                    else
//                    {
//                        height = ( arrlist.count *30)+70+(((temp1.count+1)*45))-60;
//                    }
//                }
//
//                else
//                {
//                    if (temp1.count == 1)
//                    {
//                        height = ( arrlist.count *30)+70+(((arrlist.count+1)*40))-50;
//                    }
//
//                    else if (temp1.count == 2)
//                    {
//                        height = ( arrlist.count *30)+80+(((arrlist.count+1)*40));
//                    }
//
//                    else if (temp1.count == 3)
//                    {
//                        height = ( arrlist.count *30)+80+(((arrlist.count+1)*40));
//                    }
//
//                    else if (temp1.count > 3)
//                    {
//                        height = ( arrlist.count *30)+85+(((arrlist.count+1)*40));
//                    }
//
//                    else
//                    {
//                        height = ( arrlist.count *30)+70+(((arrlist.count+1)*40))-60;
//                    }
//                }
                
                height = ( arrlist.count *30)+70+(((arrlist.count+1)*60))-60;
            }

            return 230;
        }

        else
        {
            NSMutableArray *temp = [[NSMutableArray alloc]init];

            temp = [[[[arrdict objectAtIndex:sectionnum] valueForKey:@"days"] objectAtIndex:0] valueForKey:@"items"];

            NSMutableArray *ttt = [[NSMutableArray alloc]init];

            //temp1 = [[temp objectAtIndex:indexPath.row] valueForKey:@"options"];

            for(int i=0;i<temp.count;i++)
            {
                ttt = [[temp objectAtIndex:i] valueForKey:@"options"];

                if(ttt.count > 0)
                {
                    temp1 = [[temp objectAtIndex:i] valueForKey:@"options"];
                }
            }

            NSInteger height;

            NSString *str = [NSString stringWithFormat:@"%@",[[temp objectAtIndex:0] valueForKey:@"name"]];

            if ([str rangeOfString:@"+"].location == NSNotFound)
            {
                NSLog(@"string does not contain +");

                cell.btnreOrder.hidden = NO;

                cell.btnreorderheight.constant = 45;

//                if(temp.count == 2)
//                {
//                    if (temp1.count == 1)
//                    {
//                        height = ( temp.count *30)+70+(((temp1.count+1)*70));
//                    }
//
//                    else if (temp1.count == 2)
//                    {
//                        height = ( temp.count *30)+70+(((temp1.count+1)*80));
//                    }
//
//                    else if (temp1.count == 3)
//                    {
//                        height = ( temp.count *30)+70+(((temp1.count+1)*90));
//                    }
//
//                    else if (temp1.count > 3)
//                    {
//                        height = ( temp.count *30)+70+(((temp1.count+1)*95));
//                    }
//
//                    else
//                    {
//                        height = ( temp.count *30)+70+(((temp1.count+1)*50));
//                    }
//                }
//
//                else if(temp.count == 3)
//                {
//                    if (temp1.count == 1)
//                    {
//                        height = ( temp.count *30)+70+(((temp1.count+1)*100));
//                    }
//
//                    else if (temp1.count == 2)
//                    {
//                        // julie 1st element
//                        height = ( temp.count *30)+70+(((temp1.count+1)*70));
//                    }
//
//                    else if (temp1.count == 3)
//                    {
//                        height = ( temp.count *30)+70+(((temp1.count+1)*100));
//                    }
//
//                    else if (temp1.count > 3)
//                    {
//                        height = ( temp.count *30)+70+(((temp1.count+1)*115));
//                    }
//
//                    else
//                    {
//                        height = ( temp.count *30)+70+(((temp1.count+1)*70));
//                    }
//                }
//
//                else if(temp.count == 4)
//                {
//                    if (temp1.count == 1)
//                    {
//                        height = ( temp.count *30)+70+(((temp1.count+1)*90));
//                    }
//
//                    else if (temp1.count == 2)
//                    {
//                        height = ( temp.count *30)+70+(((temp1.count+1)*100));
//                    }
//
//                    else if (temp1.count == 3)
//                    {
//                        height = ( temp.count *30)+70+(((temp1.count+1)*110));
//                    }
//
//                    else if (temp1.count > 3)
//                    {
//                        height = ( temp.count *30)+70+(((temp1.count+1)*120));
//                    }
//
//                    else
//                    {
//                        height = ( temp.count *30)+70+(((temp1.count+1)*80));
//                    }
//                }
//
//                else if (temp.count > 4)
//                {
//                    if (temp1.count == 1)
//                    {
//                        height = ( temp.count *30)+70+(((temp1.count+1)*100));
//                    }
//
//                    else if (temp1.count == 2)
//                    {
//                        height = ( temp.count *30)+70+(((temp1.count+1)*110));
//                    }
//
//                    else if (temp1.count == 3)
//                    {
//                        height = ( temp.count *30)+70+(((temp1.count+1)*120));
//                    }
//
//                    else if (temp1.count > 3)
//                    {
//                        height = ( temp.count *30)+70+(((temp1.count+1)*130));
//                    }
//
//                    else
//                    {
//                        height = ( temp.count *30)+70+(((temp1.count+1)*90));
//                    }
//                }
//
//                else
//                {
//                    if (temp1.count == 1)
//                    {
//                        height = ( temp.count *30)+70+(((temp.count+1)*50));
//                    }
//
//                    else if (temp1.count == 2)
//                    {
//                        height = ( temp.count *30)+70+(((temp.count+1)*70));
//                    }
//
//                    else if (temp1.count == 3)
//                    {
//                        height = ( temp.count *30)+70+(((temp.count+1)*90));
//                    }
//
//                    else if (temp1.count > 3)
//                    {
//                        height = ( temp.count *30)+70+(((temp.count+1)*115));
//                    }
//
//                    else
//                    {
//                        height = ( temp.count *30)+70+(((temp.count+1)*30));
//                    }
//                }
                
                height = ( temp.count *30)+70+(((temp.count+1)*60));
            }

            else
            {
                NSLog(@"string contains +!");

                cell.btnreOrder.hidden = NO;

                cell.btnreorderheight.constant = 45;

                if(temp.count >= 2)
                {
                    height = ( temp.count *30)+70+(((temp1.count+1)*45))-50;
                }

                else
                {
                    height = ( temp.count *30)+70+(((temp.count+1)*70))-50;
                }
            }

            return 225;
        }
        
        //return UITableViewAutomaticDimension;
    }
    
    else if(tableView == self.tbladdress)
    {
        return 56;
    }
    
    return 0;
}




//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    NSMutableArray *temp = [[arrdict objectAtIndex: sectionnum]valueForKey:@"items"];
//
//    NSInteger height = ( temp.count *30)+200;
//    return 600;
//}





- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    if ((tableView=self.tbldata))
    {
        return [self tableView:tableView heightForHeaderInSection:section];
    }

    return 0;
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _tbldata)
    {
        static NSString *cellIdentifier=@"cell";
        PreOrederDetailsTableViewCell *cell=(PreOrederDetailsTableViewCell *)[self.tbldata dequeueReusableCellWithIdentifier:cellIdentifier];
        
        NSArray *nib;
        nib=[[NSBundle mainBundle]loadNibNamed:@"PreOrederDetailsTableViewCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
        
        NSString *timeString = [[arrdict objectAtIndex:sectionnum] valueForKey:@"order_date"];
        
        NSArray *components = [timeString componentsSeparatedByString:@" "];
        NSString *time = components[1];
        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        dateFormatter.dateStyle=NSDateFormatterMediumStyle;
        [dateFormatter setDateFormat:@"HH:mm:ss"];
        NSDate *finaltime1 =[dateFormatter dateFromString:time];
        [dateFormatter setDateFormat:@"hh:mm a"];
        
        NSString *finaltime = [dateFormatter stringFromDate:finaltime1];
        
        finaltime =[finaltime stringByReplacingOccurrencesOfString:@"PM" withString:@"pm"];
        
        finaltime =[finaltime stringByReplacingOccurrencesOfString:@"AM" withString:@"am"];
        
        cell.btnreOrder.tag =indexPath.section;
        [cell.btnreOrder addTarget:self action:@selector(btnreorderpro:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.lblAdd.text = [NSString stringWithFormat:@"%@ %@ - %@ %@",@"Order No.",[[arrdict objectAtIndex:sectionnum] valueForKey:@"orderID"],@"Time",finaltime ];
        
        NSLog(@"%f",cell.tblheight.constant);
        
        NSLog(@"kDefaultAccordionHeaderViewHeight-%f",self.tbldata.contentSize.height);
        
        return cell;
    }
    
    else if(tableView == self.tbladdress)
    {
        if(arrdata.count>2)
        {
            arrtemp = [arrdata objectAtIndex:indexPath.row];
        }
        
        if(indexPath.row == 0)
        {
            NSArray *nib;
            
            cell11 = (WorkTableViewCell *)[self.tbladdress dequeueReusableCellWithIdentifier:@"cell1"];
            
            if (cell11 == nil) {
                nib = [[NSBundle mainBundle] loadNibNamed:@"WorkTableViewCell" owner:self options:nil];
            }
            
            cell11 = [nib objectAtIndex:0];
            cell11.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell11;
        }
        
        else if(indexPath.row == 1)
        {
            NSArray *nib;
            
            cell2 = (HomeTableViewCell *)[self.tbladdress dequeueReusableCellWithIdentifier:@"cell2"];
            
            if (cell2 == nil) {
                nib = [[NSBundle mainBundle] loadNibNamed:@"HomeTableViewCell" owner:self options:nil];
            }
            
            cell2 = [nib objectAtIndex:0];
            cell2.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell2;
        }
        
        else
        {
            NSArray *nib;
            //   NSString *tableIdentifier = @"cell3";
            cell3 = (AddressTableViewCell *)[self.tbladdress dequeueReusableCellWithIdentifier:@"cell3"];
            
            if (cell3 == nil) {
                nib = [[NSBundle mainBundle] loadNibNamed:@"AddressTableViewCell" owner:self options:nil];
            }
            
            cell3 = [nib objectAtIndex:0];
            
            cell3.lbladdress.text = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"title"]];
            
//            if([[[arrdata objectAtIndex:indexPath.row] valueForKey:@"type"] isEqualToString:@"2"])
//            {
//                cell3.lbladdress.text = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"title"]];
//            }
            
            cell3.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell3;
        }
    }
    
    return 0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _tbladdress)
    {
        NSString *strid =[NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"id"]];
        
        NSString *straddresstype = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"type"]];
        
        [[NSUserDefaults standardUserDefaults] setObject:straddresstype forKey:@"address_type"];
        
        NSString *street = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"street"]];
        
        [[NSUserDefaults standardUserDefaults] setObject:street forKey:@"street"];
        
        NSString *sublocation = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"sublocation"]];
        
        [[NSUserDefaults standardUserDefaults] setObject:sublocation forKey:@"sublocation"];
        
        NSString *location = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"location"]];
        
        NSString *city = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"city"]];
        
        [[NSUserDefaults standardUserDefaults] setObject:city forKey:@"city"];
        
        NSString *title = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"title"]];
        
        NSString *strmin_amount = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"min_amount"]];
        
        [[NSUserDefaults standardUserDefaults] setValue:strmin_amount forKey:@"min_amount"];
        
        NSString *strBranchId = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"shopId"]];
        
        [[NSUserDefaults standardUserDefaults] setValue:strBranchId forKey:@"shopId"];
        
        NSString *address = @"";
        
        if ([street isEqualToString:@""])
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
        
        [[NSUserDefaults standardUserDefaults] setObject:title forKey:@"address_title"];
        [[NSUserDefaults standardUserDefaults] setObject:strid forKey:@"address_id"];
        [[NSUserDefaults standardUserDefaults] setObject:address forKey:@"primaryaddress"];
        
        if (indexPath.row==0)
        {
            if([[[arrdata objectAtIndex:indexPath.row] valueForKey:@"type"] isEqualToString:@"1"])
            {
                NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                
                strlocation = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"location"]];
                strcity = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"city"]];
                NSString *strdelivery_time = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"delivery_time"]];
                
                [defaults setValue:strcity forKey:@"city"];
                [defaults setValue:strlocation forKey:@"location"];
                [defaults setValue:strdelivery_time forKey:@"delivery_time"];
                
                NSString *straddresstype = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"type"]];
                
                [[NSUserDefaults standardUserDefaults] setObject:straddresstype forKey:@"address_type"];
                
                NSString *street = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"street"] ];
                
                [[NSUserDefaults standardUserDefaults] setObject:street forKey:@"street"];
                
                NSString *sublocation = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"sublocation"] ];
                
                [[NSUserDefaults standardUserDefaults] setObject:sublocation forKey:@"sublocation"];
                
                NSString *location = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"location"] ];
                
                NSString *city = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"city"] ];
                
                NSString *address = @"";
                
                if ([street isEqualToString:@""])
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
                
                [defaults setValue:address forKey:@"primaryaddress"];
                
                
                if ([strlocation isEqualToString:@""])
                {
                    AddDeliveryaddressController *obj=[[AddDeliveryaddressController alloc]initWithNibName:@"AddDeliveryaddressController" bundle:nil];
                    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                    obj.strtitle = @"Work";
                    obj.flag = @"1";
                    [self.navigationController pushViewController:obj animated:YES];
                }
                
                else
                {
                    [self wsGetTimeforASAP];
                    
                    _viewhungry.hidden=NO;
                    _viewredirect.hidden=YES;
                }
            }
        }
        
        else if (indexPath.row==1)
        {
            if([[[arrdata objectAtIndex:indexPath.row] valueForKey:@"type"] isEqualToString:@"0"])
            {
                NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                
                strlocation = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"location"]];
                strcity = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"city"]];
                NSString *strdelivery_time = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"delivery_time"]];
                
                [defaults setValue:strdelivery_time forKey:@"delivery_time"];
                [defaults setValue:strcity forKey:@"city"];
                [defaults setValue:strlocation forKey:@"location"];
                
                NSString *straddresstype = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"type"]];
                
                [[NSUserDefaults standardUserDefaults] setObject:straddresstype forKey:@"address_type"];
                
                NSString *street = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"street"]];
                NSString *sublocation = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"sublocation"]];
                NSString *location = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"location"]];
                NSString *city = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"city"]];
                
                [[NSUserDefaults standardUserDefaults] setObject:street forKey:@"street"];
                [[NSUserDefaults standardUserDefaults] setObject:sublocation forKey:@"sublocation"];
                
                NSString *address = @"";
                
                if ([street isEqualToString:@""])
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
                
                [defaults setValue:address forKey:@"primaryaddress"];
                
                
                if ([strlocation isEqualToString:@""])
                {
                    AddDeliveryaddressController *obj=[[AddDeliveryaddressController alloc]initWithNibName:@"AddDeliveryaddressController" bundle:nil];
                    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                    obj.strtitle = @"Home";
                    obj.flag = @"0";
                    [self.navigationController pushViewController:obj animated:YES];
                }
                
                else
                {
                    [self wsGetTimeforASAP];
                    
                    _viewhungry.hidden=NO;
                    _viewredirect.hidden=YES;
                }
            }
        }
        
        else
        {
//            NSString *strtype =[NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"type"]];
//
//            if([strtype isEqualToString:@"2"])
//            {
                NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
                
                strlocation = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"location"]];
                strcity = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"city"]];
                NSString *street = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"street"]];
                NSString *sublocation = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"sublocation"]];
                NSString *location = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"location"]];
                NSString *city = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"city"]];
                NSString *strdelivery_time = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"delivery_time"]];
                NSString *straddresstype = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"type"]];
                
                [[NSUserDefaults standardUserDefaults] setObject:straddresstype forKey:@"address_type"];
                [[NSUserDefaults standardUserDefaults] setObject:street forKey:@"street"];
                [[NSUserDefaults standardUserDefaults] setObject:sublocation forKey:@"sublocation"];
                
                NSString *address = @"";
                
                if ([street isEqualToString:@""])
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
                
                [defaults setValue:strdelivery_time forKey:@"delivery_time"];
                [defaults setValue:address forKey:@"primaryaddress"];
                [defaults setValue:strcity forKey:@"city"];
                [defaults setValue:strlocation forKey:@"location"];
                
                [self wsGetTimeforASAP];
                
                _viewhungry.hidden=NO;
                _viewredirect.hidden=YES;
//            }
        }
    }
}



-(IBAction)btnreorderpro:(id)sender
{
    int count = (int) [sender tag];
    
    NSMutableArray *arrtemp = [[arrdict objectAtIndex:sectionnum] valueForKey:@"days"];
    
    if (arrtemp.count > 1)
    {
        [time invalidate];
        time = nil;
        
        NSData *data = [NSData data];
        
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        
        [defaults setObject:data forKey:@"weeklyorderarray"];
        [defaults setObject:@"no" forKey:@"weeklyorderclicked"];
        [defaults synchronize];
        
        NSMutableDictionary *dicttemp =[[NSMutableDictionary alloc]init];
        dicttemp =[[arrdict objectAtIndex:count] mutableCopy];
        
        NSMutableArray *arrdays = [[NSMutableArray alloc] init];
        NSMutableArray *arritems =[[NSMutableArray alloc] init];
        NSMutableArray *arrDayByDay =[[NSMutableArray alloc] init];
        
        arrdays = [[dicttemp valueForKey:@"days"] mutableCopy];
        
        for (int x = 0; x<arrdays.count; x++)
        {
            arritems = [[[arrdays objectAtIndex:x] valueForKey:@"items"] mutableCopy];
            
            for (int i = 0; i<arritems.count; i++)
            {
                if ([[arritems objectAtIndex:i] valueForKey:@"options"])
                {
                    NSMutableArray *arrtemprorary;
                    
                    for (int j =0; j<arritems.count; j++)
                    {
                        dictoptions =[[[arritems objectAtIndex:j] valueForKey:@"options"] mutableCopy];
                        
                        NSMutableDictionary *dicttin =[[NSMutableDictionary alloc]init];
                        NSMutableDictionary *dictweekly =[[NSMutableDictionary alloc]init];
                        
                        dicttin = [[arritems objectAtIndex:j] mutableCopy];
                        
                        NSString *stritem =[NSString stringWithFormat:@"%@",[dicttin valueForKey:@"itemID"]];
                        
                        [dictweekly setObject:stritem forKey:@"itemID"];
                        
                        NSString *strname =[NSString stringWithFormat:@"%@",[dicttin valueForKey:@"name"]];
                        
                        [dictweekly setObject:strname forKey:@"name"];
                        
                        NSString *strquantity =[NSString stringWithFormat:@"%@",[dicttin valueForKey:@"quantity"]];
                        
                        [dictweekly setObject:strquantity forKey:@"quantity"];
                        
                        NSString *strprice =[NSString stringWithFormat:@"%@",[dicttin valueForKey:@"total_price"]];
                        
                        [dictweekly setObject:strprice forKey:@"totalprice"];
                        
                        NSString *strprimaryprice =[NSString stringWithFormat:@"%@",[dicttin valueForKey:@"price"]];
                        
                        [dictweekly setObject:strprimaryprice forKey:@"primaryprice"];
                        
                        arrtemp =[[NSMutableArray alloc]init];
                        arrtemp =[[dictoptions allKeys] mutableCopy];
                        NSMutableDictionary *dicttemp2 =[[NSMutableDictionary alloc] init];
                        
                        for (int l =0; l<arrtemp.count; l++)
                        {
                            arrtemprorary =[[NSMutableArray alloc]init];
                            NSMutableArray *arrsecond =[[NSMutableArray alloc]init];
                            
                            arrsecond = [[dictoptions valueForKey:[arrtemp objectAtIndex:l]] mutableCopy];
                            
                            NSMutableDictionary *dict =[[NSMutableDictionary alloc]init];
                            NSMutableDictionary *dicttemp =[[NSMutableDictionary alloc]init];
                            
                            dict = [[arrsecond objectAtIndex:0] mutableCopy];
                            
                            NSString *stritem =[NSString stringWithFormat:@"%@",[dict valueForKey:@"id"]];
                            
                            [dicttemp setObject:stritem forKey:@"id"];
                            
                            NSString *strname =[NSString stringWithFormat:@"%@",[dict valueForKey:@"name"]];
                            
                            [dicttemp setObject:strname forKey:@"name"];
                            
                            NSString *strprice =[NSString stringWithFormat:@"%@",[dict valueForKey:@"price"]];
                            
                            [dicttemp setObject:strprice forKey:@"price"];
                            
                            [arrtemprorary addObject:dicttemp];
                            
                            [dicttemp2 setObject:arrtemprorary forKey:[arrtemp objectAtIndex:l]];
                        }
                        
                        [dictweekly setObject:dicttemp2 forKey:@"options"];
                        
                        [arritems replaceObjectAtIndex:j withObject:dictweekly];
                    }
                }
                
                else
                {
                    NSMutableDictionary *dicttin =[[NSMutableDictionary alloc]init];
                    NSMutableDictionary *dictweekly =[[NSMutableDictionary alloc]init];
                    NSMutableDictionary *dictoptions =[[NSMutableDictionary alloc]init];
                    
                    dicttin = [[arritems objectAtIndex:i] mutableCopy];
                    
                    NSString *stritem =[NSString stringWithFormat:@"%@",[dicttin valueForKey:@"itemID"]];
                    
                    [dictweekly setObject:stritem forKey:@"itemID"];
                    
                    NSString *strname =[NSString stringWithFormat:@"%@",[dicttin valueForKey:@"name"]];
                    
                    [dictweekly setObject:strname forKey:@"name"];
                    
                    NSString *strquantity =[NSString stringWithFormat:@"%@",[dicttin valueForKey:@"quantity"]];
                    
                    [dictweekly setObject:strquantity forKey:@"quantity"];
                    
                    NSString *strprice =[NSString stringWithFormat:@"%@",[dicttin valueForKey:@"total_price"]];
                    
                    [dictweekly setObject:strprice forKey:@"totalprice"];
                    
                    NSString *strprimaryprice =[NSString stringWithFormat:@"%@",[dicttin valueForKey:@"price"]];
                    
                    [dictweekly setObject:strprimaryprice forKey:@"primaryprice"];
                    
                    [dictweekly setObject:dictoptions forKey:@"options"];
                    
                    if ([[dicttin valueForKey:@"itemID"] isEqualToString:@"0"])
                    {
                        [arritems removeObjectAtIndex:i];
                    }
                    
                    else
                    {
                        
                    }
                    
                    [arritems replaceObjectAtIndex:i withObject:dictweekly];
                }
            }
            
            NSMutableDictionary *dictday =[[NSMutableDictionary alloc]init];
            
            [dictday setObject:arritems forKey:@"products"];
            
            [arrDayByDay addObject:dictday];
        }
        
        NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:arrDayByDay];
        
        [defaults setObject:data1 forKey:@"weeklyorderarray"];
        
        CalenderViewController *obj=[[CalenderViewController alloc]initWithNibName:@"CalenderViewController" bundle:nil];
        obj.strReorder = @"yes";
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
    
    else
    {
        NSData *data = [NSData data];
        
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        
        [defaults setObject:data forKey:@"arrayaddtocart"];
        
        NSMutableDictionary *dicttemp =[[NSMutableDictionary alloc]init];
        dicttemp =[[arrdict objectAtIndex:count] mutableCopy];
        
        NSMutableArray *arrdays = [[NSMutableArray alloc]init];
        NSMutableArray *arritems =[[NSMutableArray alloc]init];
        
        arrdays = [[dicttemp valueForKey:@"days"] mutableCopy];
        arritems = [[[arrdays objectAtIndex:0] valueForKey:@"items"] mutableCopy];
        
        for (int i =0; i<arritems.count; i++)
        {
            if ([[arritems objectAtIndex:i] valueForKey:@"options"])
            {
                NSMutableArray *arrtemprorary;
                
                for (int j =0; j<arritems.count; j++)
                {
                    dictoptions =[[[arritems objectAtIndex:j] valueForKey:@"options"] mutableCopy];
                    
                    NSMutableDictionary *dicttin =[[NSMutableDictionary alloc]init];
                    
                    dicttin = [[arritems objectAtIndex:j] mutableCopy];
                    
                    NSString *strprice =[NSString stringWithFormat:@"%@",[[arritems objectAtIndex:j]valueForKey:@"total_price"]];
                    [dicttin setObject:strprice forKey:@"totalprice"];
                    
                    arrtemp =[[NSMutableArray alloc]init];
                    arrtemprorary =[[NSMutableArray alloc]init];
                    arrtemp =[[dictoptions allKeys] mutableCopy];
                    
                    for (int l =0; l<arrtemp.count; l++)
                    {
                       NSMutableArray *arrsecond =[[NSMutableArray alloc]init];
                        
                       arrsecond = [[dictoptions valueForKey:[arrtemp objectAtIndex:l]] mutableCopy];
                       NSString *strtemp =[NSString stringWithFormat:@"%@",[[arrtemp objectAtIndex:l]mutableCopy]];
                        
                       for (int k  =0; k<arrsecond.count; k++)
                        {
                            NSMutableDictionary *dictte =[[NSMutableDictionary alloc]init];
                            
                            dictte =[[arrsecond objectAtIndex:k] mutableCopy];
                            
                            [dictte setObject:strtemp forKey:@"nameofarray"];
                            
                            [arrtemprorary addObject:dictte];
                        }
                    }
                    
                    [dicttin setObject:arrtemprorary forKey:@"arrcustom"];
                    
                    [arritems replaceObjectAtIndex:j withObject:dicttin];
                }
            }
            
            else
            {
                NSMutableDictionary *dicttin =[[NSMutableDictionary alloc]init];
                
                dicttin = [[arritems objectAtIndex:i] mutableCopy];
                
                NSString *strprice =[NSString stringWithFormat:@"%@",[dicttin valueForKey:@"total_price"]];
                
                [dicttin setObject:strprice forKey:@"totalprice"];
                
                if ([[dicttin valueForKey:@"itemID"] isEqualToString:@"0"])
                {
                    [arritems removeObjectAtIndex:i];
                }
                
                else
                {
                    
                }
                
                [arritems replaceObjectAtIndex:i withObject:dicttin];
            }
        }
        
        NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:arritems];
        
        [defaults setObject:data1 forKey:@"arrayaddtocart"];
        
        _viewredirect.hidden = NO;
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView==self.tbldata)
    {
        static NSString *CellIdentifier = @"AccordionHeaderViewReuseIdentifier";
        headerCell = [_tbldata dequeueReusableHeaderFooterViewWithIdentifier:CellIdentifier];
        NSString *dateString = [[arrdict objectAtIndex:section] valueForKey:@"order_date"];
        
        NSArray *components = [dateString componentsSeparatedByString:@" "];
        NSString *date = components[0];
        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        dateFormatter.dateStyle=NSDateFormatterMediumStyle;
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *finaldate1 =[dateFormatter dateFromString:date];
        
        [dateFormatter setDateFormat:@"EEE  dd/MM/yy"];
        
        NSString *finaldate = [dateFormatter stringFromDate:finaldate1];
        headerCell.lblname.text=finaldate;
        
        NSString *strtitle = [NSString stringWithFormat:@"%@",[[arrdict objectAtIndex:section]valueForKey:@"address_title"]];
        
        if ([strtitle isKindOfClass:[NSNull class]])
        {
            headerCell.lbltitle.text = @"";
        }
        
        else if ([strtitle isEqualToString:@"<null>"])
        {
            headerCell.lbltitle.text = @"";
        }
        
        else
        {
            headerCell.lbltitle.text =[NSString stringWithFormat:@"%@",[[arrdict objectAtIndex:section]valueForKey:@"address_title"]];
        }
        
        
        
        if ([[[arrdict objectAtIndex:section]valueForKey:@"flag"]isEqualToString:@"true"])
        {
            headerCell.imgdown.image=[UIImage imageNamed:@"greenUp"];
            headerCell.lblline.hidden = YES;
        }
        
        else
        {
            headerCell.imgdown.image=[UIImage imageNamed:@"grayDown"];
            headerCell.lblline.hidden = NO;
        }
        headerCell.lblcount.hidden = YES;
        headerCell.lblHeaderleading.constant = 10;
    
        
        //        headerCell.imgbackground.image=[UIImage imageNamed:@"stripdown"];
        //
        //
        //        headerCell.imgUpper.image=[UIImage imageNamed:@"stripdown"];
        
        //  self.scrollview1.contentSize=CGSizeMake(320,  self.tableview1.frame.origin.y+self.tableview1.frame.size.height+300);
        
        return headerCell;
    }
    
    return 0;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* pickerLabel = (UILabel*)_datepicker;
    
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        
        pickerLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:16];
    }
    
    return pickerLabel;
}


#pragma mark - <FZAccordionTableViewDelegate> -



-(void)tableView:(FZAccordionTableView *)tableView didOpenSection:(NSInteger)section withHeader:(nullable UITableViewHeaderFooterView *)header
{
    
}




-(void)tableView:(FZAccordionTableView *)tableView didDeselectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
}





- (void)tableView:(FZAccordionTableView *)tableView willOpenSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header
{
    sectionnum = (int) section;
    
    for (int i = 0; i<arrdict.count; i++)
    {
        NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
        
        dictet =[[arrdict objectAtIndex:i] mutableCopy];
        
        NSString *strdhcj = [NSString stringWithFormat:@"%@",[dictet valueForKey:@"flag"]];
        
        if ([strdhcj isEqualToString:@"true"])
        {
            flagopencondtion =@"true";
        }
    }
    
    
    for (int i =0; i<arrdict.count; i++)
    {
        NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
        
        dictet =[[arrdict objectAtIndex:i] mutableCopy];
        [dictet setObject:@"false" forKey:@"flag"];
        
        [arrdict replaceObjectAtIndex:i withObject:dictet];
    }
    
    for (int i =0; i<arrdict.count; i++)
    {
        NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
        
        dictet =[[arrdict objectAtIndex:i] mutableCopy];
        
        if (i == section)
        {
            [dictet setObject:@"true" forKey:@"flag"];
        }
        
        [arrdict replaceObjectAtIndex:i withObject:dictet];
    }
    
    NSMutableArray *arrtemp = [[arrdict objectAtIndex:section]valueForKey:@"days"];
    NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:arrtemp];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setObject:data1 forKey:@"arrtemp"];
    [defaults synchronize];
    
    [_tbldata reloadData];
}




- (void)tableView:(FZAccordionTableView *)tableView willCloseSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header
{
    
    if ([flagopencondtion isEqualToString:@"true"]) {
        flagopencondtion=@"";
    }
    else{
        
        
    for (int i =0; i<arrdict.count; i++)
    {
        NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];

        dictet =[[arrdict objectAtIndex:i] mutableCopy];

        if (i == section)
        {
            [dictet setObject:@"false" forKey:@"flag"];
        }

        else
        {
            [dictet setObject:@"false" forKey:@"flag"];
        }

        [arrdict replaceObjectAtIndex:i withObject:dictet];
    }
    }
    [_tbldata reloadData];
}





- (void)tableView:(FZAccordionTableView *)tableView didCloseSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header
{
    
}




- (IBAction)btnaddnewdeliverylocation:(id)sender
{
    [time invalidate];
    time = nil;
    
    MenuViewController *obj=[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.navigationController pushViewController:obj animated:YES];
}




- (IBAction)btnworkclicked:(id)sender
{
    self.viewhungry.hidden=NO;
    self.viewredirect.hidden=YES;
}




- (IBAction)btnhomeclicked:(id)sender
{
    self.viewredirect.hidden=YES;
    _viewpicker.hidden=YES;
    self.viewhungry.hidden=NO;
}




- (IBAction)btnsarahshouseclicked:(id)sender
{
    self.viewredirect.hidden=YES;
    _viewpicker.hidden=YES;
    self.viewhungry.hidden=NO;
}


- (IBAction)btnASAPclicked:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setValue:@"ASAP" forKey:@"ASAP"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSString *strcurrent =[NSString stringWithFormat:@"%@",[formatter stringFromDate:[NSDate date]]];
    
    strcurrent =[strcurrent stringByReplacingOccurrencesOfString:@"PM" withString:@"pm"];
    
    strcurrent =[strcurrent stringByReplacingOccurrencesOfString:@"AM" withString:@"am"];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *startdatenew =[dateFormat dateFromString:strstart];
    NSDate *enddatenew =[dateFormat dateFromString:strend];
    
    [dateFormat setDateFormat:@"hh:mm a"];
    
    NSString *startdat = [dateFormat stringFromDate:startdatenew];
    NSString *enddat = [dateFormat stringFromDate:enddatenew];
    
    startdat =[startdat stringByReplacingOccurrencesOfString:@"PM" withString:@"pm"];
    
    startdat =[startdat stringByReplacingOccurrencesOfString:@"AM" withString:@"am"];
    
    enddat =[enddat stringByReplacingOccurrencesOfString:@"PM" withString:@"pm"];
    
    enddat =[enddat stringByReplacingOccurrencesOfString:@"AM" withString:@"am"];
    
    NSString *string = [NSString stringWithFormat:@"This branch is not open yet. Delivery hours are between %@ and %@.",startdat, enddat];
    
    NSDate *date1= [formatter dateFromString:strstart];
    NSDate *date2 = [formatter dateFromString:strcurrent];
    
    NSComparisonResult result = [date1 compare:date2];
    if(result == NSOrderedDescending)
    {
        NSLog(@"date1 is later than date2");
        
        //_btnASAP.userInteractionEnabled = NO;
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:string
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
    
    else if(result == NSOrderedAscending)
    {
        NSLog(@"date2 is later than date1");
    }
    
    else
    {
        NSLog(@"date1 is equal to date2");
    }
    
    
    NSString *str = [NSString stringWithFormat:@"Sorry, this branch is now closed. Delivery hours are between %@ and %@.",startdat, enddat];
    
    NSString *strshop = [NSString stringWithFormat:@"%@",[dictime valueForKey:@"shop"]];
    
    NSString *shopname = [NSString stringWithFormat:@"Your order will be sent from %@",strshop];
    
    NSDate *enddate= [formatter dateFromString:strend];
    NSDate *currentdate = [formatter dateFromString:strcurrent];
    
    NSComparisonResult resultdate = [enddate compare:currentdate];
    if(resultdate == NSOrderedDescending)
    {
        [time invalidate];
        time = nil;
        
        NSLog(@"enddate is later than currentdate");
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:shopname
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        CartViewController *cart =[[CartViewController alloc]init];
                                        cart.strreorder =@"yes";
                                        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                                        [self.navigationController pushViewController:cart animated:YES];
                                    }];
        
        //Add your buttons to alert controller
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
    
    else if(result == NSOrderedAscending)
    {
        NSLog(@"currentdate is later than enddate");
        
        //_btnASAP.userInteractionEnabled = NO;
        _btnlater.userInteractionEnabled = NO;
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:str
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
        [time invalidate];
        time = nil;
        
        NSLog(@"enddate is equal to currentdate");
        
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:shopname
                                     preferredStyle:UIAlertControllerStyleAlert];
        
        //Add Buttons
        
        UIAlertAction* yesButton = [UIAlertAction
                                    actionWithTitle:@"OK"
                                    style:UIAlertActionStyleDefault
                                    handler:^(UIAlertAction * action) {
                                        CartViewController *cart =[[CartViewController alloc]init];
                                        cart.strreorder =@"yes";
                                        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                                        [self.navigationController pushViewController:cart animated:YES];
                                    }];
        
        //Add your buttons to alert controller
        
        [alert addAction:yesButton];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}








- (IBAction)btnletterclicked:(id)sender
{
    _viewhungry.hidden=YES;
    _viewredirect.hidden=YES;
    _viewpicker.hidden=NO;
    
    _datepicker.backgroundColor = [UIColor whiteColor];
    [_datepicker setValue:[UIColor colorWithRed:119.0/255.0f green:189.0/255.0f blue:29.0/255.0f alpha:1] forKey:@"textColor"];
    
    [self wsGetTime];
    
//    time =  [NSTimer scheduledTimerWithTimeInterval:60.0
//                                                 target:self
//                                               selector:@selector(wsGetTime)
//                                               userInfo:nil
//                                                repeats:YES];
}



- (IBAction)btnsettimeclicked:(id)sender
{
    [time invalidate];
    time = nil;
    
    [[NSUserDefaults standardUserDefaults] setValue:@"" forKey:@"ASAP"];
    
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormat setLocale:usLocale];
    
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    //[dateFormat setDateFormat:@"hh:mm a"];
    [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm a"];
    str_date=[NSString stringWithFormat:@"%@",[dateFormat stringFromDate:_datepicker.date]];
    
    str_date =[str_date stringByReplacingOccurrencesOfString:@"PM" withString:@"pm"];
    
    str_date =[str_date stringByReplacingOccurrencesOfString:@"AM" withString:@"am"];
    
    self.viewpicker.hidden=YES;
//    NSDate *date =[NSDate date];
//    [dateFormat setDateFormat:@"yyyy-MM-dd"];
//
//    NSString *str_day=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:date]];
    
    NSString *savedate =[NSString stringWithFormat:@"%@",str_date];
    
    [[NSUserDefaults standardUserDefaults] setObject:savedate forKey:@"delivery_time"];
    
    CartViewController *cart =[[CartViewController alloc]initWithNibName:@"CartViewController" bundle:nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    cart.strreorder =@"yes";
    [self.navigationController pushViewController:cart animated:YES];
}





- (IBAction)btnback:(id)sender
{
    [time invalidate];
    time = nil;
    
    if ([_pushflag isEqualToString:@"yes"])
    {
        MyAccountViewController *obj=[[MyAccountViewController alloc]initWithNibName:@"MyAccountViewController" bundle:nil];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
    
    else
    {
        HomeViewController *obj=[[HomeViewController alloc]initWithNibName:@"HomeViewController" bundle:nil];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
}




- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    [time invalidate];
    time = nil;
    
    return YES;
}





#pragma mark <---Web Services--->

-(void)wsGetOrderHistory
{
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSUserDefaults  *defaults=[NSUserDefaults standardUserDefaults];
    NSString *user_id = [defaults valueForKey:@"user_id"];
    NSString *token = [defaults valueForKey:@"token"];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"request=%@&action=%@&clientID=%@&limit=%@&offset=%@&token=%@&orderID=%@&key=%@&secret=%@",@"order",@"history",user_id,@"",@"",token,@"",str_key,str_secret];
    
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
                arrdict = [[dictionary valueForKey:@"orders"] mutableCopy];
                
                if(arrdict.count==0)
                {
                    _lblnorecords.hidden=NO;
                    _tbldata.hidden=YES;
                }
                
                else
                {
                    _lblnorecords.hidden=YES;
                    _tbldata.hidden=NO;
                    
                    for (int i =0; i<arrdict.count; i++)
                    {
                        NSMutableDictionary *dictet = [[NSMutableDictionary alloc]init];
                        
                        dictet = [[arrdict objectAtIndex:i] mutableCopy];
                        
                        [dictet setObject:@"false" forKey:@"flag"];
                        
                        [arrdict replaceObjectAtIndex:i withObject:dictet];
                    }
                    
                    arrdays = [[arrdict objectAtIndex:0] valueForKey:@"days"];
                    
                    arritems = [[arrdays objectAtIndex:0] valueForKey:@"items"];
                    
                    [_tbldata reloadData];
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





-(void)wsGetAddress
{
    NSUserDefaults  *defaults=[NSUserDefaults standardUserDefaults];
    NSString *user_id=[defaults valueForKey:@"user_id"];
    NSString *token = [defaults valueForKey:@"token"];
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *strWebserviceCompleteURL = [NSString stringWithFormat:@"%@",str_global_domain] ;
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
        
        //dispatch_async(dispatch_get_main_queue(),^{
            
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
                
                [self.tbladdress reloadData];
                
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
        //});
    }
}

-(void)wsGetTime
{
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSString *strloc = [defaults valueForKey:@"location"];
    NSString *parameter=[NSString stringWithFormat:@"request=%@&area=%@&action=%@&key=%@&secret=%@",@"allareas",strloc,@"getshop",str_key,str_secret];
    
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
        
        //dispatch_async(dispatch_get_main_queue(),^{
            
            if([errorCode isEqualToString:@"1"])
            {
                dictshop = [dictionary valueForKey:@"data"];
                
                dictavailable = [dictshop valueForKey:@"available_times"];
                
                //mintime = [dictshop valueForKey:@"start_new"];
                mintime = [dictavailable valueForKey:@"start"];
                
                //strEndTime =[dictshop valueForKey:@"end_new"];
                strEndTime = [dictavailable valueForKey:@"end"];
                
                NSString *strshop = [NSString stringWithFormat:@"%@",[dictshop valueForKey:@"shop"]];
                
                NSString *shopname = [NSString stringWithFormat:@"Your order will be sent from %@",strshop];
                
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:shopname
                                             preferredStyle:UIAlertControllerStyleAlert];
                
                //Add Buttons
                
                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action)
                                            {
                                                strtime = @"1";
                                                _viewhungry.hidden=YES;
                                                _viewredirect.hidden=YES;
                                                _viewpicker.hidden=NO;
                                                [_viewpicker bringSubviewToFront:self.view];
                                                
                                                _datepicker.backgroundColor = [UIColor whiteColor];
                                                [_datepicker setValue:[UIColor colorWithRed:119.0/255.0f green:189.0/255.0f blue:29.0/255.0f alpha:1] forKey:@"textColor"];
                                                
                                                [self funcTime1];
                                                
                                                //                                                time =  [NSTimer scheduledTimerWithTimeInterval:60.0
                                                //                                                                                         target:self
                                                //                                                                                       selector:@selector(funcTime1)
                                                //                                                                                       userInfo:nil
                                                //                                                                                        repeats:YES];
                                            }];
                
                //Add your buttons to alert controller
                [alert addAction:yesButton];
                
                [self presentViewController:alert animated:YES completion:nil];
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




-(void)funcTime1
{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormat setLocale:usLocale];
    
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    
    NSString *strex = [NSString stringWithFormat:@"%@", mintime];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *startdatweb = [dateFormat dateFromString:strex];
    
    [dateFormat setDateFormat:@"HH:mm"];
    
    strStartTime=[NSString stringWithFormat:@"%@",[dateFormat stringFromDate:startdatweb]];
    
//    NSString *startdatsystem =[dateFormat stringFromDate:[NSDate date]];
//
//    NSDate *startdatsys =[dateFormat dateFromString:startdatsystem];
//
//    NSDate *datefinal = startdatweb;
//    NSComparisonResult result = [startdatsys compare:datefinal];
//
//    if (result == NSOrderedDescending)
//    {
//        datefinal = startdatsys;
//    }
//
//    [dateFormat setDateFormat:@"HH:mm"];
//
//    strStartTime=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:datefinal]];
    
    
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//
//    NSString *straddtime = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"delivery_time"]];
//
//    straddtime = [straddtime stringByReplacingOccurrencesOfString:@"mins" withString:@""];
//
//    int addmin = straddtime.intValue;
//
//    NSTimeInterval seconds = addmin * 60;
//
//    NSDate *datetemp2 = [datetemp dateByAddingTimeInterval:seconds];
//
//    strStartTime=[NSString stringWithFormat:@"%@",[dateFormat stringFromDate:datetemp2]];
    
    starttime = strStartTime.intValue;
    
    NSDate *startmin =[dateFormat dateFromString:strStartTime];
    
    [dateFormat setDateFormat:@"mm"];
    
    NSString *strmin1 = [dateFormat stringFromDate:startmin];
    
    minute = strmin1.integerValue;
    
    [dateFormat setDateFormat:@"dd"];
    
    NSString *strday = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:startdatweb]];
    
    startday = strday.intValue;
    
    [dateFormat setDateFormat:@"MM"];
    
    NSString *strmonth = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:startdatweb]];
    
    startmonth = strmonth.intValue;
    
    [dateFormat setDateFormat:@"yyyy"];
    
    NSString *stryear = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:startdatweb]];
    
    startyear = stryear.intValue;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:datetemp2];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:startdatweb];
    
//    NSInteger minute1 = [components minute];
//
//    if ((0 <= minute1) && (minute1 <= 15))
//    {
//        minute = 15;
//    }
//
//    else  if( (16 <= minute1) && (minute1 <= 30))
//    {
//        minute = 30;
//    }
//
//    else  if((31 <= minute1) && (minute1 <= 45))
//    {
//        minute = 45;
//    }
//
//    else  if ((46 <= minute1) && (minute1 <= 60))
//    {
//        minute = 00;
//
//        if (starttime <23)
//        {
//            starttime = starttime + 1;
//        }
//
//        else
//        {
//            starttime = 0;
//        }
//    }
    
    strEndTime = [dictavailable valueForKey:@"end"];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *enddatweb =[dateFormat dateFromString:strEndTime];
    
    [dateFormat setDateFormat:@"HH:mm"];
    
    NSString *enddat = [dateFormat stringFromDate:enddatweb];
    
//    NSDate *endfinaldate =[dateFormat dateFromString:enddat];
    
    endtime = enddat.intValue;
    
    NSDate *endmin =[dateFormat dateFromString:enddat];
    
    [dateFormat setDateFormat:@"mm"];
    
    NSString *endmin1 = [dateFormat stringFromDate:endmin];
    
    NSInteger minute2 = endmin1.integerValue;
    
    [dateFormat setDateFormat:@"dd"];
    
    NSString *strendday = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:enddatweb]];
    
    endday = strendday.intValue;
    
    [dateFormat setDateFormat:@"MM"];
    
    NSString *strendmonth = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:enddatweb]];
    
    endmonth = strendmonth.intValue;
    
    [dateFormat setDateFormat:@"yyyy"];
    
    NSString *strendyear = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:enddatweb]];
    
    endyear = strendyear.intValue;
    
//    NSDateComponents *components1 = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:endfinaldate];
//
//    NSInteger minute2 = [components1 minute];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    [components setDay:startday];
    [components setMonth:startmonth];
    [components setYear:startyear];
    [components setHour: starttime];
    [components setMinute: minute];
    [components setSecond: 0];
    NSDate *startDate = [gregorian dateFromComponents: components];
    
    [components setDay:endday];
    [components setMonth:endmonth];
    [components setYear:endyear];
    [components setHour: endtime];
    [components setMinute: minute2];
    [components setSecond: 0];
    NSDate *endDate = [gregorian dateFromComponents: components];
    
    _datepicker.datePickerMode=UIDatePickerModeDateAndTime;
    
    _datepicker.backgroundColor = [UIColor whiteColor];
    [_datepicker setValue:[UIColor colorWithRed:119.0/255.0f green:189.0/255.0f blue:29.0/255.0f alpha:1] forKey:@"textColor"];
    
    if (startDate == NULL || startDate == nil)
    {
        startDate = [NSDate date];
    }
    
    else
    {
        
    }
    
    [_datepicker setMinimumDate:startDate];
    [_datepicker setMaximumDate:endDate];
    [_datepicker setDate:startDate animated:YES];
}


-(void)wsGetTimeforASAP
{
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSString *strloc = [defaults valueForKey:@"location"];
    NSString *parameter=[NSString stringWithFormat:@"request=%@&area=%@&action=%@&key=%@&secret=%@",@"allareas",strloc,@"getshop",str_key,str_secret];
    
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
        
        //dispatch_async(dispatch_get_main_queue(),^{
            
            if([errorCode isEqualToString:@"1"])
            {
                dictime = [dictionary valueForKey:@"data"];
                
                //strstart = [[arr objectAtIndex:0] valueForKey:@"start"];
                strstart = [dictime valueForKey:@"start_new"];
                
                //strend = [[arr objectAtIndex:0] valueForKey:@"end"];
                strend = [dictime valueForKey:@"end_new"];
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



- (IBAction)btnaddress:(id)sender
{
    
}



@end

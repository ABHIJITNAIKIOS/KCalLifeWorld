//
//  CalenderViewController.m
//  Kcal
//
//  Created by Pipl09 on 17/07/17.
//  Copyright © 2017 Pipl09. All rights reserved.
//

#import "CalenderViewController.h"
#import "BaseViewController.h"
#import "AppDelegate.h"
#import "CalendarTableViewCell.h"
#import "AddDeliveryaddressController.h"
#import "HomeTableViewCell.h"
#import "WorkTableViewCell.h"
#import "AddressTableViewCell.h"
#import "WeeklyViewCart.h"

@interface CalenderViewController ()<CKCalendarDelegate>
{
    CalendarTableViewCell *cell;
    CKCalendarView *calendar;
    NSMutableArray *arremp;
    NSMutableArray *arremp1;
    NSArray *arrtemp;
    NSString *str;
    NSString *strselecteddateglobal;
    NSString *flagminiumdate;
    NSString *task_id;
    NSString *inputTextField,*CurrMonth,*currYear;
    NSString *todayDate;
    NSString *cur_date ,*flagfirst;
    NSString *month1, *day1;
    NSString *year1;
    NSArray *arrDate;
    NSCalendar *calendar1;
    NSDateComponents *components1;
    int count;
    AddressTableViewCell *cell3;
    HomeTableViewCell *cell2;
    WorkTableViewCell *cell1;
    NSString *str_date,*str_date1;
    NSMutableArray *arrdata;
    NSMutableArray *arrdata1;
    NSMutableArray *areadict;
    NSString *strlocation,*strcity,*selecteddate;
    NSString *strtime;
    NSArray *area,*arrshop;
    CGFloat screenWidth;
    CGFloat screenHeight;
    CGFloat screenX;
    CGFloat screenY;
    NSString *status;
    NSString *strEndTime,*strStartTime,*flagTimer,*mintime;
    NSInteger minute;
    int endtime,starttime,startday,startmonth,startyear,endday,endmonth,endyear;
    NSTimer *time;
    NSMutableArray *result;
    NSMutableArray *showdays;
    NSMutableArray *arrSelecteddates,*arrdateAndTime;
    NSMutableDictionary *arrSelecteddatesAndTime;
    int cnt;
    NSString *weeklyflag;
    NSString *strdate;
    NSString *str_time;
    NSMutableDictionary *dicttime;
    NSMutableArray *arrtime;
    NSString *strd;
    NSString *stDate;
    NSMutableArray *arrDate1;
    NSDate *clickDate;
    NSDictionary *dictt, *dictavailable;
    NSString *flagdate;
    NSMutableArray *arrweeklydata;
}


@property (nonatomic, weak) CKCalendarView *calendar;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property (nonatomic, strong) NSDate *minimumDate;
@property (nonatomic, strong) NSArray *disabledDates;
@property (strong, nonatomic) NSArray *dataInSecondViewController;
@property (nonatomic, weak) IBOutlet UILabel *monthDisplayedDayLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstaint;
@property (weak, nonatomic) IBOutlet UIButton *previousMonthButton;
@property (weak, nonatomic) IBOutlet UIButton *nextMonthButton;
@property (nonatomic, strong) NSDateFormatter *formatter;

@end


@implementation CalenderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [time invalidate];
    time = nil;
    
    dicttime = [[NSMutableDictionary alloc]init];
    dictt = [[NSDictionary alloc] init];
    dictavailable = [[NSDictionary alloc] init];
    arrtime = [[NSMutableArray alloc]init];
    arrDate1 = [[NSMutableArray alloc] init];
    arrweeklydata = [[NSMutableArray alloc]init];
    
    self.tblObj.delegate=self;
    self.tblObj.dataSource=self;
    _viewReorder.hidden = YES;
    count=3;
    cnt=0;
    
    NSData *dataarraddtocart = [[NSUserDefaults standardUserDefaults]valueForKey:@"weeklyorderarray"];
    
    if (!(dataarraddtocart == nil))
    {
        arrweeklydata=[[NSKeyedUnarchiver unarchiveObjectWithData:dataarraddtocart] mutableCopy];
    }
    
    
    if ([_strReorder isEqualToString:@"yes"])
    {
        _viewReorder.hidden = NO;
        
        if (arrweeklydata.count > 1)
        {
            count = (int)arrweeklydata.count;
        }
    }
    
    else
    {
        _viewReorder.hidden = YES;
    }
    
    self.navigationItem.hidesBackButton = YES;
    [self.viewpopup addSubview:self.view];
    self.viewpopup.hidden=YES;
    _LBLNORECORD.hidden=YES;
    flagminiumdate =@"yes";
    strselecteddateglobal =@"";
    strd = @"";
    flagdate = @"";
    
    screenWidth = [UIScreen mainScreen].bounds.size.width;
    screenHeight = [UIScreen mainScreen].bounds.size.height;
    screenX = [UIScreen mainScreen].bounds.origin.x;
    screenY = [UIScreen mainScreen].bounds.origin.y;
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    defaults=[NSUserDefaults standardUserDefaults];
    status=[defaults valueForKey:@"status"];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    
    NSData *data = [NSData data];
    
    [[NSUserDefaults standardUserDefaults] setValue:data forKey:@"arrinsertdate"];
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"arrayaddtocart"];
    
    self.viewredirect.hidden=YES;
    
    NSString *strcount = [NSString stringWithFormat:@"%d", count];
    
    [[NSUserDefaults standardUserDefaults] setValue:strcount forKey:@"totalcount"];
    
    UIColor *color = [UIColor colorWithRed:108/255.0f green:108/255.0f blue:110/255.0f alpha:1];
    
    self.txtdeliveryaddress.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"Where shall we deliver to?" attributes:@{NSForegroundColorAttributeName: color}];
    
    NSDate *date = [NSDate date];
    
    calendar1 = [NSCalendar currentCalendar];
    components1 = [calendar1 components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear) fromDate:date];
    day1 = [NSString stringWithFormat:@"%ld",(long)[components1 day]];
    month1=[NSString stringWithFormat:@"%ld",(long)[components1 month]];
    year1=[NSString stringWithFormat:@"%ld",(long)[components1 year]];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSString *todaydate = [dateFormat stringFromDate:[NSDate date]];
    showdays =[[NSMutableArray alloc] init];
    arrSelecteddates =[[NSMutableArray alloc] init];
    arrdateAndTime =[[NSMutableArray alloc] init];
    NSDate *todayDate = [NSDate date];
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [showdays addObject:todaydate];
    
    for (int i=0;i<15;i++)
    {
        [dateComponents setDay:+1];
        NSDate *nextday = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:todayDate options:0];
        NSString *nextaddday = [dateFormat stringFromDate:nextday];
        
        todayDate = nextday;
        
        [showdays addObject:nextaddday];
        NSLog(@"todayDate: %@", showdays);
        NSLog(@"todayDate: %@", todayDate);
    }
    
    NSLog(@"CurrMonth %@", CurrMonth);
    NSLog(@"currYear %@", currYear);
    
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    self.title=@"Weekly Order";
    
    calendar = [[CKCalendarView alloc] initWithStartDay:startSunday];
    self.calendar = calendar;
    calendar.delegate = self;
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    calendar.onlyShowCurrentMonth = YES;
    calendar.adaptHeightToNumberOfWeeksInMonth = YES;
    calendar.frame = self.tempcalenderview.frame;
    
    calendar.frame = CGRectMake(20, self.tempcalenderview.frame.origin.y, screenWidth-40, self.tempcalenderview.frame.size.height-100);
    [self.mainview addSubview:calendar];
    
    self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(calendar.frame) + 4, self.view.bounds.size.width, 24)];
    [self.view addSubview:self.dateLabel];
    
    self.view.backgroundColor = [UIColor whiteColor];
    _btnnext.backgroundColor=[UIColor colorWithRed:198.0/255.0f green:197.0/255.0f blue:197.0/255.0f alpha:1];
    _datepicker.minuteInterval = 15;
}




-(void)viewDidDisappear:(BOOL)animated
{
    [time invalidate];
    time = nil;
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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




-(BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    [time invalidate];
    time = nil;
    
    return YES;
}





-(void)viewDidAppear:(BOOL)animated
{
    for (UIButton *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 401)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 134)
        {
            [view removeFromSuperview];
        }
    }
    
    
    if ([status isEqualToString:@"login"])
    {
        flagfirst=@"yes";
        
        [GiFHUD showWithOverlay];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self wsGetAddress];
        });
    }
}



- (IBAction)btntermsclicked:(id)sender
{
    self.viewpopup.hidden = NO;
    
    _viewpopup.frame=CGRectMake(screenX, screenY, screenWidth, screenHeight);
    
    [self.view addSubview:_viewpopup];
}




- (IBAction)btnclosepopup:(id)sender
{
    //self.viewblur.hidden = YES;
    self.viewpopup.hidden = YES;
}





#pragma mark tableview delegate methods


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}




-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView ==_tbladdress)
    {
        return arrdata.count;
    }
    
    else if(tableView == _tblObj)
    {
        return arrdateAndTime.count;
    }
    
    return 0;
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _tblObj)
    {
        NSString *cellIdentifier=@"cell";
        cell=(CalendarTableViewCell *)[self.tblObj dequeueReusableCellWithIdentifier:cellIdentifier];
        
        NSArray *nib;
        
        nib=[[NSBundle mainBundle]loadNibNamed:@"CalendarTableViewCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
        
        cell.lbldate.text = [[arrdateAndTime objectAtIndex:indexPath.row]valueForKey:@"SelectedDate"];
        //cell.lbltime.text=[[arrdateAndTime objectAtIndex:indexPath.row]valueForKey:@"SelectedTime"];
        
        cell.btnclose.tag = indexPath.row;
        [cell.btnclose addTarget:self action:@selector(cancledateclicked:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    else if(tableView == _tbladdress)
    {
        if(arrdata.count>2)
        {
            arrtemp = [arrdata objectAtIndex:indexPath.row];
        }
        
        if(indexPath.row == 0)
        {
            NSArray *nib;
            
            cell1 = (WorkTableViewCell *)[self.tbladdress dequeueReusableCellWithIdentifier:@"cell1"];
            
            if (cell1 == nil) {
                nib = [[NSBundle mainBundle] loadNibNamed:@"WorkTableViewCell" owner:self options:nil];
            }
            
            cell1 = [nib objectAtIndex:0];
            
            cell1.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell1;
        }
        
        else if(indexPath.row == 1)
        {
            NSArray *nib;
            
            cell2 = (HomeTableViewCell *)[self.tbladdress dequeueReusableCellWithIdentifier:@"cell2"];
            
            if (cell2 == nil)
            {
                nib = [[NSBundle mainBundle] loadNibNamed:@"HomeTableViewCell" owner:self options:nil];
            }
            
            cell2 = [nib objectAtIndex:0];
            cell2.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell2;
        }
        
        else
        {
            NSArray *nib;
            
            cell3 = (AddressTableViewCell *)[self.tbladdress dequeueReusableCellWithIdentifier:@"cell3"];
            
            if (cell3 == nil) {
                nib = [[NSBundle mainBundle] loadNibNamed:@"AddressTableViewCell" owner:self options:nil];
            }
            
            cell3 = [nib objectAtIndex:0];
            
            cell3.lbladdress.text = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"title"]];
            
//            if([[[arrdata objectAtIndex:indexPath.row] valueForKey:@"type"] isEqualToString:@"2"])
//            {
//                cell3.lbladdress.text = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row] valueForKey:@"title"]];
//
//            }
            
            cell3.selectionStyle =UITableViewCellSelectionStyleNone;
            return cell3;
        }
    }
    
    return 0;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:
(NSIndexPath *)indexPath
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
        
        NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
        
        [defaults setObject:address forKey:@"weeklyorderaddress"];
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
                    //[self wsGetTime];
                    
                    if ([flagdate isEqualToString:@""])
                    {
                        [GiFHUD showWithOverlay];
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                            [self wsGetWeeklyTime];
                        });
                    }
                    
                    else
                    {
                        
                    }
                    
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
                    //[self wsGetTime];
                    
                    if ([flagdate isEqualToString:@""])
                    {
                        [GiFHUD showWithOverlay];
                        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
                        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                            [self wsGetWeeklyTime];
                        });
                    }
                    
                    else
                    {
                        
                    }
                    
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
                
                //[self wsGetTime];
                
                if ([flagdate isEqualToString:@""])
                {
                    [GiFHUD showWithOverlay];
                    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
                    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                        [self wsGetWeeklyTime];
                    });
                }
                
                else
                {
                    
                }
                
                _viewredirect.hidden=YES;
//            }
        }
    }
}





-(void)cancledateclicked:(UIButton *)sender
{
    NSData *data1 = [NSData data];
    
    [arrdateAndTime removeObjectAtIndex:sender.tag];
    [arrSelecteddates removeObjectAtIndex:sender.tag];
    [arrDate1 removeObjectAtIndex:sender.tag];
    
    if (arrSelecteddates.count > 0)
    {
        
    }
    
    else
    {
        flagdate = @"";
    }
    
    data1 = [NSKeyedArchiver archivedDataWithRootObject:arrDate1];
    
    [[NSUserDefaults standardUserDefaults] setValue:data1 forKey:@"arrinsertdate"];
    
    cnt=cnt-1;
    
    if (arrdateAndTime.count == 0)
    {
        _LBLNORECORD.hidden = YES;
        _btnnext.backgroundColor=[UIColor colorWithRed:198.0/255.0f green:197.0/255.0f blue:197.0/255.0f alpha:1];
    }
    
    else
    {
        _LBLNORECORD.hidden = YES;
    }
    
    [_tblObj reloadData];
    _tblobjheight.constant = _tblObj.contentSize.height;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"callCalendar" object:self];
}



#pragma mark <---CKCalendarDelegate--->


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)
    {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    }
    
    else
    {
        return YES;
    }
}



- (void)localeDidChange
{
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [self.calendar setLocale:usLocale];
}




- (void)calendar:(CKCalendarView *)calendar configureDateItem:(CKDateItem *)dateItem forDate:(NSDate *)date
{
    // TODO: play with the coloring if we want to...
    
//    dateItem.backgroundColor = [UIColor whiteColor];
//    
//    dateItem.textColor =  [UIColor colorWithRed:198/255.0f green:197/255.0f blue:197/255.0f alpha:1];
    calendar.titleFont = [UIFont fontWithName:@"AvenirNext-DemiBold" size:15.0f];
    calendar.titleColor= [UIColor lightGrayColor];
}





- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date
{
    NSData *data = [NSData data];
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"weeklyorderarray"];
    [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"weeklyorderclicked"];
    
    stDate=[self.dateFormatter stringFromDate:date];
    NSLog(@"strDate=%@",stDate);
    strselecteddateglobal = stDate;
    
    if ([flagdate isEqualToString:@"yes"])
    {
        [GiFHUD showWithOverlay];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self wsGetWeeklyTime];
        });
    }
    
    else
    {
        
    }
    
//    [GiFHUD showWithOverlay];
//    //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        [self wsGetWeeklyTime];
//    });
    
    
    [self CalendarSelectDate:date];
    
    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//
//    NSString *strcount = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"totalcount"]];
//
//    int intcount = [strcount intValue];
//
//    NSDateFormatter *dateFormatterwe = [[NSDateFormatter alloc] init];
//    dateFormatterwe.dateFormat = @"yyyy-MM-dd";
//
//    NSDate *finaldate = [NSDate date];
//
//    NSTimeInterval days = 21600 * 60;
//
//    finaldate = [finaldate dateByAddingTimeInterval:days];
//
//    NSString *strthirdparty = [dateFormatterwe stringFromDate:date];
//
//    NSDate *datethirdparty = [dateFormatterwe dateFromString:strthirdparty];
//
//    NSString *strtsystem= [dateFormatterwe stringFromDate:[NSDate date]];
//    NSString *strtsystemfinal = [dateFormatterwe stringFromDate:finaldate];
//    NSComparisonResult result = [datethirdparty compare:[NSDate date]];
//    NSComparisonResult resultfinal = [datethirdparty compare:finaldate];
//
//    if (([strtsystem isEqualToString:strthirdparty] || result == NSOrderedDescending) && ([strtsystemfinal isEqualToString:strthirdparty] || resultfinal == NSOrderedAscending))
//    {
//        [arrDate1 addObject:date];
//
//        if (arrDate1.count > intcount)
//        {
//            [arrDate1 removeLastObject];
//        }
//    }
//
//    NSData *data1 = [NSData data];
//
//    data1 = [NSKeyedArchiver archivedDataWithRootObject:arrDate1];
//
//    [[NSUserDefaults standardUserDefaults] setValue:data1 forKey:@"arrinsertdate"];
//
//    NSDate *dateforday = date;
//
//    NSDateFormatter *formatter = [[NSDateFormatter alloc ]init];
//
//    [formatter setDateFormat:@"EEEE"];
//
//    NSString *strday = [formatter stringFromDate:dateforday];
//
//
//    if ([strday isEqualToString:@"Sunday"])
//    {
//        strd = @"0";
//    }
//
//    else if ([strday isEqualToString:@"Monday"])
//    {
//        strd = @"1";
//    }
//
//    else if ([strday isEqualToString:@"Tuesday"])
//    {
//        strd = @"2";
//    }
//
//    else if ([strday isEqualToString:@"Wednesday"])
//    {
//        strd = @"3";
//    }
//
//    else if ([strday isEqualToString:@"Thursday"])
//    {
//        strd = @"4";
//    }
//
//    else if ([strday isEqualToString:@"Friday"])
//    {
//        strd = @"5";
//    }
//
//    else if ([strday isEqualToString:@"Saturday"])
//    {
//        strd = @"6";
//    }
//
//
//    NSArray *items1 = [stDate componentsSeparatedByString:@"-"];   //take the one array for split the string
//
//    year1=[NSString stringWithFormat:@"%@",[items1 objectAtIndex:0]];
//    month1=[NSString stringWithFormat:@"%@",[items1 objectAtIndex:1]];
//    cur_date=[NSString stringWithFormat:@"%@",[items1 objectAtIndex:2]];
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    NSDateFormatter *monthDayFormatter = [[NSDateFormatter alloc] init];
//    [monthDayFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
//    [monthDayFormatter setDateFormat:@"d"];
//    int date_day = [[monthDayFormatter stringFromDate:date] intValue];
//    NSString *suffix_string = @"|st|nd|rd|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|st|nd|rd|th|th|th|th|th|th|th|st";
//    NSArray *suffixes = [suffix_string componentsSeparatedByString: @"|"];
//    NSString *suffix = [suffixes objectAtIndex:date_day];
//    [dateFormatter setDateFormat:[NSString stringWithFormat:@"EEEE d'%@' MMMM",suffix]];
//    selecteddate = [dateFormatter stringFromDate:date];
//
//    self.lbldeliverydate.text = [NSString stringWithFormat:@"%@",selecteddate];
//
//    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
//    [dateFormat setDateFormat:@"yyyy-MM-dd"];
//    strdate =[dateFormat stringFromDate:date];
//
//
//    NSDate *date_now=[NSDate date];
//    NSString *found;
//    if ([date_now compare:date] == NSOrderedAscending)
//    {
//        flagminiumdate =@"no";
//
//        if([flagfirst isEqualToString:@"no"])
//        {
//            [self funcTime1];
//        }
//
//        NSString *foundFlag=@"no";
//
//        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//        NSString *dateselect = [dateFormatter stringFromDate:date];
//
//        for (int i=0;i<showdays.count;i++)
//        {
//            NSString *temp =[showdays objectAtIndex:i];
//
//            if([dateselect isEqualToString:temp])
//            {
//                if (arrSelecteddates.count >0)
//                {
//                    for (int p = 0; p<arrSelecteddates.count; p++)
//                    {
//                        NSLog(@"dates=%@",[arrSelecteddates objectAtIndex:p]);
//
//                        NSString *temparrdate = [NSString stringWithFormat:@"%@",[arrSelecteddates objectAtIndex:p]];
//
//                        if ([selecteddate isEqualToString: temparrdate])
//                        {
//                            foundFlag =@"yes";
//
//                       UIAlertController * alert = [UIAlertController
//                                                         alertControllerWithTitle:nil
//                                                         message:@"You have already selected this date."
//                                                            preferredStyle:UIAlertControllerStyleAlert];
//                            //Add Buttons
//                            UIAlertAction* yesButton = [UIAlertAction
//                                                        actionWithTitle:@"OK"
//                                                        style:UIAlertActionStyleDefault
//                                                        handler:^(UIAlertAction * action) {
//
//                                                        }];
//
//                            //Add your buttons to alert controller
//
//                            [alert addAction:yesButton];
//
//                            [self presentViewController:alert animated:YES completion:nil];
//                        }
//                    }
//
//                    if ( [foundFlag isEqualToString:@"no"])
//                    {
//                        // if([dateselect isEqualToString:temp]){
//                        if(cnt < count)
//                        {
//                            [arrSelecteddates addObject:selecteddate];
//                            cnt= cnt+1;
//                            NSLog(@"cnt=%d",cnt);
//
//                            self.viewpicker.hidden=NO;
//                            [self.view addSubview:_viewpicker];
//                            self.viewpicker.frame = CGRectMake(0, 0, screenWidth, screenHeight);
//                            found =@"yes";
//                        }
//
//                        else
//                        {
//                            NSString *msg = [NSString stringWithFormat:@"%@%d%@",@"You cannot select more than ",cnt,@" days"];
//
//                            UIAlertController *alert = [UIAlertController
//                                                         alertControllerWithTitle:nil
//                                                         message:msg
//                                                         preferredStyle:UIAlertControllerStyleAlert];
//                            //Add Buttons
//                            UIAlertAction *yesButton = [UIAlertAction
//                                                        actionWithTitle:@"OK"
//                                                        style:UIAlertActionStyleDefault
//                                                        handler:^(UIAlertAction * action) {
//
//                                                        }];
//
//                            //Add your buttons to alert controller
//
//                            [alert addAction:yesButton];
//
//                            [self presentViewController:alert animated:YES completion:nil];
//                        }
//                        //}
//                    }
//                }
//                //}
//
//                else
//                {
//                    // if([dateselect isEqualToString:temp]){
//
//                    if(cnt < count)
//                    {
//                        [arrSelecteddates addObject:selecteddate];
//                        cnt= cnt+1;
//                        NSLog(@"cnt=%d",cnt);
//
//                        self.viewredirect.hidden=NO;
//                        [self.view addSubview:_viewredirect];
//                        self.viewredirect.frame = CGRectMake(0, 0, screenWidth, screenHeight);
//
//                        found =@"yes";
//                    }
//
//                    else
//                    {
//                        NSString *msg = [NSString stringWithFormat:@"%@%d%@",@"You cannot select more than ",cnt,@" days"];
//                        UIAlertController * alert = [UIAlertController
//                                                     alertControllerWithTitle:nil
//                                                     message:msg
//                                                     preferredStyle:UIAlertControllerStyleAlert];
//                        //Add Buttons
//                        UIAlertAction* yesButton = [UIAlertAction
//                                                    actionWithTitle:@"OK"
//                                                    style:UIAlertActionStyleDefault
//                                                    handler:^(UIAlertAction * action) {
//
//                                                    }];
//
//                        //Add your buttons to alert controller
//
//                        [alert addAction:yesButton];
//
//                        [self presentViewController:alert animated:YES completion:nil];
//                    }
//                    //}
//                    //}
//
//                    self.viewredirect.hidden=NO;
//                    [self.view addSubview:_viewredirect];
//                    self.viewredirect.frame = CGRectMake(0, 0, screenWidth, screenHeight);
//                }
//            }
//        }
//
//        if ([found isEqualToString:@"yes"])
//        {
//
//        }
//
//        else
//        {
//            UIAlertController * alert = [UIAlertController
//                                         alertControllerWithTitle:nil
//                                         message:@"Please select date from today's date to next 15 days."
//                                         preferredStyle:UIAlertControllerStyleAlert];
//
//            //Add Buttons
//
//            UIAlertAction* yesButton = [UIAlertAction
//                                        actionWithTitle:@"OK"
//                                        style:UIAlertActionStyleDefault
//                                        handler:^(UIAlertAction * action) {
//
//                                        }];
//
//
//            //Add your buttons to alert controller
//
//            [alert addAction:yesButton];
//
//            [self presentViewController:alert animated:YES completion:nil];
//        }
//
//        NSLog(@"greatr");
//    }
//
//    else if ([date_now compare:date] == NSOrderedSame)
//    {
//        flagminiumdate =@"yes";
//
//        if([flagfirst isEqualToString:@"no"])
//        {
//            [self funcTime1];
//        }
//
//        NSString *foundFlag=@"no";
//        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//
//        // for (int i=0;i<showdays.count;i++){
//        //   NSString *temp =[showdays objectAtIndex:i];
//
//        if (arrSelecteddates.count >0)
//        {
//            for (int p = 0; p<arrSelecteddates.count; p++)
//            {
//                NSLog(@"dates=%@",[arrSelecteddates objectAtIndex:p]);
//
//                NSString *temparrdate = [NSString stringWithFormat:@"%@",[arrSelecteddates objectAtIndex:p]];
//
//                if ([selecteddate isEqualToString: temparrdate])
//                {
//                    foundFlag =@"yes";
//
//                    UIAlertController * alert = [UIAlertController
//                                                 alertControllerWithTitle:nil
//                                                 message:@"You have already selected this date."
//                                                 preferredStyle:UIAlertControllerStyleAlert];
//                    //Add Buttons
//                    UIAlertAction* yesButton = [UIAlertAction
//                                                actionWithTitle:@"OK"
//                                                style:UIAlertActionStyleDefault
//                                                handler:^(UIAlertAction * action) {
//
//                                                }];
//
//                    //Add your buttons to alert controller
//
//                    [alert addAction:yesButton];
//
//                    [self presentViewController:alert animated:YES completion:nil];
//                }
//            }
//        }
//
//        else
//        {
//            // if([dateselect isEqualToString:temp]){
//
//            if(cnt < count)
//            {
//                [arrSelecteddates addObject:selecteddate];
//                cnt= cnt+1;
//                NSLog(@"cnt=%d",cnt);
//
//                self.viewredirect.hidden=NO;
//                [self.view addSubview:_viewredirect];
//                self.viewredirect.frame = CGRectMake(0, 0, screenWidth, screenHeight);
//
//                found =@"yes";
//            }
//
//            else
//            {
//                NSString *msg = [NSString stringWithFormat:@"%@%d%@",@"You cannot select more than ",cnt,@" days."];
//
//                UIAlertController * alert = [UIAlertController
//                                             alertControllerWithTitle:nil
//                                             message:msg
//                                             preferredStyle:UIAlertControllerStyleAlert];
//                //Add Buttons
//                UIAlertAction* yesButton = [UIAlertAction
//                                            actionWithTitle:@"OK"
//                                            style:UIAlertActionStyleDefault
//                                            handler:^(UIAlertAction * action) {
//
//                                            }];
//
//                //Add your buttons to alert controller
//
//                [alert addAction:yesButton];
//
//                [self presentViewController:alert animated:YES completion:nil];
//            }
//        //}
//    //}
//
//            self.viewredirect.hidden=NO;
//            [self.view addSubview:_viewredirect];
//            self.viewredirect.frame = CGRectMake(0, 0, screenWidth, screenHeight);
//        }
//    }
//
//    else
//    {
//        flagminiumdate =@"yes";
//
//        if([flagfirst isEqualToString:@"no"])
//        {
//            [self funcTime1];
//        }
//
//        NSString *foundFlag=@"no";
//        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//        NSString *dateselect = [dateFormatter stringFromDate:date];
//
//        for (int i=0;i<showdays.count;i++)
//        {
//            NSString *temp =[showdays objectAtIndex:i];
//
//            if([dateselect isEqualToString: temp])
//            {
//                if (arrSelecteddates.count >0)
//                {
//                    for (int p = 0; p<arrSelecteddates.count; p++)
//                    {
//                        NSLog(@"dates=%@",[arrSelecteddates objectAtIndex:p]);
//
//                        NSString *temparrdate = [NSString stringWithFormat:@"%@",[arrSelecteddates objectAtIndex:p]];
//
//                        if ([selecteddate isEqualToString: temparrdate])
//                        {
//                            foundFlag =@"yes";
//
//                            UIAlertController * alert = [UIAlertController
//                                                         alertControllerWithTitle:nil
//                                                         message:@"You have already selected this date."
//                                                         preferredStyle:UIAlertControllerStyleAlert];
//                            //Add Buttons
//                            UIAlertAction* yesButton = [UIAlertAction
//                                                        actionWithTitle:@"OK"
//                                                        style:UIAlertActionStyleDefault
//                                                        handler:^(UIAlertAction * action) {
//
//                                                        }];
//
//                            //Add your buttons to alert controller
//
//                            [alert addAction:yesButton];
//
//                            [self presentViewController:alert animated:YES completion:nil];
//                        }
//                    }
//
//                    if ([foundFlag isEqualToString:@"no"])
//                    {
//                        // if([dateselect isEqualToString:temp]){
//
//                        if(cnt < count)
//                        {
//                            [arrSelecteddates addObject:selecteddate];
//                            cnt= cnt+1;
//                            NSLog(@"cnt=%d",cnt);
//
//                            self.viewpicker.hidden=NO;
//                            [self.view addSubview:_viewpicker];
//                            self.viewpicker.frame = CGRectMake(0, 0, screenWidth, screenHeight);
//
//                            found =@"yes";
//                        }
//
//                        else
//                        {
//                            NSString *msg = [NSString stringWithFormat:@"%@%d%@",@"You cannot select more than ",cnt,@" days."];
//                            UIAlertController * alert = [UIAlertController
//                                                         alertControllerWithTitle:nil
//                                                         message:msg
//                                                         preferredStyle:UIAlertControllerStyleAlert];
//                            //Add Buttons
//                            UIAlertAction* yesButton = [UIAlertAction
//                                                        actionWithTitle:@"OK"
//                                                        style:UIAlertActionStyleDefault
//                                                        handler:^(UIAlertAction * action) {
//
//                                                        }];
//
//                            //Add your buttons to alert controller
//
//                            [alert addAction:yesButton];
//
//                            [self presentViewController:alert animated:YES completion:nil];
//                        }
//                    //}
//                    }
//                }
//            //}
//
//                else
//                {
//                    // if([dateselect isEqualToString:temp]){
//
//                    if(cnt < count)
//                    {
//                        [arrSelecteddates addObject:selecteddate];
//                        cnt= cnt+1;
//                        NSLog(@"cnt=%d",cnt);
//
//                        self.viewredirect.hidden=NO;
//                        [self.view addSubview:_viewredirect];
//                        self.viewredirect.frame = CGRectMake(0, 0, screenWidth, screenHeight);
//
//                        found =@"yes";
//                    }
//
//                    else
//                    {
//                        NSString *msg = [NSString stringWithFormat:@"%@%d%@",@"You cannot select more than ",cnt,@" days."];
//
//                        UIAlertController * alert = [UIAlertController
//                                                     alertControllerWithTitle:nil
//                                                     message:msg
//                                                     preferredStyle:UIAlertControllerStyleAlert];
//                        //Add Buttons
//                        UIAlertAction* yesButton = [UIAlertAction
//                                                    actionWithTitle:@"OK"
//                                                    style:UIAlertActionStyleDefault
//                                                    handler:^(UIAlertAction * action) {
//
//                                                    }];
//
//                        //Add your buttons to alert controller
//
//                        [alert addAction:yesButton];
//
//                        [self presentViewController:alert animated:YES completion:nil];
//                    }
//                //}
//            //}
//
//                    self.viewredirect.hidden=NO;
//                    [self.view addSubview:_viewredirect];
//                    self.viewredirect.frame = CGRectMake(0, 0, screenWidth, screenHeight);
//                }
//            }
//        }
//
//        if ([found isEqualToString:@"yes"])
//        {
//
//        }
//
//        else
//        {
//            UIAlertController * alert = [UIAlertController
//                                         alertControllerWithTitle:nil
//                                         message:@"Please select date from today's date to next 15 days."
//                                         preferredStyle:UIAlertControllerStyleAlert];
//
//            //Add Buttons
//
//            UIAlertAction* yesButton = [UIAlertAction
//                                        actionWithTitle:@"OK"
//                                        style:UIAlertActionStyleDefault
//                                        handler:^(UIAlertAction * action) {
//
//                                        }];
//
//
//            //Add your buttons to alert controller
//
//            [alert addAction:yesButton];
//
//            [self presentViewController:alert animated:YES completion:nil];
//        }
//
//        NSLog(@"greatr");
//    }
}



- (BOOL)calendar:(CKCalendarView *)calendar willChangeToMonth:(NSDate *)date
{
    NSString *stDate1=[self.dateFormatter stringFromDate:date];
    NSLog(@"strDate=%@",stDate1);
    
    NSArray *items1 = [stDate1 componentsSeparatedByString:@"-"];   //take the one array for split the string
    
    year1=[NSString stringWithFormat:@"%@",[items1 objectAtIndex:0]];
    month1=[NSString stringWithFormat:@"%@",[items1 objectAtIndex:1]];
    
    
    if ([date laterDate:self.minimumDate] == date)
    {
       //self.calendar.backgroundColor = [UIColor blueColor];
        
        return YES;
    }
    
    else
    {
      // self.calendar.backgroundColor = [UIColor redColor];
        return NO;
    }
}





- (void)calendar:(CKCalendarView *)calendar didLayoutInRect:(CGRect)frame
{
    NSLog(@"calendar layout: %@", NSStringFromCGRect(frame));
}




-(void)CalendarSelectDate:(NSDate *)date
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *strcount = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"totalcount"]];
    
    int intcount = [strcount intValue];
    
    NSDateFormatter *dateFormatterwe = [[NSDateFormatter alloc] init];
    dateFormatterwe.dateFormat = @"yyyy-MM-dd";
    
    NSDate *finaldate = [NSDate date];
    
    NSTimeInterval days = 21600 * 60;
    
    finaldate = [finaldate dateByAddingTimeInterval:days];
    
    NSString *strthirdparty = [dateFormatterwe stringFromDate:date];
    
    NSDate *datethirdparty = [dateFormatterwe dateFromString:strthirdparty];
    
    NSString *strtsystem= [dateFormatterwe stringFromDate:[NSDate date]];
    NSString *strtsystemfinal = [dateFormatterwe stringFromDate:finaldate];
    NSComparisonResult result = [datethirdparty compare:[NSDate date]];
    NSComparisonResult resultfinal = [datethirdparty compare:finaldate];
    
    if (([strtsystem isEqualToString:strthirdparty] || result == NSOrderedDescending) && ([strtsystemfinal isEqualToString:strthirdparty] || resultfinal == NSOrderedAscending))
    {
        [arrDate1 addObject:date];
        
        if (arrDate1.count > intcount)
        {
            [arrDate1 removeLastObject];
        }
    }
    
    NSData *data1 = [NSData data];
    
    data1 = [NSKeyedArchiver archivedDataWithRootObject:arrDate1];
    
    [[NSUserDefaults standardUserDefaults] setValue:data1 forKey:@"arrinsertdate"];
    
    NSDate *dateforday = date;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc ]init];
    
    [formatter setDateFormat:@"EEEE"];
    
    NSString *strday = [formatter stringFromDate:dateforday];
    
    
    if ([strday isEqualToString:@"Sunday"])
    {
        strd = @"0";
    }
    
    else if ([strday isEqualToString:@"Monday"])
    {
        strd = @"1";
    }
    
    else if ([strday isEqualToString:@"Tuesday"])
    {
        strd = @"2";
    }
    
    else if ([strday isEqualToString:@"Wednesday"])
    {
        strd = @"3";
    }
    
    else if ([strday isEqualToString:@"Thursday"])
    {
        strd = @"4";
    }
    
    else if ([strday isEqualToString:@"Friday"])
    {
        strd = @"5";
    }
    
    else if ([strday isEqualToString:@"Saturday"])
    {
        strd = @"6";
    }
    
    
    NSArray *items1 = [stDate componentsSeparatedByString:@"-"];   //take the one array for split the string
    
    year1=[NSString stringWithFormat:@"%@",[items1 objectAtIndex:0]];
    month1=[NSString stringWithFormat:@"%@",[items1 objectAtIndex:1]];
    cur_date=[NSString stringWithFormat:@"%@",[items1 objectAtIndex:2]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *monthDayFormatter = [[NSDateFormatter alloc] init];
    [monthDayFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [monthDayFormatter setDateFormat:@"d"];
    int date_day = [[monthDayFormatter stringFromDate:date] intValue];
    NSString *suffix_string = @"|st|nd|rd|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|st|nd|rd|th|th|th|th|th|th|th|st";
    NSArray *suffixes = [suffix_string componentsSeparatedByString: @"|"];
    NSString *suffix = [suffixes objectAtIndex:date_day];
    [dateFormatter setDateFormat:[NSString stringWithFormat:@"EEEE d'%@' MMMM",suffix]];
    selecteddate = [dateFormatter stringFromDate:date];
    
    self.lbldeliverydate.text = [NSString stringWithFormat:@"%@",selecteddate];
    
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    strdate =[dateFormat stringFromDate:date];
    
    
    NSDate *date_now=[NSDate date];
    NSString *found;
    if ([date_now compare:date] == NSOrderedAscending)
    {
        flagminiumdate =@"no";
        
        if([flagfirst isEqualToString:@"no"])
        {
//            [GiFHUD showWithOverlay];
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self funcTime1];
            });
        }
        
        NSString *foundFlag=@"no";
        
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateselect = [dateFormatter stringFromDate:date];
        
        for (int i=0;i<showdays.count;i++)
        {
            NSString *temp =[showdays objectAtIndex:i];
            
            if([dateselect isEqualToString:temp])
            {
                if (arrSelecteddates.count >0)
                {
                    for (int p = 0; p<arrSelecteddates.count; p++)
                    {
                        NSLog(@"dates=%@",[arrSelecteddates objectAtIndex:p]);
                        
                        NSString *temparrdate = [NSString stringWithFormat:@"%@",[arrSelecteddates objectAtIndex:p]];
                        
                        if ([selecteddate isEqualToString: temparrdate])
                        {
                            foundFlag =@"yes";
                            
                            UIAlertController * alert = [UIAlertController
                                                         alertControllerWithTitle:nil
                                                         message:@"You have already selected this date."
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
                    }
                    
                    if ( [foundFlag isEqualToString:@"no"])
                    {
                        // if([dateselect isEqualToString:temp]){
                        if(cnt < count)
                        {
                            [arrSelecteddates addObject:selecteddate];
                            cnt= cnt+1;
                            NSLog(@"cnt=%d",cnt);
                            
                            self.viewpicker.hidden=NO;
                            [self.view addSubview:_viewpicker];
                            self.viewpicker.frame = CGRectMake(0, 0, screenWidth, screenHeight);
                            found =@"yes";
                        }
                        
                        else
                        {
                            NSString *msg = [NSString stringWithFormat:@"%@%d%@",@"You cannot select more than ",cnt,@" days"];
                            
                            UIAlertController *alert = [UIAlertController
                                                        alertControllerWithTitle:nil
                                                        message:msg
                                                        preferredStyle:UIAlertControllerStyleAlert];
                            //Add Buttons
                            UIAlertAction *yesButton = [UIAlertAction
                                                        actionWithTitle:@"OK"
                                                        style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction * action) {
                                                            
                                                        }];
                            
                            //Add your buttons to alert controller
                            
                            [alert addAction:yesButton];
                            
                            [self presentViewController:alert animated:YES completion:nil];
                        }
                        //}
                    }
                }
                //}
                
                else
                {
                    // if([dateselect isEqualToString:temp]){
                    
                    if(cnt < count)
                    {
                        [arrSelecteddates addObject:selecteddate];
                        cnt= cnt+1;
                        NSLog(@"cnt=%d",cnt);
                        
                        self.viewredirect.hidden=NO;
                        [self.view addSubview:_viewredirect];
                        self.viewredirect.frame = CGRectMake(0, 0, screenWidth, screenHeight);
                        
                        found =@"yes";
                    }
                    
                    else
                    {
                        NSString *msg = [NSString stringWithFormat:@"%@%d%@",@"You cannot select more than ",cnt,@" days"];
                        UIAlertController * alert = [UIAlertController
                                                     alertControllerWithTitle:nil
                                                     message:msg
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
                    //}
                    //}
                    
                    self.viewredirect.hidden=NO;
                    [self.view addSubview:_viewredirect];
                    self.viewredirect.frame = CGRectMake(0, 0, screenWidth, screenHeight);
                }
            }
        }
        
        if ([found isEqualToString:@"yes"])
        {
            
        }
        
        else
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:nil
                                         message:@"Please select date from today's date to next 15 days."
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
        
        NSLog(@"greatr");
    }
    
    else if ([date_now compare:date] == NSOrderedSame)
    {
        flagminiumdate =@"yes";
        
        if([flagfirst isEqualToString:@"no"])
        {
            [self funcTime1];
        }
        
        NSString *foundFlag=@"no";
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        
        // for (int i=0;i<showdays.count;i++){
        //   NSString *temp =[showdays objectAtIndex:i];
        
        if (arrSelecteddates.count >0)
        {
            for (int p = 0; p<arrSelecteddates.count; p++)
            {
                NSLog(@"dates=%@",[arrSelecteddates objectAtIndex:p]);
                
                NSString *temparrdate = [NSString stringWithFormat:@"%@",[arrSelecteddates objectAtIndex:p]];
                
                if ([selecteddate isEqualToString: temparrdate])
                {
                    foundFlag =@"yes";
                    
                    UIAlertController * alert = [UIAlertController
                                                 alertControllerWithTitle:nil
                                                 message:@"You have already selected this date."
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
            }
        }
        
        else
        {
            // if([dateselect isEqualToString:temp]){
            
            if(cnt < count)
            {
                [arrSelecteddates addObject:selecteddate];
                cnt= cnt+1;
                NSLog(@"cnt=%d",cnt);
                
                self.viewredirect.hidden=NO;
                [self.view addSubview:_viewredirect];
                self.viewredirect.frame = CGRectMake(0, 0, screenWidth, screenHeight);
                
                found =@"yes";
            }
            
            else
            {
                NSString *msg = [NSString stringWithFormat:@"%@%d%@",@"You cannot select more than ",cnt,@" days."];
                
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:msg
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
            //}
            //}
            
            self.viewredirect.hidden=NO;
            [self.view addSubview:_viewredirect];
            self.viewredirect.frame = CGRectMake(0, 0, screenWidth, screenHeight);
        }
    }
    
    else
    {
        flagminiumdate =@"yes";
        
        if([flagfirst isEqualToString:@"no"])
        {
            [self funcTime1];
        }
        
        NSString *foundFlag=@"no";
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *dateselect = [dateFormatter stringFromDate:date];
        
        for (int i=0;i<showdays.count;i++)
        {
            NSString *temp =[showdays objectAtIndex:i];
            
            if([dateselect isEqualToString: temp])
            {
                if (arrSelecteddates.count >0)
                {
                    for (int p = 0; p<arrSelecteddates.count; p++)
                    {
                        NSLog(@"dates=%@",[arrSelecteddates objectAtIndex:p]);
                        
                        NSString *temparrdate = [NSString stringWithFormat:@"%@",[arrSelecteddates objectAtIndex:p]];
                        
                        if ([selecteddate isEqualToString: temparrdate])
                        {
                            foundFlag =@"yes";
                            
                            UIAlertController * alert = [UIAlertController
                                                         alertControllerWithTitle:nil
                                                         message:@"You have already selected this date."
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
                    }
                    
                    if ([foundFlag isEqualToString:@"no"])
                    {
                        // if([dateselect isEqualToString:temp]){
                        
                        if(cnt < count)
                        {
                            [arrSelecteddates addObject:selecteddate];
                            cnt= cnt+1;
                            NSLog(@"cnt=%d",cnt);
                            
                            self.viewpicker.hidden=NO;
                            [self.view addSubview:_viewpicker];
                            self.viewpicker.frame = CGRectMake(0, 0, screenWidth, screenHeight);
                            
                            found =@"yes";
                        }
                        
                        else
                        {
                            NSString *msg = [NSString stringWithFormat:@"%@%d%@",@"You cannot select more than ",cnt,@" days."];
                            UIAlertController * alert = [UIAlertController
                                                         alertControllerWithTitle:nil
                                                         message:msg
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
                        //}
                    }
                }
                //}
                
                else
                {
                    // if([dateselect isEqualToString:temp]){
                    
                    if(cnt < count)
                    {
                        [arrSelecteddates addObject:selecteddate];
                        cnt= cnt+1;
                        NSLog(@"cnt=%d",cnt);
                        
                        self.viewredirect.hidden=NO;
                        [self.view addSubview:_viewredirect];
                        self.viewredirect.frame = CGRectMake(0, 0, screenWidth, screenHeight);
                        
                        found =@"yes";
                    }
                    
                    else
                    {
                        NSString *msg = [NSString stringWithFormat:@"%@%d%@",@"You cannot select more than ",cnt,@" days."];
                        
                        UIAlertController * alert = [UIAlertController
                                                     alertControllerWithTitle:nil
                                                     message:msg
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
                    //}
                    //}
                    
                    self.viewredirect.hidden=NO;
                    [self.view addSubview:_viewredirect];
                    self.viewredirect.frame = CGRectMake(0, 0, screenWidth, screenHeight);
                }
            }
        }
        
        if ([found isEqualToString:@"yes"])
        {
            
        }
        
        else
        {
            UIAlertController * alert = [UIAlertController
                                         alertControllerWithTitle:nil
                                         message:@"Please select date from today's date to next 15 days."
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
        
        NSLog(@"greatr");
    }
}





- (IBAction)btnaddAddress:(id)sender
{
    AddDeliveryaddressController *obj=[[AddDeliveryaddressController alloc]initWithNibName:@"AddDeliveryaddressController" bundle:nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    
    obj.flag = @"2";
    obj.fromWeeklyCalendar = @"yes";
    [self.navigationController pushViewController:obj animated:YES];
}




- (IBAction)btnsettimeclicked:(id)sender
{
    flagTimer =@"no";
    flagdate = @"yes";
    [time invalidate];
    time = nil;
    
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormat setLocale:usLocale];
    
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    [dateFormat setDateFormat:@"hh:mm a"];
    
    str_date = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:_datepicker.date]];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm a"];
    
    str_time = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:_datepicker.date]];
    
    str_time =[str_time stringByReplacingOccurrencesOfString:@"PM" withString:@"pm"];
    
    str_time =[str_time stringByReplacingOccurrencesOfString:@"AM" withString:@"am"];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    strdate = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:_datepicker.date]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSDateFormatter *monthDayFormatter = [[NSDateFormatter alloc] init];
    [monthDayFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [monthDayFormatter setDateFormat:@"d"];
    int date_day = [[monthDayFormatter stringFromDate:_datepicker.date] intValue];
    NSString *suffix_string = @"|st|nd|rd|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|th|st|nd|rd|th|th|th|th|th|th|th|st";
    NSArray *suffixes = [suffix_string componentsSeparatedByString: @"|"];
    NSString *suffix = [suffixes objectAtIndex:date_day];
    [dateFormatter setDateFormat:[NSString stringWithFormat:@"EEEE d'%@' MMMM",suffix]];
    NSString *newdate = [dateFormatter stringFromDate:_datepicker.date];
    
    if(arrSelecteddates.count >0)
    {
        NSLog(@"cnt=%d",count);
        
        NSMutableDictionary *tempdict = [[NSMutableDictionary alloc] init];
        [tempdict removeAllObjects];
        
        NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
        
        if(arrSelecteddates.count>0)
        {
            [dictet setObject:selecteddate forKey:@"SelectedDate"];
            [dictet setObject:newdate forKey:@"NewSelectedDate"];
            [dictet setObject:str_date forKey:@"SelectedTime"];
            [dictet setObject:strdate forKey:@"delivery_date"];
            [dictet setObject:str_time forKey:@"delivery_time"];
            [dictet setObject:@"no" forKey:@"isclicked"];
            [dictet setObject:@"no" forKey:@"cutleryflag"];
            
            [arrdateAndTime addObject:dictet];
            NSLog(@"arrSelecteddates=%lu",(unsigned long)arrdateAndTime.count);
            
            _LBLNORECORD.hidden=YES;
            
            [_tblObj bringSubviewToFront:self.view];
            _tblObj.hidden=NO;
            _btnnext.backgroundColor=[UIColor colorWithRed:119.0/255.0f green:189.0/255.0f blue:29.0/255.0f alpha:1];
            
            [self.tblObj reloadData];
            _tblobjheight.constant = _tblObj.contentSize.height;
            
            if(screenHeight < 800)
            {
                _tbltop.constant = 15;
            }
            
            else
            {
                _tbltop.constant = 75;
            }
            
            self.viewpicker.hidden=YES;
        }
    }
}





- (IBAction)btnminimum:(id)sender
{
    NSData *data1 = [NSData data];
    
    count=count-1;
    
    if(count<3)
    {
        count=3;
        _lblcount.text=[NSString stringWithFormat:@"%d",count];
        
        NSString *strcount = [NSString stringWithFormat:@"%d", count];
        
        [[NSUserDefaults standardUserDefaults] setValue:strcount forKey:@"totalcount"];
    }
    
    else
    {
        _lblcount.text=[NSString stringWithFormat:@"%d",count];
        
        NSString *strcount = [NSString stringWithFormat:@"%d", count];
        
        [[NSUserDefaults standardUserDefaults] setValue:strcount forKey:@"totalcount"];
    }
    
    if (arrdateAndTime.count > 0)
    {
        int count = [_lblcount.text intValue];
        
        if (arrdateAndTime.count > count)
        {
            [arrdateAndTime removeLastObject];
            [arrSelecteddates removeLastObject];
            [arrDate1 removeLastObject];
            cnt=cnt-1;
            [_tblObj reloadData];
            _tblobjheight.constant = _tblObj.contentSize.height;
        }
    }
    
    else
    {
        
    }
    
    data1 = [NSKeyedArchiver archivedDataWithRootObject:arrDate1];
    
    [[NSUserDefaults standardUserDefaults] setValue:data1 forKey:@"arrinsertdate"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"callCalendar" object:self];
}




- (IBAction)btnplus:(id)sender
{
    count=count+1;
    
    if(count<1)
    {
        count=3;
        _lblcount.text=[NSString stringWithFormat:@"%d",count];
        
        NSString *strcount = [NSString stringWithFormat:@"%d", count];
        
        [[NSUserDefaults standardUserDefaults] setValue:strcount forKey:@"totalcount"];
    }
    
    else if(count>13)
    {
        count=14;
        _lblcount.text=[NSString stringWithFormat:@"%d",count];
        
        NSString *strcount = [NSString stringWithFormat:@"%d", count];
        
        [[NSUserDefaults standardUserDefaults] setValue:strcount forKey:@"totalcount"];
    }
    
    else
    {
        _lblcount.text=[NSString stringWithFormat:@"%d",count];
        
        NSString *strcount = [NSString stringWithFormat:@"%d", count];
        
        [[NSUserDefaults standardUserDefaults] setValue:strcount forKey:@"totalcount"];
    }
}






#pragma mark <---Web Services--->

-(void)wsGetAddress
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *user_id=[defaults valueForKey:@"user_id"];
    NSString *token = [defaults valueForKey:@"token"];
    BaseViewController *base=[[BaseViewController alloc]init];
    NSString *strWebserviceCompleteURL = [NSString stringWithFormat:@"%@",str_global_domain] ;
    [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"isgetmethod"];
    
    NSString *parameter=[NSString stringWithFormat:@"user_id=%@&request=%@&action=%@&key=%@&secret=%@&token=%@",user_id,@"addresses",@"view",str_key,str_secret,token];
    
    NSDictionary *dictionary =[[NSMutableDictionary alloc]init];
    
    dictionary=[base WebParsingMethod:strWebserviceCompleteURL :parameter];
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
        });
    }
}





//-(void)wsGetTime
//{
//    BaseViewController *base=[[BaseViewController alloc]init];
//
//    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
//    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
//
//    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
//    NSString *strloc = [defaults valueForKey:@"location"];
//    NSString *parameter=[NSString stringWithFormat:@"request=%@&area=%@&action=%@",@"allareas",strloc,@"getshop"];
//
//    NSDictionary *dictionary =[[NSMutableDictionary alloc]init];
//
//    dictionary=[base WebParsingMethod:stringWebServicesCompleteUrl :parameter];
//
//    if(dictionary == (id)[NSNull null] || dictionary == nil)
//    {
//        UIAlertController * alert = [UIAlertController
//                                     alertControllerWithTitle:nil
//                                     message:@"Oops, cannot connect to server."
//                                     preferredStyle:UIAlertControllerStyleAlert];
//
//        //Add Buttons
//
//        UIAlertAction* yesButton = [UIAlertAction
//                                    actionWithTitle:@"OK"
//                                    style:UIAlertActionStyleDefault
//                                    handler:^(UIAlertAction * action)
//                                    {
//
//                                    }];
//
//        //Add your buttons to alert controller
//        [alert addAction:yesButton];
//
//        [self presentViewController:alert animated:YES completion:nil];
//    }
//
//    else
//    {
//        NSString *errorCode=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"code"]];
//        NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
//
//        //dispatch_async(dispatch_get_main_queue(),^{
//
//            if([errorCode isEqualToString:@"1"])
//            {
//                arrshop = [dictionary valueForKey:@"data"];
//
//                mintime = [[arrshop objectAtIndex:0]valueForKey:@"start"];
//
//                NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
//                dateFormat.dateStyle=NSDateFormatterMediumStyle;
//                [dateFormat setDateFormat:@"HH:mm"];
//                strStartTime=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:[NSDate date]]];
//
//                starttime = strStartTime.intValue;
//                NSCalendar *calendar = [NSCalendar currentCalendar];
//                NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:[NSDate date]];
//
//                NSInteger minute1 = [components minute];
//
//                if ((0 < minute1) && (minute1 < 15))
//                {
//                    minute = 15;
//                }
//
//                else if( (16 < minute1) && (minute1 < 30))
//                {
//                    minute = 30;
//                }
//
//                else if((31 < minute1) && (minute1 < 45))
//                {
//                    minute = 45;
//                }
//
//                else if ((46 < minute1) && (minute1 < 60))
//                {
//                    minute = 00;
//                    starttime = starttime + 1;
//                }
//
//                strEndTime =[[arrshop objectAtIndex:0]valueForKey:@"end"];
//                endtime = 20;
//
//                strEndTime =[[arrshop objectAtIndex:0]valueForKey:@"end"];
//                endtime = strEndTime.intValue;
//
//                NSString *strshop = [NSString stringWithFormat:@"%@",[[arrshop objectAtIndex:0] valueForKey:@"shop"]];
//
//                NSString *shopname = [NSString stringWithFormat:@"Your order will be sent from %@",strshop];
//
//                UIAlertController * alert = [UIAlertController
//                                             alertControllerWithTitle:nil
//                                             message:shopname
//                                             preferredStyle:UIAlertControllerStyleAlert];
//
//                //Add Buttons
//
//                UIAlertAction* yesButton = [UIAlertAction
//                                            actionWithTitle:@"OK"
//                                            style:UIAlertActionStyleDefault
//                                            handler:^(UIAlertAction * action)
//                                            {
//                                                strtime = @"1";
//                                                _viewredirect.hidden=YES;
//                                                _viewpicker.hidden=NO;
//                                                [self.view addSubview:_viewpicker];
//                                                self.viewpicker.frame = CGRectMake(0, 0, screenWidth, screenHeight);
//                                                [_viewpicker bringSubviewToFront:self.view];
//
//                                                _datepicker.backgroundColor = [UIColor whiteColor];
//                                                [_datepicker setValue:[UIColor colorWithRed:119.0/255.0f green:189.0/255.0f blue:29.0/255.0f alpha:1] forKey:@"textColor"];
//
//                                                [self funcTime1];
//
//                                                time =  [NSTimer scheduledTimerWithTimeInterval:60.0
//                                                                                         target:self
//                                                                                       selector:@selector(funcTime1)
//                                                                                       userInfo:nil
//                                                                                        repeats:YES];
//
//                                                flagfirst=@"no";
//                                            }];
//
//                //Add your buttons to alert controller
//                [alert addAction:yesButton];
//
//                [self presentViewController:alert animated:YES completion:nil];
//            }
//
//            else if ([errorCode isEqualToString:@"0"])
//            {
//                NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
//
//                UIAlertController * alert = [UIAlertController
//                                             alertControllerWithTitle:nil
//                                             message:message
//                                             preferredStyle:UIAlertControllerStyleAlert];
//
//                //Add Buttons
//
//                UIAlertAction* yesButton = [UIAlertAction
//                                            actionWithTitle:@"OK"
//                                            style:UIAlertActionStyleDefault
//                                            handler:^(UIAlertAction * action) {
//
//                                            }];
//
//                //Add your buttons to alert controller
//
//                [alert addAction:yesButton];
//
//                [self presentViewController:alert animated:YES completion:nil];
//            }
//
//            else if ([errorCode isEqualToString:@"5"])
//            {
//                UIAlertController * alert = [UIAlertController
//                                             alertControllerWithTitle:nil
//                                             message:message
//                                             preferredStyle:UIAlertControllerStyleAlert];
//
//                //Add Buttons
//
//                UIAlertAction* yesButton = [UIAlertAction
//                                            actionWithTitle:@"OK"
//                                            style:UIAlertActionStyleDefault
//                                            handler:^(UIAlertAction * action) {
//
//                                            }];
//
//                //Add your buttons to alert controller
//
//                [alert addAction:yesButton];
//
//                [self presentViewController:alert animated:YES completion:nil];
//            }
//
//            else
//            {
//                UIAlertController * alert = [UIAlertController
//                                             alertControllerWithTitle:nil
//                                             message:@"Something went wrong. Please try again later."
//                                             preferredStyle:UIAlertControllerStyleAlert];
//
//                //Add Buttons
//                UIAlertAction* yesButton = [UIAlertAction
//                                            actionWithTitle:@"OK"
//                                            style:UIAlertActionStyleDefault
//                                            handler:^(UIAlertAction * action) {
//
//                                            }];
//
//                //Add your buttons to alert controller
//
//                [alert addAction:yesButton];
//
//                [self presentViewController:alert animated:YES completion:nil];
//            }
//        //});
//    }
//}




//-(void)wsGetWeeklyTime
//{
//    BaseViewController *base=[[BaseViewController alloc]init];
//
//    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
//    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
//
//    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
//    NSString *strloc = [defaults valueForKey:@"location"];
//    NSString *parameter=[NSString stringWithFormat:@"request=%@&area=%@&action=%@&key=%@&secret=%@",@"allareas",strloc,@"getshopforweekly",str_key,str_secret];
//
//    NSDictionary *dictionary =[[NSMutableDictionary alloc]init];
//
//    dictionary=[base WebParsingMethod:stringWebServicesCompleteUrl :parameter];
//
//    if(dictionary == (id)[NSNull null] || dictionary == nil)
//    {
//        UIAlertController * alert = [UIAlertController
//                                     alertControllerWithTitle:nil
//                                     message:@"Oops, cannot connect to server."
//                                     preferredStyle:UIAlertControllerStyleAlert];
//
//        //Add Buttons
//
//        UIAlertAction* yesButton = [UIAlertAction
//                                    actionWithTitle:@"OK"
//                                    style:UIAlertActionStyleDefault
//                                    handler:^(UIAlertAction * action)
//                                    {
//
//                                    }];
//
//        //Add your buttons to alert controller
//        [alert addAction:yesButton];
//
//        [self presentViewController:alert animated:YES completion:nil];
//    }
//
//    else
//    {
//        NSString *errorCode=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"code"]];
//        NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
//
//        //dispatch_async(dispatch_get_main_queue(),^{
//
//        if([errorCode isEqualToString:@"1"])
//        {
//            dicttime = [dictionary valueForKey:@"data"];
//            arrtime = [dicttime valueForKey:@"time"];
//
//            for (int i = 0; i<arrtime.count; i++)
//            {
//                NSString *strday = [[arrtime objectAtIndex:i] valueForKey:@"day"];
//
//                if ([strday isEqualToString:strd])
//                {
//                    mintime = [[arrtime objectAtIndex:i] valueForKey:@"start_time"];
//
//                    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
//                    dateFormat.dateStyle=NSDateFormatterMediumStyle;
//                    [dateFormat setDateFormat:@"HH:mm"];
//                    strStartTime=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:[NSDate date]]];
//
//                    starttime = strStartTime.intValue;
//                    NSCalendar *calendar = [NSCalendar currentCalendar];
//                    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:[NSDate date]];
//
//                    NSInteger minute1 = [components minute];
//
//                    if ((0 < minute1) && (minute1 < 15))
//                    {
//                        minute = 15;
//                    }
//
//                    else if( (16 < minute1) && (minute1 < 30))
//                    {
//                        minute = 30;
//                    }
//
//                    else if((31 < minute1) && (minute1 < 45))
//                    {
//                        minute = 45;
//                    }
//
//                    else if ((46 < minute1) && (minute1 < 60))
//                    {
//                        minute = 00;
//                        starttime = starttime + 1;
//                    }
//
//                    strEndTime =[[arrtime objectAtIndex:i] valueForKey:@"end_time"];
//                    endtime = strEndTime.intValue;
//
//                    NSString *strshop = [NSString stringWithFormat:@"%@",[dicttime valueForKey:@"shop_name"]];
//
//                    NSString *shopname = [NSString stringWithFormat:@"Your order will be sent from %@.",strshop];
//
//                    UIAlertController * alert = [UIAlertController
//                                                 alertControllerWithTitle:nil
//                                                 message:shopname
//                                                 preferredStyle:UIAlertControllerStyleAlert];
//
//                    //Add Buttons
//
//                    UIAlertAction* yesButton = [UIAlertAction
//                                                actionWithTitle:@"OK"
//                                                style:UIAlertActionStyleDefault
//                                                handler:^(UIAlertAction * action)
//                                                {
//                                                    strtime = @"1";
//                                                    _viewredirect.hidden=YES;
//                                                    _viewpicker.hidden=NO;
//                                                    [self.view addSubview:_viewpicker];
//                                                    self.viewpicker.frame = CGRectMake(0, 0, screenWidth, screenHeight);
//                                                    [_viewpicker bringSubviewToFront:self.view];
//
//                                                    _datepicker.backgroundColor = [UIColor whiteColor];
//                                                    [_datepicker setValue:[UIColor colorWithRed:119.0/255.0f green:189.0/255.0f blue:29.0/255.0f alpha:1] forKey:@"textColor"];
//
//                                                    [self funcTime1];
//
//                                                    time =  [NSTimer scheduledTimerWithTimeInterval:60.0
//                                                                                             target:self
//                                                                                           selector:@selector(funcTime1)
//                                                                                           userInfo:nil
//                                                                                            repeats:YES];
//
//                                                    flagfirst=@"no";
//                                                }];
//
//                    //Add your buttons to alert controller
//                    [alert addAction:yesButton];
//
//                    [self presentViewController:alert animated:YES completion:nil];
//                }
//            }
//        }
//
//        else if ([errorCode isEqualToString:@"0"])
//        {
//            NSString *message=[NSString stringWithFormat:@"%@",[dictionary valueForKey:@"message"]];
//
//            UIAlertController * alert = [UIAlertController
//                                         alertControllerWithTitle:nil
//                                         message:message
//                                         preferredStyle:UIAlertControllerStyleAlert];
//
//            //Add Buttons
//
//            UIAlertAction* yesButton = [UIAlertAction
//                                        actionWithTitle:@"OK"
//                                        style:UIAlertActionStyleDefault
//                                        handler:^(UIAlertAction * action) {
//
//                                        }];
//
//            //Add your buttons to alert controller
//
//            [alert addAction:yesButton];
//
//            [self presentViewController:alert animated:YES completion:nil];
//        }
//
//        else if ([errorCode isEqualToString:@"5"])
//        {
//            UIAlertController * alert = [UIAlertController
//                                         alertControllerWithTitle:nil
//                                         message:message
//                                         preferredStyle:UIAlertControllerStyleAlert];
//
//            //Add Buttons
//
//            UIAlertAction* yesButton = [UIAlertAction
//                                        actionWithTitle:@"OK"
//                                        style:UIAlertActionStyleDefault
//                                        handler:^(UIAlertAction * action) {
//
//                                        }];
//
//            //Add your buttons to alert controller
//
//            [alert addAction:yesButton];
//
//            [self presentViewController:alert animated:YES completion:nil];
//        }
//
//        else
//        {
//            UIAlertController * alert = [UIAlertController
//                                         alertControllerWithTitle:nil
//                                         message:@"Something went wrong. Please try again later."
//                                         preferredStyle:UIAlertControllerStyleAlert];
//
//            //Add Buttons
//            UIAlertAction* yesButton = [UIAlertAction
//                                        actionWithTitle:@"OK"
//                                        style:UIAlertActionStyleDefault
//                                        handler:^(UIAlertAction * action) {
//
//                                        }];
//
//            //Add your buttons to alert controller
//
//            [alert addAction:yesButton];
//
//            [self presentViewController:alert animated:YES completion:nil];
//        }
//        //});
//    }
//}




-(void)wsGetWeeklyTime
{
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSString *token = [defaults valueForKey:@"token"];
    NSString *strloc = [defaults valueForKey:@"location"];
    
    NSString *parameter=[NSString stringWithFormat:@"request=%@&area=%@&action=%@&key=%@&secret=%@&date=%@&order_type=%@&token=%@",@"allareas",strloc,@"getshopforweekly",str_key,str_secret,stDate,@"weekly",token];
    
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
            NSLog(@"weeklytime called");
            dicttime = [dictionary valueForKey:@"data"];
            
            dictt = [dicttime valueForKey:@"time"];
            
            dictavailable = [dictt valueForKey:@"available_times"];
            
            mintime = [dictavailable valueForKey:@"start"];
            
            strEndTime = [dictavailable valueForKey:@"end"];
            
            NSString *strshop = [NSString stringWithFormat:@"%@",[dicttime valueForKey:@"shop"]];
            
            NSString *shopname = [NSString stringWithFormat:@"Your order will be sent from %@.",strshop];
            
            if ([flagdate isEqualToString:@""])
            {
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
                                                _viewredirect.hidden=YES;
                                                _viewpicker.hidden=NO;
                                                [self.view addSubview:_viewpicker];
                                                self.viewpicker.frame = CGRectMake(0, 0, screenWidth, screenHeight);
                                                [_viewpicker bringSubviewToFront:self.view];
                                                
                                                _datepicker.backgroundColor = [UIColor whiteColor];
                                                [_datepicker setValue:[UIColor colorWithRed:119.0/255.0f green:189.0/255.0f blue:29.0/255.0f alpha:1] forKey:@"textColor"];
                                                
                                                [self funcTime1];
                                                
                                                time =  [NSTimer scheduledTimerWithTimeInterval:60.0
                                                                                         target:self
                                                                                       selector:@selector(funcTime1)
                                                                                       userInfo:nil
                                                                                        repeats:YES];
                                                
                                                flagfirst=@"no";
                                            }];
                
                //Add your buttons to alert controller
                [alert addAction:yesButton];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
            
            else
            {
                
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
        //});
    }
}





-(void)funcTime1
{
    NSLog(@"funcTime1 called");
    
//    arrtime = [dicttime valueForKey:@"time"];
//
//    for (int i = 0; i<arrtime.count; i++)
//    {
//        NSString *strday = [[arrtime objectAtIndex:i] valueForKey:@"day"];
//
//        if ([strday isEqualToString:strd])
//        {
//            mintime = [[arrtime objectAtIndex:i] valueForKey:@"start_time"];
//
//            strEndTime = [[arrtime objectAtIndex:i] valueForKey:@"end_time"];
//        }
//    }
    
    mintime = [dictavailable valueForKey:@"start"];
    
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
    
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormat setLocale:usLocale];
    
    dateFormat.dateStyle=NSDateFormatterMediumStyle;
    
    NSString *strex = [NSString stringWithFormat:@"%@", mintime];
    
    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *startdatweb =[dateFormat dateFromString:strex];
    
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
    
    [dateFormat setDateFormat:@"HH:mm"];
    
    strStartTime=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:startdatweb]];
    
//    NSDate *datetemp = [dateFormat dateFromString:strStartTime];
//
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
    //NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:datetemp2];
    NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:startdatweb];
    
//    NSInteger minute1 = [components minute];
//
//    if ((0 <= minute1) && (minute1 <= 15))
//    {
//        minute = 15;
//    }
//
//    else if( (16 <= minute1) && (minute1 <= 30))
//    {
//        minute = 30;
//    }
//
//    else if((31 <= minute1) && (minute1 <= 45))
//    {
//        minute = 45;
//    }
//
//    else if ((46 <= minute1) && (minute1 <= 60))
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
    
    if ([flagminiumdate isEqualToString:@"yes"])
    {
        [_datepicker setMinimumDate:startDate];
    }
    
    else
    {
        flagminiumdate=@"";
        
        NSDateFormatter *formattinf =[[NSDateFormatter alloc]init];
        
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [formattinf setLocale:usLocale];
        
        [formattinf setDateFormat:@"yyyy-MM-dd HH:mm"];
        
        NSString *strtotaldate =[NSString stringWithFormat:@"%@",mintime];
        NSDate *granddate =[formattinf dateFromString:strtotaldate];
        
        [formattinf setDateFormat:@"HH:mm"];
        
        NSString *strstarttime =[formattinf stringFromDate:granddate];
        
//        NSDate *datetemp = [formattintime dateFromString:strstarttime];
//
//        NSTimeInterval seconds = 45 * 60;
//
//        NSDate *datetemp2 = [datetemp dateByAddingTimeInterval:seconds];
//
//        strstarttime=[NSString stringWithFormat:@"%@",[formattintime stringFromDate:datetemp2]];
        
        int strdate1 = [strstarttime intValue];
        
        NSDate *startmin =[formattinf dateFromString:strstarttime];
        
        [dateFormat setDateFormat:@"mm"];
        
        NSString *strmin1 = [dateFormat stringFromDate:startmin];
        
        int strdate2 = strmin1.intValue;
        
        [dateFormat setDateFormat:@"dd"];
        
        NSString *strday = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:startdatweb]];
        
        int startday2 = strday.intValue;
        
        [dateFormat setDateFormat:@"MM"];
        
        NSString *strmonth = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:startdatweb]];
        
        int startmonth2 = strmonth.intValue;
        
        [dateFormat setDateFormat:@"yyyy"];
        
        NSString *stryear = [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:startdatweb]];
        
        int startyear2 = stryear.intValue;
        
        NSCalendar *calendar = [NSCalendar currentCalendar];
//        NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:datetemp2];
        NSDateComponents *components = [calendar components:(NSCalendarUnitHour | NSCalendarUnitMinute) fromDate:startdatweb];
        
//        NSInteger minute1 = [components minute];
//
//        int strdate2 = 0;
//
//        if ((0 <= minute1) && (minute1 <= 15))
//        {
//            strdate2 = 15;
//        }
//
//        else if( (16 <= minute1) && (minute1 <= 30))
//        {
//            strdate2 = 30;
//        }
//
//        else if((31 <= minute1) && (minute1 <= 45))
//        {
//            strdate2 = 45;
//        }
//
//        else if ((46 <= minute1) && (minute1 <= 60))
//        {
//            strdate2 = 00;
//
//            if (strdate1 <23)
//            {
//                strdate1 = strdate1 + 1;
//            }
//
//            else
//            {
//                strdate1 = 0;
//            }
//        }
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
        [components setDay:startday2];
        [components setMonth:startmonth2];
        [components setYear:startyear2];
        [components setHour: strdate1];
        [components setMinute: strdate2];
        [components setSecond: 0];
        
        NSDate *startDatet = [gregorian dateFromComponents:components];
        [_datepicker setMinimumDate:startDatet];
    }
    
    [_datepicker setMaximumDate:endDate];
    [_datepicker setDate:startDate animated:YES];
}





- (IBAction)btnnextclicked:(id)sender
{
    int days = 0;
    NSString *strcount = [NSString stringWithFormat:@"%d",count];
    
    if (arrweeklydata.count > 1)
    {
        days = count;
    }
    
    else
    {
        days = [_lblcount.text intValue];
    }
    
    
    if(arrdateAndTime.count<days)
    {
        NSString *msg = [NSString stringWithFormat:@"Please select your delivery dates."];
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:msg
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
        
        if (arrweeklydata.count > 1)
        {
            WeeklyViewCart *obj=[[WeeklyViewCart alloc]initWithNibName:@"WeeklyViewCart" bundle:nil];
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
            
            for (int i = 0; i<arrdateAndTime.count; i++)
            {
                NSMutableDictionary *dictemp =[[NSMutableDictionary alloc]init];
                NSMutableArray *arrtemp =[[NSMutableArray alloc]init];
                
                dictemp =[[arrdateAndTime objectAtIndex:i] mutableCopy];
                
                for (int j = i; j<arrweeklydata.count; j++)
                {
                    NSMutableDictionary *dictweekly =[[NSMutableDictionary alloc]init];
                    
                    dictweekly = [[arrweeklydata objectAtIndex:j] mutableCopy];
                    
                    arrtemp = [dictweekly valueForKey:@"products"];
                    
                    break;
                }
                
                [dictemp setObject:arrtemp forKey:@"products"];
                
                [arrdateAndTime replaceObjectAtIndex:i withObject:dictemp];
            }
            
            NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:arrdateAndTime];
            
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            [defaults setObject:data1 forKey:@"weeklyorderarray"];
            [defaults synchronize];
            [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"weeklyorderclicked"];
            [[NSUserDefaults standardUserDefaults] setObject:strcount forKey:@"weeklycount"];
            
            [self.navigationController pushViewController:obj animated:YES];
        }
        
        else
        {
            MenuViewController *obj=[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
            obj.weeklyflag=@"yes";
            
            for (int i = 0; i<arrdateAndTime.count; i++)
            {
                NSMutableDictionary *dictemp =[[NSMutableDictionary alloc]init];
                NSMutableArray *arrtemp =[[NSMutableArray alloc]init];
                
                dictemp =[[arrdateAndTime objectAtIndex:i] mutableCopy];
                
                [dictemp setObject:arrtemp forKey:@"products"];
                
                [arrdateAndTime replaceObjectAtIndex:i withObject:dictemp];
            }
            
            NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:arrdateAndTime];
            
            NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
            [defaults setObject:data1 forKey:@"weeklyorderarray"];
            [defaults synchronize];
            [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"weeklyorderclicked"];
            [[NSUserDefaults standardUserDefaults] setValue:_lblcount.text forKey:@"weeklycount"];
            
            [self.navigationController pushViewController:obj animated:YES];
        }
    }
}




@end

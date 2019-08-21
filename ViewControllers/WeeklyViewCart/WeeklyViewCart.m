//
//  WeeklyViewCart.m
//  KCal
//
//  Created by Pipl-10 on 02/08/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "WeeklyViewCart.h"
#import "weeklyCell.h"
#import "MenuViewController.h"
#import "SubmenuCell.h"
#import "AccordionHeaderView.h"
#import "weeklyCell.h"
#import "SubViewextraTableViewCell.h"
#import "BaseViewController.h"
#import "AppDelegate.h"
#import "paymentMethodViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreText/CTStringAttributes.h>
#import <CoreText/CoreText.h>

static NSString *const kTableViewCellReuseIdentifier = @"TableViewCellReuseIdentifier";

@interface WeeklyViewCart ()
{
    weeklyCell *cell;
    NSString *str_date, *str_date1;
    NSMutableArray *arrweeklydata, *arritems;
    AccordionHeaderView *headerCell;
    int sectionnum;
    SubmenuCell *cell1;
    int countsection, sendertag;
    NSMutableArray *arrproducts;
    NSString *stropenflag;
    int selectsection;
    NSString *flagopencondtion;
    NSString *strdiscountprices;
    int sfmhdsifj;
    NSMutableArray *arrweeks;
    NSMutableDictionary *dictoptions;
    NSMutableDictionary *dicttempo;
    CGRect screenRect ;
    CGFloat screenWidth;
    CGFloat screenHeight;
    int cutlery_count;
}

@end

@implementation WeeklyViewCart

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *strcount = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"cutlery_selected"]];
    cutlery_count = strcount.intValue;
    
    screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    for (UIButton *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 134)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 227)
        {
            [view removeFromSuperview];
        }
    }
    
    countsection = 0;
    
    dictoptions = [[NSMutableDictionary alloc]init];
    _arrweekllydatas =[[NSMutableArray alloc] init];
    
    _txtcomment.layer.cornerRadius = 5;
    _txtcomment.layer.borderWidth=1.0f;
    _txtcomment.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _txtcomment.clipsToBounds = YES;
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissblurcomment)];
    
    [self.lblblurcomment addGestureRecognizer:tap2];
    
    self.title = @"My Cart";
    self.navigationItem.hidesBackButton = YES;
    stropenflag =@"no";
    [self.view addSubview:_viewEnterPromocode];
    [self.view addSubview:_viewqty];
    [self.view addSubview:_viewcomment];
    _viewcomment.hidden=YES;
    _viewqty.hidden = YES;
    self.viewEnterPromocode.hidden=YES;
    _viewpromocode.hidden=NO;
    
    self.viewafterpomocode.hidden=YES;
    self.tblobj.allowMultipleSectionsOpen=NO;
    
    [self.tblobj registerClass:[UITableViewCell class] forCellReuseIdentifier:kTableViewCellReuseIdentifier];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"triggeronce"];
    
    NSString *strpromo_code = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"promocode_for_order"]];
    
    if (strpromo_code.length > 0)
    {
        _lblpromotitle.text = [NSString stringWithFormat:@"%@",strpromo_code];
        
        self.btnpromo.hidden = YES;
        self.btnaddPromocode.hidden = YES;
    }
    
    else
    {
        self.btnpromo.hidden = NO;
        self.btnaddPromocode.hidden = NO;
    }
    
    [self.tblobj registerNib:[UINib nibWithNibName:@"AccordionHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:kAccordionHeaderViewReuseIdentifier];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"handle_data" object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addquntity) name:@"addquntity" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addcomentview) name:@"addcomentview" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addcutleryval) name:@"addcutleryval" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteitem) name:@"deleteitem" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addmoreitems) name:@"addmoreitems" object:nil];
    
    
    arrweeklydata =[[NSMutableArray alloc]init];
    
    NSData *dataarraddtocart = [[NSUserDefaults standardUserDefaults]valueForKey:@"weeklyorderarray"];
    
    if (!(dataarraddtocart == nil))
    {
        arrweeklydata=[[NSKeyedUnarchiver unarchiveObjectWithData:dataarraddtocart] mutableCopy];
    }
    
    
    for (int i =0; i<arrweeklydata.count; i++)
    {
        NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
        dictet =[[arrweeklydata objectAtIndex:i] mutableCopy];
        [dictet setObject:@"false" forKey:@"flag"];
        [arrweeklydata replaceObjectAtIndex:i withObject:dictet];
    }
    
    
    for (int k = 0; k<arrweeklydata.count; k++)
    {
        NSMutableDictionary *dictet = [[NSMutableDictionary alloc]init];
        dictet = [[arrweeklydata objectAtIndex:k] mutableCopy];
        
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        
        arr = [dictet valueForKey:@"products"];
        int tempamount = 0;
        
        for (int l = 0; l<arr.count; l++)
        {
            NSMutableDictionary *dictemp =[[NSMutableDictionary alloc]init];
            
            dictemp = [[arr objectAtIndex:l] mutableCopy];
            
            NSString *strprice = [NSString stringWithFormat:@"%@",[dictemp valueForKey:@"totalprice"]];
            
            int price = [strprice intValue];
            
            tempamount = tempamount + price;
        }
        
        NSString *sgf = [NSString stringWithFormat:@"%d",tempamount];
        [dictet setObject:sgf forKey:@"sumofallprices"];
        
        [arrweeklydata replaceObjectAtIndex:k withObject:dictet];
    }
    
    
    _viewobjheight.constant = arrweeklydata.count*60;
    
    sfmhdsifj = 0;
    
    for (int i = 0; i<arrweeklydata.count; i++)
    {
        NSMutableArray *fast =[[NSMutableArray alloc]init];
        fast =[[[arrweeklydata objectAtIndex:i]valueForKey:@"products"] mutableCopy];
        
        for (int m = 0; m<fast.count; m++)
        {
            NSString *jdv =[NSString stringWithFormat:@"%@",[[fast objectAtIndex:m]valueForKey:@"totalprice"]];
            int fgdjk = [jdv intValue];
            NSString *ttqty = [[fast objectAtIndex:m]valueForKey:@"quantity"];
            int qty= ttqty.intValue;
            if(qty > 0)
            {
                sfmhdsifj = sfmhdsifj + fgdjk;
            }
            
            else
            {
                sfmhdsifj = sfmhdsifj + fgdjk;
            }
        }
    }
    
    
    int fee = (int) arrweeklydata.count;
    
    int totalfee = 5 * fee;
    
    _lbldeliveryfee.text = [NSString stringWithFormat:@"AED %d.00", totalfee];
    _lbldeliveryfees.text = [NSString stringWithFormat:@"AED %d.00", totalfee];
    
    sfmhdsifj = sfmhdsifj + totalfee;
    _lbltotalprice.text = [NSString stringWithFormat:@"AED %d.00", sfmhdsifj];
    _lbltotalprice1.text = [NSString stringWithFormat:@"AED %d.00", sfmhdsifj];
    
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissblurpromo)];
    [self.viewEnterPromocode addGestureRecognizer:tap1];
    
    [self wsloyaltycode];
}





-(void)dismissblurpromo
{
    [self.view endEditing:YES];
    
    _txtpromocode.text =@"";
    [_viewEnterPromocode setHidden:YES];
}




-(void)dismissblurcomment
{
    [self.view endEditing:YES];
    
    _viewcomment.hidden=YES;
    [[NSUserDefaults standardUserDefaults]setObject:_txtcomment.text forKey:@"notes"];
}




-(void)addcutleryval
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSString *tempsection = [defaults valueForKey:@"sectionnum"];
    int tempsection1 = tempsection.intValue;
    
    for (int i=0; i<arrweeklydata.count; i++)
    {
        if(i == tempsection1)
        {
            NSMutableArray *arrsetiondata = [[NSMutableArray alloc] init];
            NSMutableDictionary *dicttemp = [[NSMutableDictionary alloc] init];
            
            arrsetiondata=[[[arrweeklydata objectAtIndex:i] valueForKey:@"products"] mutableCopy];
            
            dicttemp =[[arrweeklydata objectAtIndex:i] mutableCopy];
            NSString *strcutlery =[NSString stringWithFormat:@"%@",[dicttemp valueForKey:@"cutleryflag"]];
            
            if ([strcutlery isEqualToString:@"no"])
            {
                cutlery_count = cutlery_count + 1;
                NSString *strcount = [NSString stringWithFormat:@"%d",cutlery_count];
                [dicttemp setObject:@"yes" forKey:@"cutleryflag"];
                [[NSUserDefaults standardUserDefaults] setObject:strcount forKey:@"cutlery_selected"];
            }
            
            else
            {
                cutlery_count = cutlery_count - 1;
                NSString *strcount = [NSString stringWithFormat:@"%d",cutlery_count];
                [dicttemp setObject:@"no" forKey:@"cutleryflag"];
                [[NSUserDefaults standardUserDefaults]setObject:strcount forKey:@"cutlery_selected"];
            }
            
            [arrweeklydata replaceObjectAtIndex:i withObject:dicttemp];
        }
    }
    
    NSMutableArray *arrtemp = [arrweeklydata objectAtIndex:tempsection1];
    NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:arrtemp];
    NSUserDefaults *defaultObj = [NSUserDefaults standardUserDefaults];
    [defaultObj setObject:data1 forKey:@"arrtemp111"];
    NSData *dataa = [NSKeyedArchiver archivedDataWithRootObject:arrweeklydata];
    [defaultObj setObject:dataa forKey:@"weeklyorderarray"];
    
    [_tblobj reloadData];
    
    WeeklyViewCart *cart =[[WeeklyViewCart alloc]init];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.navigationController pushViewController:cart animated:NO];
}




-(void)addcomentview
{
    for (int i = 0; i<arrweeklydata.count; i++)
    {
        NSString *strflag = [NSString stringWithFormat:@"%@",[[arrweeklydata objectAtIndex:i] valueForKey:@"flag"]];
        
        if ([strflag isEqualToString:@"true"])
        {
            NSMutableDictionary *dicttemp = [[NSMutableDictionary alloc] init];
            
            dicttemp = [[arrweeklydata objectAtIndex:i] mutableCopy];
            
            NSString *strnotes = [NSString stringWithFormat:@"%@",[dicttemp valueForKey:@"notes"]];
            
            if ([strnotes isEqualToString:@"(null)"])
            {
                self.txtcomment.text = @"";
            }
            
            else
            {
                self.txtcomment.text = strnotes;
            }
            
//            NSString *strnotes = [NSString stringWithFormat:@"%@",_txtcomment.text];
//
//            [dicttemp setObject:strnotes forKey:@"notes"];
//
//            [arrweeklydata replaceObjectAtIndex:i withObject:dicttemp];
//
//            NSMutableArray *arrProduct = [[arrweeklydata objectAtIndex:i] valueForKey:@"products"];
//
//            for (int j = 0; j<arrProduct.count; j++)
//            {
//                NSString *strnotes = [NSString stringWithFormat:@"%@",[[arrProduct objectAtIndex:j] valueForKey:@"notes"]];
//
//                if ([strnotes isEqualToString:@"(null)"])
//                {
//                    self.txtcomment.text = @"";
//                }
//
//                else
//                {
//                    self.txtcomment.text = strnotes;
//                }
//            }
        }
    }
    
    [_viewcomment setHidden:NO];
    _viewcomment.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}





-(void)addquntity
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    dictoptions = [[NSMutableDictionary alloc]init];
    
    NSString *tempval = [defaults valueForKey:@"sendertag"];
    sendertag = tempval.intValue;
    NSData *data = [defaults objectForKey:@"arrweeklydata"];
    _arrweekllydatas = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    _viewqty.hidden=NO;
    _viewqty.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    NSLog(@"arrweeklydata =%@",_arrweekllydatas);
    NSLog(@"name=%@",[_arrweekllydatas valueForKey:@"name"]);
    _lbltitle.text = [NSString stringWithFormat:@"%@",[_arrweekllydatas valueForKey:@"name"]];
    _lblqty.text = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"qty"]];
    
    
    dictoptions =[[_arrweekllydatas valueForKey:@"options"] mutableCopy];
    
    dicttempo =[[NSMutableDictionary alloc]init];
    
    NSMutableArray *arrtemp =[[NSMutableArray alloc]init];
    NSMutableArray *arrtemprorary =[[NSMutableArray alloc]init];
    arrtemp =[[dictoptions allKeys] mutableCopy];
    
    for (int k = 0; k<arrtemp.count; k++)
    {
        NSMutableArray *arrsecond =[[NSMutableArray alloc]init];
        
        arrsecond = [[dictoptions valueForKey:[arrtemp objectAtIndex:k]] mutableCopy];
        NSString *strtemp =[NSString stringWithFormat:@"%@",[[arrtemp objectAtIndex:k] mutableCopy]];
        
        for (int l=0; l<arrsecond.count; l++)
        {
            NSMutableDictionary *dictte =[[NSMutableDictionary alloc]init];
            
            dictte =[[arrsecond objectAtIndex:l] mutableCopy];
            
            [dictte setObject:strtemp forKey:@"nameofarray"];
            
            [arrtemprorary addObject:dictte];
        }
    }
    
    [dicttempo setObject:arrtemprorary forKey:@"arrcustom"];
    
    
    
    
    
//    for (int i = 0; i<arrweeklydata.count; i++)
//    {
//        NSMutableArray *arrproduct12 = [[NSMutableArray alloc]init];
//
//        arrproduct12 =[[arrweeklydata objectAtIndex:i]valueForKey:@"products"];
//
//        for (int j = 0; j<arrproduct12.count; j++)
//        {
//            dictoptions =[[[arrproduct12 objectAtIndex:j] valueForKey:@"options"] mutableCopy];
//
//            NSMutableDictionary *dicttin =[[NSMutableDictionary alloc]init];
//
//            NSMutableArray *arrtemp =[[NSMutableArray alloc]init];
//            NSMutableArray *arrtemprorary =[[NSMutableArray alloc]init];
//            arrtemp =[[dictoptions allKeys] mutableCopy];
//
//            for (int k = 0; k<arrtemp.count; k++)
//            {
//                NSMutableArray *arrsecond =[[NSMutableArray alloc]init];
//
//                arrsecond = [[dictoptions valueForKey:[arrtemp objectAtIndex:k]] mutableCopy];
//                NSString *strtemp =[NSString stringWithFormat:@"%@",[[arrtemp objectAtIndex:k]mutableCopy]];
//
//                for (int l=0; l<arrsecond.count; l++)
//                {
//                    NSMutableDictionary *dictte =[[NSMutableDictionary alloc]init];
//
//                    dictte =[[arrsecond objectAtIndex:l] mutableCopy];
//
//                    [dictte setObject:strtemp forKey:@"nameofarray"];
//
//                    [arrtemprorary addObject:dictte];
//                }
//            }
//
//            [dicttin setObject:arrtemprorary forKey:@"arrcustom"];
//
//            [arrproduct12 replaceObjectAtIndex:j withObject:dicttin];
//        }
//    }
    
    
    
    if(_arrweekllydatas.count > 0)
    {
        _qtyflag = @"yes";
        [_tblselectmenu reloadData];
        self.tblselectmenuheight.constant = _tblselectmenu.contentSize.height;
    }
}




-(void)addmoreitems
{
    NSString *strdate =[[NSUserDefaults standardUserDefaults] valueForKey:@"triggeronce"];
    
    if ([strdate isEqualToString:@"yes"])
    {
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"triggeronce"];
        
        MenuViewController *obj=[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
}




-(void)deleteitem
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSString *tempval = [defaults valueForKey:@"sendertag"];
    sendertag = tempval.intValue;
    
    UIAlertController * alert = [UIAlertController                                                          alertControllerWithTitle:NSLocalizedString(@"",nil) message:@"Are you sure you want to delete this item ?" preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"YES"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    
                                    NSMutableArray *srrproducts = [[NSMutableArray alloc]init];
                                    
                                    NSMutableDictionary *dcittemp = [[NSMutableDictionary alloc]init];
                                    
                                    NSString *strsection = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"sectionnum"]];
                                    
                                    sectionnum = strsection.intValue;
                                    
                                    dcittemp = [[arrweeklydata objectAtIndex:sectionnum] mutableCopy];
                                    
                                    srrproducts = [[dcittemp valueForKey:@"products"] mutableCopy];
                                    
                                    if (srrproducts.count != 0)
                                    {
                                        [srrproducts removeObjectAtIndex:sendertag];
                                    }
                                    
                                    [dcittemp setObject:srrproducts forKey:@"products"];
                                    
                                    [arrweeklydata replaceObjectAtIndex:sectionnum withObject:dcittemp];
                                    
                                    NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:arrweeklydata];
                                    NSUserDefaults *defaultObj = [NSUserDefaults standardUserDefaults];
                                    [defaultObj setObject:data1 forKey:@"weeklyorderarray"];
                                    [defaultObj synchronize];
                                    
                                    [_tblobj reloadData];
                                    
                                    WeeklyViewCart *cart =[[WeeklyViewCart alloc]init];
                                    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                                    [self.navigationController pushViewController:cart animated:NO];
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





-(void)viewDidAppear:(BOOL)animated
{
    [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"triggeronce"];
    
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame = CGRectMake(12, 15, 18, 18);
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"white_left"] forState:UIControlStateNormal];
    leftbtn.tag=230;
    
    [leftbtn addTarget:self action:@selector(back)
      forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:leftbtn];
    
//    if (arrweeklydata.count > 0)
//    {
//        NSString *str;
//        NSMutableArray *arrcount = [[NSMutableArray alloc]init];
//        for (int i = 0; i<arrweeklydata.count; i++)
//        {
//            NSArray *arr = [[arrweeklydata objectAtIndex:i] valueForKey:@"products"];
//
//            if (arr.count == 0)
//            {
//                str = [NSString stringWithFormat:@"Don't forget to select your meals for %@",[[arrweeklydata objectAtIndex:i] valueForKey:@"SelectedDate"]];
//
//                int temp = i;
//
//                [arrcount addObject:[NSString stringWithFormat:@"%d",temp]];
//            }
//        }
//
//
//        if (arrcount.count == 1)
//        {
//            UIAlertController *alert = [UIAlertController
//                                        alertControllerWithTitle:nil
//                                        message:str
//                                        preferredStyle:UIAlertControllerStyleAlert];
//
//            //Add Buttons
//
//            UIAlertAction *yesButton = [UIAlertAction
//                                        actionWithTitle:@"OK"
//                                        style:UIAlertActionStyleDefault
//                                        handler:^(UIAlertAction * action) {
//
//                                            _btnselectpaymentmethod.hidden = YES;
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
//        else if (arrcount.count > 1)
//        {
//            UIAlertController * alert = [UIAlertController
//                                         alertControllerWithTitle:nil
//                                         message:@"Please add products for remaining days"
//                                         preferredStyle:UIAlertControllerStyleAlert];
//
//            //Add Buttons
//
//            UIAlertAction* yesButton = [UIAlertAction
//                                        actionWithTitle:@"OK"
//                                        style:UIAlertActionStyleDefault
//                                        handler:^(UIAlertAction * action) {
//
//                                            _btnselectpaymentmethod.hidden = YES;
//                                        }];
//
//
//            //Add your buttons to alert controller
//
//            [alert addAction:yesButton];
//
//            [self presentViewController:alert animated:YES completion:nil];
//        }
//    }
    
    [_tblobj reloadData];
    _tblobjheight.constant=_tblobj.contentSize.height;
}




-(void)back
{
    MenuViewController *obj=[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.navigationController pushViewController:obj animated:YES];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}




- (IBAction)btnaddPromocode:(id)sender
{
    [_viewEnterPromocode setHidden:NO];
    _viewEnterPromocode.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}




- (IBAction)btnpromocodesubmit:(id)sender
{
    if ([_txtpromocode.text isEqualToString:@""])
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"Please enter a promo code."
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
        
        _viewEnterPromocode.hidden=NO;
    }
    
    else
    {
        _viewEnterPromocode.hidden=YES;
        
        [GiFHUD showWithOverlay];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self wspromocode];
        });
    }
}





#pragma mark tableview delegate methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == _tblselectmenu)
    {
        if([_qtyflag isEqualToString:@"yes"])
        {
            NSArray *arr2 =[_arrweekllydatas valueForKey:@"options"];
            
            return arr2.count;
        }
    }
    
    else
    {
        return 1;
    }
    
    return 0;
}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == _tblselectmenu)
    {
        return 1;
    }
    
    else
    {
        return arrweeklydata.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==self.tblobj)
    {
        return 45;
    }
    
    else
    {
        return 0;
    }
    
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tblobj)
    {
        NSMutableArray *temp1;
        NSMutableArray *ttt= [[NSMutableArray alloc] init];
        NSLog(@"indexPath.row=%ld",(long)indexPath.row);
        NSLog(@"cell1.CHTdynamic.constant=%f",cell1.CHTdynamic.constant);
        NSMutableArray *temp = [[arrweeklydata objectAtIndex:sectionnum] valueForKey:@"products"];
        
        for(int i=0;i<temp.count;i++)
        {
            ttt = [[temp objectAtIndex:i] valueForKey:@"options"];
            if( ttt.count > 0)
            {
                temp1 = [[temp objectAtIndex:i] valueForKey:@"options"];
            }
        }
        
        NSInteger height;
        
//        if( temp.count > 2)
//        {
//            height = (temp.count *30)+60+(((temp.count+1)*65)+150);
//            _viewobjheight.constant = height +(arrweeklydata.count*75);
//        }
//
//        else
//        {
//            height = ( temp.count*30)+60+((((temp.count+1)*95)+150));
//            _viewobjheight.constant = _tblobj.contentSize.height+cell1.CHTdynamic.constant+arrweeklydata.count*125;
//        }
        
        
        
        if(temp.count == 2)
        {
            if (temp1.count == 1)
            {
                height = ( temp.count *30)+60+(((temp1.count+1)*(temp.count * 48))+150);
                _viewobjheight.constant = height +(arrweeklydata.count*75);
            }
            
            else if (temp1.count == 2)
            {
                height = ( temp.count *30)+70+(((temp1.count+1)*(temp.count * 48))+150);
                _viewobjheight.constant = height +(arrweeklydata.count*75);
            }
            
            else if (temp1.count > 2)
            {
                height = ( temp.count *30)+70+(((temp1.count+1)*(temp.count * 50))+150);
                _viewobjheight.constant = height +(arrweeklydata.count*75);
            }
            
            else
            {
                height = ( temp.count *30)+70+(((temp1.count+1)*50));
                _viewobjheight.constant = height +(arrweeklydata.count*70);
            }
        }
        
        else if (temp.count > 2)
        {
            if (temp1.count == 1)
            {
                height = ( temp.count *30)+60+(((temp1.count+1)*(temp.count * 48))+150);
                _viewobjheight.constant = height +(arrweeklydata.count*75);
            }
            
            else if (temp1.count == 2)
            {
                height = ( temp.count *30)+70+(((temp1.count+1)*(temp.count * 48))+150);
                _viewobjheight.constant = height +(arrweeklydata.count*75);
            }
            
            else if (temp1.count > 2)
            {
                height = ( temp.count *30)+70+(((temp1.count+1)*(temp.count * 48))+150);
                _viewobjheight.constant = height +(arrweeklydata.count*75);
            }
            
            else
            {
                height = ( temp.count *30)+70+(((temp1.count+1)*50));
                _viewobjheight.constant = height +(arrweeklydata.count*75);
            }
        }
        
        else
        {
            if (temp1.count == 1)
            {
                height = ( temp.count *30)+60+(((temp.count+1)*(temp.count * 48))+150);
                
                _viewobjheight.constant = _tblobj.contentSize.height+cell1.CHTdynamic.constant+arrweeklydata.count*125;
            }
            
            else if (temp1.count == 2)
            {
                height = ( temp.count *30)+60+(((temp.count+1)*(temp.count * 60))+150);
                _viewobjheight.constant = _tblobj.contentSize.height+cell1.CHTdynamic.constant+arrweeklydata.count*115;
            }
            
            else if (temp1.count > 2)
            {
                height = ( temp.count *30)+60+(((temp.count+1)*(temp.count * 110))+150);
                _viewobjheight.constant = height +(arrweeklydata.count*75);
            }
            
            else
            {
                height = ( temp.count *30)+60+(((temp.count+1)*(temp.count * 48))+150);
                _viewobjheight.constant = _tblobj.contentSize.height+cell1.CHTdynamic.constant+arrweeklydata.count*100;
            }
        }
        
        return height;
    }
    
    else
    {
        return 40;
    }
}




- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
{
    if ((tableView=self.tblobj))
    {
        return [self tableView:tableView heightForHeaderInSection:section];
    }
    
    return 0;
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _tblobj)
    {
        static NSString *cellIdentifier=@"cell";
        weeklyCell *cell=(weeklyCell *)[self.tblobj dequeueReusableCellWithIdentifier:cellIdentifier];
        NSArray *nib;
        nib=[[NSBundle mainBundle]loadNibNamed:@"weeklyCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        dateFormatter.dateStyle=NSDateFormatterMediumStyle;
        [dateFormatter setDateFormat:@"HH:mm:ss"];
        
        [dateFormatter setDateFormat:@"HH:mm"];
        
        NSLog(@"kDefaultAccordionHeaderViewHeight-%f",self.tblobj.contentSize.height);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    else if(tableView == _tblselectmenu)
    {
        SubViewextraTableViewCell *cell1;
        NSArray *nib;
        NSString *tableIdentifier = @"SubViewextraTableViewCell";
        
        cell1 = (SubViewextraTableViewCell*)[_tblselectmenu dequeueReusableCellWithIdentifier:tableIdentifier];
        
        if (cell1 == nil)
        {
            nib = [[NSBundle mainBundle] loadNibNamed:@"SubViewextraTableViewCell" owner:self options:nil];
            cell1 = [nib objectAtIndex:0];
        }
        
        
        NSArray *arr2 =[dicttempo valueForKey:@"arrcustom"];
        
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
        
        if (arr2.count > 0)
        {
            NSString *strname =[ NSString stringWithFormat:@"%@:",[[arr2 objectAtIndex:indexPath.row]valueForKey:@"nameofarray"]];
            
            NSString *firstChar = [strname substringToIndex:1];
            
            /* remove any diacritic mark */
            NSString *folded = [firstChar stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:locale];
            
            /* create the new string */
            NSString *result = [[folded uppercaseString] stringByAppendingString:[strname substringFromIndex:1]];
            
            result = [result stringByReplacingOccurrencesOfString:@"Sidedish" withString:@"SIDE"];
            
            result = [result stringByReplacingOccurrencesOfString:@"SIDE2" withString:@"EXTRA"];
            
            result =[result stringByReplacingOccurrencesOfString:@"Addon" withString:@"ADD-ON"];
            
            result =[result stringByReplacingOccurrencesOfString:@"ADD-ON2" withString:@"ADD-ON"];
            
            result =[result stringByReplacingOccurrencesOfString:@"Option" withString:@"OPTION"];
            
            //        NSArray *arr2 =[_arrweekllydatas valueForKey:@"options"];
            
            //NSString *strname = [NSString stringWithFormat:@"%@",[[arr2 objectAtIndex:indexPath.row] valueForKey:@"title"]];
            
            cell1.lblside.text = result;
            cell1.lblside.frame=CGRectMake(10, cell1.lblside.frame.origin.y, cell1.lblside.frame.size.width,cell1.lblside.frame.size.height);
            cell1.lblside.textAlignment = NSTextAlignmentLeft;
            
            [cell1.contentView addSubview:cell1.lblside];
            NSString *strdetails = [NSString stringWithFormat:@"%@",[[arr2 objectAtIndex:indexPath.row]valueForKey:@"name"]];
            cell1.lblsidedetail.text= strdetails;
        }
        
        else
        {
            cell1.lblside.text = @"";
            cell1.lblside.frame=CGRectMake(10, cell1.lblside.frame.origin.y, cell1.lblside.frame.size.width,cell1.lblside.frame.size.height);
            cell1.lblside.textAlignment = NSTextAlignmentLeft;
            
            [cell1.contentView addSubview:cell1.lblside];
            
            cell1.lblsidedetail.text= @"";
        }
        
        
        cell1.lblsidedetail.frame=CGRectMake(10, cell1.lblsidedetail.frame.origin.y, cell1.lblsidedetail.frame.size.width,cell1.lblsidedetail.frame.size.height);
        cell1.lblsidedetail.textAlignment = NSTextAlignmentLeft;
        [cell1.contentView addSubview:cell1.lblsidedetail];
        
        cell1.lblsideamt.hidden = YES;
        
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell1;
    }
    
    return 0;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView==self.tblobj)
    {
        static NSString *CellIdentifier = @"AccordionHeaderViewReuseIdentifier";
        headerCell = [_tblobj dequeueReusableHeaderFooterViewWithIdentifier:CellIdentifier];
        
        NSString *finaldate = [NSString stringWithFormat:@"%@",[[arrweeklydata objectAtIndex:section] valueForKey:@"NewSelectedDate"]];
        
        NSString *finaltime = [NSString stringWithFormat:@"%@",[[arrweeklydata objectAtIndex:section] valueForKey:@"SelectedTime"]];
        
        finaldate =[finaldate stringByReplacingOccurrencesOfString:@"Sunday" withString:@"Sun"];
        finaldate =[finaldate stringByReplacingOccurrencesOfString:@"Monday" withString:@"Mon"];
        finaldate =[finaldate stringByReplacingOccurrencesOfString:@"Tuesday" withString:@"Tue"];
        finaldate =[finaldate stringByReplacingOccurrencesOfString:@"Wednesday" withString:@"Wed"];
        finaldate =[finaldate stringByReplacingOccurrencesOfString:@"Thursday" withString:@"Thu"];
        finaldate =[finaldate stringByReplacingOccurrencesOfString:@"Friday" withString:@"Fri"];
        finaldate =[finaldate stringByReplacingOccurrencesOfString:@"Saturday" withString:@"Sat"];
        
        headerCell.lblname.text = [NSString stringWithFormat:@"%@  -  %@",finaldate,finaltime];
        
        NSString *strFlag = [[arrweeklydata objectAtIndex:section] valueForKey:@"flag"];
        
        
        if (arrweeklydata.count > 0)
        {
            NSString *strtotal =[NSString stringWithFormat:@"%@",[[arrweeklydata objectAtIndex:section] valueForKey:@"sumofallprices"]];
            
            int price = [strtotal intValue];
            
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            
            NSString *strmin = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"min_amount"]];
            
            int min = [strmin intValue];
            
            if (price < min)
            {
                headerCell.lblname.textColor = [UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1];
                
                if ([strFlag isEqualToString:@"true"])
                {
                    headerCell.imgdown.image=[UIImage imageNamed:@"greenUp"];
                }
                
                else  if ([strFlag isEqualToString:@"false"])
                {
                    headerCell.imgdown.image=[UIImage imageNamed:@"grayDown"];
                }
            }
            
            else
            {
                if ([strFlag isEqualToString:@"true"])
                {
                    headerCell.imgdown.image=[UIImage imageNamed:@"greenUp"];
                    
                    headerCell.lblname.textColor = [UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1];
                }
                
                else  if ([strFlag isEqualToString:@"false"])
                {
                    headerCell.imgdown.image=[UIImage imageNamed:@"grayDown"];
                    
                    headerCell.lblname.textColor = [UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:110.0/255.0 alpha:1];
                }
            }
        }
        
        
        
//        if ([strFlag isEqualToString:@"true"])
//        {
//            headerCell.imgdown.image=[UIImage imageNamed:@"greenUp"];
//
//            headerCell.lblname.textColor = [UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1];
//        }
//
//        else  if ([strFlag isEqualToString:@"false"])
//        {
//            headerCell.imgdown.image=[UIImage imageNamed:@"grayDown"];
//
//            headerCell.lblname.textColor = [UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:110.0/255.0 alpha:1];
//        }
        
        return headerCell;
    }
    
    return 0;
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
    selectsection = (int) section;
    NSString *tempsectionnum = [NSString stringWithFormat:@"%d",sectionnum];
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    [defaults setValue:tempsectionnum forKey:@"sectionnum"];
    
    for (int i = 0; i<arrweeklydata.count; i++)
    {
        NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
        
        dictet =[[arrweeklydata objectAtIndex:i] mutableCopy];
        
        NSString *strdhcj = [NSString stringWithFormat:@"%@",[dictet valueForKey:@"flag"]];
        
        if ([strdhcj isEqualToString:@"true"])
        {
          //  flagopencondtion =@"true";
        }
    }
    
    
    
    for (int i =0; i<arrweeklydata.count; i++)
    {
        NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
        
        dictet =[[arrweeklydata objectAtIndex:i] mutableCopy];
        
        [dictet setObject:@"false" forKey:@"flag"];
        
        [arrweeklydata replaceObjectAtIndex:i withObject:dictet];
    }
    
    
    for (int i =0; i<arrweeklydata.count; i++)
    {
        NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
        
        dictet =[[arrweeklydata objectAtIndex:i] mutableCopy];
        
        if (i == section)
        {
            [dictet setObject:@"true" forKey:@"flag"];
        }
        
        [arrweeklydata replaceObjectAtIndex:i withObject:dictet];
    }
    
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrweeklydata];
    
    [[NSUserDefaults standardUserDefaults] setValue:data forKey:@"weeklyorderarray"];
    NSMutableArray *arrtemp = [arrweeklydata objectAtIndex:section];
    NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:arrtemp];
    NSUserDefaults *defaultObj = [NSUserDefaults standardUserDefaults];
    [defaultObj setObject:data1 forKey:@"arrtemp111"];
    [defaultObj synchronize];
    
    if(section == arrweeklydata.count-1)
    {
        _viewobjheight.constant = _tblobj.contentSize.height+cell1.CHTdynamic.constant+arrweeklydata.count*30;
        [_tblobj reloadData];
    }
    
    else
    {
        [_tblobj reloadData];
    }
}




- (void)tableView:(FZAccordionTableView *)tableView willCloseSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header
{
    if ([flagopencondtion isEqualToString:@"true"])
    {
        flagopencondtion=@"";
    }
    
    else
    {
        _viewobjheight.constant = arrweeklydata.count*60;
        
        for (int i =0; i<arrweeklydata.count; i++)
        {
            NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
            dictet =[[arrweeklydata objectAtIndex:i] mutableCopy];
            
            if (i == section)
            {
                [dictet setObject:@"false" forKey:@"flag"];
            }
            else
            {
                [dictet setObject:@"false" forKey:@"flag"];
            }
            
            [arrweeklydata replaceObjectAtIndex:i withObject:dictet];
        }
        
        [_tblobj reloadData];
    }
}

- (void)tableView:(FZAccordionTableView *)tableView didCloseSection:(NSInteger)section withHeader:(UITableViewHeaderFooterView *)header
{
       [_tblobj reloadData];
}




- (IBAction)btnincrease:(id)sender
{
    NSString *strcount = _lblqty.text;
    
    int countint =[strcount intValue];
    
    countint = countint +1;
    
    _lblqty.text =[NSString stringWithFormat:@"%d",countint];
    
    [_lblqty setFont:[UIFont fontWithName:@"AvenirNext-DemiBold" size:25]];
}


- (IBAction)btndecrease:(id)sender
{
    NSString *strcount = _lblqty.text;
    
    int countint =[strcount intValue];
    
    if (countint >1)
    {
        countint = countint - 1;
    }
    
    else if (countint == 1)
    {
        countint = 1;
    }
    
    _lblqty.text =[NSString stringWithFormat:@"%d",countint];
    [_lblqty setFont:[UIFont fontWithName:@"AvenirNext-DemiBold" size:25]];
}


- (IBAction)btnupdate:(id)sender
{
    for (int i =0; i<arrweeklydata.count; i++)
    {
        if(i == sectionnum)
        {
            NSMutableArray *arrsetiondata = [[NSMutableArray alloc ] init];
            NSMutableDictionary *dicttemp =[[NSMutableDictionary alloc]init];
            
            arrsetiondata=[[[arrweeklydata objectAtIndex:i] valueForKey:@"products"] mutableCopy];
            dicttemp =[[arrweeklydata objectAtIndex:i] mutableCopy];
            
            for (int j =0; j<arrsetiondata.count; j++)
            {
                if (j == sendertag)
                {
                    NSMutableDictionary *arrindexdata;
                    NSString *strprice =[NSString stringWithFormat:@"%@",[[arrsetiondata objectAtIndex:j]valueForKey:@"primaryprice"]];
                    
                    int primaryprice =[strprice intValue];
                    int countdata =[_lblqty.text intValue];
                    
                    int total = primaryprice * countdata;
                    NSString *dafhyfs =[NSString stringWithFormat:@"%d",total];
                    
                    arrindexdata = [arrsetiondata objectAtIndex:j];
                    [arrindexdata setObject:_lblqty.text forKey:@"quantity"];
                    [arrindexdata setValue:dafhyfs forKey:@"sumofallprices"];
                    [arrindexdata setValue:dafhyfs forKey:@"totalprice"];
                    [arrsetiondata replaceObjectAtIndex:j withObject:arrindexdata];
                }
            }
            
            [dicttemp setObject:arrsetiondata forKey:@"products"];
            [arrweeklydata replaceObjectAtIndex:i withObject:dicttemp];
        }
    }
    
    
    
    
    sfmhdsifj=0;
    
    for (int i =0; i<arrweeklydata.count; i++)
    {
        NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
        
        dictet =[[arrweeklydata objectAtIndex:i] mutableCopy];
        
        [dictet setObject:@"false" forKey:@"flag"];
        [arrweeklydata replaceObjectAtIndex:i withObject:dictet];
        
        NSMutableArray *fast =[[NSMutableArray alloc]init];
        fast =[[[arrweeklydata objectAtIndex:i]valueForKey:@"products"] mutableCopy];
      
        for (int m = 0; m<fast.count; m++)
        {
            NSString *jdv =@"";
            
            NSMutableDictionary *dictw =[[NSMutableDictionary alloc]init];
            
            dictw =[fast objectAtIndex:m];
            jdv =[NSString stringWithFormat:@"%@",[dictw valueForKey:@"totalprice"]];
            
            int fgdjk = [jdv intValue];
            NSString *ttqty = _lblqty.text;
            int qty= ttqty.intValue;
            if(qty > 0)
            {
                sfmhdsifj = sfmhdsifj + (qty * fgdjk);
            }
            
            else
            {
                sfmhdsifj = sfmhdsifj +fgdjk;
            }
        }
    }
    
    
    int fee = (int) arrweeklydata.count;
    
    int totalfee = 5 * fee;
    
    _lbldeliveryfee.text = [NSString stringWithFormat:@"AED %d.00", totalfee];
    _lbldeliveryfees.text = [NSString stringWithFormat:@"AED %d.00", totalfee];
    
    sfmhdsifj = sfmhdsifj + totalfee;
    
    _lbltotalprice.text =[NSString stringWithFormat:@"AED %d.00", sfmhdsifj];
    _lbltotalprice1.text =[NSString stringWithFormat:@"AED %d.00", sfmhdsifj];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrweeklydata];
    
    [[NSUserDefaults standardUserDefaults] setValue:data forKey:@"weeklyorderarray"];
    
    WeeklyViewCart *cart =[[WeeklyViewCart alloc]init];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.navigationController pushViewController:cart animated:NO];
    _viewqty.hidden=YES;
}




- (IBAction)btncommentsubmit:(id)sender
{
    if ([_txtcomment.text isEqualToString:@""])
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"Please add some comments."
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
        _viewcomment.hidden=YES;
        //[[NSUserDefaults standardUserDefaults]setObject:_txtcomment.text forKey:@"cartcomment"];
        
        for (int i =0; i<arrweeklydata.count; i++)
        {
            if(i == sectionnum)
            {
                NSMutableArray *arrsetiondata = [[NSMutableArray alloc] init];
                NSMutableDictionary *dicttemp =[[NSMutableDictionary alloc] init];
                arrsetiondata=[[[arrweeklydata objectAtIndex:i] valueForKey:@"products"] mutableCopy];
                dicttemp =[[arrweeklydata objectAtIndex:i] mutableCopy];
                
                NSString *strnotes = [NSString stringWithFormat:@"%@",_txtcomment.text];
                
                [dicttemp setObject:strnotes forKey:@"notes"];
                
//                for (int j =0; j<arrsetiondata.count; j++)
//                {
//                    if(j == sendertag)
//                    {
//                        NSMutableDictionary *arrindexdata;
//                        arrindexdata = [arrsetiondata objectAtIndex:j];
//                        [arrindexdata setObject:_txtcomment.text forKey:@"notes"];
//
//                        [arrsetiondata replaceObjectAtIndex:j withObject:arrindexdata];
//                    }
//                }
//
//                [dicttemp setObject:arrsetiondata forKey:@"products"];
                
                [arrweeklydata replaceObjectAtIndex:i withObject:dicttemp];
            }
        }
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrweeklydata];
        
        [[NSUserDefaults standardUserDefaults] setValue:data forKey:@"weeklyorderarray"];
        
        WeeklyViewCart *cart =[[WeeklyViewCart alloc]init];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:cart animated:NO];
    }
}




- (IBAction)btnpaymentmethod:(id)sender
{
    [[NSUserDefaults standardUserDefaults] setObject:_lbltotalprice.text forKey:@"grandtotal"];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"tryAgainPayment"];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrweeklydata];
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"posttotalorder"];
    
    paymentMethodViewController *check =[[paymentMethodViewController alloc]init];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"weekly" forKey:@"back"];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    
    [self.navigationController pushViewController:check animated:YES];
}




- (NSMutableAttributedString *)plainStringToAttributedUnits:(NSString *)string;
{
//    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]
                                            initWithData: [string dataUsingEncoding:NSUnicodeStringEncoding]
                                            options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                            documentAttributes: nil
                                            error: nil];
    
    UIFont *font = [UIFont systemFontOfSize:10.0f];
    UIFont *smallFont = [UIFont systemFontOfSize:9.0f];
    
    [attString beginEditing];
    [attString addAttribute:NSFontAttributeName value:(font) range:NSMakeRange(0, string.length - 2)];
    [attString addAttribute:NSFontAttributeName value:(smallFont) range:NSMakeRange(string.length - 1, 1)];
    [attString addAttribute:(NSString*)kCTSuperscriptAttributeName value:@"1" range:NSMakeRange(string.length - 1, 1)];
    [attString addAttribute:(NSString*)kCTForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, string.length - 1)];
    [attString endEditing];
    return attString;
}




#pragma mark <---Web Services--->

-(void)wsloyaltycode
{
    BaseViewController *base=[[BaseViewController alloc]init];
    arrweeks = [[NSMutableArray alloc]init];
    NSMutableArray *arr =[[NSMutableArray alloc]init];
    
    for (int y = 0; y<arrweeklydata.count; y++)
    {
        [arr addObject:[arrweeklydata objectAtIndex:y]];
    }
    
    for (int i = 0; i<arr.count; i++)
    {
        NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
        
        NSString *date = [[arr objectAtIndex:i] valueForKey:@"delivery_date"];
        NSString *time = [[arr objectAtIndex:i] valueForKey:@"delivery_time"];
        
        [dictet setObject:date forKey:@"delivery_date"];
        [dictet setObject:time forKey:@"delivery_time"];
        
        NSString *strcomment = self.txtcomment.text;
        [dictet setObject:strcomment forKey:@"notes"];
        
        NSMutableArray *arrproduct12 = [[NSMutableArray alloc]init];
        
        arrproduct12 =[[arr objectAtIndex:i]valueForKey:@"products"];
        
        NSMutableArray *arritemid =[[NSMutableArray alloc]init];
        
        for (int j = 0; j<arrproduct12.count; j++)
        {
            NSMutableArray *arrtem =[[NSMutableArray alloc]init];
            
            NSMutableDictionary *dicttemp =[[NSMutableDictionary alloc]init];
            
            [dicttemp setObject:[[arrproduct12 objectAtIndex:j] valueForKey:@"itemID"] forKey:@"itemID"];
            [dicttemp setObject:[[arrproduct12 objectAtIndex:j] valueForKey:@"quantity"] forKey:@"quantity"];
            
//            NSString *strcomment = self.txtcomment.text;
//            [dicttemp setObject:strcomment forKey:@"notes"];
            
            dictoptions =[[[arrproduct12 objectAtIndex:j] valueForKey:@"options"] mutableCopy];
            
            NSMutableDictionary *dicttin =[[NSMutableDictionary alloc]init];
            
            //dicttin =[[arrproduct objectAtIndex:j] mutableCopy];
            
            NSMutableArray *arrtemp =[[NSMutableArray alloc]init];
            NSMutableArray *arrtemprorary =[[NSMutableArray alloc]init];
            arrtemp =[[dictoptions allKeys] mutableCopy];
            
            for (int k = 0; k<arrtemp.count; k++)
            {
                NSMutableArray *arrsecond =[[NSMutableArray alloc]init];
                
                arrsecond = [[dictoptions valueForKey:[arrtemp objectAtIndex:k]] mutableCopy];
                NSString *strtemp =[NSString stringWithFormat:@"%@",[[arrtemp objectAtIndex:k]mutableCopy]];
                
                for (int l=0; l<arrsecond.count; l++)
                {
                    NSMutableDictionary *dictte =[[NSMutableDictionary alloc]init];
                    
                    dictte =[[arrsecond objectAtIndex:l] mutableCopy];
                    
                    [dictte setObject:strtemp forKey:@"nameofarray"];
                    
                    [arrtemprorary addObject:dictte];
                }
            }
            
            [dicttin setObject:arrtemprorary forKey:@"arrcustom"];
            
            [arrproduct12 replaceObjectAtIndex:j withObject:dicttin];
            
            
            NSArray *aerr = [[arrproduct12 objectAtIndex:j]valueForKey:@"arrcustom"];
            
            for (int m =0; m<aerr.count; m++)
            {
                NSMutableDictionary *dictt =[[NSMutableDictionary alloc]init];
                
                [dictt setObject:[NSString stringWithFormat:@"%@",[[aerr objectAtIndex:m]valueForKey:@"id"]] forKey:@"id"];
                [dictt setObject:@"1" forKey:@"quantity"];
                
                [arrtem addObject:dictt];
            }
            
            [dicttemp setObject:arrtem forKey:@"options"];
            
            [arritemid addObject:dicttemp];
        }
        
        [dictet setObject:arritemid forKey:@"items"];
        
        [arrweeks addObject:dictet];
    }
    
    
    
    arrweeklydata =[[NSMutableArray alloc]init];
    
    NSData *dataarraddtocart = [[NSUserDefaults standardUserDefaults]valueForKey:@"weeklyorderarray"];
    
    if (!(dataarraddtocart == nil))
    {
        arrweeklydata=[[NSKeyedUnarchiver unarchiveObjectWithData:dataarraddtocart] mutableCopy];
    }
    
    
    for (int i =0; i<arrweeklydata.count; i++)
    {
        NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
        dictet =[[arrweeklydata objectAtIndex:i] mutableCopy];
        [dictet setObject:@"false" forKey:@"flag"];
        [arrweeklydata replaceObjectAtIndex:i withObject:dictet];
    }
    
    
    for (int k = 0; k<arrweeklydata.count; k++)
    {
        NSMutableDictionary *dictet = [[NSMutableDictionary alloc]init];
        dictet =[[arrweeklydata objectAtIndex:k] mutableCopy];
        
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        
        arr = [dictet valueForKey:@"products"];
        int tempamount = 0;
        
        for (int l = 0; l<arr.count; l++)
        {
            NSMutableDictionary *dictemp =[[NSMutableDictionary alloc]init];
            
            dictemp = [[arr objectAtIndex:l] mutableCopy];
            
            NSString *strprice = [NSString stringWithFormat:@"%@",[dictemp valueForKey:@"totalprice"]];
            
            int rupees = [strprice intValue];
            
            tempamount = tempamount + rupees;
        }
        
        NSString *sgf = [NSString stringWithFormat:@"%d",tempamount];
        [dictet setObject:sgf forKey:@"sumofallprices"];
        
        [arrweeklydata replaceObjectAtIndex:k withObject:dictet];
    }
    
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arrweeks options:NSJSONWritingPrettyPrinted error:&error];
    NSString *strarrdata = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    //NSString *addtitle = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults]valueForKey:@"address_title"]];
    NSString *straddresstype = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"address_type"]];
    
//    NSString *straddressid = @"";
//
//    if ([addtitle isEqualToString:@"Home"])
//    {
//        straddressid = @"0";
//    }
//
//    else if ([addtitle isEqualToString:@"Work"])
//    {
//        straddressid = @"1";
//    }
//
//    else
//    {
//        straddressid = @"2";
//    }
    
    NSString *parameter;
    
    parameter=[NSString stringWithFormat:@"request=%@&action=%@&key=%@&secret=%@&token=%@&payment=%@&user_id=%@&address_type=%@&address_type_id=%@&days=%@&promo_code=%@&validate=%@&ios=%@",@"menu",@"order",str_key,str_secret,[[NSUserDefaults standardUserDefaults]valueForKey:@"token"],@"",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],straddresstype,[[NSUserDefaults standardUserDefaults]valueForKey:@"address_id"],strarrdata,[[NSUserDefaults standardUserDefaults] valueForKey:@"promocode_for_order"],@"validate",@"1"];
    
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
                NSDictionary *dictdelivery=[dictionary valueForKey:@"delivery"];
                
                NSString *strcharge = [dictdelivery valueForKey:@"charge"];
                
                int charge = strcharge.intValue;
                
                NSDictionary *dictpromo=[dictionary valueForKey:@"promo"];
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                NSMutableDictionary *dicttemp = [[NSMutableDictionary alloc]init];
                
                dicttemp = [dictionary valueForKey:@"keys"];
                
                NSDictionary *dictcheck = [[NSDictionary alloc]init];
                
                dictcheck = [dicttemp valueForKey:@"checkout"];
                
                NSString *strcheckout = [NSString stringWithFormat:@"%@",[dictcheck valueForKey:@"public_key"]];
                
                [defaults setObject:strcheckout forKey:@"checkout_pk"];
                
                NSDictionary *dictvisacheckout = [[NSDictionary alloc]init];
                
                dictvisacheckout = [dicttemp valueForKey:@"visa_checkout"];
                
                NSString *strvisacheckout = [NSString stringWithFormat:@"%@",[dictvisacheckout valueForKey:@"api_key"]];
                
                [defaults setObject:strvisacheckout forKey:@"visa_checkout_api"];
                
                NSMutableDictionary *dictkeys = [[NSMutableDictionary alloc]init];
                
                dictkeys = [dictionary valueForKey:@"new_payment_methods"];
                
                NSString *dictvisa;
                
                dictvisa = [NSString stringWithFormat:@"%@",[dictkeys valueForKey:@"visa_checkout"]];
                
                if ([dictvisa isEqualToString:@"false"])
                {
                    [defaults setObject:@"novisa" forKey:@"visacheckout"];
                }
                
                else
                {
                    [defaults setObject:@"visa" forKey:@"visacheckout"];
                }
                
                NSMutableArray *arrpaymentmethod = [[NSMutableArray alloc]init];
                
                arrpaymentmethod = [dictkeys valueForKey:@"payment_method"];
                
                for (int j = 0; j<arrpaymentmethod.count; j++)
                {
                    NSString *strpayment = [NSString stringWithFormat:@"%@",[arrpaymentmethod objectAtIndex:j]];
                    
                    if ([strpayment isEqualToString:@"Online card payment"])
                    {
                        [defaults setObject:@"card" forKey:@"shoppaymentmethod"];
                    }
                    
                    else
                    {
                        [defaults setObject:@"cash" forKey:@"shoppaymentmethod"];
                    }
                    
                    break;
                }
                
                
                NSString *strprice = [NSString stringWithFormat:@"%@",[dictpromo valueForKey:@"discount"]];
                
                if ([strprice rangeOfString:@"."].location == NSNotFound)
                {
                    NSLog(@"string does not contain .");
                    
                    strdiscountprices =[NSString stringWithFormat:@"- AED %@.00",strprice];
                }
                
                else
                {
                    NSLog(@"string contains .!");
                    
                    strdiscountprices =[NSString stringWithFormat:@"- AED %@",strprice];
                }
                
                
                
                if (charge == 0)
                {
                    [_viewafterpomocode setHidden:NO];
                }
                
//                if ([strprice isEqualToString:@"0.00"] && [[dictpromo valueForKey:@"description"] isEqualToString:@"free delivery"])
//                {
//                    [_viewafterpomocode setHidden:NO];
//                }
                
                else if ([strprice isEqualToString:@"0.00"])
                {
                    [_viewafterpomocode setHidden:YES];
                }
                
                else
                {
                    [_viewafterpomocode setHidden:NO];
                }
                
                
                
                float valueofdiscount;
                
                if (charge == 0)
                {
                    int fee = (int) arrweeklydata.count;
                    
                    float totalfee = 5.00 * fee;
                    
                    _lbldiscount.text = [NSString stringWithFormat:@"- AED %.2f", totalfee];
                    
                    valueofdiscount = 5.00 * fee;
                }
                
//                if ([[dictpromo valueForKey:@"description"] isEqualToString:@"free delivery"])
//                {
//                    int fee = (int) arrweeklydata.count;
//
//                    float totalfee = 5.00 * fee;
//
//                    _lbldiscount.text = [NSString stringWithFormat:@"- AED %.2f", totalfee];
//
//                    valueofdiscount = 5.00 * fee;
//                }
                
                else
                {
                    _lbldiscount.text = strdiscountprices;
                    
                    NSString *dis = [dictpromo valueForKey:@"discount"];
                    
                    valueofdiscount = [dis floatValue];
                }
                
                
                NSString *STRTOTALS =_lbltotalprice.text;
                
                STRTOTALS =[STRTOTALS stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"AED"]];
                
                int totalvalue =[STRTOTALS intValue];
                
                float supervqale = totalvalue - valueofdiscount;
                
                _lbltotalprice.text = [NSString stringWithFormat:@"AED %.2f", supervqale];
            }
            
            else if ([errorCode isEqualToString:@"0"])
            {
                NSAttributedString *attributedString = [[NSAttributedString alloc]
                                                        initWithData: [message dataUsingEncoding:NSUnicodeStringEncoding]
                                                        options: @{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType }
                                                        documentAttributes: nil
                                                        error: nil];
                
                
                UIAlertController *alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:attributedString.string preferredStyle:UIAlertControllerStyleAlert];
                
                
                UIAlertAction *yesButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                
                                                _btnselectpaymentmethod.hidden = YES;
                                                
                                            }];
                
                
                //Add your buttons to alert controller
                
                [alert addAction:yesButton];
                
                [self presentViewController:alert animated:YES completion:nil];
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




-(void)wspromocode
{
    BaseViewController *base=[[BaseViewController alloc]init];
    arrweeks = [[NSMutableArray alloc]init];
    NSMutableArray *arr =[[NSMutableArray alloc]init];
    
    for (int y = 0; y<arrweeklydata.count; y++)
    {
        [arr addObject:[arrweeklydata objectAtIndex:y]];
    }
    
    
    for (int i = 0; i<arr.count; i++)
    {
        NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
        //dictet =[[arrweeklydata objectAtIndex:i] mutableCopy];
        
        NSString *date = [[arr objectAtIndex:i] valueForKey:@"delivery_date"];
        NSString *time = [[arr objectAtIndex:i] valueForKey:@"delivery_time"];
        
        [dictet setObject:date forKey:@"delivery_date"];
        [dictet setObject:time forKey:@"delivery_time"];
        
        NSMutableArray *arrproduct12 = [[NSMutableArray alloc]init];
        
        arrproduct12 =[[arr objectAtIndex:i]valueForKey:@"products"];
        
        NSMutableArray *arritemid =[[NSMutableArray alloc]init];
        
        for (int j = 0; j<arrproduct12.count; j++)
        {
            NSMutableArray *arrtem =[[NSMutableArray alloc]init];
            
            NSMutableDictionary *dicttemp =[[NSMutableDictionary alloc]init];
            
            [dicttemp setObject:[[arrproduct12 objectAtIndex:j] valueForKey:@"itemID"] forKey:@"itemID"];
            [dicttemp setObject:[[arrproduct12 objectAtIndex:j] valueForKey:@"quantity"] forKey:@"quantity"];
            
            
            dictoptions =[[[arrproduct12 objectAtIndex:j] valueForKey:@"options"] mutableCopy];
            
            NSMutableDictionary *dicttin =[[NSMutableDictionary alloc]init];
            
            //dicttin =[[arrproduct objectAtIndex:j] mutableCopy];
            
            NSMutableArray *arrtemp =[[NSMutableArray alloc]init];
            NSMutableArray *arrtemprorary =[[NSMutableArray alloc]init];
            arrtemp =[[dictoptions allKeys] mutableCopy];
            
            for (int k = 0; k<arrtemp.count; k++)
            {
                NSMutableArray *arrsecond =[[NSMutableArray alloc]init];
                
                arrsecond = [[dictoptions valueForKey:[arrtemp objectAtIndex:k]] mutableCopy];
                NSString *strtemp =[NSString stringWithFormat:@"%@",[[arrtemp objectAtIndex:k]mutableCopy]];
                
                for (int l=0; l<arrsecond.count; l++)
                {
                    NSMutableDictionary *dictte =[[NSMutableDictionary alloc]init];
                    
                    dictte =[[arrsecond objectAtIndex:l] mutableCopy];
                    
                    [dictte setObject:strtemp forKey:@"nameofarray"];
                    
                    [arrtemprorary addObject:dictte];
                }
            }
            
            [dicttin setObject:arrtemprorary forKey:@"arrcustom"];
            
            [arrproduct12 replaceObjectAtIndex:j withObject:dicttin];
            
            
            NSArray *aerr =[[arrproduct12 objectAtIndex:j]valueForKey:@"arrcustom"];
            
            for (int m =0; m<aerr.count; m++)
            {
                NSMutableDictionary *dictt =[[NSMutableDictionary alloc]init];
                
                [dictt setObject:[NSString stringWithFormat:@"%@",[[aerr objectAtIndex:m]valueForKey:@"id"]] forKey:@"id"];
                [dictt setObject:@"1" forKey:@"quantity"];
                
                [arrtem addObject:dictt];
            }
            
            [dicttemp setObject:arrtem forKey:@"options"];
            
            [arritemid addObject:dicttemp];
        }
        
        [dictet setObject:arritemid forKey:@"items"];
        
        [arrweeks addObject:dictet];
    }
    
    
    arrweeklydata =[[NSMutableArray alloc]init];
    
    NSData *dataarraddtocart = [[NSUserDefaults standardUserDefaults]valueForKey:@"weeklyorderarray"];
    
    if (!(dataarraddtocart == nil))
    {
        arrweeklydata=[[NSKeyedUnarchiver unarchiveObjectWithData:dataarraddtocart] mutableCopy];
    }
    
    for (int i =0; i<arrweeklydata.count; i++)
    {
        NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
        dictet =[[arrweeklydata objectAtIndex:i] mutableCopy];
        [dictet setObject:@"false" forKey:@"flag"];
        [arrweeklydata replaceObjectAtIndex:i withObject:dictet];
    }
    
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arrweeks options:NSJSONWritingPrettyPrinted error:&error];
    NSString *strarrdata = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    //NSString *addtitle = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"address_title"]];
    NSString *straddresstype = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"address_type"]];
    
//    NSString *straddressid = @"";
//
//    if ([addtitle isEqualToString:@"Home"])
//    {
//        straddressid = @"0";
//    }
//
//    else if ([addtitle isEqualToString:@"Work"])
//    {
//        straddressid = @"1";
//    }
//
//    else
//    {
//        straddressid = @"2";
//    }
    
    NSString *parameter;
    
    parameter=[NSString stringWithFormat:@"request=%@&action=%@&key=%@&secret=%@&token=%@&payment=%@&user_id=%@&address_type=%@&promo_code=%@&days=%@&validate=%@&ios=%@",@"menu",@"order",str_key,str_secret,[[NSUserDefaults standardUserDefaults]valueForKey:@"token"],@"",[[NSUserDefaults standardUserDefaults]valueForKey:@"user_id"],straddresstype,_txtpromocode.text,strarrdata,@"validate",@"1"];
    
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
        
        dispatch_async(dispatch_get_main_queue(),^{
            
            if([errorCode isEqualToString:@"1"])
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:@"Promo code applied successfully." preferredStyle:UIAlertControllerStyleAlert];
                
                
                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                
                                                NSDictionary *dictdelivery=[dictionary valueForKey:@"delivery"];
                                                
                                                NSString *strcharge = [dictdelivery valueForKey:@"charge"];
                                                
                                                int charge = strcharge.intValue;
                                                
                                                NSDictionary *dictpromo=[dictionary valueForKey:@"promo"];
                                                
                                                strdiscountprices =[NSString stringWithFormat:@"- AED %@",[dictpromo valueForKey:@"discount"]];
                                                
                                                NSString *string = [dictpromo valueForKey:@"description"];
                                                
                                                float valueofdiscount;
                                                
                                                if (charge == 0)
                                                {
                                                    [_viewafterpomocode setHidden:NO];
                                                    
                                                    int fee = (int) arrweeklydata.count;
                                                    
                                                    float totalfee = 5.00 * fee;
                                                    
                                                    _lbldiscount.text = [NSString stringWithFormat:@"- AED %.2f", totalfee];
                                                    
                                                    valueofdiscount = 5.00 * fee;
                                                }
                                                
//                                                if ([string isEqualToString:@"free delivery"])
//                                                {
//                                                    [_viewafterpomocode setHidden:NO];
//
//                                                    int fee = (int) arrweeklydata.count;
//
//                                                    float totalfee = 5.00 * fee;
//
//                                                    _lbldiscount.text = [NSString stringWithFormat:@"- AED %.2f", totalfee];
//
//                                                    valueofdiscount = 5.00 * fee;
//                                                }
                                                
                                                else if ([string containsString:@"Free"])
                                                {
                                                    [_viewafterpomocode setHidden:YES];
                                                    
                                                    _lblprotitle.text  =[NSString stringWithFormat:@"%@",_txtpromocode.text];
                                                    _btnpromo.hidden = YES;
                                                    
                                                    NSLog(@"string contains Free!");
                                                    
                                                    NSString *str = [NSString stringWithFormat:@"Congrats, you get 1 %@.", string];
                                                    
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
                                                    [_viewafterpomocode setHidden:NO];
                                                    
                                                    _lbldiscount.text = strdiscountprices;
                                                    
                                                    valueofdiscount =[[dictpromo valueForKey:@"discount"] floatValue];
                                                }
                                                
                                                
                                                
                                                [[NSUserDefaults standardUserDefaults] setObject:_txtpromocode.text forKey:@"promocode_for_order"];
                                                
                                                _lblpromotitle.text  =[NSString stringWithFormat:@"%@",_txtpromocode.text];
                                                
                                                _btnaddPromocode.hidden = YES;
                                                
                                                _txtpromocode.text = @"";
                                                
                                                
                                                NSString *STRTOTALS = [NSString stringWithFormat:@"AED %d.00", sfmhdsifj];
                                                
                                                STRTOTALS =[STRTOTALS stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"AED"]];
                                                
                                                float totalvalue =[STRTOTALS floatValue];
                                                
                                                float supervqale = totalvalue - valueofdiscount;
                                                
                                                _lbltotalprice.text = [NSString stringWithFormat:@"AED %.2f",supervqale];
                                            }];
                
                
                //Add your buttons to alert controller
                
                [alert addAction:yesButton];
                
                [self presentViewController:alert animated:YES completion:nil];
            }
            
            else if ([errorCode isEqualToString:@"0"])
            {
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:@"Please enter a valid promo code." preferredStyle:UIAlertControllerStyleAlert];
                
                
                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                _txtpromocode.text = @"";
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
                                                _txtpromocode.text = @"";
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
                                                _txtpromocode.text = @"";
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

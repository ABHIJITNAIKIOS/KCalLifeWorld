//
//  MenuDetailsController.m
//  KCal
//
//  Created by Pipl-10 on 05/03/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//
#import "MenuDetailsController.h"
#import "MenuViewController.h"
#import "AppDelegate.h"
#import "BaseViewController.h"
#import "UIImageView+AFNetworking.h"
#import "menuDetailsTableViewCell.h"
#import "menudetailsCell.h"
#import "AddExtraCell.h"
#import "NutritionViewController.h"
#import "AddExtraCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "GiFHUD.h"

@interface MenuDetailsController ()
{
    NSString *flag;
    int sectiontemp;
    int count,tblheight;
    NSArray *arrProduct, *arrOptions, *arrAddons;
    NSString *strCheck;
    int totalprice;
    NSMutableArray *arrsection;
    NSMutableArray *arrheader;
    NSMutableDictionary *dictsection;
    NSMutableArray *arrtempdata;
    NSMutableArray *arrList, *arrfreeside, *arrextra;
    NSMutableDictionary *dictoffer;
    NSString *strrandom;
    NSMutableArray *arrtempoffer;
    CGRect screenRect;
    CGFloat screenWidth;
    CGFloat screenHeight;
}

@end

@implementation MenuDetailsController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    sectiontemp = 0;
    NSLog(@"is project ko do saal hogayae");
    [_imgnew setHidden:YES];
    [_imgsoldout setHidden:YES];
    [_imgpopular setHidden:YES];
    [_stackkcal setHidden:YES];
    _btnaddtocart.hidden = YES;
    _lblOutofStock.hidden = YES;
    
    [_btnvitamindetail setImage:[UIImage imageNamed:@"INFO_OFF"] forState:UIControlStateNormal];
    
    arrsection = [[NSMutableArray alloc]init];
    arrheader = [[NSMutableArray alloc]init];
    arrtempoffer = [[NSMutableArray alloc]init];
    dictoffer = [[NSMutableDictionary alloc]init];
    dictsection = [[NSMutableDictionary alloc]init];
    screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    
    _viewdescriptionHeight.constant=0.0f;
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismisstap)];
    
    [self.lbloffer addGestureRecognizer:tap1];
    
    if (_arrmenu.count > 0)
    {
        self.offername.text = _getoffername;
        self.offerline.text = _getofferline;
        
        if (_arrgroup2.count > 0)
        {
            NSMutableArray *arr = _arrgroup2.mutableCopy;
            
            for (int i = 0; i<arr.count; i++)
            {
                NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
                
                dictet = [[arr objectAtIndex:i] mutableCopy];
                
                [dictet setObject:@"no" forKey:@"isclicked"];
                [arr replaceObjectAtIndex:i withObject:dictet];
            }
            
            _arrgroup2 = [[NSMutableArray alloc]init];
            
            _arrgroup2 = arr.mutableCopy;
            
            NSString *stroutOfStockimg =[NSString stringWithFormat:@"%@",[_arrmenu valueForKey:@"outOfStock"]];
            
            if ([stroutOfStockimg isEqualToString:@"Y"])
            {
                self.viewKcalfriday.hidden = YES;
            }
            
            else
            {
                self.viewKcalfriday.hidden = NO;
                self.viewKcalfriday.frame = CGRectMake(0, 0, screenWidth, screenHeight);
                [self.view addSubview:_viewKcalfriday];
            }
            
            self.lbloffer.frame = self.view.frame;
            
            [_tbloffers reloadData];
            
            [GiFHUD showWithOverlay];
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self MenuDetail];
            });
        }
        
        else
        {
            self.viewKcalfriday.hidden = YES;
        }
    }
    
    else
    {
        [GiFHUD showWithOverlay];
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self wsMenudetails];
        });
    }
    
    self.viewaddcart.layer.shadowColor = [[UIColor darkGrayColor] CGColor];
    
    self.viewaddcart.layer.shadowOffset = CGSizeMake(1.0f, 1.0f);
    
    self.viewaddcart.layer.shadowRadius = 2.0f;
    
    self.viewaddcart.layer.shadowOpacity = 1.0f;
    
    self.viewdescriptiondetail.hidden=YES;
    _lblbg.hidden=YES;
    
    count=0;
    tblheight=0;
    flag=@"true";
    
    if(screenHeight > 800)
    {
        _viewleading.constant = 30;
        _viewtrailling.constant = 30;
        _viewspace.constant = 10;
    }
    
    [GiFHUD setGifWithImageName:@"Spinner3.gif"];
}



-(void)dismisstap
{
    _viewKcalfriday.hidden=YES;
}



-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBar.hidden=YES;
}




-(void)viewDidAppear:(BOOL)animated
{
    int random = arc4random_uniform(100000);
    
    strrandom = [NSString stringWithFormat:@"%d",random];
    
    for (UIButton *view in self.navigationController.navigationBar.subviews)
    {
        if (view.tag == 211)
        {
            [view removeFromSuperview];
        }
        
        if (view.tag == 134)
        {
            [view removeFromSuperview];
        }
    }
}




-(void)MenuDetail
{
    [GiFHUD dismiss];
    arrfreeside = [[NSMutableArray alloc]init];
    arrextra = [[NSMutableArray alloc]init];
    
    [_stackkcal setHidden:NO];
    
    arrProduct = _arrmenu;
    
    NSMutableArray *arrsymbols = [[NSMutableArray alloc]init];
    
    arrsymbols = [arrProduct valueForKey:@"symbols_images"];
    
    for (int k = 0; k<arrsymbols.count; k++)
    {
        UIImageView *imgsymbol = [[UIImageView alloc]initWithFrame:_btnnutritionclicked.frame];
        
        NSString *strimg = [arrsymbols objectAtIndex:k];
        
        NSURL *url = [NSURL URLWithString:strimg];
        
        [imgsymbol setImageWithURL:url];
        
        [imgsymbol setContentMode:UIViewContentModeScaleAspectFill];
        
        [_stacksymbol addArrangedSubview:imgsymbol];
        
        if(screenHeight > 800)
        {
            [_stacksymbol setSpacing:13.0f];
        }
        
        else
        {
            [_stacksymbol setSpacing:7.0f];
        }
    }
    
    [_stacksymbol addArrangedSubview:_btnnutritionclicked];
    
    
    NSDictionary *dictoption =[[NSDictionary alloc]init];
    
    if ([arrProduct valueForKey:@"options"])
    {
        dictoption =[[arrProduct valueForKey:@"options"] mutableCopy];
    }
    
    self.lblName2.text=[arrProduct valueForKey:@"name"];
    self.lblDescription.text=[arrProduct valueForKey:@"shortDescription"];
    self.lblKcal.text=[NSString stringWithFormat:@"%@,",[arrProduct valueForKey:@"kcal"]];
    self.lblCarbs.text=[NSString stringWithFormat:@"%@g,",[arrProduct valueForKey:@"carbs"]];
    self.lblFat.text=[NSString stringWithFormat:@"%@g,",[arrProduct valueForKey:@"fat"]];
    self.lblPro.text=[NSString stringWithFormat:@"%@g",[arrProduct valueForKey:@"pro"]];
    
    if ([[arrProduct valueForKey:@"type"] isEqualToString:@"1"])
    {
        NSString *strprices =[NSString stringWithFormat:@"%@",[arrProduct valueForKey:@"fixed_price"]];
        
        int intprices =[strprices intValue];
        
        _lblprice.text =[NSString stringWithFormat:@"AED %d",intprices];
        
        NSString *strtotalprice =[NSString stringWithFormat:@"%@",[arrProduct valueForKey:@"fixed_price"]];
        
        totalprice =[strtotalprice intValue];
        
        _lbltotalprice.text =[NSString stringWithFormat:@"AED %d",totalprice];
    }
    
    else if ([[arrProduct valueForKey:@"type"] isEqualToString:@"2"])
    {
        NSString *strprices =[NSString stringWithFormat:@"%@",[arrProduct valueForKey:@"price"]];
        
        int intprices =[strprices intValue];
        
        _lblprice.text =[NSString stringWithFormat:@"AED %d",intprices];
        
        NSString *strtotalprice =[NSString stringWithFormat:@"%@",[arrProduct valueForKey:@"price"]];
        
        totalprice =[strtotalprice intValue];
        
        _lbltotalprice.text =[NSString stringWithFormat:@"AED %d",totalprice];
    }
    
    else
    {
        NSString *strprices =[NSString stringWithFormat:@"%@",[arrProduct valueForKey:@"price"]];
        
        int intprices =[strprices intValue];
        
        _lblprice.text =[NSString stringWithFormat:@"AED %d",intprices];
        
        NSString *strtotalprice =[NSString stringWithFormat:@"%@",[arrProduct valueForKey:@"price"]];
        
        totalprice =[strtotalprice intValue];
        
        _lbltotalprice.text =[NSString stringWithFormat:@"AED %d",totalprice];
    }
    
    
    NSString *strnewimg =[NSString stringWithFormat:@"%@",[arrProduct valueForKey:@"new"]];
    
    NSString *stroutOfStockimg =[NSString stringWithFormat:@"%@",[arrProduct valueForKey:@"outOfStock"]];
    
    NSString *strpopular_itemimg =[NSString stringWithFormat:@"%@",[arrProduct valueForKey:@"popular_item"]];
    
    
    if ([strnewimg isEqualToString:@"Y"])
    {
        [_imgnew setHidden:YES];
    }
    
    else
    {
        [_imgnew setHidden:YES];
    }
    
    
    
    if ([stroutOfStockimg isEqualToString:@"Y"])
    {
        self.viewKcalfriday.hidden = YES;
        _lblOutofStock.hidden = NO;
        _btnaddtocart.hidden = YES;
        [_imgsoldout setHidden:YES];
    }
    
    else
    {
        self.viewKcalfriday.hidden = NO;
        _lblOutofStock.hidden = YES;
        _btnaddtocart.hidden = NO;
        [_imgsoldout setHidden:YES];
    }
    
    
    
    if ([strpopular_itemimg isEqualToString:@"Y"])
    {
        [_imgpopular setHidden:YES];
    }
    
    else
    {
        [_imgpopular setHidden:YES];
    }
    
    
    NSArray *arrNeutrition=[arrProduct valueForKey:@"nutritional_facts"];
    
    NSArray *arrvitamins=[arrProduct valueForKey:@"vitamins"];
    
    NSMutableDictionary *dictaddon = [[NSMutableDictionary alloc]init];
    
    dictaddon = [[[arrProduct valueForKey:@"options"] valueForKey:@"addon"] mutableCopy];
    
    arrAddons=[[dictaddon valueForKey:@"options"] mutableCopy];
    
    //arrAddons=[[arrProduct valueForKey:@"options"] valueForKey:@"addon"];
    
    dictsection =[[arrProduct valueForKey:@"options"] mutableCopy];
    
    NSMutableArray *arrcompare = [[NSMutableArray alloc]init];
    
    arrcompare = [[arrProduct valueForKey:@"option_compare"] mutableCopy];
    
    arrsection = arrcompare;
    
    //arrsection =[[dictsection allKeys] mutableCopy];
    sectiontemp = (int) arrsection.count;
    arrtempdata =[[NSMutableArray alloc]init];
    
    for (int k = 0; k<arrsection.count; k++)
    {
        NSString *strehjwg=[arrsection objectAtIndex:k];
        
        //NSMutableArray *arrtemp1 =[[dictsection valueForKey:strehjwg] mutableCopy];
        
        NSMutableDictionary *dictdish = [[NSMutableDictionary alloc]init];
        
        dictdish = [[dictsection valueForKey:strehjwg] mutableCopy];
        
        [arrheader addObject: [dictdish valueForKey:@"name"]];
        
        NSMutableArray *arrtemp1 =[[dictdish valueForKey:@"options"] mutableCopy];
        
        
        for (int i = 0; i<arrtemp1.count; i++)
        {
            NSMutableDictionary *dictemp =[[NSMutableDictionary alloc]init];
            
            dictemp = [[arrtemp1 objectAtIndex:i] mutableCopy];
            
            [dictemp setObject:@"no" forKey:@"isclicked"];
            
            [arrtemp1 replaceObjectAtIndex:i withObject:dictemp];
        }
        
        [dictsection setObject:arrtemp1 forKey:strehjwg];
    }
    
    [_tblselection reloadData];
    
    if (dictsection.count > 0)
    {
        _lblline.hidden = NO;
    }
    
    else
    {
        _lblline.hidden = YES;
    }
    
    
    arrList=[[NSMutableArray alloc]init];
    
    
    for (int i=0; i<arrAddons.count; i++)
    {
        NSString *eg =[NSString stringWithFormat:@"%@",[[arrAddons objectAtIndex:i] valueForKey:@"symbols"]];
        
        if ([eg isEqualToString:@"0"])
        {
            
        }
        
        else
        {
            [arrList addObject:[arrAddons objectAtIndex:i]];
        }
    }
    
    for (int i=0; i<arrOptions.count; i++)
    {
        NSString *eg =[NSString stringWithFormat:@"%@",[[arrOptions objectAtIndex:i] valueForKey:@"symbols"]];
        
        if ([eg isEqualToString:@"0"])
        {
            
        }
        
        else
        {
            [arrList addObject:[arrOptions objectAtIndex:i]];
        }
    }
    
    
    for (int i =0; i<arrNeutrition.count; i++)
    {
        NSString *strcondn =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i] valueForKey:@"name"]];
        
        
        if ([strcondn isEqualToString:@"Kilo Calories"])
        {
            NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
            NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
            
            _lblKiloCalories.text = strvalue;
            _lblkilocalpercent.text = strdaily_value;
        }
        
        else if ([strcondn isEqualToString:@"Fat Calories"])
        {
            NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
            NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
            
            _lblFatCalories.text = strvalue;
            _lblfatpercent.text = strdaily_value;
        }
        
        else if ([strcondn isEqualToString:@"Total fat"])
        {
            NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
            NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
            
            _lblZTotalfat.text = strvalue;
            _lbltotalfatpercent.text = strdaily_value;
        }
        
        else if ([strcondn isEqualToString:@"Saturated Fat"])
        {
            NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
            NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
            
            _lblSaturatedfat.text = strvalue;
            _lblsatfatpercent.text = strdaily_value;
        }
        
        else if ([strcondn isEqualToString:@"Trans. Fat"])
        {
            NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
            NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
            
            _lblTransfat.text = strvalue;
            _lbltransfatpercent.text = strdaily_value;
        }
        
        else if ([strcondn isEqualToString:@"Mono unsat. Fat"])
        {
            NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
            NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
            
            _lblmonosatfat.text = strvalue;
            _lblmonofatpercent.text = strdaily_value;
        }
        
        else if ([strcondn isEqualToString:@"Poly unsat. Fat"])
        {
            NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
            NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
            
            _lblpolysatfat.text = strvalue;
            _lblpolyfatpercent.text = strdaily_value;
        }
        
        else if ([strcondn isEqualToString:@"Cholesterol"])
        {
            NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
            NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
            
            _lblCholestrol.text = strvalue;
            _lblcholestrolpercent.text = strdaily_value;
        }
        
        else if ([strcondn isEqualToString:@"Sodium"])
        {
            NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
            NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
            
            _lblSodium.text = strvalue;
            _lblsodiumpercent.text = strdaily_value;
        }
        
        else if ([strcondn isEqualToString:@"Potassium"])
        {
            NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
            NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
            
            _lblPotassium.text = strvalue;
            _lblpotassiumpercent.text = strdaily_value;
        }
        
        else if ([strcondn isEqualToString:@"Total Carbs"])
        {
            NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
            NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
            
            _lbltotalcarbs.text = strvalue;
            _lbltotalcarbpercent.text = strdaily_value;
        }
        
        else if ([strcondn isEqualToString:@"Dietary Fiber"])
        {
            NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
            NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
            
            _lblDietryFiber.text = strvalue;
            _lbldietrypercent.text = strdaily_value;
        }
        
        else if ([strcondn isEqualToString:@"Sugars"])
        {
            NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
            NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
            
            _lblsuger.text = strvalue;
            _lblsugarpercent.text = strdaily_value;
        }
        
        else if ([strcondn isEqualToString:@"Protein"])
        {
            NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
            NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
            
            _lblProtien.text = strvalue;
            _lblprotienpercent.text = strdaily_value;
        }
    }
    
    
    
    for (int i = 0; i<arrvitamins.count; i++)
    {
        NSString *strcondn =[NSString stringWithFormat:@"%@",[[arrvitamins objectAtIndex:i]valueForKey:@"name"]];
        
        
        if ([strcondn isEqualToString:@"Vitamin A"])
        {
            NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrvitamins objectAtIndex:i]valueForKey:@"value"]];
            _lblVitaminAval.text = strvalue;
        }
        
        else if ([strcondn isEqualToString:@"Vitamin C"])
        {
            NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrvitamins objectAtIndex:i]valueForKey:@"value"]];
            _lblVitaminCval.text = strvalue;
        }
        
        else if ([strcondn isEqualToString:@"Calcium"])
        {
            NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrvitamins objectAtIndex:i]valueForKey:@"value"]];
            _lblcalciumval.text = strvalue;
        }
        
        else if ([strcondn isEqualToString:@"Iron"])
        {
            NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrvitamins objectAtIndex:i]valueForKey:@"value"]];
            _lblironval.text = strvalue;
        }
        
        else if ([strcondn isEqualToString:@"Thiamin"])
        {
            NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrvitamins objectAtIndex:i]valueForKey:@"value"]];
            _lblthiminval.text = strvalue;
        }
        
        else if ([strcondn isEqualToString:@"Vitamin B6"])
        {
            NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrvitamins objectAtIndex:i]valueForKey:@"value"]];
            _lblvitaminval.text = strvalue;
        }
        
        else if ([strcondn isEqualToString:@"Phosphorous"])
        {
            NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrvitamins objectAtIndex:i]valueForKey:@"value"]];
            _lblPhosphorousval.text = strvalue;
        }
        
        else if ([strcondn isEqualToString:@"Magnesium"])
        {
            NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrvitamins objectAtIndex:i]valueForKey:@"value"]];
            _lblmagnesiumval.text = strvalue;
        }
        
        else if ([strcondn isEqualToString:@"Copper"])
        {
            NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrvitamins objectAtIndex:i]valueForKey:@"value"]];
            _lblcopperval.text = strvalue;
        }
        
        else if ([strcondn isEqualToString:@"Manganese"])
        {
            NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrvitamins objectAtIndex:i]valueForKey:@"value"]];
            _lblmanganeseval.text = strvalue;
        }
    }
    
    
    
    
    NSArray *arroptions=[[NSArray alloc]init];
    
    if ([dictoption valueForKey:@"sidedish2"])
    {
        NSDictionary *dictside = [[NSDictionary alloc]init];
        
        dictside = [[dictoption valueForKey:@"sidedish2"] mutableCopy];
        
        //arroptions = [dictoption valueForKey:@"sidedish2"];
        
        arroptions = [[dictside valueForKey:@"options"] mutableCopy];
        
        strCheck = @"option";
        arrOptions  = arroptions;
    }
    
    
    if (arrOptions.count > 0)
    {
        _lblsideoptions.hidden = NO;
    }
    
    else
    {
        _lblsideoptions.hidden = YES;
        _sideoptiontop.constant = 0;
        _lblsideoptionheight.constant = 0;
    }
    
    
    if ([dictoption valueForKey:@"sidedish2"])
    {
        NSDictionary *dictside = [[NSDictionary alloc]init];
        
        dictside = [[dictoption valueForKey:@"sidedish2"] mutableCopy];
        
        //NSMutableArray *arrtemp =[[dictoption valueForKey:@"sidedish2"] mutableCopy];
        
        NSMutableArray *arrtemp =[[dictside valueForKey:@"options"] mutableCopy];
        
        for (int i = 0; i<arrtemp.count; i++)
        {
            NSMutableDictionary *dictemp =[[NSMutableDictionary alloc]init];
            
            dictemp = [[arrtemp objectAtIndex:i] mutableCopy];
            [dictemp setObject:@"no" forKey:@"isclicked"];
            
            [arrtemp replaceObjectAtIndex:i withObject:dictemp];
        }
        
        arrextra = [[NSMutableArray alloc]init];
        
        arrextra = arrtemp;
    }
    
    
    
    if ([dictoption valueForKey:@"sidedish"])
    {
        NSDictionary *dictside = [[NSDictionary alloc]init];
        
        dictside = [[dictoption valueForKey:@"sidedish"] mutableCopy];
        
        //NSMutableArray *arrtemp =[[dictoption valueForKey:@"sidedish"] mutableCopy];
        
        NSMutableArray *arrtemp =[[dictside valueForKey:@"options"] mutableCopy];
        
        for (int i = 0; i<arrtemp.count; i++)
        {
            NSMutableDictionary *dictemp =[[NSMutableDictionary alloc]init];
            
            dictemp = [[arrtemp objectAtIndex:i] mutableCopy];
            [dictemp setObject:@"no" forKey:@"isclicked"];
            
            [arrtemp replaceObjectAtIndex:i withObject:dictemp];
        }
        
        arrfreeside = [[NSMutableArray alloc]init];
        
        arrfreeside = arrtemp;
    }
    
    
    NSString *strimg = [NSString stringWithFormat:@"%@",[[arrProduct  valueForKey:@"images"] valueForKey:@"normal"]];
    
    NSURL *url = [NSURL URLWithString:strimg];
    
    SDImageCache *cache = [SDImageCache sharedImageCache];
    [cache clearMemory];
    [cache clearDiskOnCompletion:nil];
    [cache removeImageForKey:strimg fromDisk:YES withCompletion:nil];
    
//    NSData *data = [NSData dataWithContentsOfURL:url];
//
//    self.img.image = [UIImage imageWithData:data];
    
    [self.img sd_setImageWithURL:url
                placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRefreshCached];
    
    //[self.img setImageWithURL:[NSURL URLWithString:strimg] placeholderImage:[UIImage imageNamed:@"placeholderfood"]];
}




- (IBAction)btnnutritionalinfo:(id)sender
{
    NSLog(@"%@",arrOptions);
    
    if([flag isEqualToString:@"true"])
    {
        flag=@"false";
        
        _lblline.hidden = NO;
        
        [_btnvitamindetail setImage:[UIImage imageNamed:@"INFO_ON"] forState:UIControlStateNormal];
        
        if (arrList.count > 0)
        {
            _viewdescriptionHeight.constant= 380 +_tblsideoptionsheight.constant;
        }
        
        else
        {
            _viewdescriptionHeight.constant= 380;
        }
        
        self.viewdescriptiondetail.hidden=NO;
        _tblsideoptions.delegate = self;
        _tblsideoptions.dataSource = self;
        
        if (arrOptions.count > 0)
        {
            dispatch_async(dispatch_get_main_queue(),^{
                _tblsideoptionsheight.constant = 200;
                _viewdescriptionHeight.constant = 380 + arrOptions.count * 58;
                [_tblsideoptions reloadData];
            });
        }
    }
    
    else if([flag isEqualToString:@"false"])
    {
        if (dictsection.count > 0)
        {
            _lblline.hidden = NO;
        }
        
        else
        {
            _lblline.hidden = YES;
        }
        
        [_btnvitamindetail setImage:[UIImage imageNamed:@"INFO_OFF"] forState:UIControlStateNormal];
        
        flag=@"true";
        _viewdescriptionHeight.constant=0.0f;
        self.viewdescriptiondetail.hidden=YES;
    }
}





- (IBAction)btnback:(id)sender
{
//    MenuViewController *menu =[[MenuViewController alloc]init];
//
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
//
//    [self.navigationController pushViewController:menu animated:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}





- (IBAction)btndone:(id)sender
{
    arrtempoffer = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<_arrgroup2.count; i++)
    {
        if ([[[_arrgroup2 objectAtIndex:i] valueForKey:@"isclicked"] isEqualToString:@"yes"])
        {
            [arrtempoffer addObject:[_arrgroup2 objectAtIndex:i]];
        }
    }
    
    
    if (arrtempoffer.count > 0)
    {
        _viewKcalfriday.hidden = YES;
        
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        
        [dictoffer setObject:arr forKey:@"options"];
        
        [dictoffer setObject:@"1" forKey:@"quantity"];
        
        [dictoffer setObject:[[arrtempoffer objectAtIndex:0] valueForKey:@"itemID"] forKey:@"itemID"];
        
        [dictoffer setObject:strrandom forKey:@"random_no"];
        
        //    NSMutableArray *arroffer =[[NSMutableArray alloc]init];
        //
        //    NSData *dataarrayoffer =[[NSUserDefaults standardUserDefaults] valueForKey:@"arrayoffer"];
        //
        //    if (!(dataarrayoffer.bytes == 0))
        //    {
        //        arroffer=[[NSKeyedUnarchiver unarchiveObjectWithData:dataarrayoffer] mutableCopy];
        //    }
        //
        //    [arroffer addObject:dictoffer];
        //
        //    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arroffer];
        //
        //    [[NSUserDefaults standardUserDefaults] setValue:data forKey:@"arrayoffer"];
        //
        //    [dictoffer setObject:[[arrtempoffer objectAtIndex:0] valueForKey:@"name"] forKey:@"name"];
    }
    
    else
    {
        UIAlertController * alert = [UIAlertController
                                     alertControllerWithTitle:nil
                                     message:@"Please select your free item."
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




#pragma  mark <---table view delegate--->


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView == _tblselection)
    {
        return arrsection.count;
    }
    
    else
    {
        return 1;
    }
}




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView == _tbloffers)
    {
        return 0.0f;
    }
    
    else
    {
        return 20.0f;
    }
}



- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView == _tblselection)
    {
        UIView *viewheader =[[UIView alloc]init];
        UILabel *lbltitle =[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 310, 13)];
        
        //NSString *str = [NSString stringWithFormat:@"%@:",[arrsection objectAtIndex:section]];
        
        NSString *str = [NSString stringWithFormat:@"%@:",[arrheader objectAtIndex:section]];
        
//        NSString *firstChar = [str substringToIndex:1];
//
//        /* remove any diacritic mark */
//        NSString *folded = [firstChar stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:locale];
//
//        /* create the new string */
//        NSString *result = [[folded uppercaseString] stringByAppendingString:[str substringFromIndex:1]];
//
//        result =[result stringByReplacingOccurrencesOfString:@"Sidedish" withString:@"Choose your FREE side"];
//
//        result =[result stringByReplacingOccurrencesOfString:@"Choose your FREE side2" withString:@"Add EXTRA"];
//
//        result =[result stringByReplacingOccurrencesOfString:@"Addon" withString:@"Add-on"];
//
//        result =[result stringByReplacingOccurrencesOfString:@"Add-on2" withString:@"Add-on"];
//
//        lbltitle.text = result;
        
        lbltitle.text = str;
        
        [lbltitle setTextAlignment:NSTextAlignmentLeft];
        [lbltitle setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:13.0f]];
//        [lbltitle setTextColor:[UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:110.0/255.0 alpha:1.0f]];
        [lbltitle setTextColor:[UIColor blackColor]];
        [viewheader addSubview:lbltitle];
        
        return viewheader;
    }
    
    else if (tableView == _tbloffers)
    {
        return 0;
    }
    
    else
    {
        UIView *viewheader =[[UIView alloc]init];
//        UILabel *lbltitle =[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 310, 0)];
//
//        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
//
//        NSString *str = [NSString stringWithFormat:@"%@:",[arrsection objectAtIndex:section]];
//
//        //lbltitle.text =[NSString stringWithFormat:@"%@:",[arrsection objectAtIndex:section]];
//
//        NSString *firstChar = [str substringToIndex:1];
//
//        /* remove any diacritic mark */
//        NSString *folded = [firstChar stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:locale];
//
//        /* create the new string */
//        NSString *result = [[folded uppercaseString] stringByAppendingString:[str substringFromIndex:1]];
//        lbltitle.text = result;
//
//        [lbltitle setTextAlignment:NSTextAlignmentLeft];
//        [lbltitle setFont:[UIFont fontWithName:@"AvenirNext-Medium" size:12.0f]];
//        [lbltitle setTextColor:[UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:110.0/255.0 alpha:1.0f]];
//        [viewheader addSubview:lbltitle];
        
        return viewheader;
    }
}





- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (tableView == _tblselection)
    {
        UIView *viewheader =[[UIView alloc]init];
        UILabel *lbltitle =[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.origin.x+11,self.view.frame.origin.x+5, self.view.frame.size.width-22, 1)];
        [lbltitle setBackgroundColor:[UIColor colorWithRed:198.0/255.0 green:197.0/255.0 blue:197.0/255.0 alpha:1.0f]];
        [viewheader addSubview:lbltitle];
        return viewheader;
    }
    
    else if (tableView == _tbloffers)
    {
        return 0;
    }
    
    else
    {
        UIView *viewheader =[[UIView alloc]init];
        UILabel *lbltitle =[[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.origin.x+11,self.view.frame.origin.x+5, self.view.frame.size.width-22, 0)];
        [lbltitle setBackgroundColor:[UIColor colorWithRed:198.0/255.0 green:197.0/255.0 blue:197.0/255.0 alpha:1.0f]];
        [viewheader addSubview:lbltitle];
        return viewheader;
    }
}





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _tblsideoptions)
    {
        return arrOptions.count;
    }
    
    else if ([strCheck isEqualToString:@"addons"])
    {
        return arrAddons.count;
    }
    
    else if (tableView == _tblselection)
    {
        NSString *strselect =[NSString stringWithFormat:@"%@",[arrsection objectAtIndex:section]];
        
        arrtempdata =[dictsection valueForKey:strselect];
        
        return arrtempdata.count;
    }
    
    else if (tableView == _tbloffers)
    {
        return _arrgroup2.count;
    }
    
    else
    {
        return arrList.count;
    }
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tblselection)
    {
        return 33;
    }
    
    if (tableView == _tblsideoptions)
    {
        return 58;
    }
    
    else if (tableView == _tbloffers)
    {
        return 44;
    }
    
    else
    {
        return YES;
    }
}





-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == _tbloffers)
    {
        NSArray *nib;
        
        AddExtraCell *cell1 = (AddExtraCell *)[self.tbloffers dequeueReusableCellWithIdentifier:@"cell1"];
        
        nib = [[NSBundle mainBundle] loadNibNamed:@"AddExtraCell" owner:self options:nil];
        
        cell1 =[[AddExtraCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        
        cell1 = [nib objectAtIndex:0];
        
        cell1.lbltitle.text = [[_arrgroup2 objectAtIndex:indexPath.row] valueForKey:@"name"];
        
        if ([[[_arrgroup2 objectAtIndex:indexPath.row] valueForKey:@"isclicked"] isEqualToString:@"yes"])
        {
            [cell1.imgcircle setImage:[UIImage imageNamed:@"greenCircle"]];
        }
        
        else
        {
            [cell1.imgcircle setImage:[UIImage imageNamed:@"grayCircle"]];
        }
        
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell1;
    }
    
    else if (tableView == self.tblsideoptions)
    {
        NSArray *nib;
        
        menuDetailsTableViewCell *cell1 = (menuDetailsTableViewCell *)[self.tblsideoptions dequeueReusableCellWithIdentifier:@"cell1"];
        
        nib = [[NSBundle mainBundle] loadNibNamed:@"menuDetailsTableViewCell" owner:self options:nil];
        
        cell1 =[[menuDetailsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell1"];
        
        cell1 = [nib objectAtIndex:0];
        
        NSArray *arrsym =[[NSArray alloc]init];
        
        if (arrOptions.count > 0)
        {
            _lblsideoptions.hidden = NO;
            
        }
        
        else
        {
            _lblsideoptions.hidden = YES;
            _sideoptiontop.constant = 0;
            _lblsideoptionheight.constant = 0;
        }
        
        cell1.lbltitle.text=[NSString stringWithFormat:@"%@",[[arrOptions objectAtIndex:indexPath.row] valueForKey:@"name"]];
        cell1.lblkcalval.text=[NSString stringWithFormat:@"%@,",[[arrOptions objectAtIndex:indexPath.row] valueForKey:@"kcal"]];
        cell1.lblfatvalue.text=[NSString stringWithFormat:@"%@g,",[[arrOptions objectAtIndex:indexPath.row] valueForKey:@"fat"]];
        cell1.lblcarbsvalue.text=[NSString stringWithFormat:@"%@g,",[[arrOptions objectAtIndex:indexPath.row] valueForKey:@"carbs"]];
        cell1.lblproval.text=[NSString stringWithFormat:@"%@g",[[arrOptions objectAtIndex:indexPath.row] valueForKey:@"pro"]];
        
        //NSString *arrsymbolestr =[NSString stringWithFormat:@"%@",[[arrOptions objectAtIndex:indexPath.row]valueForKey:@"symbols"]];
        
        NSString *arrsymbolestr =[NSString stringWithFormat:@"%@",[[arrOptions objectAtIndex:indexPath.row]valueForKey:@"symbols_img"]];
        
        if (![arrsymbolestr isEqualToString:@"0"])
        {
            arrsym =[[arrOptions objectAtIndex:indexPath.row]valueForKey:@"symbols_img"];
        }
        
        
        
        for (int k = 0; k<arrsym.count; k++)
        {
            NSString *strimg = [arrsym objectAtIndex:k];
            
            NSURL *url = [NSURL URLWithString:strimg];
            
            if (k == 0)
            {
                [cell1.imgfirst setImageWithURL:url];
            }
            
            else if (k == 1)
            {
                [cell1.imgsecond setImageWithURL:url];
            }
            
            else if (k == 2)
            {
                [cell1.imgthird setImageWithURL:url];
            }
            
            else if (k == 3)
            {
                [cell1.imgfour setImageWithURL:url];
            }
        }
        
        
        
//        for (int i =0; i<arrsym.count; i++)
//        {
//            NSString *ints = [NSString stringWithFormat:@"%@",[arrsym objectAtIndex:i]];
//
//            int intsymbol =[ints intValue];
//
//            if (i == 0)
//            {
//                if (intsymbol == 1)
//                {
//                    cell1.imgfirst.image =[UIImage imageNamed:@"2"];
//                }
//
//                else if (intsymbol == 2)
//                {
//                    cell1.imgfirst.image =[UIImage imageNamed:@"8"];
//                }
//
//                else if (intsymbol == 3)
//                {
//                    cell1.imgfirst.image =[UIImage imageNamed:@"5"];
//                }
//
//                else if (intsymbol == 4)
//                {
//                    cell1.imgfirst.image =[UIImage imageNamed:@"13"];
//                }
//
//                else if (intsymbol == 5)
//                {
//                    cell1.imgfirst.image =[UIImage imageNamed:@"3"];
//                }
//
//                else if (intsymbol == 6)
//                {
//                    cell1.imgfirst.image =[UIImage imageNamed:@"1"];
//                }
//
//                else if (intsymbol == 8)
//                {
//                    cell1.imgfirst.image =[UIImage imageNamed:@"9"];
//                }
//
//                else if (intsymbol == 10)
//                {
//                    cell1.imgfirst.image =[UIImage imageNamed:@"4"];
//                }
//
//                else if (intsymbol == 11)
//                {
//                    cell1.imgfirst.image =[UIImage imageNamed:@"7"];
//                }
//            }
//
//            else if (i ==1)
//            {
//                if (intsymbol == 1)
//                {
//                    cell1.imgsecond.image =[UIImage imageNamed:@"2"];
//                }
//                else if (intsymbol == 2)
//                {
//                    cell1.imgsecond.image =[UIImage imageNamed:@"8"];
//                }
//
//                else if (intsymbol == 3)
//                {
//                    cell1.imgsecond.image =[UIImage imageNamed:@"5"];
//                }
//
//                else if (intsymbol == 4)
//                {
//                    cell1.imgsecond.image =[UIImage imageNamed:@"13"];
//                }
//
//                else if (intsymbol == 5)
//                {
//                    cell1.imgsecond.image =[UIImage imageNamed:@"3"];
//                }
//                else if (intsymbol == 6)
//                {
//                    cell1.imgsecond.image =[UIImage imageNamed:@"1"];
//                }
//
//                else if (intsymbol == 8)
//                {
//                    cell1.imgsecond.image =[UIImage imageNamed:@"9"];
//                }
//
//                else if (intsymbol == 10)
//                {
//                    cell1.imgsecond.image =[UIImage imageNamed:@"4"];
//                }
//
//                else if (intsymbol == 11)
//                {
//                    cell1.imgsecond.image =[UIImage imageNamed:@"7"];
//                }
//            }
//
//            else if (i ==2)
//            {
//                if (intsymbol == 1)
//                {
//                    cell1.imgthird.image =[UIImage imageNamed:@"2"];
//                }
//
//                else if (intsymbol == 2)
//                {
//                    cell1.imgthird.image =[UIImage imageNamed:@"8"];
//                }
//
//                else if (intsymbol == 3)
//                {
//                    cell1.imgthird.image =[UIImage imageNamed:@"5"];
//                }
//
//                else if (intsymbol == 4)
//                {
//                    cell1.imgthird.image =[UIImage imageNamed:@"13"];
//                }
//
//                else if (intsymbol == 5)
//                {
//                    cell1.imgthird.image =[UIImage imageNamed:@"3"];
//                }
//                else if (intsymbol == 6)
//                {
//                    cell1.imgthird.image =[UIImage imageNamed:@"1"];
//                }
//
//                else if (intsymbol == 8)
//                {
//                    cell1.imgthird.image =[UIImage imageNamed:@"9"];
//                }
//
//                else if (intsymbol == 10)
//                {
//                    cell1.imgthird.image =[UIImage imageNamed:@"4"];
//                }
//
//                else if (intsymbol == 11)
//                {
//                    cell1.imgthird.image =[UIImage imageNamed:@"7"];
//                }
//            }
//
//            else if (i ==3)
//            {
//                if (intsymbol == 1)
//                {
//                    cell1.imgfour.image =[UIImage imageNamed:@"2"];
//                }
//
//                else if (intsymbol == 2)
//                {
//                    cell1.imgfour.image =[UIImage imageNamed:@"8"];
//                }
//
//                else if (intsymbol == 3)
//                {
//                    cell1.imgfour.image =[UIImage imageNamed:@"5"];
//                }
//
//                else if (intsymbol == 4)
//                {
//                    cell1.imgfour.image =[UIImage imageNamed:@"13"];
//                }
//
//                else if (intsymbol == 5)
//                {
//                    cell1.imgfour.image =[UIImage imageNamed:@"3"];
//                }
//
//                else if (intsymbol == 6)
//                {
//                    cell1.imgfour.image =[UIImage imageNamed:@"1"];
//                }
//
//                else if (intsymbol == 8)
//                {
//                    cell1.imgfour.image =[UIImage imageNamed:@"9"];
//                }
//
//                else if (intsymbol == 10)
//                {
//                    cell1.imgfour.image =[UIImage imageNamed:@"4"];
//                }
//
//                else if (intsymbol == 11)
//                {
//                    cell1.imgfour.image =[UIImage imageNamed:@"7"];
//                }
//            }
//        }
        
        _tblsideoptionsheight.constant = _tblsideoptions.contentSize.height+10;
        _viewdescriptionHeight.constant= 380 +_tblsideoptionsheight.constant;
        NSLog(@"%f", _tblsideoptionsheight.constant);
        
        cell1.selectionStyle=UITableViewCellSelectionStyleNone;
        
        return cell1;
    }
    
    else if (tableView == _tblselection)
    {
        NSArray *nib;
        
        menudetailsCell *cell2 = (menudetailsCell *)[self.tblfree dequeueReusableCellWithIdentifier:@"cell2"];
        
        nib = [[NSBundle mainBundle] loadNibNamed:@"menudetailsCell" owner:self options:nil];
        
        cell2 =[[menudetailsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
        
        cell2 = [nib objectAtIndex:0];
        
        int countsec = (int) indexPath.section;
        
        NSString *strid =[NSString stringWithFormat:@"%@",[arrsection objectAtIndex:countsec]];
        arrtempdata =[[NSMutableArray alloc]init];
        
        arrtempdata =[[dictsection valueForKey:strid] mutableCopy];
        
        NSString *strpricecompare =[NSString stringWithFormat:@"%@",[[arrtempdata objectAtIndex:indexPath.row]valueForKey:@"price"]];
        
        int intpricecompare =[strpricecompare intValue];
        
        if (intpricecompare >0)
        {
            //NSString *strprice =[NSString stringWithFormat:@"%@ %@",[[arrtempdata objectAtIndex:indexPath.row]valueForKey:@"currency"],[[arrtempdata objectAtIndex:indexPath.row]valueForKey:@"price"]];
            
            NSString *strprice =[NSString stringWithFormat:@"(+ %@ %d)",[[arrtempdata objectAtIndex:indexPath.row]valueForKey:@"currency"],intpricecompare];
            
            cell2.lblprice.text =strprice;
        }
        
        else
        {
            cell2.lblprice.text =@"";
        }
        
        
        NSString *strname =[NSString stringWithFormat:@"%@",[[arrtempdata objectAtIndex:indexPath.row]valueForKey:@"name"]];
        
        cell2.lblmenutitle.text = strname;
        
        if ([[[arrtempdata objectAtIndex:indexPath.row]valueForKey:@"isclicked"] isEqualToString:@"yes"])
        {
            [cell2.imgmenucircle setImage:[UIImage imageNamed:@"greenCircle"]];
        }
        
        else
        {
            [cell2.imgmenucircle setImage:[UIImage imageNamed:@"grayCircle"]];
        }
        
        self.ChtTableSelection.constant = self.tblselection.contentSize.height;
        
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell2;
    }
    
//    else if(tableView == self.tblfree)
//    {
//        NSArray *nib;
//        NSString *tableIdentifier = @"cell2";
//        menudetailsCell *cell2 = (menudetailsCell *)[self.tblfree dequeueReusableCellWithIdentifier:@"cell2"];
//        
//        //  if (cell == nil) {
//        nib = [[NSBundle mainBundle] loadNibNamed:@"menudetailsCell" owner:self options:nil];
//        
//        cell2 =[[menudetailsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
//        
//        cell2 = [nib objectAtIndex:0];
//        
//        
//       // NSString *strprice =[NSString stringWithFormat:@"%@ %@",[[arrextra objectAtIndex:indexPath.row]valueForKey:@"currency"],[[arrextra objectAtIndex:indexPath.row]valueForKey:@"price"]];
//        
//        
//        NSString *strname =[NSString stringWithFormat:@"%@",[[arrfreeside objectAtIndex:indexPath.row]valueForKey:@"name"]];
//        
//        
//        
//        cell2.lblmenutitle.text = strname;
//        cell2.lblprice.text = @"";
//        
//        
//        if ([[[arrfreeside objectAtIndex:indexPath.row]valueForKey:@"isclicked"] isEqualToString:@"yes"]) {
//            [cell2.imgmenucircle setImage:[UIImage imageNamed:@"greenCircle"]];
//            
//        }
//        else{
//            
//            [cell2.imgmenucircle setImage:[UIImage imageNamed:@"grayCircle"]];
//            
//        }
//        
//        
//        return cell2;
//    }
//    
//    else if(tableView == self.tblextra)
//    {
//        NSArray *nib;
//        NSString *tableIdentifier = @"cell2";
//        menudetailsCell *cell2 = (menudetailsCell *)[self.tblfree dequeueReusableCellWithIdentifier:@"cell2"];
//        
//        //  if (cell == nil) {
//        nib = [[NSBundle mainBundle] loadNibNamed:@"menudetailsCell" owner:self options:nil];
//        
//        cell2 =[[menudetailsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell2"];
//        
//        cell2 = [nib objectAtIndex:0];
//        
//        
//        NSString *strprice =[NSString stringWithFormat:@"%@ %@",[[arrextra objectAtIndex:indexPath.row]valueForKey:@"currency"],[[arrextra objectAtIndex:indexPath.row]valueForKey:@"price"]];
//        
//        
//        NSString *strname =[NSString stringWithFormat:@"%@",[[arrextra objectAtIndex:indexPath.row]valueForKey:@"name"]];
//        
//        
//        
//        cell2.lblmenutitle.text = strname;
//         cell2.lblprice.text = strprice;
//        
//        
//        if ([[[arrextra objectAtIndex:indexPath.row]valueForKey:@"isclicked"] isEqualToString:@"yes"]) {
//            [cell2.imgmenucircle setImage:[UIImage imageNamed:@"greenCircle"]];
//            
//        }
//        else{
//            
//              [cell2.imgmenucircle setImage:[UIImage imageNamed:@"grayCircle"]];
//            
//        }
//        
//        
//        
//        
//        
//        
//        return cell2;
//    }
    
    return 0;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == _tblselection)
    {
        int sectioncount = (int) indexPath.section;
        
        NSString *strselect =[NSString stringWithFormat:@"%@",[arrsection objectAtIndex:sectioncount]];
        
        arrtempdata =[[NSMutableArray alloc]init];
        
        arrtempdata =[[dictsection valueForKey:strselect] mutableCopy];
        
        
        //            for (int i = 0; i<arrtempdata.count; i++) {
        //
        //                NSMutableDictionary *dictemp =[[NSMutableDictionary alloc]init];
        //
        //                dictemp = [[arrtempdata objectAtIndex:i] mutableCopy];
        //                [dictemp setObject:@"no" forKey:@"isclicked"];
        //
        //                [arrtempdata replaceObjectAtIndex:i withObject:dictemp];
        //
        //
        //
        //
        //            }
        //
        
        //  [arrtempdata replaceObjectAtIndex:i withObject:dictemp];
        
        
        if ([[[arrtempdata objectAtIndex:indexPath.row] valueForKey:@"isclicked"] isEqualToString:@"yes"])
        {
            NSString *strpricesingle =[NSString stringWithFormat:@"%@",[[arrtempdata objectAtIndex:indexPath.row]valueForKey:@"price"]];
            
            int temp = [strpricesingle intValue];
            
            if (totalprice > 0)
            {
                totalprice =totalprice - temp;
            }
            
            _lbltotalprice.text =[NSString stringWithFormat:@"AED %d",totalprice];
            
            [[arrtempdata objectAtIndex:indexPath.row]setObject:@"no" forKey:@"isclicked"];
        }
        
        else
        {
            for (int i = 0; i<arrtempdata.count; i++)
            {
                if ([[[arrtempdata objectAtIndex:i]valueForKey:@"isclicked"]isEqualToString:@"yes"])
                {
                    NSString *strpricesingle =[NSString stringWithFormat:@"%@",[[arrtempdata objectAtIndex:i]valueForKey:@"price"]];
                    
                    int temp = [strpricesingle intValue];
                    
                    if (totalprice >0)
                    {
                        totalprice =totalprice - temp;
                    }
                    
                    _lbltotalprice.text =[NSString stringWithFormat:@"AED %d",totalprice];
                }
                
                [[arrtempdata objectAtIndex:i]setObject:@"no" forKey:@"isclicked"];
            }
            
            
            NSString *strpricesingle = [NSString stringWithFormat:@"%@",[[arrtempdata objectAtIndex:indexPath.row] valueForKey:@"price"]];
            
            int temp = [strpricesingle intValue];
            
            totalprice =totalprice + temp;
            
            _lbltotalprice.text =[NSString stringWithFormat:@"AED %d",totalprice];
            
            [[arrtempdata objectAtIndex:indexPath.row]setObject:@"yes" forKey:@"isclicked"];
        }
        
        [dictsection setObject:arrtempdata forKey:strselect];
        
        
        // NSMutableArray *
        //            if ([[[arrextra objectAtIndex:indexPath.row] valueForKey:@"isclicked"] isEqualToString:@"yes"]) {
        //
        //
        //
        //                NSString *strpricesingle =[NSString stringWithFormat:@"%@",[[arrextra objectAtIndex:indexPath.row]valueForKey:@"price"]];
        //
        //                int temp = [strpricesingle intValue];
        //
        //                totalprice =totalprice - temp;
        //
        //                _lbltotalprice.text =[NSString stringWithFormat:@"AED %d",totalprice];
        //
        //                 [[arrextra objectAtIndex:indexPath.row]setObject:@"no" forKey:@"isclicked"];
        //            }
        //            else{
        //
        //                for (int i = 0; i<arrextra.count; i++) {
        //
        //                    NSString *strtotalprice =[NSString stringWithFormat:@"%@",[arrProduct valueForKey:@"price"]];
        //
        //                    totalprice =[strtotalprice intValue];
        //
        //                     [[arrextra objectAtIndex:i]setObject:@"no" forKey:@"isclicked"];
        //
        //                }
        //
        //
        //                NSString *strpricesingle =[NSString stringWithFormat:@"%@",[[arrextra objectAtIndex:indexPath.row]valueForKey:@"price"]];
        //
        //                int temp = [strpricesingle intValue];
        //
        //                totalprice =totalprice +temp;
        //                _lbltotalprice.text =[NSString stringWithFormat:@"AED %d",totalprice];
        //                 [[arrextra objectAtIndex:indexPath.row]setObject:@"yes" forKey:@"isclicked"];
        //            }
        //
        //
        
        // totalprice
        
        [_tblselection reloadData];
    }
    
    else if (tableView == _tbloffers)
    {
        if ([[[_arrgroup2 objectAtIndex:indexPath.row] valueForKey:@"isclicked"] isEqualToString:@"yes"])
        {
            for (int i = 0; i<_arrgroup2.count; i++)
            {
                NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
                
                dictet =[[_arrgroup2 objectAtIndex:i] mutableCopy];
                
                if (i == indexPath.row)
                {
                    [dictet setObject:@"yes" forKey:@"isclicked"];
                }
                
                else
                {
                    [dictet setObject:@"no" forKey:@"isclicked"];
                }
                
                [_arrgroup2 replaceObjectAtIndex:i withObject:dictet];
            }
            
            [_tbloffers reloadData];
        }
        
        else
        {
            for (int i = 0; i<_arrgroup2.count; i++)
            {
                NSMutableDictionary *dictet =[[NSMutableDictionary alloc]init];
                
                dictet =[[_arrgroup2 objectAtIndex:i] mutableCopy];
                
                if (i == indexPath.row)
                {
                    [dictet setObject:@"yes" forKey:@"isclicked"];
                }
                
                else
                {
                    [dictet setObject:@"no" forKey:@"isclicked"];
                }
                
                [_arrgroup2 replaceObjectAtIndex:i withObject:dictet];
            }
            
            [_tbloffers reloadData];
        }
    }
    
    
//    if(tableView == _tblextra)
//    {
//        if ([[[arrextra objectAtIndex:indexPath.row] valueForKey:@"isclicked"] isEqualToString:@"yes"]) {
//
//
//
//            NSString *strpricesingle =[NSString stringWithFormat:@"%@",[[arrextra objectAtIndex:indexPath.row]valueForKey:@"price"]];
//
//            int temp = [strpricesingle intValue];
//
//            totalprice =totalprice - temp;
//
//            _lbltotalprice.text =[NSString stringWithFormat:@"AED %d",totalprice];
//
//             [[arrextra objectAtIndex:indexPath.row]setObject:@"no" forKey:@"isclicked"];
//        }
//        else{
//
//            for (int i = 0; i<arrextra.count; i++) {
//
//                NSString *strtotalprice =[NSString stringWithFormat:@"%@",[arrProduct valueForKey:@"price"]];
//
//                totalprice =[strtotalprice intValue];
//
//                 [[arrextra objectAtIndex:i]setObject:@"no" forKey:@"isclicked"];
//
//            }
//
//
//            NSString *strpricesingle =[NSString stringWithFormat:@"%@",[[arrextra objectAtIndex:indexPath.row]valueForKey:@"price"]];
//
//            int temp = [strpricesingle intValue];
//
//            totalprice =totalprice +temp;
//            _lbltotalprice.text =[NSString stringWithFormat:@"AED %d",totalprice];
//             [[arrextra objectAtIndex:indexPath.row]setObject:@"yes" forKey:@"isclicked"];
//        }
//
//
//
//       // totalprice
//        [_tblextra reloadData];
//
//
//
//    }
//
//    else  if(tableView == _tblfree)
//    {
//        if ([[[arrfreeside objectAtIndex:indexPath.row] valueForKey:@"isclicked"] isEqualToString:@"yes"]) {
//            [[arrfreeside objectAtIndex:indexPath.row]setObject:@"no" forKey:@"isclicked"];
//        }
//        else{
//
//
//            for (int i = 0; i<arrfreeside.count; i++) {
//                [[arrfreeside objectAtIndex:i]setObject:@"no" forKey:@"isclicked"];
//            }
//
//            [[arrfreeside objectAtIndex:indexPath.row]setObject:@"yes" forKey:@"isclicked"];
//        }
//
//
//
//        [_tblfree reloadData];
//
//
//
//    }
    
    else if ([strCheck isEqualToString:@"option"])
    {
        self.lblbg.hidden=YES;
    }
    
    else if ([strCheck isEqualToString:@"addons"])
    {
        self.lblbg.hidden=YES;
    }
}




- (IBAction)btnnutritionclicked:(id)sender
{
    NutritionViewController *obj = [[NutritionViewController alloc]initWithNibName:@"NutritionViewController" bundle:nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.navigationController pushViewController:obj animated:YES];
}





#pragma mark <--Web Services-->


-(void)wsMenudetails
{
    BaseViewController *base=[[BaseViewController alloc]init];
    NSString *strBranchId = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"shopId"]];
    
    if ([strBranchId isEqualToString:@"(null)"])
    {
        strBranchId = @"";
    }
    
    else
    {
        
    }
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"request=%@&language=%@&itemID=%@&branchID=%@&key=%@&secret=%@",@"menu",@"en",self.getMenuid,strBranchId,str_key,str_secret];
    
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
                                        
                                        _viewaddcart.hidden = YES;
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
            [_stacksymbol removeArrangedSubview:_btnnutritionclicked];
            if([errorCode isEqualToString:@"1"])
            {
                arrfreeside = [[NSMutableArray alloc]init];
                arrextra = [[NSMutableArray alloc]init];
                
                [_stackkcal setHidden:NO];
                
                arrProduct=[dictionary valueForKey:@"item"];
                
                NSMutableArray *arrsymbols = [[NSMutableArray alloc]init];
                
                arrsymbols = [arrProduct valueForKey:@"symbols_images"];
                
                for (int k = 0; k<arrsymbols.count; k++)
                {
                    UIImageView *imgsymbol = [[UIImageView alloc] initWithFrame:_btnnutritionclicked.frame];
                    
                    NSString *strimg = [arrsymbols objectAtIndex:k];
                    
                    NSURL *url = [NSURL URLWithString:strimg];
                    
                    [imgsymbol setImageWithURL:url];
                    
                    [imgsymbol setContentMode:UIViewContentModeScaleAspectFill];
                    
                    [_stacksymbol addArrangedSubview:imgsymbol];
                    
                    if(screenHeight > 800)
                    {
                        [_stacksymbol setSpacing:13.0f];
                    }
                    
                    else
                    {
                        [_stacksymbol setSpacing:7.0f];
                    }
                }
                
                [_stacksymbol addArrangedSubview:_btnnutritionclicked];
                
                
                NSDictionary *dictoption =[[NSDictionary alloc]init];
                
                if ([arrProduct valueForKey:@"options"])
                {
                    dictoption =[[arrProduct valueForKey:@"options"] mutableCopy];
                }
                
                self.lblName2.text=[arrProduct valueForKey:@"name"];
                self.lblDescription.text=[arrProduct valueForKey:@"shortDescription"];
                self.lblKcal.text=[NSString stringWithFormat:@"%@,",[arrProduct valueForKey:@"kcal"]];
                self.lblCarbs.text=[NSString stringWithFormat:@"%@g,",[arrProduct valueForKey:@"carbs"]];
                self.lblFat.text=[NSString stringWithFormat:@"%@g,",[arrProduct valueForKey:@"fat"]];
                self.lblPro.text=[NSString stringWithFormat:@"%@g",[arrProduct valueForKey:@"pro"]];
                
                NSString *strprices =[NSString stringWithFormat:@"%@",[arrProduct valueForKey:@"price"]];
                
                int intprices =[strprices intValue];
                
                _lblprice.text =[NSString stringWithFormat:@"AED %d",intprices];
                
                NSString *strtotalprice =[NSString stringWithFormat:@"%@",[arrProduct valueForKey:@"price"]];
                
                totalprice =[strtotalprice intValue];
                
                _lbltotalprice.text =[NSString stringWithFormat:@"AED %d",totalprice];
                
                NSString *strnewimg =[NSString stringWithFormat:@"%@",[arrProduct valueForKey:@"new"]];
                
                NSString *stroutOfStockimg =[NSString stringWithFormat:@"%@",[arrProduct valueForKey:@"outOfStock"]];
                
                NSString *strpopular_itemimg =[NSString stringWithFormat:@"%@",[arrProduct valueForKey:@"popular_item"]];
                
                
                if ([strnewimg isEqualToString:@"Y"])
                {
                    [_imgnew setHidden:YES];
                }
                
                else
                {
                    [_imgnew setHidden:YES];
                }
                
                
                
                if ([stroutOfStockimg isEqualToString:@"Y"])
                {
                    _lblOutofStock.hidden = NO;
                    _btnaddtocart.hidden = YES;
                    [_imgsoldout setHidden:YES];
                }
                
                else
                {
                    _lblOutofStock.hidden = YES;
                    _btnaddtocart.hidden = NO;
                    [_imgsoldout setHidden:YES];
                }
                
                
                
                if ([strpopular_itemimg isEqualToString:@"Y"])
                {
                    [_imgpopular setHidden:YES];
                }
                
                else
                {
                    [_imgpopular setHidden:YES];
                }
                
                
                NSArray *arrNeutrition=[arrProduct valueForKey:@"nutritional_facts"];
                
                
                
                NSArray *arrvitamins=[arrProduct valueForKey:@"vitamins"];
                
                NSMutableDictionary *dictaddon = [[NSMutableDictionary alloc]init];
                
                dictaddon = [[[arrProduct valueForKey:@"options"] valueForKey:@"addon"] mutableCopy];
                
                arrAddons=[[dictaddon valueForKey:@"options"] mutableCopy];
                
                //arrAddons=[[arrProduct valueForKey:@"options"] valueForKey:@"addon"];
                
                dictsection =[[arrProduct valueForKey:@"options"] mutableCopy];
                
                NSMutableArray *arrcompare = [[NSMutableArray alloc]init];
                
                arrcompare = [[arrProduct valueForKey:@"option_compare"] mutableCopy];
                
                arrsection = arrcompare;
                
                //arrsection =[[dictsection allKeys] mutableCopy];
                sectiontemp = (int) arrsection.count;
                arrtempdata =[[NSMutableArray alloc]init];
                
                for (int k = 0; k<arrsection.count; k++)
                {
                    NSString *strehjwg=[arrsection objectAtIndex:k];
                    
                    //NSMutableArray *arrtemp1 =[[dictsection valueForKey:strehjwg] mutableCopy];
                    
                    NSMutableDictionary *dictdish = [[NSMutableDictionary alloc]init];
                    
                    dictdish = [[dictsection valueForKey:strehjwg] mutableCopy];
                    
                    [arrheader addObject: [dictdish valueForKey:@"name"]];
                    
                    NSMutableArray *arrtemp1 =[[dictdish valueForKey:@"options"] mutableCopy];
                    
                    for (int i = 0; i<arrtemp1.count; i++)
                    {
                        NSMutableDictionary *dictemp =[[NSMutableDictionary alloc]init];
                        
                        dictemp = [[arrtemp1 objectAtIndex:i] mutableCopy];
                        
                        [dictemp setObject:@"no" forKey:@"isclicked"];
                        
                        [arrtemp1 replaceObjectAtIndex:i withObject:dictemp];
                    }
                    
                    [dictsection setObject:arrtemp1 forKey:strehjwg];
                }
                
                [_tblselection reloadData];
                
                
                if (dictsection.count > 0)
                {
                    _lblline.hidden = NO;
                }

                else
                {
                    _lblline.hidden = YES;
                }
                
                
                //  arrOptions=[[arrProduct valueForKey:@"options"] valueForKey:@"option"];
                
                arrList=[[NSMutableArray alloc]init];
                
                
                
                for (int i=0; i<arrAddons.count; i++)
                {
                    NSString *eg =[NSString stringWithFormat:@"%@",[[arrAddons objectAtIndex:i] valueForKey:@"symbols"]];
                    
                    if ([eg isEqualToString:@"0"])
                    {
                        
                    }
                    
                    else
                    {
                        [arrList addObject:[arrAddons objectAtIndex:i]];
                    }
                }
                
                
                
                for (int i=0; i<arrOptions.count; i++)
                {
                    NSString *eg =[NSString stringWithFormat:@"%@",[[arrOptions objectAtIndex:i] valueForKey:@"symbols"]];
                    
                    if ([eg isEqualToString:@"0"])
                    {
                        
                    }
                    
                    else
                    {
                        [arrList addObject:[arrOptions objectAtIndex:i]];
                    }
                }
                
                
                
                for (int i =0; i<arrNeutrition.count; i++)
                {
                    NSString *strcondn =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"name"]];
                    
                    
                    if ([strcondn isEqualToString:@"Kilo Calories"])
                    {
                        NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
                        NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
                        
                        _lblKiloCalories.text = strvalue;
                        _lblkilocalpercent.text = strdaily_value;
                    }
                    
                    else if ([strcondn isEqualToString:@"Fat Calories"])
                    {
                        NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
                        NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
                        
                        _lblFatCalories.text = strvalue;
                        _lblfatpercent.text = strdaily_value;
                    }
                    
                    else if ([strcondn isEqualToString:@"Total fat"])
                    {
                        NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
                        NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
                        
                        _lblZTotalfat.text = strvalue;
                        _lbltotalfatpercent.text = strdaily_value;
                    }
                    
                    else if ([strcondn isEqualToString:@"Saturated Fat"])
                    {
                        NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
                        NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
                        
                        _lblSaturatedfat.text = strvalue;
                        _lblsatfatpercent.text = strdaily_value;
                    }
                    
                    else if ([strcondn isEqualToString:@"Trans. Fat"])
                    {
                        NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
                        NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
                        
                        _lblTransfat.text = strvalue;
                        _lbltransfatpercent.text = strdaily_value;
                    }
                    
                    else if ([strcondn isEqualToString:@"Mono unsat. Fat"])
                    {
                        NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
                        NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
                        
                        _lblmonosatfat.text = strvalue;
                        _lblmonofatpercent.text = strdaily_value;
                    }
                    
                    else if ([strcondn isEqualToString:@"Poly unsat. Fat"])
                    {
                        NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
                        NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
                        
                        _lblpolysatfat.text = strvalue;
                        _lblpolyfatpercent.text = strdaily_value;
                    }
                    
                    else if ([strcondn isEqualToString:@"Cholesterol"])
                    {
                        NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
                        NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
                        
                        _lblCholestrol.text = strvalue;
                        _lblcholestrolpercent.text = strdaily_value;
                    }
                    
                    else if ([strcondn isEqualToString:@"Sodium"])
                    {
                        NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
                        NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
                        
                        _lblSodium.text = strvalue;
                        _lblsodiumpercent.text = strdaily_value;
                    }
                    
                    else if ([strcondn isEqualToString:@"Potassium"])
                    {
                        NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
                        NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
                        
                        _lblPotassium.text = strvalue;
                        _lblpotassiumpercent.text = strdaily_value;
                    }
                    
                    else if ([strcondn isEqualToString:@"Total Carbs"])
                    {
                        NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
                        NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
                        
                        _lbltotalcarbs.text = strvalue;
                        _lbltotalcarbpercent.text = strdaily_value;
                    }
                    
                    else if ([strcondn isEqualToString:@"Dietary Fiber"])
                    {
                        NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
                        NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
                        
                        _lblDietryFiber.text = strvalue;
                        _lbldietrypercent.text = strdaily_value;
                    }
                    
                    else if ([strcondn isEqualToString:@"Sugars"])
                    {
                        NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
                        NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
                        
                        _lblsuger.text = strvalue;
                        _lblsugarpercent.text = strdaily_value;
                    }
                    
                    else if ([strcondn isEqualToString:@"Protein"])
                    {
                        NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"value"]];
                        NSString *strdaily_value =[NSString stringWithFormat:@"%@",[[arrNeutrition objectAtIndex:i]valueForKey:@"daily_value"]];
                        
                        _lblProtien.text = strvalue;
                        _lblprotienpercent.text = strdaily_value;
                    }
                }
                
                
                for (int i = 0; i<arrvitamins.count; i++)
                {
                    NSString *strcondn =[NSString stringWithFormat:@"%@",[[arrvitamins objectAtIndex:i]valueForKey:@"name"]];
                    
                    
                    if ([strcondn isEqualToString:@"Vitamin A"])
                    {
                        NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrvitamins objectAtIndex:i]valueForKey:@"value"]];
                        _lblVitaminAval.text = strvalue;
                    }
                    
                    else if ([strcondn isEqualToString:@"Vitamin C"])
                    {
                        NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrvitamins objectAtIndex:i]valueForKey:@"value"]];
                        _lblVitaminCval.text = strvalue;
                    }
                    
                    else if ([strcondn isEqualToString:@"Calcium"])
                    {
                        NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrvitamins objectAtIndex:i]valueForKey:@"value"]];
                        _lblcalciumval.text = strvalue;
                    }
                    
                    else if ([strcondn isEqualToString:@"Iron"])
                    {
                        NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrvitamins objectAtIndex:i]valueForKey:@"value"]];
                        _lblironval.text = strvalue;
                    }
                    
                    else if ([strcondn isEqualToString:@"Thiamin"])
                    {
                        NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrvitamins objectAtIndex:i]valueForKey:@"value"]];
                        _lblthiminval.text = strvalue;
                    }
                    
                    else if ([strcondn isEqualToString:@"Vitamin B6"])
                    {
                        NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrvitamins objectAtIndex:i]valueForKey:@"value"]];
                        _lblvitaminval.text = strvalue;
                    }
                    
                    else if ([strcondn isEqualToString:@"Phosphorous"])
                    {
                        NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrvitamins objectAtIndex:i]valueForKey:@"value"]];
                        _lblPhosphorousval.text = strvalue;
                    }
                    
                    else if ([strcondn isEqualToString:@"Magnesium"])
                    {
                        NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrvitamins objectAtIndex:i]valueForKey:@"value"]];
                        _lblmagnesiumval.text = strvalue;
                    }
                    
                    else if ([strcondn isEqualToString:@"Copper"])
                    {
                        NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrvitamins objectAtIndex:i]valueForKey:@"value"]];
                        _lblcopperval.text = strvalue;
                    }
                    
                    else if ([strcondn isEqualToString:@"Manganese"])
                    {
                        NSString *strvalue =[NSString stringWithFormat:@"%@",[[arrvitamins objectAtIndex:i]valueForKey:@"value"]];
                        _lblmanganeseval.text = strvalue;
                    }
                }
                

                
                
                NSArray *arroptions=[[NSArray alloc]init];
                
                if ([dictoption valueForKey:@"sidedish2"])
                {
                    NSDictionary *dictside = [[NSDictionary alloc]init];
                    
                    dictside = [[dictoption valueForKey:@"sidedish2"] mutableCopy];
                    
                    //arroptions = [dictoption valueForKey:@"sidedish2"];
                    
                    arroptions = [[dictside valueForKey:@"options"] mutableCopy];
                    
                    strCheck = @"option";
                    arrOptions  = arroptions;
                }
                
                
                if (arrOptions.count > 0)
                {
                    _lblsideoptions.hidden = NO;
                }
                
                else
                {
                    _lblsideoptions.hidden = YES;
                    _sideoptiontop.constant = 0;
                    _lblsideoptionheight.constant = 0;
                }
                
                
                if ([dictoption valueForKey:@"sidedish2"])
                {
                    NSDictionary *dictside = [[NSDictionary alloc]init];
                    
                    dictside = [[dictoption valueForKey:@"sidedish2"] mutableCopy];
                    
                    //NSMutableArray *arrtemp =[[dictoption valueForKey:@"sidedish2"] mutableCopy];
                    
                    NSMutableArray *arrtemp =[[dictside valueForKey:@"options"] mutableCopy];
                    
                    for (int i = 0; i<arrtemp.count; i++)
                    {
                        NSMutableDictionary *dictemp =[[NSMutableDictionary alloc]init];
                        
                        dictemp = [[arrtemp objectAtIndex:i] mutableCopy];
                        [dictemp setObject:@"no" forKey:@"isclicked"];
                        
                        [arrtemp replaceObjectAtIndex:i withObject:dictemp];
                    }
                    
                    arrextra = [[NSMutableArray alloc]init];
                    
                    arrextra = arrtemp;
                    
//                    [_tblextra reloadData];
//                    self.tblextraheight.constant = self.tblextra.contentSize.height;
                }
                
                
                
                if ([dictoption valueForKey:@"sidedish"])
                {
                    NSDictionary *dictside = [[NSDictionary alloc]init];
                    
                    dictside = [[dictoption valueForKey:@"sidedish"] mutableCopy];
                    
                    //NSMutableArray *arrtemp =[[dictoption valueForKey:@"sidedish"] mutableCopy];
                    
                    NSMutableArray *arrtemp =[[dictside valueForKey:@"options"] mutableCopy];
                    
                    for (int i = 0; i<arrtemp.count; i++)
                    {
                        NSMutableDictionary *dictemp =[[NSMutableDictionary alloc]init];
                        
                        dictemp = [[arrtemp objectAtIndex:i] mutableCopy];
                        [dictemp setObject:@"no" forKey:@"isclicked"];
                        
                        [arrtemp replaceObjectAtIndex:i withObject:dictemp];
                    }
                    
                    arrfreeside = [[NSMutableArray alloc]init];
                    
                    arrfreeside = arrtemp;
                   
                    [_tblfree reloadData];
                    self.tblfreeheight.constant = self.tblfree.contentSize.height;
                }
                
                
                NSString *strimg = [NSString stringWithFormat:@"%@",[[arrProduct  valueForKey:@"images"] valueForKey:@"normal"]];
                
                NSURL *url = [NSURL URLWithString:strimg];
                
                SDImageCache *cache = [SDImageCache sharedImageCache];
                [cache clearMemory];
                [cache clearDiskOnCompletion:nil];
                [cache removeImageForKey:strimg fromDisk:YES withCompletion:nil];
                
                //NSData *data = [NSData dataWithContentsOfURL:url];
                
                //self.img.image = [UIImage imageWithData:data];
                
                [self.img sd_setImageWithURL:url
                                   placeholderImage:[UIImage imageNamed:@""] options:SDWebImageRefreshCached];
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




- (IBAction)btnaddtocart:(id)sender
{
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    NSString *status=[defaults valueForKey:@"status"];
    
    if ([status isEqualToString:@"login"])
    {
        NSMutableArray *arraddtocart =[[NSMutableArray alloc]init];
        
        NSMutableDictionary *dicttemps =[[NSMutableDictionary alloc]init];
        
        for (int i =0; i<arrsection.count; i++)
        {
            NSString *strtitle =[NSString stringWithFormat:@"%@",[arrsection objectAtIndex:i]];
            
            NSMutableArray *arrdata =[[NSMutableArray alloc]init];
            
            arrdata =[[dictsection valueForKey:strtitle] mutableCopy];
            
            NSMutableArray *arrtemp;
            
            arrtemp=[[NSMutableArray alloc]init];
            
            for (int i = 0; i<arrdata.count; i++)
            {
                if ([[[arrdata objectAtIndex:i]valueForKey:@"isclicked"]isEqualToString:@"yes"])
                {
                    [arrtemp addObject:[arrdata objectAtIndex:i]];
                }
            }
            
            [dicttemps setObject:arrtemp forKey:strtitle];
        }
        
        
        
        
        if ([_weeklyorder isEqualToString:@"yes"])
        {
            NSData *dataarraddtocart = [[NSUserDefaults standardUserDefaults]valueForKey:@"weeklyorderarray"];
            
            if (!(dataarraddtocart == nil))
            {
                arraddtocart=[[NSKeyedUnarchiver unarchiveObjectWithData:dataarraddtocart] mutableCopy];
            }
            
            NSMutableDictionary *dicttemp =[[NSMutableDictionary alloc]init];
            
            NSMutableDictionary *dicttemptotal =[[NSMutableDictionary alloc]init];
            
            NSMutableArray *arrtemp =[[NSMutableArray alloc]init];
            
            for (int i =0; i<arraddtocart.count; i++)
            {
                if ([[[arraddtocart objectAtIndex:i]valueForKey:@"isclicked"]isEqualToString:@"yes"])
                {
                    arrtemp =[[[arraddtocart objectAtIndex:i]valueForKey:@"products"] mutableCopy];
                    
                    dicttemptotal =[[arraddtocart objectAtIndex:i] mutableCopy];
                    
                    [dicttemp setObject:dicttemps forKey:@"options"];
                    
                    [dicttemp setObject:[NSString stringWithFormat:@"%d", totalprice] forKey:@"totalprice"];
                    
                    [dicttemp setObject:[NSString stringWithFormat:@"%d", totalprice] forKey:@"primaryprice"];
                    
                    [dicttemp setObject:@"1" forKey:@"quantity"];
                    
                    [dicttemp setObject:[arrProduct valueForKey:@"name"] forKey:@"name"];
                    
                    [dicttemp setObject:[arrProduct valueForKey:@"itemID"] forKey:@"itemID"];
                    
                    [arrtemp addObject:dicttemp];
                    
                    [dicttemptotal setObject:arrtemp forKey:@"products"];
                    
                    [arraddtocart replaceObjectAtIndex:i withObject:dicttemptotal];
                }
            }
            
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arraddtocart];
            
            [[NSUserDefaults standardUserDefaults] setValue:data forKey:@"weeklyorderarray"];
        }
        
        else
        {
            NSData *dataarraddtocart = [[NSUserDefaults standardUserDefaults]valueForKey:@"arrayaddtocart"];
            
            if (!(dataarraddtocart == nil))
            {
                arraddtocart=[[NSKeyedUnarchiver unarchiveObjectWithData:dataarraddtocart] mutableCopy];
            }
            
            if (arraddtocart.count == 0)
            {
                NSMutableDictionary *dicttemp =[[NSMutableDictionary alloc]init];
                
                [dicttemp setObject:dicttemps forKey:@"options"];
                
                [dicttemp setObject:[NSString stringWithFormat:@"%d", totalprice] forKey:@"totalprice"];
                
                [dicttemp setObject:@"1" forKey:@"quantity"];
                
                [dicttemp setObject:[arrProduct valueForKey:@"name"] forKey:@"name"];
                
                [dicttemp setObject:[arrProduct valueForKey:@"itemID"] forKey:@"itemID"];
                
                [dicttemp setObject:strrandom forKey:@"random_no"];
                
                if (arrtempoffer.count > 0)
                {
                    NSMutableArray *arroffer =[[NSMutableArray alloc]init];
                    
                    NSData *dataarrayoffer =[[NSUserDefaults standardUserDefaults] valueForKey:@"arrayoffer"];
                    
                    if (!(dataarrayoffer.bytes == 0))
                    {
                        arroffer=[[NSKeyedUnarchiver unarchiveObjectWithData:dataarrayoffer] mutableCopy];
                    }
                    
                    [arroffer addObject:dictoffer];
                    
                    NSData *dataoffer = [NSKeyedArchiver archivedDataWithRootObject:arroffer];
                    
                    [[NSUserDefaults standardUserDefaults] setValue:dataoffer forKey:@"arrayoffer"];
                    
                    [dictoffer setObject:[[arrtempoffer objectAtIndex:0] valueForKey:@"name"] forKey:@"name"];
                }
                
                
                [dicttemp setObject:dictoffer forKey:@"promo"];
                
                NSMutableArray *arrttotal =[[NSMutableArray alloc]init];
                
                [arrttotal addObject:dicttemp];
                
                NSArray *arrmedian =[[NSArray alloc]init];
                
                arrmedian = arrttotal;
                
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrmedian];
                
                [[NSUserDefaults standardUserDefaults] setValue:data forKey:@"arrayaddtocart"];
            }
            
            else
            {
                NSMutableDictionary *dicttemp =[[NSMutableDictionary alloc]init];
                
                [dicttemp setObject:dicttemps forKey:@"options"];
                
                [dicttemp setObject:[NSString stringWithFormat:@"%d", totalprice] forKey:@"totalprice"];
                
                [dicttemp setObject:@"1" forKey:@"quantity"];
                
                [dicttemp setObject:[arrProduct valueForKey:@"name"] forKey:@"name"];
                
                [dicttemp setObject:[arrProduct valueForKey:@"itemID"] forKey:@"itemID"];
                
                [dicttemp setObject:strrandom forKey:@"random_no"];
                
                if (arrtempoffer.count > 0)
                {
                    NSMutableArray *arroffer =[[NSMutableArray alloc]init];
                    
                    NSData *dataarrayoffer =[[NSUserDefaults standardUserDefaults] valueForKey:@"arrayoffer"];
                    
                    if (!(dataarrayoffer.bytes == 0))
                    {
                        arroffer=[[NSKeyedUnarchiver unarchiveObjectWithData:dataarrayoffer] mutableCopy];
                    }
                    
                    [arroffer addObject:dictoffer];
                    
                    NSData *dataoffer = [NSKeyedArchiver archivedDataWithRootObject:arroffer];
                    
                    [[NSUserDefaults standardUserDefaults] setValue:dataoffer forKey:@"arrayoffer"];
                    
                    [dictoffer setObject:[[arrtempoffer objectAtIndex:0] valueForKey:@"name"] forKey:@"name"];
                }
                
                [dicttemp setObject:dictoffer forKey:@"promo"];
                
                [arraddtocart addObject:dicttemp];
                
                NSArray *arrmedian =[[NSArray alloc]init];
                
                arrmedian = arraddtocart;
                
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arrmedian];
                
                [[NSUserDefaults standardUserDefaults] setValue:data forKey:@"arrayaddtocart"];
            }
        }
        
//        MenuViewController *menu =[[MenuViewController alloc]init];
//
//        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
//
//        [self.navigationController pushViewController:menu animated:YES];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    else
    {
        LoViewController *obj=[[LoViewController alloc]initWithNibName:@"LoViewController" bundle:nil];
        
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        
        [self.navigationController pushViewController:obj animated:YES];
    }
}




- (IBAction)btnclose:(id)sender
{
    flag=@"true";
    [_btnvitamindetail setImage:[UIImage imageNamed:@"INFO_OFF"] forState:UIControlStateNormal];
    _viewdescriptionHeight.constant=0.0f;
    self.viewdescriptiondetail.hidden=YES;
    //self.imghighProtine.hidden=YES;
}




@end

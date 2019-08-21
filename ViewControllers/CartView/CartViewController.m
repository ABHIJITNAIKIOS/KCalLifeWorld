//
//  CartViewController.m
//  KCal
//
//  Created by Pipl-06 on 24/07/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "CartViewController.h"
#import "SubViewextraTableViewCell.h"
#import "MenuViewController.h"
#import "CheckoutViewController.h"
#import "GiFHUD.h"
#import "BaseViewController.h"
#import "AppDelegate.h"
#import "paymentMethodViewController.h"
#import "OrderHistoryController.h"

@interface CartViewController ()
{
    NSMutableArray *arroptions;
    NSMutableDictionary *dictoptions;
    int index, countint;
    NSMutableArray *arrtemp;
    NSMutableArray *arritemsdata, *arrselected;
    int count, delete;
    NSString *strcutlery;
    NSString *strdiscountprices;
    NSMutableArray *menuselected;
    NSMutableArray *arrdays;
    SubViewextraTableViewCell *cell1;
    int lines;
    int finalsubtotal;
    NSMutableArray *arroffers;
    NSMutableArray *arr;
    NSMutableArray *arrpromotionitems;
    NSString *strname;
    NSString *strid;
    NSString *strgroupname;
    int min_total;
}

@end

@implementation CartViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbtn.frame = CGRectMake(12, 15, 18, 18);
    [leftbtn setBackgroundImage:[UIImage imageNamed:@"white_left"] forState:UIControlStateNormal];
    leftbtn.tag=225;
    
    [leftbtn addTarget:self action:@selector(back)
      forControlEvents:UIControlEventTouchUpInside];
    
    [self.navigationController.navigationBar addSubview:leftbtn];
    
    self.title = @"My Cart";
    
    arrdays = [[NSMutableArray alloc]init];
    
    self.navigationItem.hidesBackButton = YES;
    
    [GiFHUD setGifWithImageName:@"Spinner3.gif"];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissblurpromo)];
    
    [self.lblblurpromo addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissblurcomment)];
    
    [self.lblblurcomment addGestureRecognizer:tap2];
    
    self.btnselectpaymentmethod.hidden = NO;
    self.btnpromo.hidden = NO;
    self.btnaddPromocode.hidden = NO;
    _txtcommentdata.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"cartcomment"];
    
    index = 0;
    strcutlery = @"";
    countint = 0;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissTableView)];
    
    [self.viewblur addGestureRecognizer:tap];
    
    _txtcommentdata.layer.cornerRadius = 5;
    _txtcommentdata.layer.borderWidth=1.0f;
    _txtcommentdata.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _txtcommentdata.clipsToBounds = YES;
    
    _viewpromocode.hidden=NO;
    self.TopOfviewafterpromocode.active=YES;
    
    self.viewafterpomocode.hidden=YES;
    self.TopOfviewafterpromocode.active=NO;
    
    [_viewblur setHidden:YES];
    //  [self.view addSubview:_tempview];
    [_viewaddqty setHidden:YES];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"cartcomment"];
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"cutlery_selected"];
    
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
    
    [self.view addSubview:_viewEnterPromocode];
    [self.view addSubview:_viewcomment];
    [self.view addSubview:_tempview];
    _tempview.hidden=YES;
    _viewcomment.hidden=YES;
    _viewEnterPromocode.hidden=YES;
    
    arritemsdata =[[NSMutableArray alloc]init];
    
    NSData *dataarraddtocart =[[NSUserDefaults standardUserDefaults] valueForKey:@"arrayaddtocart"];
    
    if (!(dataarraddtocart == nil))
    {
        arritemsdata=[[NSKeyedUnarchiver unarchiveObjectWithData:dataarraddtocart] mutableCopy];
    }
    
    min_total = 0;
    
    for (int i = 0; i<arritemsdata.count; i++)
    {
        NSString *sgf = [NSString stringWithFormat:@"%@",[[arritemsdata objectAtIndex:i]valueForKey:@"totalprice"]];
        int tempint = [sgf intValue];
        min_total = min_total + tempint;
    }
    
    
    
    if ([_strreorder isEqualToString:@"yes"])
    {
        finalsubtotal = 0;
        
        for (int i =0; i<arritemsdata.count; i++)
        {
            NSString *strsubtotal =[NSString stringWithFormat:@"%@",[[arritemsdata objectAtIndex:i] valueForKey:@"totalprice"]];
            int intsubtotal =[strsubtotal intValue];
            
            finalsubtotal = finalsubtotal + intsubtotal;
        }
        
        _lblsubtotalprice.text =[NSString stringWithFormat:@"AED %d.00", finalsubtotal];
        
        finalsubtotal = finalsubtotal + 5;
        
        _lbltotalprice.text =[NSString stringWithFormat:@"AED %d.00", finalsubtotal];
        _lbltotalprice1.text =[NSString stringWithFormat:@"AED %d.00", finalsubtotal];
        [_tblitems reloadData];
        self.tblitemHeight.constant= _tblitems.contentSize.height;
    }
    
    else
    {
        if (arritemsdata.count >0)
        {
            NSMutableArray *arrtemprorary;
            
            for (int i =0; i<arritemsdata.count; i++)
            {
                dictoptions =[[[arritemsdata objectAtIndex:i] valueForKey:@"options"] mutableCopy];
                NSMutableDictionary *dicttin =[[NSMutableDictionary alloc]init];
                
                dicttin =[[arritemsdata objectAtIndex:i] mutableCopy];
                
                arrtemp =[[NSMutableArray alloc]init];
                arrtemprorary =[[NSMutableArray alloc]init];
                arrtemp =[[dictoptions allKeys] mutableCopy];
                
                for (int i =0; i<arrtemp.count; i++)
                {
                    NSMutableArray *arrsecond =[[NSMutableArray alloc]init];
                    
                    arrsecond = [[dictoptions valueForKey:[arrtemp objectAtIndex:i]] mutableCopy];
                    NSString *strtemp =[NSString stringWithFormat:@"%@",[[arrtemp objectAtIndex:i]mutableCopy]];
                    
                    for (int k = 0; k<arrsecond.count; k++)
                    {
                        NSMutableDictionary *dictte =[[NSMutableDictionary alloc]init];
                        
                        dictte = [[arrsecond objectAtIndex:k] mutableCopy];
                        
                        [dictte setObject:strtemp forKey:@"nameofarray"];
                        
                        [arrtemprorary addObject:dictte];
                    }
                }
                
                [dicttin setObject:arrtemprorary forKey:@"arrcustom"];
                
                [arritemsdata replaceObjectAtIndex:i withObject:dicttin];
            }
            
            
            for (int i =0; i<arritemsdata.count; i++)
            {
                NSMutableDictionary *dictte=[[NSMutableDictionary alloc]init];
                dictte =[[arritemsdata objectAtIndex:i] mutableCopy];
                NSString *strsubtotal =[NSString stringWithFormat:@"%@",[[arritemsdata objectAtIndex:i]valueForKey:@"totalprice"]];
                
                [dictte setObject:strsubtotal forKey:@"totalprice"];
                [arritemsdata replaceObjectAtIndex:i withObject:dictte];
            }
            
            
            finalsubtotal = 0;
            
            for (int i =0; i<arritemsdata.count; i++)
            {
                NSString *strsubtotal =[NSString stringWithFormat:@"%@",[[arritemsdata objectAtIndex:i]valueForKey:@"totalprice"]];
                int intsubtotal =[strsubtotal intValue];
                
                finalsubtotal = finalsubtotal + intsubtotal;
            }
            
            
            _lblsubtotalprice.text =[NSString stringWithFormat:@"AED %d.00", finalsubtotal];
            
            finalsubtotal = finalsubtotal +5;
            
            _lbltotalprice.text =[NSString stringWithFormat:@"AED %d.00", finalsubtotal];
            _lbltotalprice1.text =[NSString stringWithFormat:@"AED %d.00", finalsubtotal];
            [_tblitems reloadData];
            
            self.tblitemHeight.constant= _tblitems.contentSize.height;
        }
    }
    
    
    [GiFHUD showWithOverlay];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self wsloyaltycode];
        
    });
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
    [[NSUserDefaults standardUserDefaults]setObject:_txtcommentdata.text forKey:@"cartcomment"];
}




-(void)back
{
    if ([_strreorder isEqualToString:@"yes"])
    {
        OrderHistoryController *obj=[[OrderHistoryController alloc]initWithNibName:@"OrderHistoryController" bundle:nil];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
    
    else
    {
        MenuViewController *obj=[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
        [self.navigationController pushViewController:obj animated:YES];
    }
}





-(void)dismissTableView
{
    [self.view endEditing:YES];
    
    self.viewblur.hidden = YES;
    self.viewaddqty.hidden = YES;
}





//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    NSArray *arrextra =[[arritemsdata objectAtIndex:indexPath.row]valueForKey:@"extra"];
//    
//    
//    NSArray *arrfree =[[arritemsdata objectAtIndex:indexPath.row]valueForKey:@"free"];
//    
//    
//    if (arrfree.count >0 || arrextra.count >0) {
//        
//           return 151.0f;
//    }
//    else{
//        
//        return 37;
//    }
//    
// 
//}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if(tableView == _tblselectmenu)
    {
        return 1;
    }
    
    else
    {
        return arritemsdata.count;
    }
    
    return 0;
}




- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(tableView == _tblselectmenu)
    {
        
    }
    
    else
    {
        UIView *viewheader =[[UIView alloc]init];
        
        UIButton *btnqty =[[UIButton alloc]init];
        [btnqty setTitle:[NSString stringWithFormat:@"%@x",[[arritemsdata objectAtIndex:section]valueForKey:@"quantity"]] forState:UIControlStateNormal];
        [btnqty setFrame:CGRectMake(8, 0, 25, 25)];
        btnqty.titleLabel.font =[UIFont fontWithName:@"AvenirNext-Regular" size:13];
        //  [lblname setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:13]];
        //lblname.textColor =[UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:110.0/255.0 alpha:1.0f];
        [btnqty setTitleColor:[UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1.0f] forState:UIControlStateNormal];
        btnqty.tag = section;
        [btnqty addTarget:self action:@selector(btnchangeqty:) forControlEvents:UIControlEventTouchUpInside];
        [viewheader addSubview:btnqty];
        
        
        
        UILabel *lblname =[[UILabel alloc]init];
        //  [lblname sizeToFit];
        
        if ([[[arritemsdata objectAtIndex:section] valueForKey:@"promo"] valueForKey:@"name"])
        {
            lblname.text =[NSString stringWithFormat:@"%@ + %@",[[arritemsdata objectAtIndex:section] valueForKey:@"name"],[[[arritemsdata objectAtIndex:section] valueForKey:@"promo"] valueForKey:@"name"]];
            
            self.btnpromo.hidden = YES;
            self.btnaddPromocode.hidden = YES;
        }
        
        else
        {
            lblname.text = [NSString stringWithFormat:@"%@",[[arritemsdata objectAtIndex:section] valueForKey:@"name"]];
        }
        
        
        [lblname setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:13]];
        lblname.textColor =[UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:110.0/255.0 alpha:1.0f];
        
        lines = [lblname.text sizeWithFont:[UIFont fontWithName:@"AvenirNext-Regular" size:13]
                             constrainedToSize:CGSizeMake(185, 36)
                                 lineBreakMode:NSLineBreakByCharWrapping].height/13;
        
//        NSAttributedString *attributedText =
//        [[NSAttributedString alloc]
//         initWithString:lblname.text
//         attributes:@
//         {
//         NSFontAttributeName: [UIFont fontWithName:@"AvenirNext-Regular" size:13]
//         }];
//
//        CGRect rect = [attributedText boundingRectWithSize:CGSizeMake(185, 36)
//                                                   options:NSLineBreakByCharWrapping
//                                                   context:nil];
//        CGSize size = rect.size;
        
        
        
        lblname.numberOfLines=lines;
        
        
        if(lines >1)
        {
             [lblname setFrame:CGRectMake(41, 1, 185, 36)];
            
           
//              cell1.lblside.frame=CGRectMake(cell1.lblside.frame.origin.x, cell1.lblside.frame.origin.y+14, cell1.lblside.frame.size.width,cell1.lblside.frame.size.height);
            
        }
        else
        {
             [lblname setFrame:CGRectMake(41, 0, 185, 27)];
            
        }
        
        [viewheader addSubview:lblname];
        
        UILabel *lblamt =[[UILabel alloc]init];
        //[lblamt setFrame:CGRectMake(235, 0, 65, 28)];
        [lblamt setFrame:CGRectMake(self.view.frame.size.width-90, 0, 65, 28)];
        NSString *strprice =[NSString stringWithFormat:@"%@",[[arritemsdata objectAtIndex:section]valueForKey:@"totalprice"]];
        int intprice =[strprice intValue];
        lblamt.text =[NSString stringWithFormat:@"AED %d",intprice];
        [lblamt setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:13]];
        lblamt.textColor =[UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:110.0/255.0 alpha:1.0f];
        [viewheader addSubview:lblamt];
        
        
        
        UIButton *btndeleteitem =[[UIButton alloc]init];
        [btndeleteitem setBackgroundImage:[UIImage imageNamed:@"remove_cart_item"] forState:UIControlStateNormal];
        //[btndeleteitem setFrame:CGRectMake(290, 3, 20, 20)];
        [btndeleteitem setFrame:CGRectMake(self.view.frame.size.width-30, 3, 20, 20)];
        btndeleteitem.tag = section;
        [btndeleteitem addTarget:self action:@selector(btndelete:) forControlEvents:UIControlEventTouchUpInside];
        [viewheader addSubview:btndeleteitem];
        
        return viewheader;
    }
    
    return 0;
}





-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(tableView == _tblselectmenu)
    {
        return 0;
    }
    
    else
    {
        return 35;
    }
}





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
   // arroptions =[[NSMutableArray alloc]init];
    
    
//    dictoptions =[[NSMutableDictionary alloc]init];
//
//    dictoptions =[[arritemsdata objectAtIndex:section] valueForKey:@"options"] ;
//
//
//    arrtemp =[[NSMutableArray alloc]init];
//
//    arrtemp =[[dictoptions allKeys] mutableCopy];
//
//
//
//    for (int i =0; i<arrtemp.count; i++) {
//        NSMutableArray *arrsecond =[[NSMutableArray alloc]init];
//
//
//        arrsecond = [[dictoptions valueForKey:[arrtemp objectAtIndex:i]] mutableCopy];
//        NSString *strtemp =[NSString stringWithFormat:@"%@",[[arrtemp objectAtIndex:i]mutableCopy]];
//
//        for (int k  =0; k<arrsecond.count; k++) {
//            NSMutableDictionary *dictte =[[NSMutableDictionary alloc]init];
//
//
//            dictte =[[arrsecond objectAtIndex:k] mutableCopy];
//
//            [dictte setObject:strtemp forKey:@"nameofarray"];
//
//
//        [arroptions addObject:dictte];
//
//
//        }
//
//    }
    
    
  //  arroptions =[[arritemsdata objectAtIndex:section] valueForKey:@"arrcustom"];
    
    if(tableView == _tblselectmenu)
    {
        NSArray *arr2 =[[arritemsdata objectAtIndex:count] valueForKey:@"arrcustom"];
        return arr2.count;
    }
    
    else
    {
        arroptions =[[NSMutableArray alloc]init];
        arroptions =[[arritemsdata objectAtIndex:section] valueForKey:@"arrcustom"];
        return arroptions.count;
    }

    return 0;
}





-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib;
    NSString *tableIdentifier = @"SubViewextraTableViewCell";
    
    if(tableView == _tblselectmenu)
    {
        cell1 = (SubViewextraTableViewCell*)[_tblselectmenu dequeueReusableCellWithIdentifier:tableIdentifier];
        
        if (cell1 == nil)
        {
            nib = [[NSBundle mainBundle] loadNibNamed:@"SubViewextraTableViewCell" owner:self options:nil];
            cell1 = [nib objectAtIndex:0];
        }
        
        NSArray *arr2 =[[arritemsdata objectAtIndex:count] valueForKey:@"arrcustom"];
        
        if (arr2.count > 0)
        {
            NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
            
            NSString *strname =[NSString stringWithFormat:@"%@:",[[arr2 objectAtIndex:indexPath.row]valueForKey:@"nameofarray"]];
            
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
            
            cell1.lblside.text = result;
            cell1.lblside.frame=CGRectMake(41, 7, 263,14);
            cell1.lblside.textAlignment = NSTextAlignmentLeft;
            
            [cell1.contentView addSubview:cell1.lblside];
            
            NSString *strdetails   =[NSString stringWithFormat:@"%@",[[arr2 objectAtIndex:indexPath.row]valueForKey:@"name"]];
            cell1.lblsidedetail.text= strdetails;
            cell1.lblsidedetail.frame=CGRectMake(41, 7, 263,14);
            cell1.lblsidedetail.textAlignment = NSTextAlignmentLeft;
            [cell1.contentView addSubview:cell1.lblsidedetail];
        }
        
        else
        {
            cell1.lblside.text = @"";
            cell1.lblside.frame=CGRectMake(41, 7, 263,14);
            cell1.lblside.textAlignment = NSTextAlignmentLeft;
            
            [cell1.contentView addSubview:cell1.lblside];
            
            cell1.lblsidedetail.text= @"";
            cell1.lblsidedetail.frame=CGRectMake(41, 7, 263,14);
            cell1.lblsidedetail.textAlignment = NSTextAlignmentLeft;
            [cell1.contentView addSubview:cell1.lblsidedetail];
        }
        
        cell1.lblsideamt.hidden = YES;
        
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell1;
    }
    
    else
    {
        cell1 = (SubViewextraTableViewCell*)[_tblitems dequeueReusableCellWithIdentifier:tableIdentifier];
        
        if (cell1 == nil)
        {
            nib = [[NSBundle mainBundle] loadNibNamed:@"SubViewextraTableViewCell" owner:self options:nil];
            cell1 = [nib objectAtIndex:0];
        }
        
        int countsec = (int) indexPath.section;
        
        NSArray *arr2 =[[arritemsdata objectAtIndex:countsec] valueForKey:@"arrcustom"];
        
        if (arr2.count > 0)
        {
            NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
            
            NSString *strname =[NSString stringWithFormat:@"%@:",[[arr2 objectAtIndex:indexPath.row]valueForKey:@"nameofarray"]];
            
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
            
            cell1.lblside.text = result;
            
            
            NSString *strdetails = [NSString stringWithFormat:@"%@",[[arr2 objectAtIndex:indexPath.row]valueForKey:@"name"]];
            
            cell1.lblsidedetail.text= strdetails;
            
            
            NSString *amt = [NSString stringWithFormat:@"AED %@",[[arr2 objectAtIndex:indexPath.row]valueForKey:@"price"]];
            
            if ([amt isEqualToString:@"AED 0.00"])
            {
                cell1.lblsideamt.text = @"";
            }
            
            else
            {
                NSString *type= [amt stringByReplacingOccurrencesOfString:@".00" withString:@""];
                
                cell1.lblsideamt.text = type;
            }
        }
        
        else
        {
            cell1.lblside.text = @"";
            cell1.lblsidedetail.text= @"";
            cell1.lblsideamt.text = @"";
        }
        
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell1;
    }
    
    return 0;
}




-(void)btnchangeqty:(id)sender
{
    _tempview.hidden=NO;
    
    
    
    // [self.viewmain addSubview:_tempview];
    //    [self.viewmain bringSubviewToFront:_tempview];

    
    
    //  _tempview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width);
    //  _tempview.hidden=NO;
    count = (int) [sender tag];
    
    index = count;
    
    [_tempview setHidden:NO];
    // [_tempview addSubview:self.view];
    // [_tempview bringSubviewToFront:self.view];
    _tempview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [_viewblur setHidden:NO];
    
    menuselected = [arritemsdata objectAtIndex:index];
    _lbltitle.text=[menuselected valueForKey:@"name"];
    [_tblselectmenu reloadData];
    self.tblselectmenuheight.constant = _tblselectmenu.contentSize.height;
    _lblqty.text = [NSString stringWithFormat:@"%@",[[arritemsdata objectAtIndex:count]valueForKey:@"quantity"]];
    [_lblqty setFont:[UIFont fontWithName:@"AvenirNext-DemiBold" size:25]];
    
   // _lblqty.textColor =[UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:110.0/255.0 alpha:1.0f];
}




-(void)btndelete:(id)sender
{
    delete = (int) [sender tag];
    
    
    UIAlertController * alert = [UIAlertController                                                          alertControllerWithTitle:NSLocalizedString(@"",nil)
                                                                                                                             message:@"Are you sure you want to delete this item ?"
                                                                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    //Add Buttons
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"YES"
                                style:UIAlertActionStyleDefault
                                handler:^(UIAlertAction * action) {
                                    
                                    if ([[[arritemsdata objectAtIndex:delete] valueForKey:@"promo"] valueForKey:@"name"])
                                    {
                                        NSMutableArray *arroffer = [[NSMutableArray alloc]init];
                                        
                                        NSData *dataarraddtocart = [[NSUserDefaults standardUserDefaults] valueForKey:@"arrayoffer"];
                                        
                                        if (!(dataarraddtocart.bytes == 0))
                                        {
                                            arroffer=[[NSKeyedUnarchiver unarchiveObjectWithData:dataarraddtocart] mutableCopy];
                                        }
                                        
                                        NSMutableArray *arrdeleteoffer = [[NSMutableArray alloc]init];
                                        
                                        arrdeleteoffer = arroffer.mutableCopy;
                                        
                                        for (int i = 0; i<arrdeleteoffer.count; i++)
                                        {
                                            NSString *str = [[arrdeleteoffer objectAtIndex:i] valueForKey:@"random_no"];
                                            
                                            if ([[[[arritemsdata objectAtIndex:delete] valueForKey:@"promo"] valueForKey:@"random_no"] isEqualToString:str])
                                            {
                                                [arrdeleteoffer removeObjectAtIndex:i];
                                                
                                                arroffer = [[NSMutableArray alloc]init];
                                                
                                                arroffer = arrdeleteoffer;
                                            }
                                        }
                                        
                                        
                                        if (arroffer.count > 0)
                                        {
                                            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arroffer];
                                            
                                            [[NSUserDefaults standardUserDefaults] setValue:data forKey:@"arrayoffer"];
                                        }
                                        
                                        else
                                        {
                                            NSData *data = [NSData data];
                                            
                                            [[NSUserDefaults standardUserDefaults] setValue:data forKey:@"arrayoffer"];
                                        }
                                    }
                                    
                                    
                                    NSMutableArray *arrttotal = [[NSMutableArray alloc]init];
                                    
                                    arrttotal = arritemsdata.mutableCopy;
                                    
                                    [arrttotal removeObjectAtIndex:delete];
                                    
                                    arritemsdata = [[NSMutableArray alloc]init];
                                    
                                    arritemsdata = arrttotal;
                                    
                                    if (arritemsdata.count > 0)
                                    {
                                        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arritemsdata];
                                        
                                        [[NSUserDefaults standardUserDefaults] setValue:data forKey:@"arrayaddtocart"];
                                        
                                        [self viewDidLoad];
                                    }
                                    
                                    else
                                    {
                                        NSData *data = [NSData data];
                                        
                                        [[NSUserDefaults standardUserDefaults] setValue:data forKey:@"arrayaddtocart"];
                                        
                                        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"cartcomment"];
                                        
                                        if ([_strreorder isEqualToString:@"yes"])
                                        {
                                            OrderHistoryController *obj=[[OrderHistoryController alloc]initWithNibName:@"OrderHistoryController" bundle:nil];
                                            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                                            [self.navigationController pushViewController:obj animated:YES];
                                        }
                                        
                                        else
                                        {
                                            MenuViewController *obj=[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
                                            self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                                            [self.navigationController pushViewController:obj animated:YES];
                                        }
                                    }
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





- (IBAction)btnincrease:(id)sender
{
    NSString *strcount = _lblqty.text;
    
    int countint =[strcount intValue];
    
    countint = countint +1;

    _lblqty.text =[NSString stringWithFormat:@"%d",countint];
    
    [_lblqty setFont:[UIFont fontWithName:@"AvenirNext-DemiBold" size:25]];
    //_lblqty.textColor =[UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1.0f];
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
   // _lblqty.textColor =[UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:110.0/255.0 alpha:1.0f];
}




- (IBAction)btnupdate:(id)sender
{
    [[arritemsdata objectAtIndex:index] setObject:_lblqty.text forKey:@"quantity"];
    
    NSString *strtotal = [NSString stringWithFormat:@"%@",[[arritemsdata objectAtIndex:index]valueForKey:@"total_price"]];
    
    int inttoatl = [strtotal intValue];
    int intquantitt = [_lblqty.text intValue];
    
    
    int final = inttoatl * intquantitt;
    
    [[arritemsdata objectAtIndex:index] setObject:[NSString stringWithFormat:@"%d", final] forKey:@"totalprice"];
    
    finalsubtotal = 0;
    
    for (int i =0; i<arritemsdata.count; i++)
    {
        NSString *strsubtotal =[NSString stringWithFormat:@"%@",[[arritemsdata objectAtIndex:i]valueForKey:@"totalprice"]];
        int intsubtotal =[strsubtotal intValue];
        
        finalsubtotal = finalsubtotal + intsubtotal;
    }
    
//    if (finalsubtotal < 25)
//    {
//        [_btnaddmoreitems setTitleColor:[UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1] forState:UIControlStateNormal];
//    }
//
//    else
//    {
//        [_btnaddmoreitems setTitleColor:[UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1] forState:UIControlStateNormal];
//    }
    
    _lblsubtotalprice.text =[NSString stringWithFormat:@"AED %d.00", finalsubtotal];
    
    finalsubtotal = finalsubtotal +5;
    
    _lbltotalprice.text =[NSString stringWithFormat:@"AED %d.00", finalsubtotal];
    _lbltotalprice1.text =[NSString stringWithFormat:@"AED %d.00", finalsubtotal];
    
    [_lblqty setFont:[UIFont fontWithName:@"AvenirNext-DemiBold" size:25]];
    
    [_viewblur setHidden:YES];
    [_tempview setHidden:YES];
    [_viewaddqty setHidden:YES];
    
    [_tblitems reloadData];
    
    [GiFHUD showWithOverlay];
    //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self wsloyaltycode];
    });
}




- (IBAction)btnaddmoreitems:(id)sender
{
    MenuViewController *obj=[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    [self.navigationController pushViewController:obj animated:YES];
}





- (IBAction)btnaddPromocode:(id)sender
{
    [_viewEnterPromocode setHidden:NO];
   // [_viewEnterPromocode addSubview:self.viewmain];
    //[_viewEnterPromocode bringSubviewToFront:self.viewmain];
    _viewEnterPromocode.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}





- (IBAction)btnaddcomments:(id)sender
{
    [_viewcomment setHidden:NO];
    _viewcomment.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}





- (IBAction)btncommentsubmit:(id)sender
{
    if ([_txtcommentdata.text isEqualToString:@""])
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
        //[[NSUserDefaults standardUserDefaults]setObject:_txtcommentdata.text forKey:@"cartcomment"];
        
        for (int i = 0; i<arritemsdata.count; i++)
        {
            NSMutableDictionary *dicttemp = [[NSMutableDictionary alloc] init];
            dicttemp = [[arritemsdata objectAtIndex:i] mutableCopy];
            
            [dicttemp setObject:_txtcommentdata.text forKey:@"notes"];
            
            [arritemsdata replaceObjectAtIndex:i withObject:dicttemp];
        }
    }
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
        
        NSMutableArray *arrpromolist = [[NSMutableArray alloc]init];
        NSString *str;
        BOOL allDoneNow = NO;
        
        for (int i = 0; i<arr.count; i++)
        {
            str = [arr objectAtIndex:i];
            
            if ([_txtpromocode.text isEqualToString:str])
            {
                allDoneNow = YES;
                
                [arrpromolist addObject:[arrpromotionitems objectAtIndex:i]];
                
                break;
            }
        }
        
        if (allDoneNow == YES)
        {
            dispatch_async(dispatch_get_main_queue(),^{
                
                MenuViewController *obj=[[MenuViewController alloc]initWithNibName:@"MenuViewController" bundle:nil];
                obj.arrpromolist = arrpromolist;
                self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
                [self.navigationController pushViewController:obj animated:YES];
            });
        }
        
        else if (allDoneNow == NO)
        {
            _viewEnterPromocode.hidden=YES;
            
            [GiFHUD showWithOverlay];
            //  [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.01 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [self wspromocode];
                //
            });
        }
    }
}




- (IBAction)btnpaymentmethod:(id)sender
{
    for (int i = 0; i<arritemsdata.count; i++)
    {
        NSMutableDictionary *dicttemp = [[NSMutableDictionary alloc] init];
        dicttemp = [[arritemsdata objectAtIndex:i] mutableCopy];
        
        [dicttemp setObject:_txtcommentdata.text forKey:@"notes"];
        
        [arritemsdata replaceObjectAtIndex:i withObject:dicttemp];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:_lbltotalprice.text forKey:@"grandtotal"];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"tryAgainPayment"];
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arritemsdata];
    
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"posttotalorder"];
    
    paymentMethodViewController *check =[[paymentMethodViewController alloc]init];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"single" forKey:@"back"];
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    
    [self.navigationController pushViewController:check animated:YES];
}


- (IBAction)btncutlery:(id)sender
{
    if ([strcutlery isEqualToString:@""])
    {
        //0 for No Cutlery
        //1 for Cutlery
        
        strcutlery =@"yes";
        _lblcutlery.text =@"Yes";
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"cutlery_selected"];
        [_imgselectcutlery setImage:[UIImage imageNamed:@"greenCircle"]];
    }
    
    else
    {
        strcutlery =@"";
        _lblcutlery.text =@"Yes";
        [[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"cutlery_selected"];
        [_imgselectcutlery setImage:[UIImage imageNamed:@"grayCircle"]];
    }   
}




#pragma mark <---Web Services--->

-(void)wsloyaltycode
{
    BaseViewController *base=[[BaseViewController alloc]init];
    NSMutableArray *arritemid =[[NSMutableArray alloc]init];
    
    NSMutableArray *arroffer =[[NSMutableArray alloc]init];
    
    NSData *dataarrayoffer =[[NSUserDefaults standardUserDefaults] valueForKey:@"arrayoffer"];
    
    if (!(dataarrayoffer.bytes == 0))
    {
        arroffer=[[NSKeyedUnarchiver unarchiveObjectWithData:dataarrayoffer] mutableCopy];
    }
    
    for (int k = 0; k<arroffer.count; k++)
    {
        [arritemid addObject:[arroffer objectAtIndex:k]];
    }
    
    
    for (int i = 0; i<arritemsdata.count; i++)
    {
        NSMutableArray *arrtem =[[NSMutableArray alloc]init];
        
        NSMutableDictionary *dicttemp =[[NSMutableDictionary alloc]init];
        
        NSString *strcomment = self.txtcommentdata.text;
        [dicttemp setObject:strcomment forKey:@"notes"];
        
        [dicttemp setObject:[[arritemsdata objectAtIndex:i]valueForKey:@"itemID"] forKey:@"itemID"];
        [dicttemp setObject:[[arritemsdata objectAtIndex:i]valueForKey:@"quantity"] forKey:@"quantity"];
        
        NSArray *aerr =[[arritemsdata objectAtIndex:i]valueForKey:@"arrcustom"];
        
        for (int j =0; j<aerr.count; j++)
        {
            NSMutableDictionary *dictt =[[NSMutableDictionary alloc]init];
            
            [dictt setObject:[NSString stringWithFormat:@"%@",[[aerr objectAtIndex:j]valueForKey:@"id"]] forKey:@"id"];
            [dictt setObject:@"1" forKey:@"quantity"];
            
            [arrtem addObject:dictt];
        }
        
        [dicttemp setObject:arrtem forKey:@"options"];
        
        [arritemid addObject:dicttemp];
        
        
        NSMutableDictionary *dictdate =[[NSMutableDictionary alloc]init];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSString *strdate =[dateFormat stringFromDate:[NSDate date]];
        NSString *strtime = [defaults valueForKey:@"delivery_time"];
        
        [dictdate setObject:arritemid forKey:@"items"];
        [dictdate setObject:strdate forKey:@"delivery_date"];
        [dictdate setObject:strtime forKey:@"delivery_time"];
        
        arrdays = [[NSMutableArray alloc]init];
        
        [arrdays addObject:dictdate];
        NSLog(@"%@",arrdays);
    }
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arrdays options:NSJSONWritingPrettyPrinted error:&error];
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
//    [GiFHUD dismiss];
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
                                        
                                        _btnselectpaymentmethod.hidden = YES;
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
                    _lbldiscount.text = [NSString stringWithFormat:@"- AED 5.00"];
                    
                    valueofdiscount = 5.00;
                }
                
//                if ([[dictpromo valueForKey:@"description"] isEqualToString:@"free delivery"])
//                {
//                    _lbldiscount.text = [NSString stringWithFormat:@"- AED 5.00"];
//
//                    valueofdiscount = 5.00;
//                }
                
                else
                {
                    _lbldiscount.text = strdiscountprices;
                    
                    valueofdiscount =[[dictpromo valueForKey:@"discount"] floatValue];
                }
                
                
                NSString *STRTOTALS =_lbltotalprice.text;
                
                STRTOTALS =[STRTOTALS stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"AED"]];
                
                int totalvalue =[STRTOTALS intValue];
                
                float supervqale = totalvalue - valueofdiscount;
                
                
                _lbltotalprice.text = [NSString stringWithFormat:@"AED %.2f",supervqale];
                
                _btnselectpaymentmethod.hidden = NO;
                
                [_btnaddmoreitems setTitleColor:[UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1] forState:UIControlStateNormal];
                
                [self wsGetOffers];
            }
            
            else if ([errorCode isEqualToString:@"0"])
            {
                [self wsGetOffers];
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                
                NSString *strmin = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"min_amount"]];
                
                int min = [strmin intValue];
                
                if (min_total < min)
                {
                    [_btnaddmoreitems setTitleColor:[UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1] forState:UIControlStateNormal];
                }
                
                
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:message preferredStyle:UIAlertControllerStyleAlert];
                
                
                UIAlertAction* yesButton = [UIAlertAction
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
                [self wsGetOffers];
                
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:message preferredStyle:UIAlertControllerStyleAlert];
                
                //Add Buttons
                
                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                
                                                _btnselectpaymentmethod.hidden = YES;
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
                [self wsGetOffers];
                
                UIAlertController * alert = [UIAlertController
                                             alertControllerWithTitle:nil
                                             message:message preferredStyle:UIAlertControllerStyleAlert];
                
                //Add Buttons
                
                UIAlertAction* yesButton = [UIAlertAction
                                            actionWithTitle:@"OK"
                                            style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction * action) {
                                                
                                                _btnselectpaymentmethod.hidden = YES;
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





-(void)wsGetOffers
{
    BaseViewController *base=[[BaseViewController alloc]init];
    
    NSString *stringWebServicesCompleteUrl=[NSString stringWithFormat:@"%@",str_global_domain];
    NSLog(@"web service url =%@",stringWebServicesCompleteUrl);
    
    NSString *parameter=[NSString stringWithFormat:@"request=%@&action=%@&key=%@&secret=%@",@"non_automatic_promotion",@"view",str_key,str_secret];
    
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
        
        //dispatch_async(dispatch_get_main_queue(),^{
        
            if([errorCode isEqualToString:@"1"])
            {
                arroffers = [[NSMutableArray alloc]init];
                arr = [[NSMutableArray alloc]init];
                arrpromotionitems = [[NSMutableArray alloc]init];
                
                arroffers = [dictionary valueForKey:@"data"];
                
                for (int i = 0; i<arroffers.count; i++)
                {
                    NSString *strpromoname = [[arroffers objectAtIndex:i] valueForKey:@"promo_code"];
                    strname = [[arroffers objectAtIndex:i] valueForKey:@"name"];
                    strid = [[arroffers objectAtIndex:i] valueForKey:@"promotionID"];
                    strgroupname = [[arroffers objectAtIndex:i] valueForKey:@"group2_name"];
                    
                    [arr addObject:strpromoname];
                    
                    NSMutableArray *arritems = [[NSMutableArray alloc]init];
                    
                    arritems = [[[arroffers objectAtIndex:i] valueForKey:@"promotion_items"] mutableCopy];
                    
                    if (arritems.count > 0)
                    {
                        for (int j = 0; j<arritems.count; j++)
                        {
                            NSMutableDictionary *dictet = [[NSMutableDictionary alloc]init];
                            
                            dictet = [[arritems objectAtIndex:j] mutableCopy];
                            
                            [dictet setObject:strname forKey:@"name"];
                            [dictet setObject:strid forKey:@"promotionID"];
                            [dictet setObject:strgroupname forKey:@"group2_name"];
                            
                            [arritems replaceObjectAtIndex:j withObject:dictet];
                            
                            [arrpromotionitems addObject:[arritems objectAtIndex:j]];
                        }
                    }
                }
            }
            
            else if ([errorCode isEqualToString:@"0"])
            {
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
        //});
    }
}





-(void)wspromocode
{
    BaseViewController *base=[[BaseViewController alloc]init];
    NSMutableArray *arritemid =[[NSMutableArray alloc]init];
    
    NSMutableArray *arroffer =[[NSMutableArray alloc]init];
    
    NSData *dataarrayoffer =[[NSUserDefaults standardUserDefaults] valueForKey:@"arrayoffer"];
    
    if (!(dataarrayoffer.bytes == 0))
    {
        arroffer=[[NSKeyedUnarchiver unarchiveObjectWithData:dataarrayoffer] mutableCopy];
    }
    
    for (int k = 0; k<arroffer.count; k++)
    {
        [arritemid addObject:[arroffer objectAtIndex:k]];
    }
    
    for (int i = 0; i<arritemsdata.count; i++)
    {
        NSMutableArray *arrtem =[[NSMutableArray alloc]init];
        
        NSMutableDictionary *dicttemp =[[NSMutableDictionary alloc]init];
        [dicttemp setObject:[[arritemsdata objectAtIndex:i]valueForKey:@"itemID"] forKey:@"itemID"];
        [dicttemp setObject:[[arritemsdata objectAtIndex:i]valueForKey:@"quantity"] forKey:@"quantity"];
        
        NSArray *aerr =[[arritemsdata objectAtIndex:i]valueForKey:@"arrcustom"];
        
        for (int i =0; i<aerr.count; i++)
        {
            NSMutableDictionary *dictt =[[NSMutableDictionary alloc]init];
            
            [dictt setObject:[NSString stringWithFormat:@"%@",[[aerr objectAtIndex:i]valueForKey:@"id"]] forKey:@"id"];
            [dictt setObject:@"1" forKey:@"quantity"];
            
            [arrtem addObject:dictt];
        }
        
        [dicttemp setObject:arrtem forKey:@"options"];
        
        //  [arritemid addObject:[[arritemsdata objectAtIndex:i]valueForKey:@"itemID"]];
        
        [arritemid addObject:dicttemp];
        
        
        NSMutableDictionary *dictdate =[[NSMutableDictionary alloc]init];
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        NSString *strdate =[dateFormat stringFromDate:[NSDate date]];
        NSString *strtime = [defaults valueForKey:@"delivery_time"];
        
        arrdays = [[NSMutableArray alloc]init];
        
        [dictdate setObject:arritemid forKey:@"items"];
        [dictdate setObject:strdate forKey:@"delivery_date"];
        [dictdate setObject:strtime forKey:@"delivery_time"];
        
        [arrdays addObject:dictdate];
        NSLog(@"%@",arrdays);
    }
    
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arrdays options:NSJSONWritingPrettyPrinted error:&error];
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
                                                    
                                                    _lbldiscount.text = [NSString stringWithFormat:@"- AED 5.00"];
                                                    
                                                    valueofdiscount = 5;
                                                }
                                                
//                                                if ([string isEqualToString:@"free delivery"])
//                                                {
//                                                    [_viewafterpomocode setHidden:NO];
//
//                                                    _lbldiscount.text = [NSString stringWithFormat:@"- AED 5.00"];
//
//                                                    valueofdiscount = 5;
//                                                }
                                                
                                                else if ([string containsString:@"Free"])
                                                {
                                                    [_viewafterpomocode setHidden:YES];
                                                    
                                                    _lblprotitle.text  =[NSString stringWithFormat:@"%@",_txtpromocode.text];
                                                    _btnpromo.hidden = YES;
                                                    
                                                    NSLog(@"string contains Free!");
                                                    
                                                    NSString *string2 = [dictpromo valueForKey:@"free_product"];
                                                    
                                                    NSString *str = [NSString stringWithFormat:@"Congrats, you get 1 %@", string2];
                                                    
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
                                                
                                                
                                                NSString *STRTOTALS = [NSString stringWithFormat:@"AED %d.00", finalsubtotal];
                                                
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
                                             message:message preferredStyle:UIAlertControllerStyleAlert];
                
                
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

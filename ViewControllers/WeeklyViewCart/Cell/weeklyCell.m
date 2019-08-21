//
//  weeklyCell.m
//  KCal
//
//  Created by Pipl-10 on 02/08/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import "weeklyCell.h"
#import "SubmenuCell.h"
#import "OrderHistoryController.h"
#import "AppDelegate.h"
#import "BaseViewController.h"
#import "ExtraViewCell.h"
#import "WeeklyViewCart.h"
#import "AccordionHeaderView.h"

@implementation weeklyCell
SubmenuCell *cell111;
NSMutableArray *arrdict111;
NSArray *arrorderList111;
NSMutableArray *arrtemp111;
ExtraViewCell *cell112;
NSMutableArray *arrdata111;
NSMutableArray *arrrtemp;
NSMutableArray *arrrtemp2;
CGFloat screenWidth1;
CGFloat screenHeight1;
int count111;
int delete;

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"cutlery_selected"];
    
    _subMenuTableView.delegate=self;
    _subMenuTableView.dataSource =self;
    
    screenWidth1 = [UIScreen mainScreen].bounds.size.width;
    screenHeight1 = [UIScreen mainScreen].bounds.size.height;
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    defaults = [NSUserDefaults standardUserDefaults];

    [_subMenuTableView addSubview:self.viewqty];
    self.viewqty.hidden=YES;
    
    NSData *data = [defaults objectForKey:@"arrtemp111"];
    _arrtemp111 = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    //    self.subMenuTableView.estimatedRowHeight = 30;
    //    self.subMenuTableView.rowHeight = UITableViewAutomaticDimension;
    
    count111 = 0;
    arrdata111 = [_arrtemp111 valueForKey:@"products"];
    
    NSLog(@"arrdata111=%@",arrdata111);
    _strcutlery=@"";
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        // Initialization code
        //        self.frame = CGRectMake(0, 0, 300, 50);
        //        _subMenuTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain]; //create tableview a
        //
        //        _subMenuTableView.tag = 100;
        //        _subMenuTableView.delegate = self;
        //        _subMenuTableView.dataSource = self;
        //        [self.maskView addSubview:_subMenuTableView]; // add it cell111
        //  [subMenuTableView release]; // for without ARC
    }
    
    return self;
}




-(void)layoutSubviews
{
    [super layoutSubviews];
    //    UITableView *subMenuTableView =(UITableView *) [self viewWithTag:100];
    //    subMenuTableView.frame = CGRectMake(0.2, 0.3, self.bounds.size.width-5,    self.bounds.size.height-5);//set the frames for tableview
}




//manage datasource and  delegate for submenu tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < arrdata111.count)
    {
        return 30+cell111.CHTdynamic.constant;
    }
    
    else
    {
        return 350;
    }
}





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrdata111.count + 1;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row < arrdata111.count)
    {
        NSArray *nib;
        NSString *tableIdentifier = @"SubmenuCell";
        
        cell111 = (SubmenuCell*)[_subMenuTableView dequeueReusableCellWithIdentifier:tableIdentifier];
        
        if (cell111 == nil)
        {
            nib = [[NSBundle mainBundle] loadNibNamed:@"SubmenuCell" owner:self options:nil];
            cell111 = [nib objectAtIndex:0];
        }
        
        NSString *price = [[arrdata111 objectAtIndex:indexPath.row] valueForKey:@"totalprice"];
        
        if ([[[arrdata111 objectAtIndex:indexPath.row] valueForKey:@"promo"] valueForKey:@"name"])
        {
            cell111.lblname.text =[NSString stringWithFormat:@"%@ + %@",[[arrdata111 objectAtIndex:indexPath.row] valueForKey:@"name"],[[[arrdata111 objectAtIndex:indexPath.row] valueForKey:@"promo"] valueForKey:@"name"]];
            
            //self.btnpromo.hidden = YES;
            //self.btnaddPromocode.hidden = YES;
        }
        
        else
        {
            cell111.lblname.text = [NSString stringWithFormat:@"%@",[[arrdata111 objectAtIndex:indexPath.row] valueForKey:@"name"]];
        }
        
        
        cell111.lblamt.text= [NSString stringWithFormat:@"%@ %@",@"AED",price];
        NSString *qty =[NSString stringWithFormat:@"%@%@",[[arrdata111 objectAtIndex:indexPath.row]valueForKey:@"quantity"],@"x"];
        [cell111.btnqty setTitle:qty forState:UIControlStateNormal];
        cell111.btnqty.titleLabel.text =[NSString stringWithFormat:@"%@%@",[[arrdata111 objectAtIndex:indexPath.row]valueForKey:@"quantity"],@"x"];
        [cell111.btnqty addTarget:self action:@selector(btnqtyclicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton *btndeleteitem =[[UIButton alloc]init];
        [btndeleteitem setBackgroundImage:[UIImage imageNamed:@"remove_cart_item"] forState:UIControlStateNormal];
        
//        if(screenHeight1 > 800)
//        {
//            [btndeleteitem setFrame:CGRectMake(cell111.frame.size.width + 23, 14, 20, 20)];
//        }
//
//        else
//        {
//            [btndeleteitem setFrame:CGRectMake(290, 14, 20, 20)];
//        }
        
        
        [btndeleteitem setFrame:CGRectMake(screenWidth1-29, 14, 20, 20)];
        
        btndeleteitem.tag = indexPath.row;
        [btndeleteitem addTarget:self action:@selector(btndelete:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell111 addSubview:btndeleteitem];
        
        arrrtemp = [[NSMutableArray alloc]init];
        arrrtemp2 = [[NSMutableArray alloc]init];
        
        NSMutableDictionary *arr = [[arrdata111 objectAtIndex:indexPath.row]valueForKey:@"options"];
        
        NSMutableArray *aaa = [[arr allKeys] mutableCopy];
        
        for (int j = 0; j<aaa.count; j++)
        {
            NSMutableArray *arroption = [arr valueForKey:[aaa objectAtIndex:j]];
            
            for (int k = 0; k<arroption.count; k++)
            {
                NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
                
                NSString *strname =[NSString stringWithFormat:@"%@:",[aaa objectAtIndex:j]];
                
                NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en-US"];
                
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
                
                [temp setObject:result forKey:@"title"];
                
                //[temp setObject:[aaa objectAtIndex:j] forKey:@"title"];
                [temp setObject:[[arroption objectAtIndex:0] valueForKey:@"name"] forKey:@"name"];
                
                NSMutableDictionary *dictprice = [[NSMutableDictionary alloc]init];
                
                [dictprice setObject:@"" forKey:@"title"];
                
                NSString *price = [NSString stringWithFormat:@"AED %@",[[arroption objectAtIndex:0] valueForKey:@"price"]];
                
                if ([price isEqualToString:@"AED 0.00"])
                {
                    [dictprice setObject:@"" forKey:@"price"];
                }
                
                else
                {
                    NSString *type= [price stringByReplacingOccurrencesOfString:@".00" withString:@""];
                    
                    [dictprice setObject:type forKey:@"price"];
                }
                
                [arrrtemp2 addObject:dictprice];
                
                [arrrtemp addObject:temp];
                
                NSLog(@"%@", arroption);
            }
        }
        
        int cnt = 0;
        
        for (int i = 0; i < arrrtemp.count ; i++)
        {
            NSMutableDictionary *dict = [arrrtemp objectAtIndex:i];
            NSMutableDictionary *dict2 = [arrrtemp2 objectAtIndex:i];
            
            NSArray *subviews = [cell111.viewdynamic subviews];
            for (int j = 0; j < (dict.count); j++)
            {
                NSLog(@"single");
                
                cnt++;
                
                NSMutableArray * arrrtemp = [[NSMutableArray alloc] init];
                [arrrtemp addObject:[dict valueForKey:@"title"]];
                [arrrtemp addObject:[dict valueForKey:@"name"]];
                
                
                NSMutableArray * arrrtemp2 = [[NSMutableArray alloc] init];
                [arrrtemp2 addObject:[dict2 valueForKey:@"title"]];
                [arrrtemp2 addObject:[dict2 valueForKey:@"price"]];
                
                
                UILabel *label =  [[UILabel alloc] initWithFrame: CGRectMake(0,((j+1)+subviews.count/2)*25,280,15)];
                
                label.lineBreakMode = NSLineBreakByWordWrapping; //multiple lines in a label
                label.numberOfLines = 0;
                
                label.text = [arrrtemp objectAtIndex:j];
                
                UILabel *label2 =  [[UILabel alloc] initWithFrame: CGRectMake(screenWidth1-cell111.lblamt.frame.size.width*2-24,((j+1)+subviews.count/2)*25.5,280,15)];
                
                [cell111.viewdynamic addSubview:label2];
                
                label2.text = [arrrtemp2 objectAtIndex:j];
                
                [label2 setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:13]];
                label2.textColor =[UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:110.0/255.0 alpha:1.0f];
                
                [label setFont:[UIFont fontWithName:@"AvenirNext-Regular" size:13]];
                label.textColor =[UIColor colorWithRed:108.0/255.0 green:108.0/255.0 blue:110.0/255.0 alpha:1.0f];
                
                [label sizeToFit]; // resize the width and height to fit the text
                NSLog(@"Actual height is: %f", label.frame.size.height); // Use this for spacing any further elements
                
                CGSize expectedLabelSize = [label.text sizeWithFont:label.font
                                                  constrainedToSize:label.frame.size
                                                      lineBreakMode:NSLineBreakByWordWrapping];
                //adjust the label the the new height.
                CGRect newFrame = label.frame;
                newFrame.size.height = expectedLabelSize.height;
                label.frame = newFrame;
                
                [cell111.viewdynamic addSubview:label];
                cell111.CHTdynamic.constant = newFrame.origin.y;
            }
        }
        
        cell111.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell111;
    }
    
    else
    {
        NSArray *nib;
        NSString *tableIdentifier = @"ExtraViewCell";
        
        cell112 = (ExtraViewCell*)[_subMenuTableView dequeueReusableCellWithIdentifier:tableIdentifier];
        
        if (cell112 == nil)
        {
            nib = [[NSBundle mainBundle] loadNibNamed:@"ExtraViewCell" owner:self options:nil];
            cell112 = [nib objectAtIndex:0];
        }
        
        
        cell112.btnaddmoreitems.tag = indexPath.row;
        [cell112.btnaddmoreitems addTarget:self action:@selector(additems:) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *strprice = [_arrtemp111 valueForKey:@"sumofallprices"];
        
        int price = strprice.intValue;
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        
        NSString *strmin = [NSString stringWithFormat:@"%@",[defaults valueForKey:@"min_amount"]];
        
        int min = [strmin intValue];
        
        if (price < min)
        {
            [cell112.btnaddmoreitems setTitleColor:[UIColor colorWithRed:255.0/255.0 green:0.0/255.0 blue:0.0/255.0 alpha:1] forState:UIControlStateNormal];
        }
        
        else
        {
            [cell112.btnaddmoreitems setTitleColor:[UIColor colorWithRed:119.0/255.0 green:189.0/255.0 blue:29.0/255.0 alpha:1] forState:UIControlStateNormal];
        }
        
        
        cell112.btnaddcomments.tag = indexPath.row;
        [cell112.btnaddcomments addTarget:self action:@selector(addcoment:) forControlEvents:UIControlEventTouchUpInside];
        
        cell112.btnaddcutlery.tag = indexPath.row;
        [cell112.btnaddcutlery addTarget:self action:@selector(addcutlery:) forControlEvents:UIControlEventTouchUpInside];
        
        int subtotal=0;
        
        for(int i=0;i<arrdata111.count;i++)
        {
            NSString *ttt =[[arrdata111 objectAtIndex:i]valueForKey:@"totalprice1"];
            
            int t1 = ttt.intValue;
            
            if(t1>0)
            {
                //NSString *finalsubtotal=[NSString stringWithFormat:@"%@",[[arrdata111 objectAtIndex:i]valueForKey:@"totalprice"]];
                //  int total= finalsubtotal.intValue;
                subtotal = subtotal + t1;
            }
            
            else
            {
                NSString *finalsubtotal=[NSString stringWithFormat:@"%@",[[arrdata111 objectAtIndex:i]valueForKey:@"totalprice"]];
                int total= finalsubtotal.intValue;
                subtotal = subtotal + total;
            }
        }
        
        
        cell112.lblsubtotal.text =[NSString stringWithFormat:@"%@ %d",@"AED",subtotal];
        if ([[_arrtemp111 valueForKey:@"cutleryflag"] isEqualToString:@"no"])
        {
            //0 for No Cutlery
            //1 for Cutlery
            
            _strcutlery =@"yes";
            cell112.lblcutlery.text =@"Yes";
            [cell112.imhcutlery setImage:[UIImage imageNamed:@"grayCircle"]];
            //[[NSUserDefaults standardUserDefaults]setObject:@"0" forKey:@"cutlery_selected"];
        }
        
        else
        {
            _strcutlery =@"";
            cell112.lblcutlery.text =@"Yes";
            [cell112.imhcutlery setImage:[UIImage imageNamed:@"greenCircle"]];
            //[[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"cutlery_selected"];
        }
        
        cell112.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell112;
    }
}




-(void)btndelete:(id)sender
{
    delete = (int) [sender tag];
    NSMutableArray *arrrtemp = arrdata111; //[arrdata111 objectAtIndex:delete];
    NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:arrrtemp];
    
    NSString *temptag = [NSString stringWithFormat:@"%d",delete];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    [defaults setValue:temptag forKey:@"sendertag"];
    [defaults setObject:data1 forKey:@"arrweeklydata"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"deleteitem" object:self];
}




-(void)addcoment:(UIButton *)sender
{
    int tag = (int) sender.tag;
    NSString *temptag = [NSString stringWithFormat:@"%d",tag];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    [defaults setValue: temptag forKey:@"sendertag"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addcomentview" object:self];
}




-(void)additems:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addmoreitems" object:self];
}




-(void)addcutlery:(UIButton *)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addcutleryval" object:self];
}





-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}




-(void)btnqtyclicked:(UIButton *)sender
{
    int tag = (int) sender.tag;
    
    NSMutableArray *arrrtemp = [arrdata111 objectAtIndex:tag];
    NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:arrrtemp];
    
    NSString *temptag = [NSString stringWithFormat:@"%d",tag];
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    
    [defaults setValue: temptag forKey:@"sendertag"];
    [defaults setObject:data1 forKey:@"arrweeklydata"];
    [defaults setValue:[NSString stringWithFormat:@"%@",[[arrdata111 objectAtIndex:tag]valueForKey:@"quantity"]] forKey:@"qty"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addquntity" object:self];
}




@end

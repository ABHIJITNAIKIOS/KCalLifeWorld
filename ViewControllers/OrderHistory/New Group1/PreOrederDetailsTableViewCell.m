//
//  PreOrederDetailsTableViewCell.m
//  Eaterity
//
//  Created by PIPL-03 on 17/02/17.
//  Copyright © 2017 PIPL-03. All rights reserved.
//

#import "PreOrederDetailsTableViewCell.h"
#import "SubmenuCell.h"
#import "OrderHistoryController.h"
#import "AppDelegate.h"
#import "BaseViewController.h"
@implementation PreOrederDetailsTableViewCell

SubmenuCell *cell;
NSMutableArray *arrtemp;
NSMutableArray *arrtemp2;
NSMutableArray *arrdata;
CGFloat screenWidth;
CGFloat screenHeight;

int count1;


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    _subMenuTableView.delegate=self;
    _subMenuTableView.dataSource =self;
    
    arrdata = [[NSMutableArray alloc]init];
    
    screenWidth = [UIScreen mainScreen].bounds.size.width;
    screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSData *data = [defaults objectForKey:@"arrtemp"];
    _arrtemp = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    
    if (_arrtemp.count > 1)
    {
        for (int i = 0; i<_arrtemp.count; i++)
        {
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
            
            arr = [[[_arrtemp objectAtIndex:i] valueForKey:@"items"] mutableCopy];
            
            for (int j = 0; j<arr.count; j++)
            {
                dict = [[arr objectAtIndex:j] mutableCopy];
                [arrdata addObject:dict];
            }
        }
    }
    
    else
    {
        count1 = 0;
        arrdata = [[_arrtemp objectAtIndex:0]valueForKey:@"items"];
        NSLog(@"arrdata=%@",arrdata);
    }
    
//    _subMenuTableView.estimatedRowHeight = 48;
//    _subMenuTableView.rowHeight = UITableViewAutomaticDimension;
//
    _btnreOrder.hidden = NO;
    
    _btnreorderheight.constant = 45;
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
//        [self.maskView addSubview:_subMenuTableView]; // add it cell
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}




//manage datasource and  delegate for submenu tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.tblheight.constant = self.subMenuTableView.contentSize.height;

    return cell.CHTdynamic.constant+30;

    //return UITableViewAutomaticDimension;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrdata.count;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib;
    NSString *tableIdentifier = @"SubmenuCell";
    
    cell = (SubmenuCell*)[_subMenuTableView dequeueReusableCellWithIdentifier:tableIdentifier];
    
    if (cell == nil)
    {
        nib = [[NSBundle mainBundle] loadNibNamed:@"SubmenuCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    
    NSString *price = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row]valueForKey:@"total_price"]];
    NSArray *components = [price componentsSeparatedByString:@"."];
    price = components[0];
    cell.lblname.text= [[arrdata objectAtIndex:indexPath.row]valueForKey:@"name"];
    cell.lblamt.text= [NSString stringWithFormat:@"%@ %@",@"AED",price];
    NSString *qty =[NSString stringWithFormat:@"%@%@",[[arrdata objectAtIndex:indexPath.row]valueForKey:@"quantity"],@"x"];
    [cell.btnqty setTitle:qty forState:UIControlStateNormal];
    
    NSString *str = [NSString stringWithFormat:@"%@",[[arrdata objectAtIndex:indexPath.row]valueForKey:@"name"]];
    
    if ([str rangeOfString:@"+"].location == NSNotFound)
    {
        NSLog(@"string does not contain +");
    }
    
    else
    {
        NSLog(@"string contains +!");
        
        _btnreOrder.hidden = NO;
        
        _btnreorderheight.constant = 45;
    }
    
    
    arrtemp = [[NSMutableArray alloc]init];
    arrtemp2 = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *arr = [[arrdata objectAtIndex:indexPath.row]valueForKey:@"options"];
    
    NSArray *aaa = [arr allKeys];
    
    for (int j = 0; j<aaa.count; j++)
    {
        NSMutableArray *arroption = [arr valueForKey:[aaa objectAtIndex:j]];
        
        NSMutableDictionary *temp = [[NSMutableDictionary alloc]init];
        
        NSString *strname =[NSString stringWithFormat:@"%@:",[[arroption objectAtIndex:0] valueForKey:@"option_type"]];
        
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
        [temp setObject:[[arroption objectAtIndex:0] valueForKey:@"name"] forKey:@"name"];
        
        NSMutableDictionary * dictprice = [[NSMutableDictionary alloc]init];
        
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
        
        [arrtemp2 addObject:dictprice];
        
        [arrtemp addObject:temp];
        
        NSLog(@"%@", arroption);
    }
    
    int cnt = 0;
    
    for (int i = 0; i < arrtemp.count ; i++)
    {
        NSMutableDictionary *dict = [arrtemp objectAtIndex:i];
        NSMutableDictionary *dict2 = [arrtemp2 objectAtIndex:i];
        
        NSArray *subviews = [cell.viewdynamic subviews];
        for (int j = 0; j < (dict.count); j++)
        {
            NSLog(@"single");
            
            cnt++;
            
            NSMutableArray * arrtemp = [[NSMutableArray alloc] init];
            [arrtemp addObject:[dict valueForKey:@"title"]];
            [arrtemp addObject:[dict valueForKey:@"name"]];
            
            
            NSMutableArray * arrtemp2 = [[NSMutableArray alloc] init];
            [arrtemp2 addObject:[dict2 valueForKey:@"title"]];
            [arrtemp2 addObject:[dict2 valueForKey:@"price"]];
            
            UILabel *label =  [[UILabel alloc] initWithFrame: CGRectMake(0,((j+1)+subviews.count/2)*25,280,15)];
            
            label.lineBreakMode = NSLineBreakByWordWrapping; //multiple lines in a label
            label.numberOfLines = 0;
            
            label.text = [arrtemp objectAtIndex:j];
            
            UILabel *label2 = [[UILabel alloc] initWithFrame: CGRectMake(screenWidth-cell.lblamt.frame.size.width*2-25,((j+1)+subviews.count/2)*25.5,100,15)];
            
            [cell.viewdynamic addSubview:label2];
            
            label2.text = [arrtemp2 objectAtIndex:j];
            
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
            
            [cell.viewdynamic addSubview:label];
            cell.CHTdynamic.constant = newFrame.origin.y;
        }
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}



@end

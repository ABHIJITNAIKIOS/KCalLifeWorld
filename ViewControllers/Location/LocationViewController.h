//
//  LocationViewController.h
//  KCal
//
//  Created by Apple on 06/03/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationViewController : UIViewController

@property (strong, nonatomic) NSDictionary*dictResInfo;
@property(nonatomic,strong)NSString *getName;
@property(nonatomic,strong)NSString *getBrachID;
@property (weak, nonatomic) IBOutlet UIImageView *imgOutlet;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblOpening;
- (IBAction)btnCall:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblphoneNum;
@property (weak, nonatomic) IBOutlet UIButton *btnviewlocation;

@end

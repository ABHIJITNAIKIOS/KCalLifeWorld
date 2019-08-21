//
//  orderStatusViewController.h
//  KCal
//
//  Created by Pipl014 on 02/08/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FLAnimatedImageView.h"

@interface orderStatusViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *lblmessage;

@property (strong, nonatomic) IBOutlet UILabel *lblorderno;

@property (strong, nonatomic) NSString *strorder_id;

@property (weak, nonatomic) IBOutlet FLAnimatedImageView *imggif;
@property (strong, nonatomic) NSMutableDictionary *dictorder;

@end

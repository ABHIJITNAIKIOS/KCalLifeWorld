//
//  SignOutViewController.h
//  KCal
//
//  Created by Pipl-02 on 29/06/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"

@interface SignOutViewController : UIViewController <SlideNavigationControllerDelegate>


@property (weak, nonatomic) IBOutlet UIView *view1;

@property (weak, nonatomic) IBOutlet UIButton *btnyes;

@property (weak, nonatomic) IBOutlet UIButton *btnno;

@property (strong, nonatomic) NSString *strflag;

@end

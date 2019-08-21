//
//  AboutUsController.h
//  KCal
//
//  Created by Pipl-10 on 23/02/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutUsController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblaboutusContent;
@property (weak, nonatomic) IBOutlet UIImageView *imgAbout;
- (IBAction)btnBack:(id)sender;
- (IBAction)btnKal_Life:(id)sender;
- (IBAction)btnKal_Extra:(id)sender;
- (IBAction)btnKal_fuelUP:(id)sender;
//- (IBAction)btnKalGourmet:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnKal_Life;
@property (weak, nonatomic) IBOutlet UIButton *btnKal_Extra;
@property (weak, nonatomic) IBOutlet UIButton *btnKal_fuelUP;
//@property (weak, nonatomic) IBOutlet UIButton *btnKalGourmet;

@end

//
//  ChangeProfileViewController.h
//  KCal
//
//  Created by Pipl-01 on 04/07/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeProfileViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIImageView *imgProfile;
@property (strong, nonatomic) IBOutlet UIButton *btnRemove;
- (IBAction)btnRemove:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnCamera;
- (IBAction)btnCamera:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnAlbum;
- (IBAction)btnAlbum:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnupdate;

@end

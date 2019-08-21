//
//  OffersViewController.h
//  KCal
//
//  Created by Pipl-02 on 21/09/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OffersViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>


@property (strong, nonatomic) IBOutlet UITableView *tblObj;

@property (weak, nonatomic) IBOutlet UIView *viewoffer;

@property (weak, nonatomic) IBOutlet UIButton *btnordernow;


@end

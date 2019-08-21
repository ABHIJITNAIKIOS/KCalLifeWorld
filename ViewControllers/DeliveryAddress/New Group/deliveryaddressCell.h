//
//  deliveryaddressCell.h
//  KCal
//
//  Created by Pipl-10 on 20/07/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface deliveryaddressCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbltitle;
@property (strong, nonatomic) IBOutlet UILabel *lbladdress;
@property (strong, nonatomic) IBOutlet UIButton *btnedit;
@property (weak, nonatomic) IBOutlet UIButton *btneditbig;

@end

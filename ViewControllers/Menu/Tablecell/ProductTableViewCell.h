//
//  ProductTableViewCell.h
//  KCal
//
//  Created by Apple on 28/02/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgProduct;
@property (weak, nonatomic) IBOutlet UIImageView *imgpopular;
@property (weak, nonatomic) IBOutlet UIImageView *imgnew;
@property (weak, nonatomic) IBOutlet UIImageView *imgsoldout;
@property (weak, nonatomic) IBOutlet UILabel *lblProductName;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;

@end

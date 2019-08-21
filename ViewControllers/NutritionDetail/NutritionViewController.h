//
//  NutritionViewController.h
//  KCal
//
//  Created by Pipl-10 on 04/07/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NutritionViewController : UIViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) IBOutlet UICollectionView *neutritionCollection;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ChtcollectionView;
@property (strong, nonatomic) IBOutlet UIButton *btnback;



@end

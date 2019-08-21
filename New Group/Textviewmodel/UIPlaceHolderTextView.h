//
//  UIPlaceHolderTextView.h
//  KCal
//
//  Created by Pipl-06 on 27/07/18.
//  Copyright © 2018 Panaceatek. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface UIPlaceHolderTextView : UITextView

@property (nonatomic, retain) IBInspectable NSString *placeholder;
@property (nonatomic, retain) IBInspectable UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end

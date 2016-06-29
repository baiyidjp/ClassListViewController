//
//  UIColor+HexCode.h
//
//
//  Created by Annie Shih on 11/14/12.
//  Copyright (c) 2012 Tibco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexCode)
+ (UIColor *) colorFromHexString:(NSString *)hexString;
+ (UIColor *)raidersGrayColor;
+ (UIColor *)raidersDrakGrayColor;

@end

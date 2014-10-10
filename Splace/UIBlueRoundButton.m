//
//  UIBlueRoundButton.m
//  Splace
//
//  Created by Oleg Agapov on 10/10/14.
//  Copyright (c) 2014 Oleg Agapov. All rights reserved.
//

#import "UIBlueRoundButton.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation UIBlueRoundButton

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath  bezierPathWithRoundedRect:self.bounds cornerRadius:5.0];
    UIColor *color = UIColorFromRGB(0x2C566C);
    [color setFill];
    [roundedRect fill];
    [super drawRect:rect];
}

@end

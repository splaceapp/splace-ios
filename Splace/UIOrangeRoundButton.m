//
//  UIOrangeRoundButton.m
//  Splace
//
//  Created by Oleg Agapov on 10/10/14.
//  Copyright (c) 2014 Oleg Agapov. All rights reserved.
//

#import "UIOrangeRoundButton.h"

@implementation UIOrangeRoundButton

- (void)drawRect:(CGRect)rect
{
    UIBezierPath *roundedRect = [UIBezierPath  bezierPathWithRoundedRect:self.bounds cornerRadius:5.0];
    UIColor *color = [UIColor colorWithRed:198.0/255.0 green:80.0/255.0 blue:42.0/255.0 alpha:1.0];
    [color setFill];
    [roundedRect fill];
    [super drawRect:rect];
}


@end

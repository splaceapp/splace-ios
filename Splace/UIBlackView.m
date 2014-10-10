//
//  UIBlackImageView.m
//  Splace
//
//  Created by Oleg Agapov on 10/10/14.
//  Copyright (c) 2014 Oleg Agapov. All rights reserved.
//

#import "UIBlackView.h"

@implementation UIBlackView

- (void)drawRect:(CGRect)rect
{
    UIColor* color = [[UIColor blackColor] colorWithAlphaComponent:0.9];
    [color setFill];
    UIRectFill(rect);
}



@end

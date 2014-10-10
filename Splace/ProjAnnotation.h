//
//  ProjAnnotation.h
//  Splace
//
//  Created by Oleg Agapov on 10/10/14.
//  Copyright (c) 2014 Oleg Agapov. All rights reserved.
//

#import "StartAnnotation.h"

@interface ProjAnnotation : StartAnnotation

@property (nonatomic, assign) NSUInteger type;
@property (nonatomic, assign) NSUInteger money;
@property (copy, nonatomic) NSString *idString;

@end

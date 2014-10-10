//
//  DetailsProjectViewController.h
//  Splace
//
//  Created by Oleg Agapov on 10/10/14.
//  Copyright (c) 2014 Oleg Agapov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailsProjectViewController : UIViewController

@property (assign, nonatomic) NSUInteger projectType;
@property (assign, nonatomic) NSUInteger donatedMoney;
@property (assign, nonatomic) NSString *projectTitle;
@property (copy, nonatomic) NSString *idString;

@end

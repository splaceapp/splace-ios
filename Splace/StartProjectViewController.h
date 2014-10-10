//
//  NewProjectViewController.h
//  Splace
//
//  Created by Oleg Agapov on 10/9/14.
//  Copyright (c) 2014 Oleg Agapov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface StartProjectViewController : UIViewController

@property (assign, nonatomic) NSUInteger projectType;
@property (assign, nonatomic) CLLocationCoordinate2D coordinates;

@end

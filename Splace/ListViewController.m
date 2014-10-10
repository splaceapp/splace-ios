//
//  ListViewController.m
//  Splace
//
//  Created by Oleg Agapov on 10/9/14.
//  Copyright (c) 2014 Oleg Agapov. All rights reserved.
//

#import "ListViewController.h"
#import "StartProjectViewController.h"

@interface ListViewController ()

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(UIControl *)sender
{
    StartProjectViewController *startProjectViewController = segue.destinationViewController;
    startProjectViewController.projectType = sender.tag;
    startProjectViewController.coordinates = self.coordinates;
}
//
//- (IBAction)benchButton:(id)sender
//{
//    
//}
//
//- (IBAction)parkButton:(id)sender
//{
//    
//}
//
//- (IBAction)bollardButton:(id)sender
//{
//    
//}
//
//- (IBAction)trashButton:(id)sender
//{
//    
//}
//
//- (IBAction)lawnButton:(id)sender
//{
//    
//}

@end

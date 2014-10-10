//
//  DetailsProjectViewController.m
//  Splace
//
//  Created by Oleg Agapov on 10/10/14.
//  Copyright (c) 2014 Oleg Agapov. All rights reserved.
//

#import "DetailsProjectViewController.h"

@interface DetailsProjectViewController ()

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *donateLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation DetailsProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    UIImage *image = nil;
    NSString *name = nil;
    NSUInteger price = 0;
    switch (self.projectType)
    {
        case 1:
            image = [UIImage imageNamed:@"BenchWide"];
            name = @"Bench";
            price = 1200;
            break;
        case 2:
            image = [UIImage imageNamed:@"TrashCanWide"];
            name = @"Trash Can";
            price = 300;
            break;
        case 3:
            image = [UIImage imageNamed:@"BollardWide"];
            name = @"Bollard";
            price = 700;
            break;
        case 4:
            image = [UIImage imageNamed:@"BicycleParkingWide"];
            name = @"Bicyle Parking";
            price = 1000;
            break;
        case 5:
            image = [UIImage imageNamed:@"GrassLawnWide"];
            name = @"Grass Lawn";
            price = 200;
            break;
        default:
            break;
    }
    
    self.imageView.image = image;
    self.typeLabel.text = self.projectTitle;
    
    self.priceLabel.text = [NSString stringWithFormat:@"%u out of %u UAH collected!", self.donatedMoney, price];
//    self.slider.maximumValue = (float)price;
}

- (IBAction)sliderDidUpdateValue:(UISlider *)sender
{
    self.donateLabel.text = [NSString stringWithFormat:@"%.0f UAH", sender.value];
}

@end

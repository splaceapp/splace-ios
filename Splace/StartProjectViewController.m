//
//  NewProjectViewController.m
//  Splace
//
//  Created by Oleg Agapov on 10/9/14.
//  Copyright (c) 2014 Oleg Agapov. All rights reserved.
//

#import "StartProjectViewController.h"

@interface StartProjectViewController ()

@property (weak, nonatomic) IBOutlet UISlider *slider;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *maxLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *donateLabel;

@end

@implementation StartProjectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *orangeColor = [UIColor colorWithRed:198.0/255.0 green:80.0/255.0 blue:42.0/255.0 alpha:1.0];
    self.donateLabel.textColor = orangeColor;
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
    self.typeLabel.text = name;
    
    self.priceLabel.text = [NSString stringWithFormat:@"%u UAH", price];
    self.slider.maximumValue = (float)price;
    self.maxLabel.text = [NSString stringWithFormat:@"%u", price];
}

- (IBAction)sliderDidUpdateValue:(UISlider *)sender
{
    self.donateLabel.text = [NSString stringWithFormat:@"%.0f UAH", sender.value];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

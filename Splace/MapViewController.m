//
//  ViewController.m
//  Splace
//
//  Created by Oleg Agapov on 10/9/14.
//  Copyright (c) 2014 Oleg Agapov. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "StartAnnotation.h"
#import "ListViewController.h"
#import "ASSplaceTransmitter.h"
#import "ProjAnnotation.h"
#import "DetailsProjectViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface MapViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet MKMapView* mapView;

@property (strong) CLLocationManager* locationManager;
@property (strong) StartAnnotation* dropPin;
@property (strong) NSArray* markers;

@end

@implementation MapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self performSelector:@selector(startStandardUpdates) withObject:self afterDelay:1.0];
    [self addLongGesture];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.mapView removeAnnotations:[self.mapView annotations]];
    self.markers = [[ASSplaceTransmitter sharedTransmitter] offlaneGetMarkers];
    [self anotateMap];
    [self addLongGesture];
}

- (void)addLongGesture
{
    UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGesture:)];
    [self.mapView addGestureRecognizer:longPressGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    if ([annotation class] == [MKUserLocation class])
    {
        return nil;
    }

    MKAnnotationView* aView = [[MKAnnotationView alloc] initWithAnnotation:annotation
                                                           reuseIdentifier:@"MyCustomAnnotation"];
    
    
    UIButton *button = nil;
    if ([annotation isMemberOfClass: [StartAnnotation class]])
    {
        button = [UIButton buttonWithType:UIButtonTypeContactAdd];
        aView.image = [UIImage imageNamed:@"SplacePin"];
    }
    else
    {
        button = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        aView.image = [UIImage imageNamed:@"SplacePinBlue"];
    }
    button.tintColor = [UIColor colorWithRed:198.0/255.0 green:80.0/255.0 blue:42.0/255.0 alpha:1.0];
    aView.rightCalloutAccessoryView = button;
    aView.canShowCallout = YES;
    aView.centerOffset = CGPointMake(10, -20);
    return aView;
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray *)views {
    MKAnnotationView *aV;
    
    for (aV in views)
    {
        
        // Don't pin drop if annotation is user location
        if ([aV.annotation isKindOfClass:[MKUserLocation class]]) {
            continue;
        }
        
        // Check if current annotation is inside visible map rect, else go to next one
        MKMapPoint point =  MKMapPointForCoordinate(aV.annotation.coordinate);
        if (!MKMapRectContainsPoint(self.mapView.visibleMapRect, point)) {
            continue;
        }
        
        CGRect endFrame = aV.frame;
        
        // Move annotation out of view
        aV.frame = CGRectMake(aV.frame.origin.x, aV.frame.origin.y - self.view.frame.size.height, aV.frame.size.width, aV.frame.size.height);
        
        // Animate drop
        [UIView animateWithDuration:0.5 delay:0.04*[views indexOfObject:aV] options: UIViewAnimationOptionCurveLinear animations:^{
            
            aV.frame = endFrame;
            
            // Animate squash
        }completion:^(BOOL finished){
            if (finished) {
                [UIView animateWithDuration:0.05 animations:^{
                    aV.transform = CGAffineTransformMakeScale(1.0, 0.8);
                    
                }completion:^(BOOL finished){
                    if (finished) {
                        [UIView animateWithDuration:0.1 animations:^{
                            aV.transform = CGAffineTransformIdentity;
                        }];
                    }
                }];
            }
        }];
    }
}

- (void)startStandardUpdates
{
    // Create the location manager if this object does not
    // already have one.
    if (nil == self.locationManager)
    {
        self.locationManager = [[CLLocationManager alloc] init];
    }
    [self.locationManager requestAlwaysAuthorization];
    
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    // Set a movement threshold for new events.
    self.locationManager.distanceFilter = 200; // meters
    
    [self.locationManager startUpdatingLocation];
}

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0)
    {
        MKCoordinateRegion region = { { 0.0, 0.0 }, { 0.0, 0.0 } };
        region.center.latitude = self.locationManager.location.coordinate.latitude;
        region.center.longitude = self.locationManager.location.coordinate.longitude;
        region.span.longitudeDelta = 0.01f;
        region.span.longitudeDelta = 0.01f;
        [self.mapView setRegion:region animated:YES];
    }
}

-(void)handleLongPressGesture:(UIGestureRecognizer*)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        [self.mapView removeGestureRecognizer:sender];
    }
    else
    {
        [self.mapView removeAnnotation:self.dropPin];
        // Here we get the CGPoint for the touch and convert it to latitude and longitude coordinates to display on the map
        CGPoint point = [sender locationInView:self.mapView];
        CLLocationCoordinate2D locCoord = [self.mapView convertPoint:point toCoordinateFromView:self.mapView];
        // Then all you have to do is create the annotation and add it to the map
        self.dropPin = [[StartAnnotation  alloc] init];
        self.dropPin.title = @"Need something here?";
        self.dropPin.subtitle = @"Start crowfunding project";
        self.dropPin.coordinate = locCoord;
        [self.mapView addAnnotation:self.dropPin];
    }
}

- (void)anotateMap
{
    for (NSDictionary *dict in self.markers)
    {
        CLLocationCoordinate2D locCoord = CLLocationCoordinate2DMake([dict[@"latitude"] floatValue], [dict[@"longtitude"] floatValue]);
        ProjAnnotation *projAnnotation = [ProjAnnotation new];
        projAnnotation.title = dict[@"title"];
        projAnnotation.type = [dict[@"type"] integerValue];
        projAnnotation.money = [dict[@"moneyDonated"] integerValue];
        projAnnotation.idString = dict[@"id"];
        projAnnotation.coordinate = locCoord;

        NSString *name = nil;
        switch (projAnnotation.type)
        {
            case 1:
                name = @"Bench";
                break;
            case 2:
                name = @"Trash Can";
                break;
            case 3:
                name = @"Bollard";
                break;
            case 4:
                name = @"Bicyle Parking";
                break;
            case 5:
                name = @"Grass Lawn";
                break;
            default:
                break;
        }
        projAnnotation.subtitle = name;
        [self.mapView addAnnotation:projAnnotation];
    }
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    UIButton* button = (UIButton *)control;
    if (button.buttonType == UIButtonTypeContactAdd)
    {
        ListViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"ListViewController"];
        controller.coordinates = view.annotation.coordinate;
        [self.navigationController pushViewController:controller animated:YES];
    }
    else
    {
        DetailsProjectViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsViewController"];
        controller.projectType = [(ProjAnnotation*)view.annotation type];
        controller.projectTitle = [(ProjAnnotation*)view.annotation title];
        controller.donatedMoney = [(ProjAnnotation*)view.annotation money];
        controller.idString = [(ProjAnnotation*)view.annotation idString];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

@end

//
//  MapRouteViewController.m
//  Aaarriba
//
//  Created by David Pflugpeil on 23.03.14.
//  Copyright (c) 2014 wunderfactory. All rights reserved.
//

#import "MapRouteViewController.h"

@interface MapRouteViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *userStartLocationManager;
@property (nonatomic, strong) CLLocation *userStartLocation;

@property BOOL getLocation;

@end



@implementation MapRouteViewController

@synthesize userStartLocation, userStartLocationManager, getLocation;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.locationRouteMapView.delegate = self;
    //self.locationRouteMapView.showsUserLocation = YES;
    
    userStartLocationManager = [[CLLocationManager alloc] init];
    userStartLocationManager.delegate = self;
    userStartLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    userStartLocationManager.distanceFilter = kCLDistanceFilterNone;
    
    [userStartLocationManager startUpdatingLocation];

    UITapGestureRecognizer *touchGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    touchGesture.numberOfTapsRequired = 1;
    
    
    //UILongPressGestureRecognizer *longGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    //longGestureRecognizer.minimumPressDuration = 0.1;
    [self.locationRouteMapView addGestureRecognizer:touchGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan) {
        
        [self.locationRouteMapView removeAnnotations:self.locationRouteMapView.annotations];
        
        CGPoint touchPoint = [gestureRecognizer locationInView:self.locationRouteMapView];
        CLLocationCoordinate2D touchMapCoordinate = [self.locationRouteMapView convertPoint:touchPoint toCoordinateFromView:self.locationRouteMapView];
        
        
        MKPointAnnotation *startAnnotation = [[MKPointAnnotation alloc] init];
        startAnnotation.coordinate = touchMapCoordinate;
        startAnnotation.title = @"[Adresse]";
        
        NSArray *annotationArray = @[startAnnotation];
        
        
        [self.locationRouteMapView addAnnotations:annotationArray];
    }
}



- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    userStartLocation = [locations lastObject];
    
    NSArray *locationArray = @[userStartLocation];
    [self.locationRouteMapView showAnnotations:locationArray animated:YES];
    
    float userStartCoordinateLatitude = userStartLocation.coordinate.latitude;
    float userStartCoordinateLongitude = userStartLocation.coordinate.longitude;
    
    [[NSUserDefaults standardUserDefaults] setInteger:userStartCoordinateLatitude forKey:@"userStartLocationLatitude"];
    [[NSUserDefaults standardUserDefaults] setInteger:userStartCoordinateLongitude forKey:@"userStartLocationLongitude"];
}




- (IBAction)actionButton:(id)sender {
    
    CLGeocoder *startAdressGeocoder = [[CLGeocoder alloc] init];
    [startAdressGeocoder geocodeAddressString:@"Am Rosengarten 7, Kassel" completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *topResult = [placemarks objectAtIndex:0];
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
        
        
        [self.locationRouteMapView addAnnotation:placemark];
    }];
}
@end

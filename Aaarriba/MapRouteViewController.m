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
@property (nonatomic, strong, readwrite) CLLocation *userStartLocation;

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
    
    
    UILongPressGestureRecognizer *longGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    longGestureRecognizer.minimumPressDuration = 1.0;
    [self.locationRouteMapView addGestureRecognizer:longGestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan) {
        
        CGPoint touchPoint = [gestureRecognizer locationInView:self.locationRouteMapView];
        CLLocationCoordinate2D touchMapCoordinate = [self.locationRouteMapView convertPoint:touchPoint toCoordinateFromView:self.locationRouteMapView];
        
        MKCoordinateRegion startRegion;
        startRegion.center = touchMapCoordinate;
        startRegion.span.latitudeDelta = 0.2;
        startRegion.span.longitudeDelta = 0.2;
        
        MKPointAnnotation *startAnnotation = [[MKPointAnnotation alloc] init];
        startAnnotation.coordinate = touchMapCoordinate;
        startAnnotation.title = @"[Adresse";
        
        
        [self.locationRouteMapView setRegion:startRegion animated:YES];
        
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




@end

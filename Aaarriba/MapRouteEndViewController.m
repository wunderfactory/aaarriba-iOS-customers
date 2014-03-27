//
//  MapRouteEndViewController.m
//  Aaarriba
//
//  Created by David Pflugpeil on 26.03.14.
//  Copyright (c) 2014 wunderfactory. All rights reserved.
//

#import "MapRouteEndViewController.h"

@interface MapRouteEndViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *userEndLocationManager;

@property (nonatomic, strong) CLLocation *userEndLocation;

@property BOOL getLocation;

@end



@implementation MapRouteEndViewController

@synthesize userEndLocationManager, userEndLocation, getLocation;



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
    
    
    self.endLocationMapView.delegate = self;
    //self.locationRouteMapView.showsUserLocation = YES;
    
    userEndLocationManager = [[CLLocationManager alloc] init];
    userEndLocationManager.delegate = self;
    userEndLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    userEndLocationManager.distanceFilter = kCLDistanceFilterNone;
    
    [userEndLocationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    userEndLocation = [locations lastObject];
    
    NSArray *locationArray = @[userEndLocation];
    [self.endLocationMapView showAnnotations:locationArray animated:YES];
    
    float userStartCoordinateLatitude = userEndLocation.coordinate.latitude;
    float userStartCoordinateLongitude = userEndLocation.coordinate.longitude;
    
    [[NSUserDefaults standardUserDefaults] setInteger:userStartCoordinateLatitude forKey:@"userStartLocationLatitude"];
    [[NSUserDefaults standardUserDefaults] setInteger:userStartCoordinateLongitude forKey:@"userStartLocationLongitude"];
}


@end

//
//  MapRouteViewController.m
//  Aaarriba
//
//  Created by David Pflugpeil on 23.03.14.
//  Copyright (c) 2014 wunderfactory. All rights reserved.
//

#import "MapRouteViewController.h"
#import "PricingViewController.h"

@interface MapRouteViewController () <MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate>

@property (nonatomic, strong) CLLocationManager *userStartLocationManager;
@property (nonatomic, strong) CLLocation *userStartLocation;

@property (nonatomic, strong) NSString *addressString;

@property BOOL getLocation;

@end



@implementation MapRouteViewController

@synthesize userStartLocation, userStartLocationManager, getLocation, addressString;



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
    
    
    self.addressSearchBar.delegate = self;
    self.locationRouteMapView.delegate = self;
    //self.locationRouteMapView.showsUserLocation = YES;
    
    userStartLocationManager = [[CLLocationManager alloc] init];
    userStartLocationManager.delegate = self;
    userStartLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    userStartLocationManager.distanceFilter = kCLDistanceFilterNone;
    
    

    UITapGestureRecognizer *touchGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    touchGesture.numberOfTapsRequired = 1;
    
    
    UIBarButtonItem *locateItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"10kg.png"] landscapeImagePhone:nil style:UIBarButtonItemStyleBordered target:self action:@selector(locateUserOnMapView)];
    self.navigationItem.rightBarButtonItems = @[locateItem];
    
    
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
        //startAnnotation.title = @"[Adresse]";
        
        NSArray *annotationArray = @[startAnnotation];
        
        
        [self.locationRouteMapView showAnnotations:annotationArray animated:YES];
        
        
        
        userStartLocation = [[CLLocation alloc] initWithCoordinate:touchMapCoordinate altitude:-1 horizontalAccuracy:-1 verticalAccuracy:CLLocationDistanceMax timestamp:nil];
        
        CLGeocoder *locationGeocoder = [[CLGeocoder alloc] init];
        [locationGeocoder reverseGeocodeLocation:userStartLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSString *address = [[NSString stringWithFormat:@"%@, %@, %@", [placemark thoroughfare],[placemark subThoroughfare], [placemark locality]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"(null), "]];
            
            
            [[NSUserDefaults standardUserDefaults] setObject:address forKey:@"userStartAddress"];
        }];
    }
}





- (void)locateUserOnMapView
{
    [userStartLocationManager startUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    userStartLocation = [locations lastObject];
    
    
    NSArray *locationArray = @[userStartLocation];
    [self.locationRouteMapView showAnnotations:locationArray animated:YES];
    
    CLGeocoder *locationGeocoder = [[CLGeocoder alloc] init];
    [locationGeocoder reverseGeocodeLocation:userStartLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        NSString *address = [[NSString stringWithFormat:@"%@, %@, %@", [placemark thoroughfare],[placemark subThoroughfare], [placemark locality]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"(null), "]];
        
        [[NSUserDefaults standardUserDefaults] setObject:address forKey:@"userStartAddress"];
    }];
    
    
    [userStartLocationManager stopUpdatingLocation];
}




- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *searchAddressString = self.addressSearchBar.text;
    
    
    CLGeocoder *startAdressGeocoder = [[CLGeocoder alloc] init];
    [startAdressGeocoder geocodeAddressString:searchAddressString completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *topResult = [placemarks objectAtIndex:0];
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
        
        NSArray *locationArray = @[placemark];
        
        userStartLocation = [placemarks objectAtIndex:0];
        
        [searchBar resignFirstResponder];
        [self.locationRouteMapView showAnnotations:locationArray animated:YES];
        
        
        
        NSString *address = [[NSString stringWithFormat:@"%@, %@, %@", [placemark thoroughfare],[placemark subThoroughfare], [placemark locality]] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"(null), "]];
        
        [[NSUserDefaults standardUserDefaults] setObject:address forKey:@"userStartAddress"];
    }];
}






@end

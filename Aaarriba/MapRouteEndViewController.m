//
//  MapRouteEndViewController.m
//  Aaarriba
//
//  Created by David Pflugpeil on 26.03.14.
//  Copyright (c) 2014 wunderfactory. All rights reserved.
//

#import "MapRouteEndViewController.h"

@interface MapRouteEndViewController () <MKMapViewDelegate, CLLocationManagerDelegate, UISearchBarDelegate>

@property (nonatomic, strong) CLLocationManager *userEndLocationManager;
@property (nonatomic, strong) CLLocation *userEndLocation;

@property (nonatomic, strong) NSString *addressString;

@property BOOL getLocation;

@end



@implementation MapRouteEndViewController

@synthesize userEndLocation, userEndLocationManager, getLocation, addressString;



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
    self.endLocationMapView.delegate = self;
    //self.endLocationMapView.showsUserLocation = YES;
    
    userEndLocationManager = [[CLLocationManager alloc] init];
    userEndLocationManager.delegate = self;
    userEndLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    userEndLocationManager.distanceFilter = kCLDistanceFilterNone;
    
    
    
    UITapGestureRecognizer *touchGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    touchGesture.numberOfTapsRequired = 1;
    
    
    UIBarButtonItem *locateItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"10kg.png"] landscapeImagePhone:nil style:UIBarButtonItemStyleBordered target:self action:@selector(locateUserOnMapView)];
    self.navigationItem.rightBarButtonItems = @[locateItem];
    
    
    [self.endLocationMapView addGestureRecognizer:touchGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)handleLongPress:(UIGestureRecognizer *)gestureRecognizer
{
    if (gestureRecognizer.state != UIGestureRecognizerStateBegan) {
        
        [self.endLocationMapView removeAnnotations:self.endLocationMapView.annotations];
        
        CGPoint touchPoint = [gestureRecognizer locationInView:self.endLocationMapView];
        CLLocationCoordinate2D touchMapCoordinate = [self.endLocationMapView convertPoint:touchPoint toCoordinateFromView:self.endLocationMapView];
        
        
        
        MKPointAnnotation *endAnnotation = [[MKPointAnnotation alloc] init];
        endAnnotation.coordinate = touchMapCoordinate;
        //endAnnotation.title = @"[Adresse]";
        
        NSArray *annotationArray = @[endAnnotation];
        
        
        [self.endLocationMapView showAnnotations:annotationArray animated:YES];
        
        
        
        userEndLocation = [[CLLocation alloc] initWithCoordinate:touchMapCoordinate altitude:-1 horizontalAccuracy:-1 verticalAccuracy:CLLocationDistanceMax timestamp:nil];
        
        CLGeocoder *locationGeocoder = [[CLGeocoder alloc] init];
        [locationGeocoder reverseGeocodeLocation:userEndLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            
            CLPlacemark *placemark = [placemarks objectAtIndex:0];
            NSString *address = [NSString stringWithFormat:@"%@, %@, %@", [placemark thoroughfare],[placemark subThoroughfare], [placemark locality]];
            
            [[NSUserDefaults standardUserDefaults] setObject:address forKey:@"userEndAddress"];
            
            NSLog(@"%@", address);
        }];
    }
}





- (void)locateUserOnMapView
{
    [userEndLocationManager startUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    userEndLocation = [locations lastObject];
    
    
    NSArray *locationArray = @[userEndLocation];
    [self.endLocationMapView showAnnotations:locationArray animated:YES];
    
    CLGeocoder *locationGeocoder = [[CLGeocoder alloc] init];
    [locationGeocoder reverseGeocodeLocation:userEndLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        NSString *address = [NSString stringWithFormat:@"%@, %@, %@", [placemark thoroughfare],[placemark subThoroughfare], [placemark locality]];
        
        [[NSUserDefaults standardUserDefaults] setObject:address forKey:@"userEndAddress"];
    }];
    
    
    [userEndLocationManager stopUpdatingLocation];
}




- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    NSString *searchAddressString = self.addressSearchBar.text;
    
    
    CLGeocoder *endAdressGeocoder = [[CLGeocoder alloc] init];
    [endAdressGeocoder geocodeAddressString:searchAddressString completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *topResult = [placemarks objectAtIndex:0];
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
        
        NSArray *locationArray = @[placemark];
        
        userEndLocation = [placemarks objectAtIndex:0];
        
        [searchBar resignFirstResponder];
        [self.endLocationMapView showAnnotations:locationArray animated:YES];
        
        
        
        NSString *address = [NSString stringWithFormat:@"%@, %@, %@", [placemark thoroughfare],[placemark subThoroughfare], [placemark locality]];
        
        [[NSUserDefaults standardUserDefaults] setObject:address forKey:@"userEndAddress"];
    }];
}


@end

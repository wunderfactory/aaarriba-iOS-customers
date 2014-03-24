//
//  MapRouteViewController.m
//  Aaarriba
//
//  Created by David Pflugpeil on 23.03.14.
//  Copyright (c) 2014 wunderfactory. All rights reserved.
//

#import "MapRouteViewController.h"

@interface MapRouteViewController () <MKMapViewDelegate>

@end

@implementation MapRouteViewController

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
    
    //Geokoordianten Avanti
    CLLocationCoordinate2D coordination;
    coordination.latitude = 54.5432;
    coordination.longitude = 9.41365;
    
    //Set up Region with coordinates
    MKCoordinateRegion avantiRegion;
    avantiRegion.center = coordination;
    avantiRegion.span.latitudeDelta = 10;
    avantiRegion.span.longitudeDelta = 10;
    
    //Set up the pin
    MKPointAnnotation *coordinationPoint = [[MKPointAnnotation alloc] init];
    coordinationPoint.coordinate = coordination;
    coordinationPoint.title = @"Deine Position";
    
    //Tell the MapView what to show
    [self.locationRouteMapView setRegion:avantiRegion animated:YES];
    [self.locationRouteMapView addAnnotation:coordinationPoint];
    
    NSArray *annotationArray = @[coordinationPoint];
    [self.locationRouteMapView showAnnotations:annotationArray animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

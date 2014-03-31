//
//  MapRouteEndViewController.h
//  Aaarriba
//
//  Created by David Pflugpeil on 26.03.14.
//  Copyright (c) 2014 wunderfactory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapRouteEndViewController : UIViewController

@property (weak, nonatomic) IBOutlet MKMapView *endLocationMapView;

@property (weak, nonatomic) IBOutlet UISearchBar *addressSearchBar;

@end

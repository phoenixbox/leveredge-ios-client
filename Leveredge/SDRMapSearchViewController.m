//
//  SDRMapSearchViewController.m
//  Leveredge
//
//  Created by Shane Rogers on 7/15/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRMapSearchViewController.h"
#import "SDRViewConstants.h"
#import "SDRMapAnnotation.h"

// Map Module
#import <MapKit/MapKit.h>
// Location module
#import <CoreLocation/CoreLocation.h>


@interface SDRMapSearchViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) MKMapView *_vendorsMapView;
@property (nonatomic, strong) CLLocationManager *_myLocationManager;
@property (nonatomic, strong) CLGeocoder *_geocoder;
@property (nonatomic) CGSize _searchViewSize;

@end

@implementation SDRMapSearchViewController

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
    // Extract view protocol where they all adhere to the functions for appearance initialization
    self._searchViewSize = self.view.frame.size;
    [self initAppearance];
    [self addMapToView];
    [self findOrRequestLocation];
    
    [self addMapAnnotations];
    [self geoCodeHome];
}

- (void)initAppearance
{
    self.navigationController.navigationBar.translucent = NO;
    
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackOpaque];
    [[UINavigationBar appearance] setBarTintColor:kLeveredgeBlue];
    
    [[UIToolbar appearance] setBarStyle:UIBarStyleBlackOpaque];
    [[UIToolbar appearance] setBarTintColor:kLeveredgeBlue];
    [self setHeaderLogo];
//    [self addNavigationItems];
}

- (void)setHeaderLogo {
    [[self navigationItem] setTitleView:nil];
    UIImageView *logoView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f,100.0f, 40.0f)];
    logoView.contentMode = UIViewContentModeScaleAspectFill;
    UIImage *logoImage = [UIImage imageNamed:@"leveredgeLogo.png"];
    [logoView setImage:logoImage];
    self.navigationItem.titleView = logoView;
}

//- (void)addNavigationItems{
//    UIImage *filterImage = [UIImage imageNamed:@"filterIconSmall.png"];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:filterImage landscapeImagePhone:filterImage style:UIBarButtonItemStylePlain target:self action:@selector(toggleFilter:)];
//    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
//}

- (void)addMapToView {
    self.view.backgroundColor = [UIColor whiteColor];
    self._vendorsMapView = [[MKMapView alloc]initWithFrame:CGRectMake(0.0, 0.0, self._searchViewSize.width, self._searchViewSize.height*0.8)];
    
    [self._vendorsMapView setMapType:MKMapTypeStandard];
    self._vendorsMapView.delegate = self;

    [self._vendorsMapView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    
    // Display the user
    self._vendorsMapView.showsUserLocation = YES;
    // Enable tracking mode which overrides default and forces user to be at the center of the map
    self._vendorsMapView.userTrackingMode = MKUserTrackingModeFollow;
    
    [self.view addSubview:self._vendorsMapView];
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    MKLocalSearchRequest *request = [MKLocalSearchRequest new];
    // Update this to use a search field
    request.naturalLanguageQuery = @"Restaurants";
    
    MKCoordinateSpan mapSpan = MKCoordinateSpanMake(0.01,0.01);
    request.region = MKCoordinateRegionMake(userLocation.location.coordinate, mapSpan);
    
    MKLocalSearch *search = [[MKLocalSearch alloc]initWithRequest:request];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if (error == nil){
            for(MKMapItem *item in response.mapItems){
                float latitude = item.placemark.location.coordinate.latitude;
                float longitude = item.placemark.location.coordinate.longitude;
                
                CLLocationCoordinate2D pin = CLLocationCoordinate2DMake(latitude, longitude);
                NSString *phoneAndSite = [NSString stringWithFormat:@"Phone: %@, Website: %@",item.phoneNumber, item.url];
                SDRMapAnnotation *annotation = [[SDRMapAnnotation alloc]initWithCoordinates:pin title:item.name subtitle:phoneAndSite];
                
                annotation.pinColor = MKPinAnnotationColorPurple;
                
                [self._vendorsMapView addAnnotation:annotation];
            }
        } else if (error != nil){
            NSString *errorMessage = [NSString stringWithFormat:@"An error occured with the search: %@", error];
            [self errorAlert:errorMessage];
        }
    }];

}

- (void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    [self errorAlert:@"Could not get your location"];
}

- (void)errorAlert:(NSString *)errorMessage{
    UIAlertView *alertView = [[UIAlertView alloc]
                              initWithTitle:@"Failed"
                              message:errorMessage
                              delegate:nil cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
    [alertView show];
}

- (void)findOrRequestLocation {
    if ([CLLocationManager locationServicesEnabled]) {
        self._myLocationManager = [CLLocationManager new];
        [self._myLocationManager setDelegate:self];
        
        [self._myLocationManager startUpdatingLocation];
    } else {
        NSLog(@"Ask the user to turn on location services");
    }
}

- (void)addMapAnnotations {
    // We will geocode our restaurant pins and put them on them map later :)
    CLLocationCoordinate2D examplePin = CLLocationCoordinate2DMake(50.82191692907181, -0.13811767101287842);
    SDRMapAnnotation *exampleAnnotation = [[SDRMapAnnotation alloc]initWithCoordinates:examplePin title:@"First Pin" subtitle:@"Gonna be an iOS wizard"];
    
    exampleAnnotation.pinColor = MKPinAnnotationColorPurple;
    
    [self._vendorsMapView addAnnotation:exampleAnnotation];
}

- (void)geoCodeHome{
    NSString *home = @"1303 Alpine Ave, Boulder, CO 80304, USA";
    self._geocoder = [CLGeocoder new];
    
    [self._geocoder geocodeAddressString:home completionHandler:^(NSArray *placemarks, NSError *error){
        NSLog(@"Found %lu placemarks", (unsigned long)[placemarks count]);
        // 3 scenarios - found placemarks - no placemarks - error
        if([placemarks count]>0 && error == nil){
            // Placemarks will have a CLLocation instance w/lat and longs attributes of float type
            [placemarks enumerateObjectsUsingBlock:^(CLPlacemark *placemark, NSUInteger idx, BOOL *stop) {
                float latitude = placemark.location.coordinate.latitude;
                float longitude = placemark.location.coordinate.longitude;
                
                CLLocationCoordinate2D pin = CLLocationCoordinate2DMake(latitude,longitude);
                SDRMapAnnotation *pinAnnotation = [[SDRMapAnnotation alloc]initWithCoordinates:pin title:@"Home" subtitle:@"Dublin"];
                pinAnnotation.pinColor = MKPinAnnotationColorGreen;
                [self._vendorsMapView addAnnotation:pinAnnotation];
            }];
        }else if ([placemarks count]==0 && error == nil){
            NSLog(@"No placemarks match that geocode query address");
        }else if (error != nil){
            NSLog(@"An error has occurred: %@", error);
        }
    }];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    [locations enumerateObjectsUsingBlock:^(CLLocation *location, NSUInteger index, BOOL *stop){
        NSLog(@"Latitude %f",location.coordinate.latitude);
        NSLog(@"Latitude %f",location.coordinate.longitude);
    }];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"%@", error);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id <MKAnnotation>)annotation {
    MKAnnotationView *result = nil;
    
    if([annotation isKindOfClass:[SDRMapAnnotation class]]==NO){
        return result;
    }
 
    if ([mapView isEqual: self._vendorsMapView] == NO){
        return result;
    }
    
    // Typecast the annotation that the MapView has fired this delegate message
    SDRMapAnnotation *senderAnnotation = (SDRMapAnnotation *)annotation;
    
    // Use the annotation class method to get the resusable identifier for the pin being created
    NSString *reusablePinIdentifier = [SDRMapAnnotation reusableIdentifierforPinColor:senderAnnotation.pinColor];
    
    // Use this identifier as the reusable annotation identifier on the map view
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reusablePinIdentifier];
    
    if(annotationView == nil){
        annotationView = [[MKPinAnnotationView alloc]initWithAnnotation:senderAnnotation reuseIdentifier:reusablePinIdentifier];
        
        // Ensure we can see the callout for the pin
        [annotationView setCanShowCallout:YES];
    }
    
    // Display Custom Image
    UIImage *QLLogo = [UIImage imageNamed:@"qlLogoUnhighlighted"];
    if (QLLogo != nil){
        annotationView.image = QLLogo;
    }
    
    // Ensure the color of the pin matches the color of the annotation
//    annotationView.pinColor = senderAnnotation.pinColor;
    
    result = annotationView;
    
    return result;
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

//
//  SDRMapSearchViewController.m
//  Leveredge
//
//  Created by Shane Rogers on 7/15/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRMapSearchViewController.h"
#import "SDRViewConstants.h"

// Location Modules
#import <MapKit/MapKit.h>

@interface SDRMapSearchViewController () <MKMapViewDelegate, CLLocationManagerDelegate>

@property (nonatomic, strong) MKMapView *_vendorsMapView;
@property (nonatomic, strong) CLLocationManager *_myLocationManager;
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
    [self.view addSubview:self._vendorsMapView];
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

//
//  SDRVendorsListViewController.m
//  Leveredge
//
//  Created by Shane Rogers on 2/1/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRVendorsListViewController.h"
#import "SDRViewConstants.h"
#import "SDRVendorsTableCell.h"
#import "SDRVendorChannel.h"
#import "SDRVendor.h"
#import "SDRVendorStore.h"
#import "SDRVendorViewController.h"
#import "SDRAuthStore.h"

@interface SDRVendorsListViewController ()

@end

@implementation SDRVendorsListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initAppearance];
        [self fetchVendors];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[SDRAuthStore sharedStore] addObserver:self forKeyPath:@"loggedIn" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    [self renderVendorsTable];
}

- (void)initAppearance
{
    // Set appearance info
    [[UITabBar appearance] setBarTintColor:kLeveredgeBlue];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackOpaque];
    [[UINavigationBar appearance] setBarTintColor:kLeveredgeBlue];
    
    [[UIToolbar appearance] setBarStyle:UIBarStyleBlackOpaque];
    [[UIToolbar appearance] setBarTintColor:kLeveredgeBlue];
    
    [[self navigationItem] setTitle:@"Vendors"];
}

- (void)renderVendorsTable {
    [self formatVendorsTable];
    [self.view addSubview:self.vendorsTable];
}

- (void)formatVendorsTable {
    self.vendorsTable = [[UITableView alloc]initWithFrame:self.view.bounds];
    [self.vendorsTable registerClass:[UITableViewCell class] forCellReuseIdentifier:kVendorsTableCellIdentifier];
    self.vendorsTable.delegate = self;
    self.vendorsTable.dataSource = self;
    self.vendorsTable.alwaysBounceVertical = NO;
    self.vendorsTable.scrollEnabled = YES;
    self.vendorsTable.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    self.vendorsTable.separatorColor = [UIColor clearColor];
    
    [self.vendorsTable setBackgroundColor:[UIColor clearColor]];
}

#pragma UITableViewDelgate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[vendorChannel vendors] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SDRVendor *vendor = [[vendorChannel vendors]objectAtIndex:[indexPath row]];
//    SDRVendor *vendor = [[[SDRVendorStore sharedStore] allVendors] objectAtIndex:[indexPath row]];
    
    SDRVendorsTableCell *cell = (SDRVendorsTableCell *)[tableView dequeueReusableCellWithIdentifier:kVendorsTableCellIdentifier];
    
    if([tableView isEqual:self.vendorsTable]){
        cell = [[SDRVendorsTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kVendorsTableCellIdentifier];
        
        [cell.vendorsTitleLabel setText:vendor.title];
        [cell.vendorsDescriptionLabel setText:vendor.description];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kVendorsTableCellHeight;
}

// hook into the didSelectRowAtIndexPath to instantiate a DetailViewController and push it atop the stack
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SDRVendorViewController *vendorViewController = [[SDRVendorViewController alloc]init];
    
    NSArray *vendors = [[SDRVendorStore sharedStore] allVendors];
    SDRVendor *selectedVendor = [vendors objectAtIndex:[indexPath row]];
    
    [vendorViewController setViewWithVendor:selectedVendor];
    
    [[self navigationController] pushViewController:vendorViewController animated:YES];
}

- (void)fetchVendors {
    // Create an activity indicator and start it spinning in the nav bar
    [self setActivityIndicator];
    
    void(^completionBlock)(SDRVendorChannel *obj, NSError *err)=^(SDRVendorChannel *obj, NSError *err){
        [[self navigationItem] setTitleView:nil];
        [[self navigationItem] setTitle:@"Vendors"];
        if(!err){
            // TODO: Possible change when querying subset of vendors
            vendorChannel = obj;
            // Only add if unique
            [self addUniquesToVendorStore:vendorChannel];
            
            [[self vendorsTable]reloadData];
        } else {
            [self renderErrorMessage:err];
        }
    };
    [[SDRVendorStore sharedStore]fetchVendorsWithCompletion:completionBlock];
}

- (void)addUniquesToVendorStore:(SDRVendorChannel *)vc {
    for(SDRVendor *vendor in [vc vendors]){
        [[SDRVendorStore sharedStore] addUniqueVendors:vendor];
    }
}

- (void)renderErrorMessage:(NSError *)err {
    NSString *errorString = [NSString stringWithFormat:@"Fetch failed: %@", [err localizedDescription]];
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [av show];
}

- (void)setActivityIndicator {
    UIActivityIndicatorView *aiView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [[self navigationItem] setTitleView:aiView];
    [aiView startAnimating];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:@"loggedIn"]) {
        NSLog(@"login status changed");
        
        if (![SDRAuthStore loggedIn]) {
            // Handle Login Form Display
        }        
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


@end

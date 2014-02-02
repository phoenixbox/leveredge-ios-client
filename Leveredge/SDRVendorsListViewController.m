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

@interface SDRVendorsListViewController ()

@end

@implementation SDRVendorsListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initAppearance];
        [self renderVendorsTable];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self fetchVendors];
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

- (void)fetchVendors {
    // Create an activity indicator and start it spinning in the nav bar
    [self setActivityIndicator];
    
    void(^completionBlock)(SDRVendorChannel *obj, NSError *err)=^(SDRVendorChannel *obj, NSError *err){
        [[self navigationItem] setTitleView:nil];
        [[self navigationItem] setTitle:@"Vendors"];
        if(!err){
            vendorChannel = obj;
            [[self vendorsTable]reloadData];
        } else {
            [self renderErrorMessage:err];
        }
    };
    [[SDRVendorStore sharedStore]fetchVendorsWithCompletion:completionBlock];
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

@end

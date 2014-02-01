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

- (void)initAppearance
{
    // Set appearance info
    [[UITabBar appearance] setBarTintColor:kLeveredgeBlue];
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackOpaque];
    [[UINavigationBar appearance] setBarTintColor:kLeveredgeBlue];
    
    [[UIToolbar appearance] setBarStyle:UIBarStyleBlackOpaque];
    [[UIToolbar appearance] setBarTintColor:kLeveredgeBlue];
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SDRVendorsTableCell *cell = (SDRVendorsTableCell *)[tableView dequeueReusableCellWithIdentifier:kVendorsTableCellIdentifier];
    
    if([tableView isEqual:self.vendorsTable]){
        cell = [[SDRVendorsTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kVendorsTableCellIdentifier];
        
        //  TODO: Setup attributes setting on cells
        //        cell.vendorsTitleLabel;
        //        cell.vendorsDescriptionLabel;
        //        cell.vendorsThumbnail;
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kVendorsTableCellHeight;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

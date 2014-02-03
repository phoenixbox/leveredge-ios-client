//
//  SDRVendorViewController.m
//  Leveredge
//
//  Created by Shane Rogers on 2/2/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRVendorViewController.h"

@interface SDRVendorViewController ()

@end

@implementation SDRVendorViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setViewWithVendor:(SDRVendor *)v{
    self.vendor = v;
    [[self navigationItem] setTitle:self.vendor.title];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
//    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f,50.0f, 250.0f, 50.0f)];
    [self.placeholderLabel setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:self.placeholderLabel];
//    [self setPlaceholderLabel];
}

- (void)setPlaceholderLabel {
   }


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

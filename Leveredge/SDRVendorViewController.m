//
//  SDRVendorViewController.m
//  Leveredge
//
//  Created by Shane Rogers on 2/2/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRVendorViewController.h"
#import "SDRCarousel.h"

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
    [[self navigationItem] setTitle:@"Detail View"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self buildScrollView];
    [self addContentToScrollView];
}

- (void)buildScrollView {
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];
}

- (void)addContentToScrollView {
    //    TODO: Setup visual representation of cells and setup S3 bucket
    [self buildCarousel];
    [self buildTitleContainer];
    [self buildDetailContainer];
}

- (void)buildCarousel {
    self.carousel = [[SDRCarousel alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 190.0f)];
    [self.scrollView addSubview:self.carousel];
}

- (void) buildTitleContainer {
    [self renderContainer];
    [self renderTitleAndSummary];
    [self renderTypeAndScore];
}

- (void)renderContainer {
    self.titleContainer = [[UIView alloc]initWithFrame:CGRectMake(self.carousel.frame.origin.x,self.carousel.frame.size.height, self.view.frame.size.width, 50.0f)];
    [self.titleContainer setBackgroundColor:[UIColor lightGrayColor]];
    [self.scrollView addSubview:self.titleContainer];
}

- (void)renderTitleAndSummary {
    [self renderTitle];
    [self renderSummary];
}

- (void)renderTitle {
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleContainer.frame.origin.x+5, self.titleContainer.frame.origin.x+5, self.titleContainer.frame.size.width*.75,self.titleContainer.frame.size.height*.35)];
    [self.titleLabel setText:self.vendor.title];
    [self.titleLabel setBackgroundColor:[UIColor redColor]];
    [self.titleContainer addSubview:self.titleLabel];
}

- (void)renderSummary {
    self.summary = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.frame.origin.x,self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height+5, self.titleLabel.frame.size.width,self.titleLabel.frame.size.height)];
    [self.summary setText:self.vendor.summary];
    [self.summary setBackgroundColor:[UIColor redColor]];
    [self.titleContainer addSubview:self.summary];
}

- (void)renderTypeAndScore {
    self.vendorType = [[UIImageView alloc] initWithFrame:CGRectMake(self.titleLabel.frame.size.width+10, self.titleLabel.frame.origin.y, self.view.frame.size.width - self.titleLabel.frame.size.width - 15, self.titleContainer.frame.size.height*.8)];
    [self.vendorType setBackgroundColor:[UIColor redColor]];
    [self.titleContainer addSubview:self.vendorType];
}

- (void)buildDetailContainer {

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

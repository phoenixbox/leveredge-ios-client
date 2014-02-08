//
//  SDRVendorViewController.m
//  Leveredge
//
//  Created by Shane Rogers on 2/2/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRVendorViewController.h"
#import "SDRCarousel.h"
#import "SDRViewConstants.h"

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
    [self setScrollViewContentSize];
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
    [self renderTitleContainer];
    [self renderTitleAndSummary];
    [self renderTypeAndScore];
}

- (void)renderTitleContainer {
    self.titleContainer = [[UIView alloc]initWithFrame:CGRectMake(0,self.carousel.frame.size.height, self.view.frame.size.width, 50.0f)];
    [self.titleContainer setBackgroundColor:[UIColor lightGrayColor]];
    [self.scrollView addSubview:self.titleContainer];
}

- (void)renderTitleAndSummary {
    [self renderTitle];
    [self renderSummary];
}

- (void)renderTitle {
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLeveredgeSmallPadding, kLeveredgeSmallPadding, self.titleContainer.frame.size.width*.75,self.titleContainer.frame.size.height*.35)];
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
    [self renderDetailsContainer];
    [self renderDetails];
//    [self renderDescription];
    [self buildCommentsSection];
}

- (void)renderDetailsContainer {
    self.detailsContainer = [[UIView alloc]initWithFrame:CGRectMake(0.0f,self.titleContainer.frame.origin.y + self.titleContainer.frame.size.height,self.view.frame.size.width,100.0f)];
    [self.detailsContainer setBackgroundColor:[UIColor grayColor]];
    
    [self.scrollView addSubview:self.detailsContainer];
}

- (void)renderDetails {
    [self renderPhoneNumber];
    [self renderWebsiteUrl];
    
//    self.websiteUrl = [UILabel new];
//    [self.websiteUrl setText:self.vendor.websiteUrl];
//    
//    self.address = [UILabel new];
//    [self.address setText:self.vendor.address];
}

- (void)renderPhoneNumber {
    CGRect phoneNumberContainer = self.detailsContainer.frame;
    phoneNumberContainer.origin.x = self.detailsContainer.frame.origin.x + kLeveredgeSmallPadding;
    phoneNumberContainer.origin.y = self.detailsContainer.frame.origin.y + kLeveredgeSmallPadding;
    phoneNumberContainer.size.width = self.detailsContainer.frame.size.width * 0.5;
    phoneNumberContainer.size.height = self.detailsContainer.frame.size.height * 0.2;
    
    self.phoneNumber = [UILabel new];
    
//    NSAttributedString *descriptor = [[NSAttributedString alloc] initWithString:@"Phone: " attributes:@{ NSStrokeColorAttributeName : [UIColor greenColor]}];
    
    NSAttributedString *descriptor = [[NSAttributedString alloc] initWithString:@"Phone: " attributes:@{ NSFontAttributeName : [UIFont fontWithName:@"Noteworthy-Bold" size:10.0f], NSUnderlineStyleAttributeName : @1 , NSStrokeColorAttributeName : [UIColor greenColor]}];
    
    [self.phoneNumber setText:[NSString stringWithFormat:@"%@/%@/", descriptor, self.vendor.phoneNumber]];
    [self.phoneNumber setFont:[UIFont systemFontOfSize:10.0f]];
    [self.phoneNumber setFrame:phoneNumberContainer];
    [self.phoneNumber setBackgroundColor:kPureWhite];
    
    [self.scrollView addSubview:self.phoneNumber];
}

- (void)renderWebsiteUrl {
    CGRect websiteUrlContainer = self.phoneNumber.frame;
    websiteUrlContainer.origin.x = self.phoneNumber.frame.origin.x;
    websiteUrlContainer.origin.y = self.phoneNumber.frame.origin.y + self.phoneNumber.frame.size.height + kLeveredgeSmallPadding;
    websiteUrlContainer.size.width = self.detailsContainer.frame.size.width * 0.5;
    websiteUrlContainer.size.height = self.detailsContainer.frame.size.height * 0.2;
    
    self.websiteUrl = [UILabel new];
    
    [self.websiteUrl setText:[NSString stringWithFormat:@"%@/%@/", @"Website: ", self.vendor.websiteUrl]];
    [self.websiteUrl setFont:[UIFont systemFontOfSize:10.0f]];
    [self.websiteUrl setFrame:websiteUrlContainer];
    [self.websiteUrl setBackgroundColor:kPureWhite];
    
    [self.scrollView addSubview:self.websiteUrl];
}

//- (void)renderDescription {
//    self.description = [[UITextView alloc]initWithFrame:CGRectMake(kLeveredgeSmallPadding, self.detailsContainer.frame.origin.y+kLeveredgeSmallPadding,self.detailsContainer.frame.size.width-(kLeveredgeSmallPadding*2),self.detailsContainer.frame.size.height-(kLeveredgeSmallPadding*2))];
//    [self.description setBackgroundColor:kPureWhite];
//    [self.description setText:self.vendor.description];
//    
//    [self.description sizeToFit];
//    [self.description layoutIfNeeded];
//    
//    [self.description setEditable:NO];
//    [self.description setSelectable:NO];
//    [self.scrollView addSubview:self.description];
//}

- (void)buildCommentsSection{
    
}

- (void)setScrollViewContentSize{
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrollView.subviews) {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrollView.contentSize = contentRect.size;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

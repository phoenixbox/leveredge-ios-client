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
#import "SDRLeveredgeButton.h"

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
    [self calculateDimensions];
    
    [self buildScrollView];
    [self addContentToScrollView];
    [self setScrollViewContentSize];
}

- (void)calculateDimensions {
    _detailElementWidth = (self.view.frame.size.width - (kLeveredgeSmallPadding*3))/2;
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
    [self buildLeveredgeButton];
    [self buildDescriptionContainer];
    [self buildCommentsContainer];
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
}

- (void)renderDetailsContainer {
    self.detailsContainer = [[UIView alloc]initWithFrame:CGRectMake(0.0f,self.titleContainer.frame.origin.y + self.titleContainer.frame.size.height,self.view.frame.size.width,kDetailContainerHeight)];
    [self.detailsContainer setBackgroundColor:[UIColor grayColor]];
    
    [self.scrollView addSubview:self.detailsContainer];
}

- (void)renderDetails {
    [self renderPhoneNumber];
    [self renderWebsiteUrl];
    [self renderAddress];
}

- (void)renderPhoneNumber {
    CGRect phoneNumberContainer = self.detailsContainer.frame;
    phoneNumberContainer.origin.x = self.detailsContainer.frame.origin.x + kLeveredgeSmallPadding;
    phoneNumberContainer.origin.y = self.detailsContainer.frame.origin.y + kLeveredgeSmallPadding;
    phoneNumberContainer.size.width = _detailElementWidth;
    phoneNumberContainer.size.height = kDetailElementHeight;
    
    self.phoneNumber = [UILabel new];
    NSAttributedString *processedString = [self formatString:@"Phone: " withString:self.vendor.phoneNumber];
    [self.phoneNumber setAttributedText:processedString];

    [self.phoneNumber setFont:[UIFont systemFontOfSize:10.0f]];
    [self.phoneNumber setFrame:phoneNumberContainer];
    [self.phoneNumber setBackgroundColor:kPureWhite];
    
    [self.scrollView addSubview:self.phoneNumber];
}

- (void)renderWebsiteUrl {
    CGRect websiteUrlContainer = self.phoneNumber.frame;
    websiteUrlContainer.origin.x = self.phoneNumber.frame.origin.x + self.phoneNumber.frame.size.width + kLeveredgeSmallPadding ;
    websiteUrlContainer.origin.y = self.phoneNumber.frame.origin.y;
    websiteUrlContainer.size.width = _detailElementWidth;
    websiteUrlContainer.size.height = kDetailElementHeight;
    
    self.websiteUrl = [UILabel new];
    NSAttributedString *processedString = [self formatString:@"Website: " withString:self.vendor.websiteUrl];
    [self.websiteUrl setAttributedText:processedString];
    
    [self.websiteUrl setFont:[UIFont systemFontOfSize:10.0f]];
    [self.websiteUrl setFrame:websiteUrlContainer];
    [self.websiteUrl setBackgroundColor:kPureWhite];
    
    [self.scrollView addSubview:self.websiteUrl];
}

- (void)renderAddress {
    CGRect addressContainer = self.phoneNumber.frame;
    addressContainer.origin.y = self.phoneNumber.frame.origin.y + self.phoneNumber.frame.size.height + kLeveredgeSmallPadding;
    addressContainer.size.width = self.view.frame.size.width - (kLeveredgeSmallPadding * 2);
    addressContainer.size.height = kDetailElementHeight;
    
    self.address = [UILabel new];
    
    NSString *fullAddress = [NSString stringWithFormat:@"%@, %@, %@", self.vendor.address, self.vendor.city, self.vendor.state];
    NSAttributedString *processedString = [self formatString:@"Address: " withString:fullAddress];

    [self.address setAttributedText:processedString];
    
    [self.address setFont:[UIFont systemFontOfSize:10.0f]];
    [self.address setFrame:addressContainer];
    [self.address setBackgroundColor:kPureWhite];
    
    [self.scrollView addSubview:self.address];
}

- (NSAttributedString *)formatString:(NSString *)targetString withString:(NSString *)contentString {
    NSString *string = [NSString stringWithFormat:@"%@",targetString];
    string = [string stringByAppendingString:contentString];
    
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSDictionary *attributesForFirstWord = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:10.0f],NSForegroundColorAttributeName : [UIColor redColor]};
    
    [result setAttributes:attributesForFirstWord range:[string rangeOfString:targetString]];
    return [[NSAttributedString alloc]initWithAttributedString:result];
}

- (void)buildLeveredgeButton {
    self.leveredgeButton = [[SDRLeveredgeButton alloc]initWithFrame:CGRectMake(0.0f, self.detailsContainer.frame.origin.y+kDetailContainerHeight, self.detailsContainer.frame.size.width, kLeveredgeButtonHeight)];
    [self.leveredgeButton setTitle:kLeveredgeItCopy forState:UIControlStateNormal];
    [self.leveredgeButton setTitleColor:kPureWhite forState:UIControlStateNormal];
    [self.leveredgeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    [self.leveredgeButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.leveredgeButton addTarget:self action:@selector(leveredgeIt:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.leveredgeButton setBackgroundColor:kLeveredgeBlue];
    [self.scrollView addSubview:self.leveredgeButton];
};

- (void)leveredgeIt:(SDRLeveredgeButton *)button {
    if (![button selected]){
        NSLog(@"Vendor Leveredged");
        [button setSelected:YES];
        [button setBackgroundColor:[UIColor greenColor]];
        [button setTitle:kLeveredgedCopy forState:UIControlStateNormal];
    } else {
        NSLog(@"Vendor De-Leveredged");
        [button setSelected:NO];
        [button setBackgroundColor:kLeveredgeBlue];
        [button setTitle:kLeveredgeItCopy forState:UIControlStateNormal];
    }
}

- (void)buildDescriptionContainer {
    self.descriptionContainer = [[UIView alloc]initWithFrame:CGRectMake(0.0f, self.leveredgeButton.frame.origin.y+kLeveredgeButtonHeight,self.view.frame.size.width, 0.0f)];
    [self.descriptionContainer setBackgroundColor:[UIColor grayColor]];
    [self.scrollView addSubview:self.descriptionContainer];
    
    self.description = [[UITextView alloc]initWithFrame:CGRectMake(kLeveredgeSmallPadding, self.leveredgeButton.frame.origin.y+self.leveredgeButton.frame.size.height+kLeveredgeSmallPadding,self.detailsContainer.frame.size.width-(kLeveredgeSmallPadding*2),self.detailsContainer.frame.size.height-(kLeveredgeSmallPadding*2))];
    [self.description setBackgroundColor:kPureWhite];
    [self.description setText:self.vendor.description];
    
    [self.description sizeToFit];
    [self.description layoutIfNeeded];
    
    [self.description setEditable:NO];
    [self.description setSelectable:NO];
    
    CGRect descriptionRect = self.description.frame;
    descriptionRect.size.height += (2*kLeveredgeSmallPadding);
    
    CGRect newDescriptionContainerRect = self.descriptionContainer.frame;
    newDescriptionContainerRect.size.height += descriptionRect.size.height;
    
    [self.descriptionContainer setFrame:newDescriptionContainerRect];
    
    [self.scrollView addSubview:self.description];
};

- (void)buildCommentsContainer {
    self.commentsContainer = [[UIView alloc]initWithFrame:CGRectMake(0.0f,self.descriptionContainer.frame.origin.y+self.descriptionContainer.frame.size.height, self.view.frame.size.width,0.0f)];
    [self.commentsContainer setBackgroundColor:[UIColor darkGrayColor]];
    
    self.commentsView = [[SDRCommentsView alloc]initWithFrame:CGRectMake(kLeveredgeSmallPadding, self.descriptionContainer.frame.origin.y+self.descriptionContainer.frame.size.height +kLeveredgeSmallPadding,self.view.frame.size.width, 0.0f) forVendor:self.vendor];
    
    [self setCommentsContainerSize];
    
    [self.scrollView addSubview:self.commentsContainer];
    [self.scrollView addSubview:self.commentsView];
};

- (void)setScrollViewContentSize{
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrollView.subviews) {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrollView.contentSize = contentRect.size;
}

- (void)setCommentsContainerSize{
    CGRect contentRect = CGRectZero;
    CGRect newCommentsViewFrame = self.commentsView.frame;
    for (UIView *view in self.commentsView.subviews) {
        contentRect = CGRectUnion(contentRect,view.frame);
    }
    newCommentsViewFrame.size.height = contentRect.size.height;
    [self.commentsView setFrame:newCommentsViewFrame];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

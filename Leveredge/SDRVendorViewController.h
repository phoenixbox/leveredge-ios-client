//
//  SDRVendorViewController.h
//  Leveredge
//
//  Created by Shane Rogers on 2/2/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDRVendor.h"
#import "SDRCommentsView.h"
#import "SDRCarousel.h"
#import "SDRCommentsView.h"

@interface SDRVendorViewController : UIViewController {
    float _detailElementWidth;
}

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) SDRVendor *vendor;;
@property(nonatomic, strong) UIButton *leveredgeButton;

// Vendor Image Carousel Section
@property(nonatomic, strong) SDRCarousel *carousel;

// Vendor Title Section
@property(nonatomic, strong) UIView *titleContainer;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *summary;
@property(nonatomic, strong) UIImageView *vendorType;
@property(nonatomic, strong) UIView *leveredgeScore;

// Vendor Details Section
@property(nonatomic, strong) UIView *detailsContainer;
@property(nonatomic, strong) UILabel *phoneNumber;
@property(nonatomic, strong) UILabel *websiteUrl;
@property(nonatomic, strong) UILabel *address;
@property(nonatomic, strong) UILabel *city;
@property(nonatomic, strong) UILabel *state;
@property(nonatomic, strong) UILabel *zipcode;

// Vendor Description Section
@property(nonatomic, strong) UIView *descriptionContainer;
@property(nonatomic, strong) UITextView *description;

// Vendor Comments Section
@property(nonatomic, strong) UIView *commentsContainer;
@property(nonatomic, strong) SDRCommentsView* commentsView;

- (void)setViewWithVendor:(SDRVendor *)v;
@end

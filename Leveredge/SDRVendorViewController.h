//
//  SDRVendorViewController.h
//  Leveredge
//
//  Created by Shane Rogers on 2/2/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDRVendor.h"
#import "SDRCarousel.h"

@interface SDRVendorViewController : UIViewController

@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) UIView *titleContainer;
@property(nonatomic, strong) UIView *detailsContainer;
@property(nonatomic, strong) UITextView *description;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *summary;
@property(nonatomic, strong) SDRVendor *vendor;;
@property(nonatomic, strong) SDRCarousel *carousel;
@property(nonatomic, strong) UIImageView *vendorType;
@property(nonatomic, strong) UIView *leveredgeScore;

@property(nonatomic, strong) UILabel *phoneNumber;
@property(nonatomic, strong) UILabel *websiteUrl;
@property(nonatomic, strong) UILabel *address;
@property(nonatomic, strong) UILabel *city;
@property(nonatomic, strong) UILabel *state;
@property(nonatomic, strong) UILabel *zipcode;

- (void)setViewWithVendor:(SDRVendor *)v;
@end

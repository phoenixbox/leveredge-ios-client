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
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *summary;
@property(nonatomic, strong) SDRVendor *vendor;;
@property(nonatomic, strong) SDRCarousel *carousel;
@property(nonatomic, strong) UIImageView *vendorType;
@property(nonatomic, strong) UIView *leveredgeScore;

- (void)setViewWithVendor:(SDRVendor *)v;
@end

//
//  SDRVendorViewController.h
//  Leveredge
//
//  Created by Shane Rogers on 2/2/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDRVendor.h"

@interface SDRVendorViewController : UIViewController

@property(nonatomic, strong) UILabel *placeholderLabel;
@property(nonatomic, strong) SDRVendor *vendor;;

- (void)setViewWithVendor:(SDRVendor *)v;
@end

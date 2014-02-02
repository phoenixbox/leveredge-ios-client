//
//  SDRVendor.h
//  Leveredge
//
//  Created by Shane Rogers on 2/2/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface SDRVendor : NSObject <JSONSerializable>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *vendor_type;
@property (nonatomic, strong) NSString *thumbnail;
//@property (nonatomic, strong) UIImageView *thumbnail;
@property (nonatomic, strong) NSString *phone_number;
@property (nonatomic, strong) NSString *website_url;
@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *zip_code;

@end

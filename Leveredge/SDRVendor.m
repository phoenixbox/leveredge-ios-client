//
//  SDRVendor.m
//  Leveredge
//
//  Created by Shane Rogers on 2/2/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRVendor.h"
#import "SDRVendorStore.h"

@implementation SDRVendor

- (void)readFromNSObject:(NSObject *)object {
}

- (void)readFromJSONDictionary:(NSDictionary *)d {
    // Parsing response for vendors on users
    if ([d objectForKey:@"vendor"]){
        d = [d objectForKey:@"vendor"];
        if([self vendorExists:[d objectForKey:@"id"]]){
            [self constructVendor:d];
        }
    }
    if([self vendorExists:[d objectForKey:@"id"]]){
        [self constructVendor:d];
    }
}

- (BOOL)vendorExists:(NSNumber *)vId {
    NSMutableArray *vendors = [[SDRVendorStore sharedStore] allVendors];
    for(SDRVendor *vendor in vendors){
        if ([vendor.vendorID isEqualToNumber:vId]){
            return FALSE;
        }
    }
    return TRUE;
}

- (void)constructVendor:(NSDictionary *)d {
    
    [self setVendorID:[d objectForKey:@"id"]];
    [self setTitle:[d objectForKey:@"title"]];
    [self setDescription:[d objectForKey:@"description"]];
    [self setSummary:[d objectForKey:@"summary"]];
    [self setVendorType:[d objectForKey:@"vendor_type"]];
    [self setThumbnail:[d objectForKey:@"thumbnail"]];
    [self setPhoneNumber:[d objectForKey:@"phone_number"]];
    [self setWebsiteUrl:[d objectForKey:@"website_url"]];
    [self setAddress:[d objectForKey:@"address"]];
    [self setCity:[d objectForKey:@"city"]];
    [self setState:[d objectForKey:@"state"]];
    [self setZipCode:[d objectForKey:@"zip_code"]];
    
    [[SDRVendorStore sharedStore] addVendor:self];
    
    // Use SDWebImage library to render web images
    // [self.imageView setImageWithURL:[NSURL URLWithString:@"http://www.domain.com/path/to/image.jpg"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
}

@end

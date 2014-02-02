//
//  SDRVendor.m
//  Leveredge
//
//  Created by Shane Rogers on 2/2/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRVendor.h"

@implementation SDRVendor

- (void)readFromJSONDictionary:(NSDictionary *)d {
    
    [self setTitle:[[d objectForKey:@"title"] objectForKey:@"title"]];
    [self setDescription:[[d objectForKey:@"description"] objectForKey:@"description"]];
    [self setTitle:[[d objectForKey:@"summary"] objectForKey:@"summary"]];
    [self setTitle:[[d objectForKey:@"vendor_type"] objectForKey:@"vendor_type"]];
    [self setTitle:[[d objectForKey:@"thumbnail"] objectForKey:@"thumbnail"]];
    [self setTitle:[[d objectForKey:@"phone_number"] objectForKey:@"phone_number"]];
    [self setTitle:[[d objectForKey:@"website_url"] objectForKey:@"website_url"]];
    [self setTitle:[[d objectForKey:@"address"] objectForKey:@"address"]];
    [self setTitle:[[d objectForKey:@"city"] objectForKey:@"city"]];
    [self setTitle:[[d objectForKey:@"state"] objectForKey:@"state"]];
    [self setTitle:[[d objectForKey:@"zip_code"] objectForKey:@"zip_code"]];

    // Use SDWebImage library to render web images
    // [self.imageView setImageWithURL:[NSURL URLWithString:@"http://www.domain.com/path/to/image.jpg"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
}

@end

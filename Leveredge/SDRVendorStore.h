//
//  SDRVendorStore.h
//  Leveredge
//
//  Created by Shane Rogers on 2/2/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SDRVendorChannel;
@class SDRVendor;
@class SDRUser;

@interface SDRVendorStore : NSObject {
    NSMutableArray *allVendors;
}

+ (SDRVendorStore *)sharedStore;
- (void)addVendor:(SDRVendor *)vendor;
- (NSMutableArray *)allVendors;

- (void)fetchVendorsWithCompletion:(void (^)(SDRVendorChannel *obj, NSError *err))block;
- (void)createPreQualificationforVendor:(SDRVendor *)vendor WithCompletion:(void (^)(SDRUser *, NSError *))block;

@end

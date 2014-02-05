//
//  SDRUserStore.h
//  Leveredge
//
//  Created by Shane Rogers on 2/3/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDRUser.h"

@interface SDRUserStore : NSObject {
    SDRUser *currentUser;
}

+ (SDRUserStore *)sharedStore;
- (SDRUser *)currentUser;

- (void)loginRequest:(NSDictionary *)parameters withCompletionBlock:(void (^)(SDRUser *obj, NSError *err))block;

@end

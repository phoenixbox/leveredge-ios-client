//
//  SDRUserStore.h
//  Leveredge
//
//  Created by Shane Rogers on 2/3/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDRUser.h"

@interface SDRAuthStore : NSObject {
    SDRUser *currentUser;
}

@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *email;
@property (assign, nonatomic) BOOL loggedIn;

+ (SDRAuthStore *)sharedStore;
+ (BOOL)loggedIn;
- (void)addCurrentUser:(SDRUser *)user;
- (SDRUser *)currentUser;
- (void)setToken:(NSString *)t;
- (void)setEmail:(NSString *)e;

- (void)loginRequest:(NSDictionary *)parameters withCompletionBlock:(void (^)(SDRUser *obj, NSError *err))block;

@end

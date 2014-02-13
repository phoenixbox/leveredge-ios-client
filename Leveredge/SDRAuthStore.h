//
//  SDRUserStore.h
//  Leveredge
//
//  Created by Shane Rogers on 2/3/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDRUser.h"

@interface SDRAuthStore : NSObject

@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *email;
@property (assign, nonatomic) BOOL loggedIn;
@property (strong, nonatomic) SDRUser *currentUser;

+ (SDRAuthStore *)sharedStore;
+ (BOOL)loggedIn;
- (void)addCurrentUser:(SDRUser *)user;
- (void)setToken:(NSString *)t;
- (void)setEmail:(NSString *)e;

- (void)loginRequest:(NSDictionary *)parameters withCompletionBlock:(void (^)(SDRUser *obj, NSError *err))block;

@end

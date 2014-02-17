//
//  SDRAuthStore.m
//  Leveredge
//
//  Created by Shane Rogers on 2/3/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRAuthStore.h"
#import "SDRAppConstants.h"
#import "SDRConnection.h"

@implementation SDRAuthStore

+ (SDRAuthStore *)sharedStore {
    static SDRAuthStore *authStore = nil;
    
    if(!authStore) {
        authStore = [[SDRAuthStore alloc]init];
        if(authStore.token){
            authStore.loggedIn=YES;
        }
    };
    return authStore;
}

+ (BOOL)loggedIn
{
    return [[SDRAuthStore sharedStore] loggedIn];
}

+ (NSString *)token
{
    return [[SDRAuthStore sharedStore] token];
}

- (void)addCurrentUser:(SDRUser *)user {
    if(!self.currentUser){
        self.currentUser = [SDRUser new];
    }
    self.currentUser = user;
}

- (void)logout
{
    NSLog(@"logout");
    self.token = nil;
    self.loggedIn = NO;
}

#pragma mark Accessors

- (NSString *)token
{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"token"];
}

//- (void)setToken:(NSString *)t
//{
//    self.token = t;
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setValue:t forKey:@"token"];
//    [defaults synchronize];
//}

//- (void)setEmail:(NSString *)e
//{
//    self.email = e;
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    [defaults setValue:e forKey:@"email"];
//    [defaults synchronize];
//}

- (void)loginRequest:(NSDictionary *)parameters withCompletionBlock:(void (^)(SDRUser *obj, NSError *err))block {
    
    // Create the request.
    NSString *requestString = [self constructLoginRequest:parameters];
    // Prepare the request URL
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestString] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:1000.0];

    // Specify that it will be a POST request
    [req setHTTPMethod:@"POST"];
    // Set the header fields
    [req setValue:@"application/json" forHTTPHeaderField:@"content-type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"accept"];
    
    // Set the connection
    SDRUser *user = [SDRUser new];
    SDRConnection *connection = [[SDRConnection alloc]initWithRequest:req];
    
    [connection setCompletionBlock:^(SDRUser *obj, NSError *err){
        if(!err){
            NSLog(@"Logging in successfully :)");
        }
        block(obj, err);
    }];

    [connection setJsonRootObject:user];
    
    [connection start];
}

- (NSString *)constructLoginRequest:(NSDictionary *)parameters {
    NSString *email = [parameters objectForKey:@"email"];
    NSString *password = [parameters objectForKey:@"password"];
    
    NSString *requestString = [NSString stringWithFormat:kAPIUserLogin];
    requestString = [requestString stringByAppendingString:(@"?email=")];
    requestString = [requestString stringByAppendingString:email];
    requestString = [requestString stringByAppendingString:(@"&password=")];
    requestString = [requestString stringByAppendingString:password];
    return requestString;
}

@end

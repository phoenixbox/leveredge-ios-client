//
//  SDRConnection.m
//  Leveredge
//
//  Created by Shane Rogers on 2/2/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRConnection.h"

// Keep reference to connections so they are not released before completion or error
static NSMutableArray *sharedConnectionList = nil;

@implementation SDRConnection

@synthesize request, completionBlock, jsonRootObject;

-(id)initWithRequest:(NSURLRequest *)req{
    self = [super init];
    if(self){
        [self setRequest:req];
    }
    return self;
}

-(void)start {
    dataContainer = [NSMutableData new];
    internalConnection = [[NSURLConnection alloc]initWithRequest:[self request] delegate:self startImmediately:YES];
    
    if(!sharedConnectionList){
        sharedConnectionList = [NSMutableArray new];
    }
    
    [sharedConnectionList addObject:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [dataContainer appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    id rootObject = nil;
    if ([self jsonRootObject]){
        
        NSObject *serializedObject = [NSJSONSerialization JSONObjectWithData:dataContainer options:0 error:nil];
        [[self jsonRootObject] readFromNSObject:serializedObject];
        rootObject = [self jsonRootObject];
    }
    if([self completionBlock]){
        [self completionBlock](rootObject, nil);
    }
    [sharedConnectionList removeObject:self];
}

- (void)requestError:(NSError *)error {
//    if([self completionBlock]){
//        [self completionBlock](nil, error);
//    }
    [sharedConnectionList removeObject:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    if([self completionBlock]){
        [self completionBlock](nil, error);
    }
    [sharedConnectionList removeObject:self];
}

@end

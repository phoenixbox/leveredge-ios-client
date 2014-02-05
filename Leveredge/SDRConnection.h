//
//  SDRConnection.h
//  Leveredge
//
//  Created by Shane Rogers on 2/2/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONSerializable.h"

@interface SDRConnection : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate> {
    NSURLConnection *internalConnection;
    NSMutableData *dataContainer;
    NSDictionary *userInfo;
}

@property (nonatomic, copy) NSURLRequest *request;
@property (nonatomic, copy) void (^completionBlock)(id obj, NSError *err);
@property (nonatomic, strong) id <JSONSerializable> jsonRootObject;

-(id)initWithRequest:(NSURLRequest *)req;
-(void)start;

@end

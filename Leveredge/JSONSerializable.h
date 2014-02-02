//
//  JSONSerializable.h
//  Leveredge
//
//  Created by Shane Rogers on 2/2/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JSONSerializable <NSObject>

- (void)readFromJSONArray:(NSArray *)array;
- (void)readFromJSONDictionary:(NSDictionary *)d;

@end

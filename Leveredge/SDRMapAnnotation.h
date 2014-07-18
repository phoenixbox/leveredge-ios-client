//
//  SDRMapAnnotation.h
//  Leveredge
//
//  Created by Shane Rogers on 7/17/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapKit/MapKit.h"

@interface SDRMapAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy, readonly) NSString *title; // Whats the copy property really do?
@property (nonatomic, copy, readonly) NSString *subtitle;

// Whats the instanceType declaration -
- (instancetype) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates title:(NSString *)title subtitle:(NSString *)subtitle;

@end

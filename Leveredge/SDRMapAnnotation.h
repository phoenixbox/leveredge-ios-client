//
//  SDRMapAnnotation.h
//  Leveredge
//
//  Created by Shane Rogers on 7/17/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapKit/MapKit.h"

extern NSString *const kReusablePinRed;
extern NSString *const kReusablePinGreen;
extern NSString *const kReusablePinPurple;

@interface SDRMapAnnotation : NSObject <MKAnnotation>

@property (nonatomic, unsafe_unretained, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy, readonly) NSString *title; // Whats the copy property really do?
@property (nonatomic, copy, readonly) NSString *subtitle;
@property (nonatomic, unsafe_unretained) MKPinAnnotationColor pinColor;

// Whats the instanceType declaration -
- (instancetype) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates
                               title:(NSString *)title
                            subtitle:(NSString *)subtitle;

+ (NSString *) reusableIdentifierforPinColor:(MKPinAnnotationColor)paramColor;

@end

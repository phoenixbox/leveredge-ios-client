//
//  SDRMapAnnotation.m
//  Leveredge
//
//  Created by Shane Rogers on 7/17/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRMapAnnotation.h"

NSString *const kReusablePinRed = @"Red";
NSString *const kReusablePinGreen = @"Green";
NSString *const kReusablePinPurple = @"Purple";

@implementation SDRMapAnnotation

- (instancetype) initWithCoordinates:(CLLocationCoordinate2D)paramCoordinates
                               title:(NSString *)title
                            subtitle:(NSString *)subtitle {
    // Whats the official reason for this pattern?
    self = [super init];
    
    if(self != nil) {
        // declaration of _ variable but not self._var why? - does this _coordinate have class scope?
        _coordinate = paramCoordinates;
        _title = title;
        _subtitle = subtitle;
        _pinColor = MKPinAnnotationColorPurple;
    };
    return self;
}

+ (NSString *) reusableIdentifierforPinColor:(MKPinAnnotationColor)paramColor {
    NSString *result = nil;
    
    switch (paramColor) {
        case MKPinAnnotationColorRed:{
            result = kReusablePinRed;
            break;
        }
        case MKPinAnnotationColorGreen:{
            result = kReusablePinGreen;
            break;
        }
        case MKPinAnnotationColorPurple:{
            result = kReusablePinPurple;
            break;
        }
    }
    
    return result;
}

@end

//
//  SDRAlertComponent.h
//  Leveredge
//
//  Created by Shane Rogers on 7/13/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDRAlertComponent : NSObject

- (id)initAlertWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles targetView:(UIView *)target;

- (void)showAlertView;

@end

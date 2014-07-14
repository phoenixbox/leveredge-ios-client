//
//  SDRAlertComponent.m
//  Leveredge
//
//  Created by Shane Rogers on 7/13/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRAlertComponent.h"

@interface SDRAlertComponent()

@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *targetView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *message;
@property (nonatomic, strong) NSArray *buttonTitles;
@property (nonatomic) CGRect initialAlertViewFrame;

@end

@implementation SDRAlertComponent

@end

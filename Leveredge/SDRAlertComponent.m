//
//  SDRAlertComponent.m
//  Leveredge
//
//  Created by Shane Rogers on 7/13/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRAlertComponent.h"

@interface SDRAlertComponent()

@property (nonatomic, strong) UIView *_alertView;
@property (nonatomic, strong) UIView *_backgroundView;
@property (nonatomic, strong) UIView *_targetView;
@property (nonatomic, strong) UILabel *_titleLabel;
@property (nonatomic, strong) UILabel *_messageLabel;
@property (nonatomic, strong) UIDynamicAnimator *_animator;
@property (nonatomic, strong) NSString *_title;
@property (nonatomic, strong) NSString *_message;
@property (nonatomic, strong) NSArray *_buttonTitles;
@property (nonatomic) CGRect _initialAlertViewFrame;

-(void)setupAlertView;
-(void)setupBackgroundView;

@end

@implementation SDRAlertComponent

-(id)initAlertWithTitle:(NSString *)title message:(NSString *)message buttonTitles:(NSArray *)buttonTitles targetView:(UIView *)target {
    [self setupAlertView];
    [self setupBackgroundView];


    return self;
}

- (void)setupAlertView {
    // Size and position the alertView
    CGSize alertViewSize = CGSizeMake(250.0,130.0 + 50.0 * self._buttonTitles.count);
    // Set the origin point to be off screen
    // TODO: Tweak the X value to see changes
    CGPoint initialOriginPoint = CGPointMake(self._targetView.center.x,self._targetView.center.y - alertViewSize.height);
    
    self._alertView = [[UIView alloc] initWithFrame:CGRectMake(initialOriginPoint.x,initialOriginPoint.y, alertViewSize.width, alertViewSize.height)];
    
    [self._alertView setBackgroundColor:[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1.0]];

    // NOTE: affecting the layer component
    [self._alertView.layer setCornerRadius:10.0];
    [self._alertView.layer setBorderWidth:1.0];
    // NOTE: use the QuartzColor reference that corresponds to the recievers color
    [self._alertView.layer setBorderColor:[UIColor blackColor].CGColor];
    
    // What is the state of the frame cahced for?
    self._initialAlertViewFrame = self._alertView.frame;
}

- (void)setupBackgroundView {
    // Take config options and init the semi-transp background view
}

@end

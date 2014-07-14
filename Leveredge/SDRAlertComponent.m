//
//  SDRAlertComponent.m
//  Leveredge
//
//  Created by Shane Rogers on 7/13/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRAlertComponent.h"
#import "SDRViewConstants.h"

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
    if (self =[super init]){
        self._title = title;
        self._message = message;
        self._buttonTitles = buttonTitles;
        self._targetView = target;

        [self setupBackgroundView];
        [self setupAlertView];

        // IMP: Reference is the target view: thus it uses the referenceView's coordinate system
        self._animator = [[UIDynamicAnimator alloc]initWithReferenceView:self._targetView];
    }
    
    return self;
}

- (void)setupAlertView {
    [self initAlertView];
    [self addTitleLabel];
    [self addMessageLabel];
    [self addButtons];

    [self._targetView addSubview:self._alertView];
}

- (void)setupBackgroundView {
    self._backgroundView = [[UIView alloc]initWithFrame:self._targetView.frame];
    [self._backgroundView setBackgroundColor:[UIColor grayColor]];
    [self._backgroundView setAlpha:0.0];
    [self._targetView addSubview:self._backgroundView];
}

- (void)initAlertView {
    // Size and position the alertView
    CGSize alertViewSize = CGSizeMake(250.0, 130.0 + 50.0 * self._buttonTitles.count);
    // Set the origin point to be off screen
    // TODO: Tweak the X value to see changes
    CGPoint initialOriginPoint = CGPointMake(self._targetView.center.x,-self._targetView.frame.size.height);
    
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

- (void)addTitleLabel {
    // Setup the title label
    self._titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0,10.0,self._alertView.frame.size.width,40.0)];
    [self._titleLabel setText:self._title];
    [self._titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self._titleLabel setFont:[UIFont fontWithName:@"Avenir-Heavy" size:14.0]];
    [self._alertView addSubview:self._titleLabel];
}

- (void)addMessageLabel {
    // Setup the messageLabel
    self._messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0, self._titleLabel.frame.origin.y + self._titleLabel.frame.size.height, self._alertView.frame.size.width, 40.0)];
    [self._messageLabel setText:self._message];
    [self._messageLabel setTextAlignment:NSTextAlignmentCenter];
    [self._messageLabel setFont:[UIFont fontWithName:@"Avenir-Heavy" size:14.0]];
    // NOTE: setNumberOfLines
    [self._messageLabel setNumberOfLines:3];
    [self._messageLabel setLineBreakMode:NSLineBreakByWordWrapping];
    
    [self._alertView addSubview:self._messageLabel];
}

- (void)addButtons {
    // Cache the Y origin of the last button to be incremented in a for loop
    // TODO: Extract to a button creation enumerator class
    CGFloat lastSubviewBottomY = self._messageLabel.frame.origin.y + self._messageLabel.frame.size.height;
    
    for (int i=0;i<[self._buttonTitles count];i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10.0,lastSubviewBottomY + 5.0, self._alertView.frame.size.width - 20.0,40.0)];
        [button setTitle:[self._buttonTitles objectAtIndex:i] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont fontWithName:@"Avenir" size:13.0]];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:kLeveredgeGrey forState:UIControlStateHighlighted];
        [button setBackgroundColor:kQLYellow];
        [button addTarget:self action:@selector(handleButtonTap) forControlEvents:UIControlEventTouchUpInside];
        // NOTE: Use of a tag for identifying UIElements when we trigger the selector
        [button setTag:i+1];
        
        [self._alertView addSubview:button];
        lastSubviewBottomY = button.frame.origin.y + button.frame.size.height;
    }

}

- (void)handleButtonTap {
}

#pragma mark - Public Methods

- (void)showAlertView {
    // Wipe the animations to start
    [self._animator removeAllBehaviors];
    // Behavior belongs to the _alertView - snapping to the _targetView
    UISnapBehavior *snapBehavior = [[UISnapBehavior alloc]initWithItem:self._alertView snapToPoint:self._targetView.center];
    // TODO: Tweak to understand effect
    snapBehavior.damping = 0.8;
    [self._animator addBehavior:snapBehavior];
    
    // Execute async block to trigger animation over time n
    [UIView animateWithDuration:0.75 animations:^{
        [self._backgroundView setAlpha:0.5];
    }];
}

@end

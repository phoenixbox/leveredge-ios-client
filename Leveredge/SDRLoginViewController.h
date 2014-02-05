//
//  SDRLoginViewController.h
//  Leveredge
//
//  Created by Shane Rogers on 1/26/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDRLoginViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) UILabel *logoLabel;
@property (nonatomic, strong) UITextView *logoSubHeader;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextField *emailField;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIActivityIndicatorView *requestIndicator;

@end

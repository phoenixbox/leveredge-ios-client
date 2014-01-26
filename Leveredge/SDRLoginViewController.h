//
//  SDRLoginViewController.h
//  Leveredge
//
//  Created by Shane Rogers on 1/26/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDRLoginViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic)UILabel *logoLabel;

@property (strong, nonatomic)UITextField *emailField;
@property (strong, nonatomic)UITextField *passwordField;

@property (strong, nonatomic)UIButton *loginButton;

@end

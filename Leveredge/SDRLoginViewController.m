//
//  SDRLoginViewController.m
//  Leveredge
//
//  Created by Shane Rogers on 1/26/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRLoginViewController.h"

@interface SDRLoginViewController ()

@end

@implementation SDRLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self renderForm];
}

- (void)renderForm {
    [self renderEmailField];
    [self renderPasswordField];
}

- (void)renderEmailField {
    CGRect emailFieldFrame = CGRectMake(0.0f,50.0f, 250.0f, 40.0f);
    self.emailField = [[UITextField alloc] initWithFrame:emailFieldFrame];
    
    [self formatTextField:self.emailField];
    
    self.emailField.text = @"leveredge@it.com";
    self.emailField.center = self.view.center;
    [self.view addSubview:self.emailField];
}

-(void)renderPasswordField {
    CGRect passwordFieldFrame = self.emailField.frame;
    passwordFieldFrame.origin.y += self.emailField.frame.size.height + 10;
    self.passwordField = [[UITextField alloc] initWithFrame:passwordFieldFrame];
    
    [self formatTextField:self.passwordField];
    
    self.passwordField.secureTextEntry = YES;
    self.passwordField.text = @"password";
    
    [self.view addSubview:self.passwordField];
}

- (void)formatTextField:(UITextField *)textField {
    textField.delegate = self;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.textAlignment = NSTextAlignmentCenter;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

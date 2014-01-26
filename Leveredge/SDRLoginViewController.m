//
//  SDRLoginViewController.m
//  Leveredge
//
//  Created by Shane Rogers on 1/26/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRLoginViewController.h"
#import "SDRViewConstants.h"

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
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [self renderScrollView];
    
    [self renderForm];
}

- (void)renderScrollView {
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];
}

- (void)renderForm {
    [self renderEmailField];
    [self renderPasswordField];
    [self renderLoginButton];
}

- (void)renderEmailField {
    CGRect emailFieldFrame = CGRectMake(0.0f,50.0f, 250.0f, 40.0f);
    self.emailField = [[UITextField alloc] initWithFrame:emailFieldFrame];
    self.emailField.text = @"leveredge@it.com";
    self.emailField.center = self.view.center;
    
    [self formatTextField:self.emailField];
}

- (void)renderPasswordField {
    CGRect passwordFieldFrame = self.emailField.frame;
    passwordFieldFrame.origin.y += self.emailField.frame.size.height + 10;
    self.passwordField = [[UITextField alloc] initWithFrame:passwordFieldFrame];
    self.passwordField.secureTextEntry = YES;
    self.passwordField.text = @"password";
    
    [self formatTextField:self.passwordField];
}

- (void)renderLoginButton {
    CGRect loginButtonFrame = self.passwordField.frame;
    loginButtonFrame.origin.y += self.passwordField.frame.size.height + 10;
    self.loginButton = [[UIButton alloc]initWithFrame:loginButtonFrame];
    [self.loginButton setTitle:@"Login" forState:UIControlStateNormal];
    [self.loginButton setTitleColor:kPureWhite forState:UIControlStateNormal];
    self.loginButton.backgroundColor = kLoginButtonColor;
    
    [self.loginButton addTarget:self action:@selector(loginButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:self.loginButton];
}

- (void)loginButtonPressed:(id)paramSender {
    NSLog(@"Email Field is: %@", self.emailField.text);
    NSLog(@"Password Field is: %@", self.passwordField.text);
}

- (void)formatTextField:(UITextField *)textField {
    textField.delegate = self;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:textField];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  SDRLoginViewController.m
//  Leveredge
//
//  Created by Shane Rogers on 1/26/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRLoginViewController.h"
#import "SDRViewConstants.h"
#import "SDRAppDelegate.h"

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
    [self renderLogoPlaceholderAndSubheader];
    [self renderEmailField];
    [self renderPasswordField];
    [self renderLoginButton];
}

- (void)renderLogoPlaceholderAndSubheader {
    //
    self.logoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f,0.0f, 250.0f, 50.0f)];
    [self.logoLabel setCenter:CGPointMake(self.view.frame.size.width/2, 100.0f)];
    [self.logoLabel setText:@"Leveredge"];
    [self.logoLabel setFont:[UIFont systemFontOfSize:35.0f]];
    self.logoLabel.textAlignment = NSTextAlignmentCenter;
    
    CGRect logoSubheaderFrame = self.logoLabel.frame;

    logoSubheaderFrame.origin.y += logoSubheaderFrame.size.height + 10;
    self.logoSubHeader = [[UITextView alloc]initWithFrame:logoSubheaderFrame];
    self.logoSubHeader.contentInset = UIEdgeInsetsMake(10.0f, 0.0f, 0.0f, 0.0f);
    [self.logoSubHeader setText:@"Don't just realize your purchasing power, Leveredge it"];
    [self.logoSubHeader setFont:[UIFont systemFontOfSize:12.0f]];
    self.logoSubHeader.textAlignment = NSTextAlignmentCenter;
    
    [self.scrollView addSubview:self.logoLabel];
    [self.scrollView addSubview:self.logoSubHeader];
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
    
    [self.loginButton addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:self.loginButton];
}

- (void)login:(id)paramSender {
    //    TODO: Success Callback
    SDRAppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    [appDelegate initializeNavigationController];
    
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

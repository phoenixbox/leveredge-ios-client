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
#import "SDRAuthStore.h"
#import "SDRUser.h"

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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //  TODO: Implement scroll view for login screen
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleKeyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleKeyboardWillHide:) name:UIKeyboardDidShowNotification object:nil];
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
    [self.logoLabel setText:kLogoPlaceholder];
    [self.logoLabel setFont:[UIFont systemFontOfSize:35.0f]];
    self.logoLabel.textAlignment = NSTextAlignmentCenter;
    
    CGRect logoSubheaderFrame = self.logoLabel.frame;

    logoSubheaderFrame.origin.y += logoSubheaderFrame.size.height + 10;
    self.logoSubHeader = [[UITextView alloc]initWithFrame:logoSubheaderFrame];
    self.logoSubHeader.contentInset = UIEdgeInsetsMake(10.0f, 0.0f, 0.0f, 0.0f);
    [self.logoSubHeader setText:kLogoSubHeader];
    [self.logoSubHeader setFont:[UIFont systemFontOfSize:12.0f]];
    self.logoSubHeader.textAlignment = NSTextAlignmentCenter;
    [self.logoSubHeader setEditable:NO];
    [self.logoSubHeader setSelectable:NO];
    
    [self.scrollView addSubview:self.logoLabel];
    [self.scrollView addSubview:self.logoSubHeader];
}

- (void)renderEmailField {
    CGRect emailFieldFrame = CGRectMake(0.0f,50.0f, 250.0f, 40.0f);
    self.emailField = [[UITextField alloc] initWithFrame:emailFieldFrame];
    self.emailField.text = kSampleEmail;
    self.emailField.center = self.view.center;
    
    [self formatTextField:self.emailField];
}

- (void)renderPasswordField {
    CGRect passwordFieldFrame = self.emailField.frame;
    passwordFieldFrame.origin.y += self.emailField.frame.size.height + 10;
    self.passwordField = [[UITextField alloc] initWithFrame:passwordFieldFrame];
    self.passwordField.secureTextEntry = YES;
    self.passwordField.text = kSamplePassword;
    
    [self formatTextField:self.passwordField];
}

- (void)renderLoginButton {
    // NOTE origin is not assignable - need to retrieve rect first
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
    NSString *email = self.emailField.text;
    NSString *password = self.passwordField.text;
    
    NSDictionary *loginParameters = [[NSDictionary alloc]initWithObjectsAndKeys:email,@"email",password,@"password",nil];
    
    [self setLoginActivityIndicator];
    
    void(^completionBlock)(SDRUser *obj, NSError *err)=^(SDRUser *obj, NSError *err){
        if(!err){
            SDRAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
            [appDelegate initializeNavigationController];
        } else {
            [self renderErrorMessage:err];
            NSLog(@"Error point");
        }
    };
    [[SDRAuthStore sharedStore]loginRequest:loginParameters withCompletionBlock:completionBlock];
}

- (void)renderErrorMessage:(NSError *)err {
    [[[UIAlertView alloc] initWithTitle:err.localizedDescription
                                message:err.localizedRecoverySuggestion
                               delegate:nil
                      cancelButtonTitle:NSLocalizedString(@"OK", nil)
                      otherButtonTitles:nil, nil] show];

    [self.requestIndicator stopAnimating];
}

- (void)setLoginActivityIndicator {
    self.requestIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.requestIndicator.center = CGPointMake(self.view.frame.size.width / 2.0, self.view.frame.size.height / 2.0);
    self.requestIndicator.center = self.view.center;
    [self.view addSubview:self.requestIndicator];
    
    [self.requestIndicator startAnimating];
}

- (void)formatTextField:(UITextField *)textField {
    textField.delegate = self;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:textField];
}

- (void)handleKeyboardDidShow:(NSNotification *)notification {
    NSValue *keyboardRectAsObject = [[notification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = CGRectZero;
    
    [keyboardRectAsObject getValue:&keyboardRect];
    
    self.scrollView.contentInset = UIEdgeInsetsMake(0.0f,0.0f,keyboardRect.size.height+180,0.0f);
}

- (void)handleKeyboardWillHide:(NSNotification *)notification {
    self.scrollView.contentInset = UIEdgeInsetsZero;
}

#pragma UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.emailField resignFirstResponder];
    [self.passwordField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

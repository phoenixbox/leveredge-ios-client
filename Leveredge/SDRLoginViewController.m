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
#import "SDRUserStore.h"
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
    self.emailField.text = @"rogerssh@tcd.ie";
    self.emailField.center = self.view.center;
    
    [self formatTextField:self.emailField];
}

- (void)renderPasswordField {
    CGRect passwordFieldFrame = self.emailField.frame;
    passwordFieldFrame.origin.y += self.emailField.frame.size.height + 10;
    self.passwordField = [[UITextField alloc] initWithFrame:passwordFieldFrame];
    self.passwordField.secureTextEntry = YES;
    self.passwordField.text = @"uxo6Sife!";
    
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
            [[NSUserDefaults standardUserDefaults] setObject: obj.email forKey:@"email"];
        } else {
            [self renderErrorMessage:err];
        }
    };
    [[SDRUserStore sharedStore]loginRequest:loginParameters withCompletionBlock:completionBlock];
}

- (void)renderErrorMessage:(NSError *)err {
    NSString *errorString = [NSString stringWithFormat:@"Login failed: %@", [err localizedDescription]];
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [av show];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

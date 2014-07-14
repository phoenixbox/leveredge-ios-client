//
//  SDRSelectionsViewController.m
//  Leveredge
//
//  Created by Shane Rogers on 3/15/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRSelectionsViewController.h"

// Component Imports
#import "SDRSlideMenu.h"
#import "SDRAlertComponent.h"

@interface SDRSelectionsViewController ()

@property (nonatomic, strong) SDRSlideMenu *_slideMenu;
@property (nonatomic, strong) SDRAlertComponent *_alertView;

@end

@implementation SDRSelectionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Selections";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self addNavigationItems];

    // TODO: Shoould the target be the controller or the view?
    [self initSlideMenuView];
    [self setupMenuGestures];
    
    [self initAlertView];
}

- (void)addNavigationItems{
    UIImage *filterImage = [UIImage imageNamed:@"alertIcon"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:filterImage landscapeImagePhone:filterImage style:UIBarButtonItemStylePlain target:self action:@selector(showAlert)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
}

- (void)setupMenuGestures {
    UISwipeGestureRecognizer *showMenuGesture = [[UISwipeGestureRecognizer alloc]
                                                 initWithTarget:self
                                                 action:@selector(showMenu:)];
    showMenuGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:showMenuGesture];
}

- (void)initSlideMenuView {
    CGRect desiredMenuFrame = CGRectMake(0.0,20.0,150.0,self.view.frame.size.height);
    self._slideMenu = [[SDRSlideMenu alloc] initWithFrame:desiredMenuFrame
                                               targetView:self.view
                                                direction:menuDirectionLeftToRight
                                                  options:@[@"Download", @"Upload", @"E-mail", @"Settings", @"About"]
                                            optionImages:@[@"download", @"upload", @"email", @"settings", @"info"]];
}

- (void)initAlertView {
    self._alertView = [[SDRAlertComponent alloc]initAlertWithTitle:@"Hello There!"
                                                           message:@"I am the Alert Message"
                                                      buttonTitles:@[@"Good", @"Grand", @"Great"]
                                                        targetView:self.view];
}

-(void)showAlert {
    [self._alertView showAlertView];
}

- (void)showMenu:(UIGestureRecognizer *)gestureRecognizer {
    // The selectedOptionIndex is passed back from the execution of the block
    // when the user selects one of the table cells
    [self._slideMenu showMenuWithSelectionHandler:^(NSInteger selectedOptionIndex){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SlideMenu Selection"
                            message:[NSString stringWithFormat:@"You selected cell number: %ld", selectedOptionIndex+1]
                                                       delegate:nil
                                              cancelButtonTitle:@"Dismiss"
                                              otherButtonTitles:@"Okay", nil];
        [alert show];
    }];
}

- (void)showMenuWithGesture:(UISwipeGestureRecognizer *)gesture {
}

- (void)hideMenuWithGesture:(UISwipeGestureRecognizer *)gesture {
    
};


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

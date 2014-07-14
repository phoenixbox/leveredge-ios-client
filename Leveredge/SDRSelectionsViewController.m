//
//  SDRSelectionsViewController.m
//  Leveredge
//
//  Created by Shane Rogers on 3/15/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRSelectionsViewController.h"
#import "SDRSlideMenu.h"

@interface SDRSelectionsViewController ()

@property (nonatomic, strong) SDRSlideMenu *_slideMenu;

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
    
    // TODO: Shoould the target be the controller or the view?
    [self initSlideMenuView];
    [self setupMenuGestures];
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

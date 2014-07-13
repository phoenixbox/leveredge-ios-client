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
    [self._slideMenu showMenu];
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

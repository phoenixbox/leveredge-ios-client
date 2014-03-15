//
//  SDRFilterTableViewController.m
//  Leveredge
//
//  Created by Shane Rogers on 3/15/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRFilterTableViewController.h"
#import "SDRViewConstants.h"

@interface SDRFilterTableViewController ()

@end

@implementation SDRFilterTableViewController

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
    [self setAppearance];
}

- (void)setAppearance{
    [self.view setBackgroundColor:kPureWhite];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStylePlain target:self action:@selector(dismissModal)];
    [self.navigationItem.rightBarButtonItem setTintColor:kPureWhite];
}

- (void)dismissModal{
 [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

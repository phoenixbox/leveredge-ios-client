//
//  SDRAppDelegate.m
//  Leveredge
//
//  Created by Shane Rogers on 1/26/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRAppDelegate.h"
#import "SDRLoginViewController.h"
#import "SDRVendorsListViewController.h"
#import "SDRLeveredgeSelectionsViewController.h"
#import "SDRViewConstants.h"

@implementation SDRAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    SDRLoginViewController *loginViewController = [[SDRLoginViewController alloc]init];
    [[self window] setRootViewController:loginViewController];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)initializeNavigationController{
    SDRVendorsListViewController *vendorsListViewController = [SDRVendorsListViewController new];
    SDRLeveredgeSelectionsViewController *leveredgeSelectionsViewController = [SDRLeveredgeSelectionsViewController new];

    UINavigationController *vendorsListViewNavController = [[UINavigationController alloc]initWithRootViewController:vendorsListViewController];
    UINavigationController *leveredgeSelectionsViewNavController = [[UINavigationController alloc]initWithRootViewController:leveredgeSelectionsViewController];

    UITabBarController *leveredgeTabBarController = [UITabBarController new];
    [leveredgeTabBarController setViewControllers:@[vendorsListViewNavController,leveredgeSelectionsViewNavController]];
    [self styleTabBar:leveredgeTabBarController.tabBar];
    
    [[self window] setRootViewController:leveredgeTabBarController];
}

- (void)styleTabBar:(UITabBar *)tabBar {
    [[UITabBar appearance] setBarTintColor:kLeveredgeBlue];
    [[UITabBar appearance] setSelectedImageTintColor:kPureWhite];
    NSArray *tabBarTitlesMap = @[@"Food", @"Selections"];
    NSArray *tabBarImagesMap = @[@"knifeAndFork", @"selections"];
    
    [[tabBar items] enumerateObjectsUsingBlock:^(UITabBarItem *item, NSUInteger index, BOOL *stop){
        [self setTabItemImages:item withTitle:[tabBarTitlesMap objectAtIndex:index] andImageName:[tabBarImagesMap objectAtIndex:index]];
    }];
}

- (void)setTabItemImages:(UITabBarItem *)item withTitle:(NSString *)title andImageName:(NSString *)imageName {
    [item setTitle:title];
    [item setImage:[[UIImage imageNamed:[imageName stringByAppendingString:@"Unhighlighted.png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item setSelectedImage:[[UIImage imageNamed:[imageName stringByAppendingString:@"Highlighted.png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [item setTitleTextAttributes:@{ NSForegroundColorAttributeName : kLeveredgeDeselectedGrey } forState:UIControlStateNormal];
    [item setTitleTextAttributes:@{ NSForegroundColorAttributeName : kPureWhite } forState:UIControlStateHighlighted];
};

@end

//
//  SDRVendorsListViewController.h
//  Leveredge
//
//  Created by Shane Rogers on 2/1/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDRVendorsListViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *vendorsTable;

@end

//
//  SDRVendorsListViewController.h
//  Leveredge
//
//  Created by Shane Rogers on 2/1/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDRFilterTableViewController.h"

@class SDRVendorChannel;

@interface SDRVendorsListViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource> {
    SDRVendorChannel *vendorChannel;
}

@property (nonatomic, strong) UITableView *vendorsTable;
@property (nonatomic, strong) SDRFilterTableViewController *filterListModal;

@end

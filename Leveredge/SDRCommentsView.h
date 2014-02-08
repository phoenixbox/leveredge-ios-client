//
//  SDRCommentsView.h
//  Leveredge
//
//  Created by Shane Rogers on 2/8/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDRVendor.h"

@interface SDRCommentsView : UIView <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *commentsTable;

- (id)initWithFrame:(CGRect)frame forVendor:(SDRVendor *)vendor;

@end

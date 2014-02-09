//
//  SDRCommentsView.h
//  Leveredge
//
//  Created by Shane Rogers on 2/8/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDRVendor.h"
#import "SDRCommentViewCell.h"

@interface SDRCommentsView : UIView <UITableViewDelegate, UITableViewDataSource> {
    NSArray *_copySamples;
    float _totalCellsHeight;
}

@property (nonatomic, strong) UITableView *commentsTable;
@property (strong) SDRCommentViewCell *cellPrototype;

- (id)initWithFrame:(CGRect)frame forVendor:(SDRVendor *)vendor;

@end

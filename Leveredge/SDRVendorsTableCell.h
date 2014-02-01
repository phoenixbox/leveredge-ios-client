//
//  SDRVendorsTableCell.h
//  Leveredge
//
//  Created by Shane Rogers on 2/1/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDRVendorsTableCell : UITableViewCell

@property (nonatomic, strong)UIView *vendorsThumbnail;
@property (nonatomic, strong)UIView *textContainer;
@property (nonatomic, strong)UILabel *vendorsTitleLabel;
@property (nonatomic, strong)UILabel *vendorsDescriptionLabel;

@end

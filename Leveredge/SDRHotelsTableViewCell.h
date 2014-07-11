//
//  SDRHotelsTableViewCell.h
//  Leveredge
//
//  Created by Shane Rogers on 5/21/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDRLeveredgeButton.h"

@interface SDRHotelsTableViewCell : UITableViewCell

@property (nonatomic, strong)SDRLeveredgeButton *videoThumbnail;
@property (nonatomic, strong)UILabel *hotelNameLabel;

@end

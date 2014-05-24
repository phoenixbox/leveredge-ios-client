//
//  SDRRoomsTableViewCell.m
//  Leveredge
//
//  Created by Shane Rogers on 5/21/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRRoomsTableViewCell.h"
#import "SDRViewConstants.h"

@implementation SDRRoomsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self renderCellImage];
        [self renderCellCopy];
    }
    return self;
}

- (void)renderCellImage {
    //   Square thumbnail to the side
    self.videoThumbnail = [[UIView alloc]initWithFrame:CGRectMake(self.frame.origin.x+10, self.frame.origin.x+10, 100.0f, 80.0f)];
    [self.videoThumbnail setBackgroundColor:kLeveredgeBlue];
    
    [self.contentView addSubview:self.videoThumbnail];
}

- (void)renderCellCopy {
    CGRect videoFrame = self.videoThumbnail.frame;
    float xOrigin = videoFrame.origin.x+videoFrame.size.width+10;
    float yOrigin = videoFrame.origin.y;
    
    self.roomNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(xOrigin, yOrigin, self.frame.size.width*0.75, 50.0f)];
    [self.roomNameLabel setText:@"Bedroom"];
    [self.contentView addSubview:self.roomNameLabel];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

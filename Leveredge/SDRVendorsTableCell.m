//
//  SDRVendorsTableCell.m
//  Leveredge
//
//  Created by Shane Rogers on 2/1/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRVendorsTableCell.h"
#import "SDRViewConstants.h"

@implementation SDRVendorsTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self renderCellImage];
        [self renderCellCopy];
    }
    return self;
}

- (void)renderCellImage {
    self.vendorsThumbnail = [[UIView alloc]initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, kVendorsTableCellHeight)];
    
    UIGraphicsBeginImageContext(self.vendorsThumbnail.frame.size);
    [[UIImage imageNamed:@"littleowl.jpg"] drawInRect:CGRectMake(self.frame.origin.x,self.frame.origin.y,self.frame.size.width,kVendorsTableCellHeight)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.backgroundColor = [UIColor colorWithPatternImage:image];
    
    [self.contentView addSubview:self.vendorsThumbnail];
}

- (void)renderCellCopy {
    [self renderCopyContainer];
    [self renderCopyText];
    
}

- (void)renderCopyContainer {
    self.textContainer = [[UIView alloc]initWithFrame:CGRectMake(0.0f,100.0f,self.frame.size.width,kVendorsTableCellHeight-100.0f)];
    [self.textContainer setBackgroundColor:kAlphaWhite30];
    [self.contentView addSubview:self.textContainer];
}

- (void)renderCopyText {
    self.vendorsTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5.0f,0.0f,self.frame.size.width*0.75,40.0f)];
    [self.vendorsTitleLabel setText:@"The Little Owl"];
    self.vendorsTitleLabel.textColor = kPureWhite;
    [self.vendorsTitleLabel setFont:[UIFont systemFontOfSize:20.0f]];
    self.vendorsTitleLabel.textAlignment = NSTextAlignmentLeft;
    [self.vendorsTitleLabel setBackgroundColor:[UIColor clearColor]];
    [self.textContainer addSubview:self.vendorsTitleLabel];
    
    CGRect vendorsDescriptionFrame = self.vendorsTitleLabel.frame;
    vendorsDescriptionFrame.origin.y += vendorsDescriptionFrame.size.height;
    vendorsDescriptionFrame.size.height = self.textContainer.frame.size.height - vendorsDescriptionFrame.size.height;
    
    self.vendorsDescriptionLabel = [[UILabel alloc]initWithFrame:vendorsDescriptionFrame];
    [self.vendorsDescriptionLabel setText:@"Bold flavored Mediterranean cusine."];
    [self.vendorsDescriptionLabel setFont:[UIFont systemFontOfSize:12.0f]];
    self.self.vendorsDescriptionLabel.textColor = kPureWhite;
    [self.vendorsDescriptionLabel setBackgroundColor:[UIColor clearColor]];
    [self.textContainer addSubview:self.vendorsDescriptionLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

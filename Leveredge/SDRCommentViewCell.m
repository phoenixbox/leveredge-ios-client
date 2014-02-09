//
//  SDRCommentViewCell.m
//  Leveredge
//
//  Created by Shane Rogers on 2/8/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRCommentViewCell.h"
#import "SDRViewConstants.h"

@implementation SDRCommentViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self renderCommentatorThumbnail];
        [self renderCommentatorName];
        [self renderCommentDistanceOfTime];
        [self renderComment];
    }
    return self;
}

- (void)renderCommentatorThumbnail {
    self.thumbnail = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.origin.x+kLeveredgeSmallPadding,self.frame.origin.y+kLeveredgeSmallPadding,kCommentThumbnailDimension, kCommentThumbnailDimension)];
    [self.thumbnail.layer setCornerRadius:kCommentThumbnailDimension/2];
    [self.thumbnail.layer setMasksToBounds:YES];
    [self.thumbnail setBackgroundColor:[UIColor purpleColor]];
    [self.contentView addSubview:self.self.thumbnail];
}

- (void)renderCommentatorName {
    self.commentatorName = [[UILabel alloc]initWithFrame:CGRectMake(self.thumbnail.frame.origin.x+self.thumbnail.frame.size.width+kLeveredgeSmallPadding, self.thumbnail.frame.origin.y, (self.frame.size.width-self.thumbnail.frame.size.width-(kLeveredgeSmallPadding *3))*0.65, kCommentNameheight)];
    [self.commentatorName setBackgroundColor:[UIColor purpleColor]];
    [self.contentView addSubview:self.commentatorName];
}

- (void)renderCommentDistanceOfTime {
    self.commentDistanceOfTime = [[UILabel alloc]initWithFrame:CGRectMake(self.commentatorName.frame.origin.x +self.commentatorName.frame.size.width + kLeveredgeSmallPadding, self.commentatorName.frame.origin.y,(self.frame.size.width-self.thumbnail.frame.size.width-(kLeveredgeSmallPadding *3))*0.3, kCommentNameheight)];
    [self.commentDistanceOfTime setBackgroundColor:[UIColor purpleColor]];
    [self.contentView addSubview:self.commentDistanceOfTime];
}

- (void)renderComment {
    self.comment = [[UITextView alloc]initWithFrame:CGRectMake(self.commentatorName.frame.origin.x,self.commentatorName.frame.origin.y+self.commentatorName.frame.size.height+kLeveredgeSmallPadding, (self.frame.size.width-self.thumbnail.frame.size.width-(kLeveredgeSmallPadding *4)),0.0f)];
    [self.comment setBackgroundColor:kLeveredgeBlue];
    
    [self.comment setEditable:NO];
    [self.comment setSelectable:NO];
    
    [self.contentView addSubview:self.comment];
}

- (void)resizeCommentContent {
    NSString *string = [NSString stringWithFormat:@"%@",self.comment.text];
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:string];
    NSAttributedString *attrStr = [[NSAttributedString alloc]initWithAttributedString:result];
    
    CGFloat width = (self.frame.size.width-self.thumbnail.frame.size.width-(kLeveredgeSmallPadding *4));
    
    CGRect rect = [attrStr boundingRectWithSize:CGSizeMake(width, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
    rect.origin.x = self.commentatorName.frame.origin.x;
    rect.origin.y = self.commentatorName.frame.origin.y+self.commentatorName.frame.size.height+kLeveredgeSmallPadding;
    
    [self.comment setFrame:rect];
    
    [self.comment layoutIfNeeded];
    [self.comment setNeedsLayout];
    [self.comment sizeToFit];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

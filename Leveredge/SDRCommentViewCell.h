//
//  SDRCommentViewCell.h
//  Leveredge
//
//  Created by Shane Rogers on 2/8/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDRCommentViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *commentatorName;
@property (nonatomic, strong) UIImageView *thumbnail;
@property (nonatomic, strong) UITextView *comment;
@property (nonatomic, strong) UILabel *commentDistanceOfTime;

- (void)resizeCommentContent;

@end

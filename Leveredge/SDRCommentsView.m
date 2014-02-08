//
//  SDRCommentsView.m
//  Leveredge
//
//  Created by Shane Rogers on 2/8/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRCommentsView.h"
#import "SDRViewConstants.h"
#import "SDRCommentViewCell.h"
#import "SDRLeveredgeButton.h"

@implementation SDRCommentsView

@synthesize commentsTable;

- (id)initWithFrame:(CGRect)frame forVendor:(SDRVendor *)vendor
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self renderCommentsTable];
    }
    return self;
}

- (void)renderCommentsTable {
    // Remove Arbitrary Height - Insert Min and Max || Accumulated subview heights
    self.commentsTable = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, 200.0f)];
    [self.commentsTable registerClass:[UITableViewCell class] forCellReuseIdentifier:kLeveredgeCommentCell];
    self.commentsTable.delegate = self;
    self.commentsTable.dataSource = self;
    self.commentsTable.alwaysBounceVertical = NO;
    self.commentsTable.scrollEnabled = NO;
    self.commentsTable.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.commentsTable.separatorColor = [UIColor clearColor];
    [self.commentsTable setBackgroundColor:[UIColor lightGrayColor]];
    
    [self addSubview:self.commentsTable];
}

#pragma UITableViewDelgate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SDRCommentViewCell *cell = [[SDRCommentViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kLeveredgeCommentCell];

//    TODO: Implement Comments Functionalty
//    SDRComment *comment = vendorComments[indexPath.row];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.commentatorName setText:@"Rory McDonagh"];
    [cell.comment setText:kCommentCopySample];

    [cell.commentDistanceOfTime setText:[NSString stringWithFormat:@"%@ ago",@"less than a minute"]];
    
//    TODO: Implement Comment Upvoting Functionality
//    cell.accessoryView = [self buildAccessoryButton];

    [cell setBackgroundColor:[UIColor whiteColor]];
    
//    CGRect contentRect = CGRectZero;
    CGRect newCellFrame = cell.frame;
//    for (UIView *view in cell.subviews) {
//        contentRect = CGRectUnion(contentRect,view.frame);
//    }
//    newCellFrame.size.height = (kLeveredgeSmallPadding *3+cell.comment.frame.size.height + cell.commentatorName.frame.size.height);
//  TODO: Cant set frame here
    newCellFrame.size.height += 100.0f;
    [cell setFrame:newCellFrame];

    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    TODO: Calculate cumulative height here
//    SDRCommentViewCell *cell = [[tableView visibleCells]objectAtIndex:indexPath.row];
////    SDRCommentViewCell *cell = (SDRCommentViewCell *)[tableView cellForRowAtIndexPath:indexPath];
//    
//    CGRect contentRect = CGRectZero;
//    for(UIView *view in cell.subviews) {
//        contentRect = CGRectUnion(contentRect,view.frame);
//    }
//    return contentRect.size.height;
//}

/*
- (SDRLeveredgeButton *)buildAccessoryButton {
    SDRLeveredgeButton *accessoryButton = [[SDRLeveredgeButton alloc]initWithFrame:CGRectZero];
    
    [accessoryButton setBackgroundImage:kUpvoteComment forState:UIControlStateNormal];
    [accessoryButton addTarget:self action:@selector(commentUpvoted:) forControlEvents:UIControlEventTouchUpInside];
    return accessoryButton;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

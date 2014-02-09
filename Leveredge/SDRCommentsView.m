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
#import "SDRDynamicRowHeightTableViewCell.h"

@implementation SDRCommentsView {
    NSMutableArray *_cellCache;
}

@synthesize commentsTable;

- (id)initWithFrame:(CGRect)frame forVendor:(SDRVendor *)vendor
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self buildSampleCopyArray];
        _cellCache = [NSMutableArray new];
        [self renderCommentsTable];
    }
    return self;
}

- (void)buildSampleCopyArray {
    _copySamples = [[NSArray alloc]initWithObjects:kCommentCopySampleOne,kCommentCopySampleTwo,kCommentCopySampleThree,kCommentCopySampleFour, nil];
}

- (void)renderCommentsTable {
    // Remove Arbitrary Height - Insert Min and Max || Accumulated subview heights
    self.commentsTable = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, 300.0f)];
    [self.commentsTable registerClass:[UITableViewCell class] forCellReuseIdentifier:kLeveredgeCommentCell];
    self.commentsTable.delegate = self;
    self.commentsTable.dataSource = self;
    self.commentsTable.alwaysBounceVertical = NO;
    self.commentsTable.scrollEnabled = NO;
    self.commentsTable.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.commentsTable.separatorColor = [UIColor lightGrayColor];
    [self.commentsTable setBackgroundColor:[UIColor lightGrayColor]];
    
    [self addSubview:self.commentsTable];
}

#pragma UITableViewDelgate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SDRCommentViewCell *cell = [[SDRCommentViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kLeveredgeCommentCell];
    
    NSString *copy = _copySamples[indexPath.row];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.commentatorName setText:@"Rory McDonagh"];
    [cell.commentatorName setFont:[UIFont systemFontOfSize:12.0f]];
    [cell.comment setText:copy];
    [cell resizeCommentContent];
    
    [cell.commentDistanceOfTime setText:[NSString stringWithFormat:@"%@ ago",@"less than a minute"]];
    [cell.commentDistanceOfTime setFont:[UIFont systemFontOfSize:12.0f]];
    
//    TODO: Implement Comments Functionalty
//    SDRComment *comment = vendorComments[indexPath.row];
//    TODO: Implement Comment Upvoting Functionality
//    cell.accessoryView = [self buildAccessoryButton];

    [cell setBackgroundColor:[UIColor clearColor]];

    return cell;
}

- (CGFloat) tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    return 200.0f;
    
//    CGRect blah = CGRectZero;
//    return blah.size.height;
//    
//   SDRCommentViewCell *cell = [self.commentsTable cellForRowAtIndexPath:indexPath];
//            // force layout
//    [sizingCell setNeedsLayout];
//    [sizingCell layoutIfNeeded];
//
//    CGSize fittingSize = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    //NSLog(@"fitting size: %@", NSStringFromCGSize(fittingSize));
//    
//    return fittingSize.height;
}

//- (void)resizeCommentsTableToContents {
//    CGRect contentRect = CGRectZero;
//    
//    for(SDRCommentViewCell *cell in self.commentsTable.subviews){
//        contentRect = CGRectUnion(contentRect,cell.frame);
//    }
//    self.commentsTable.contentSize = contentRect.size;
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

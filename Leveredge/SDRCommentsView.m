//
//  SDRCommentsView.m
//  Leveredge
//
//  Created by Shane Rogers on 2/8/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRCommentsView.h"
#import "SDRViewConstants.h"
#import "SDRLeveredgeButton.h"
#import "SDRDynamicRowHeightTableViewCell.h"
#import "SDRVendorViewController.h"

@implementation SDRCommentsView {
    NSMutableArray *_cellCache;
}

@synthesize commentsTable;

- (id)initWithFrame:(CGRect)frame forVendor:(SDRVendor *)vendor
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self buildCommentCopyArray];
        _cellCache = [NSMutableArray new];
        [self renderCommentsTable];
    }
    return self;
}


- (void)buildCommentCopyArray {
    _copySamples = [[NSArray alloc]initWithObjects:kCommentCopySampleOne,kCommentCopySampleTwo,kCommentCopySampleThree,kCommentCopySampleFour, nil];
}

- (CGSize)sizeOfLabel:(UILabel *)label withText:(NSString *)string {
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:string];
    NSAttributedString *attrStr = [[NSAttributedString alloc]initWithAttributedString:result];
    return [attrStr boundingRectWithSize:CGSizeMake(self.commentsTable.frame.size.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
}

- (CGSize)sizeOfTextField:(UITextView *)textView withText:(NSString *)string {
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:string];
    NSAttributedString *attrStr = [[NSAttributedString alloc]initWithAttributedString:result];
    return [attrStr boundingRectWithSize:CGSizeMake(self.commentsTable.frame.size.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil].size;
}

- (void)renderCommentsTable {
    // Set Height
    self.commentsTable = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.frame.size.width, 300.0f)];
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
    return [_copySamples count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SDRCommentViewCell *cell = [[SDRCommentViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kLeveredgeCommentCell];
    cell.frame = CGRectMake(cell.frame.origin.x, cell.frame.origin.y, tableView.frame.size.width, cell.frame.size.height);
    
    NSString *copy = _copySamples[indexPath.row];
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell.commentatorName setText:@"Rory McDonagh"];
    [cell.commentatorName setFont:[UIFont systemFontOfSize:12.0f]];
    [cell.comment setText:copy];
    
    [cell.commentDistanceOfTime setText:[NSString stringWithFormat:@"%@ ago",@"less than a minute"]];
    [cell.commentDistanceOfTime setFont:[UIFont systemFontOfSize:12.0f]];
    
//    TODO: Implement Comments Functionalty
//    SDRComment *comment = vendorComments[indexPath.row];
//    TODO: Implement Comment Upvoting Functionality
//    cell.accessoryView = [self buildAccessoryButton];
    
    [cell resizeCommentContent];
    self.totalCellsHeight += cell.comment.frame.size.height + (kLeveredgeSmallPadding*3) + cell.commentatorName.frame.size.height;
    NSLog(@"Total Height of Cells: %f", self.totalCellsHeight);
    [cell setBackgroundColor:[UIColor clearColor]];
    
    CGRect tableRect = self.commentsTable.frame;
    
    tableRect.size.height = self.totalCellsHeight;
    self.commentsTable.contentSize = tableRect.size;

    return cell;
}

- (CGFloat) tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath*)indexPath {
    self.cellPrototype.frame = CGRectMake(self.cellPrototype.frame.origin.x, self.cellPrototype.frame.origin.y, tableView.frame.size.width, self.cellPrototype.frame.size.height);
    
    CGFloat commentatorsNameHeight = [self sizeOfLabel:self.cellPrototype.commentatorName withText:@"Rory McDonagh"].height;
    
    CGFloat commentHeight = [self sizeOfTextField:self.cellPrototype.comment withText:_copySamples[indexPath.row]].height+30.0f;
    
    CGFloat padding = kLeveredgeSmallPadding;
    
    CGFloat combinedHeight = padding + commentatorsNameHeight + padding + commentHeight + padding;
    
    CGFloat minHeight = 50.0f;
    
    return MAX(combinedHeight, minHeight);
}

//- (void)resizeCommentsTableContentSize {
//    CGRect tableRect = self.commentsTable.frame;
//    tableRect.size.height = _totalCellsHeight;
//    self.commentsTable.contentSize = tableRect.size;
//}

//CGRect contentRect = CGRectZero;
//
//for(SDRCommentViewCell *cell in self.commentsTable.subviews){
//    contentRect = CGRectUnion(contentRect,cell.frame);
//}
//self.commentsTable.contentSize = contentRect.size;


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

//
//  SDRSlideMenu.h
//  Leveredge
//
//  Created by Shane Rogers on 7/12/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum MenuDirectionOptionTypes{
    menuDirectionRightToLeft,
    menuDirectionLeftToRight
} MenuDirectionOptions;

@interface SDRSlideMenu : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIColor *menuBackgroundColor;
@property (nonatomic, strong) NSMutableDictionary *tableSettings;
@property (nonatomic) CGFloat optionCellHeight;
@property (nonatomic) CGFloat acceleration;

// NOTE: Interesting use of enum type here as an argument
- (id)initWithFrame:(CGRect)frame targetView:(UIView *)targetView direction:(MenuDirectionOptions)direction options:(NSArray *)options optionImages:(NSArray *)optionImages;

-(void)showMenuWithSelectionHandler:(void(^)(NSInteger selectedOptionIndex))handler;

@end

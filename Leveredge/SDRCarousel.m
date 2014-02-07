//
//  SDRCarousel.m
//  Leveredge
//
//  Created by Shane Rogers on 2/5/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRCarousel.h"

@implementation SDRCarousel

@synthesize container, carouselImageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self buildCarousel];
    }
    return self;
}

- (void)buildCarousel {
    [self renderContainer];
    [self renderCarouselImageView];
}

- (void)renderContainer {
    self.container = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [self.container setBackgroundColor:[UIColor grayColor]];
    [self addSubview:self.container];
}

- (void)renderCarouselImageView {
    self.carouselImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.container.frame.origin.x+5,self.container.frame.origin.x+5,self.container.frame.size.width-10,self.container.frame.size.height-10)];
    [self.carouselImageView setBackgroundColor:[UIColor purpleColor]];
    [self.container addSubview:self.carouselImageView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

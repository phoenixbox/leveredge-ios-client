//
//  SDRCarousel.h
//  Leveredge
//
//  Created by Shane Rogers on 2/5/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SDRCarousel : UIView {
    NSArray *images;
}

@property(nonatomic, strong)UIView *container;
@property(nonatomic, strong)UIImageView *carouselImageView;

@end

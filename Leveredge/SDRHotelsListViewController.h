//
//  SDRVideosListViewController.h
//  Leveredge
//
//  Created by Shane Rogers on 5/15/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDRHotelChannel.h"
#import "SDRLeveredgeButton.h"

// AmazonS3 video
#import <AWSS3/AWSS3.h>

// Video Imports
#import <MobileCoreServices/UTCoreTypes.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface SDRHotelsListViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, AmazonServiceRequestDelegate> {
    SDRHotelChannel *hotelChannel;
}

@property (nonatomic, strong) UITableView *hotelsTable;
@property (nonatomic, strong) SDRLeveredgeButton *takeVideoButton;
@property (nonatomic, strong) UIView *filterFormView;
@property (nonatomic, retain) AmazonS3Client *s3;

// Dynamic Properties
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, strong) UIGravityBehavior *gravity;
@property (nonatomic, strong) UICollisionBehavior *collision;

// Video play from media library
-(BOOL)startMediaBrowserFromViewController:(UIViewController *)controller usingDelegate:(id)delegate;

// Video record and save to library
-(BOOL)startCameraControllerFromViewController:(UIViewController *)controller usingDelegate:(id)delegate;
-(void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;

@end

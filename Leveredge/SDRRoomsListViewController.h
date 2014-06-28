//
//  SDRVideosListViewController.h
//  Leveredge
//
//  Created by Shane Rogers on 5/15/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDRRoomChannel.h"
#import "SDRLeveredgeButton.h"

// AmazonS3 video
#import <AWSS3/AWSS3.h>

// Video Imports
#import <MobileCoreServices/UTCoreTypes.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface SDRRoomsListViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate, AmazonServiceRequestDelegate> {
    SDRRoomChannel *roomChannel;
}

@property (nonatomic, strong) UITableView *roomsTable;
@property (nonatomic, strong) SDRLeveredgeButton *takeVideoButton;
@property (nonatomic, retain) AmazonS3Client *s3;

// Video play from media library
-(BOOL)startMediaBrowserFromViewController:(UIViewController *)controller usingDelegate:(id)delegate;

// Video record and save to library
-(BOOL)startCameraControllerFromViewController:(UIViewController *)controller usingDelegate:(id)delegate;
-(void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;

@end

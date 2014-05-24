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

// Video Imports
#import <MobileCoreServices/UTCoreTypes.h>
#import <MediaPlayer/MediaPlayer.h>

@interface SDRRoomsListViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource> {
    SDRRoomChannel *roomChannel;
}

@property (nonatomic, strong) UITableView *roomsTable;
@property (nonatomic, strong) SDRLeveredgeButton *takeVideoButton;
//@property (nonatomic, assign) float tabBarHeight;

-(BOOL)startMediaBrowserFromViewController:(UIViewController *)controller usingDelegate:(id)delegate;

@end

//
//  SDRVideosListViewController.m
//  Leveredge
//
//  Created by Shane Rogers on 5/15/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRRoomsListViewController.h"
#import "SDRViewConstants.h"
#import "SDRRoomsTableViewCell.h"
#import "SDRRoomStore.h"
#import "SDRRoomsTableViewCell.h"
#import "SDRRoom.h"

@interface SDRRoomsListViewController ()

@end

@implementation SDRRoomsListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initAppearance];
//        self.tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self renderRoomsTable];
    [self renderTakeVideoButton];
}

- (void)initAppearance
{
    // Set appearance info
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackOpaque];
    [[UINavigationBar appearance] setBarTintColor:kLeveredgeBlue];
    
    [[UIToolbar appearance] setBarStyle:UIBarStyleBlackOpaque];
    [[UIToolbar appearance] setBarTintColor:kLeveredgeBlue];
    [self setHeaderLogo];
//    [self addNavigationItems];
}

//- (void)addNavigationItems{
//    UIImage *filterImage = [UIImage imageNamed:@"filterIconSmall.png"];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:filterImage landscapeImagePhone:filterImage style:UIBarButtonItemStylePlain target:self action:@selector(toggleFilter:)];
//    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)renderRoomsTable {
    [self formatRoomsTable];
    [self.view addSubview:self.roomsTable];
}

- (void)formatRoomsTable {
    self.roomsTable = [self buildRoomsTable];
    [self.roomsTable registerClass:[UITableViewCell class] forCellReuseIdentifier:kRoomsTableCellIdentifier];
    self.roomsTable.delegate = self;
    self.roomsTable.dataSource = self;
    self.roomsTable.alwaysBounceVertical = NO;
    self.roomsTable.scrollEnabled = YES;
    self.roomsTable.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.roomsTable.separatorColor = [UIColor blueColor];
    
    [self.roomsTable setBackgroundColor:[UIColor grayColor]];
}

- (UITableView *)buildRoomsTable {
    float tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    float width = self.view.bounds.size.width;
    float height = self.view.bounds.size.height - tabBarHeight*2;
    CGRect tableFrame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, width, height);
    UITableView *roomsTable = [[UITableView alloc] initWithFrame:tableFrame];
    return roomsTable;
}

- (void)renderTakeVideoButton {
    self.takeVideoButton = [self buildTakeVideoButton];
    [self.takeVideoButton setBackgroundColor:kLeveredgeBlue];
    [self.takeVideoButton setTitle:@"Record Another Room" forState:UIControlStateNormal];
    [self.takeVideoButton setTitleColor:kPureWhite forState:UIControlStateNormal];
    [self.takeVideoButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    [self.takeVideoButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.takeVideoButton addTarget:self action:@selector(takeVideo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.takeVideoButton];
}

- (SDRLeveredgeButton *)buildTakeVideoButton{
    float roomsTableWidth = self.roomsTable.frame.size.width;
    float roomsTableHeight = self.roomsTable.frame.size.height;

    CGRect buttonFrame = CGRectMake(10.0f,self.view.frame.origin.y+roomsTableHeight,roomsTableWidth-20,40.0f);
    
    SDRLeveredgeButton *takeVideoButton = [[SDRLeveredgeButton alloc]initWithFrame:buttonFrame];
    return takeVideoButton;
}

- (void)takeVideo:(SDRLeveredgeButton *)button {
    NSLog(@"Implement take video");
}

- (void)playVideo:(SDRLeveredgeButton *)button {
    [self startMediaBrowserFromViewController:self usingDelegate:self];
}

//#pragma UITableViewDelgate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
//    return [[roomChannel rooms] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SDRRoom *room = [[roomChannel rooms] objectAtIndex:[indexPath row]];
    
    SDRRoomsTableViewCell *cell = (SDRRoomsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kRoomsTableCellIdentifier];
    
    if([tableView isEqual:self.roomsTable]){
        cell = [[SDRRoomsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kRoomsTableCellIdentifier];
        
        //  Set the cell attributes
        [room setTitle:@"Better Room"];
        [cell.videoThumbnail addTarget:self action:@selector(playVideo:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kRoomsTableCellHeight;
}

//- (void)fetchRooms {
//    [self setActivityIndicator];
//    
//    void(^completionBlock)(SDRRoomChannel *obj, NSError *err)=^(SDRRoomChannel *obj, NSError *err){
//        // Replace the activity indicatior
//        [self setHeaderLogo];
//        if(!err){
//            roomChannel = obj;
//            [self addUniquesToRoomStore:roomChannel];
//            
//            [[self roomsTable] reloadData];
//        } else {
//            [self renderErrorMessage:err];
//        }
//    }
//    [[SDRRoomStore sharedStore]fetchRoomsWithCompletion:completionBlock];
//}

- (void)setActivityIndicator {
}

//- (void)addUniquesToRoomStore:(SDRRoomChannel *)rc {
//    for(SDRRoom *room in [rc rooms]){
//        [[SDRRoomStore sharedStore] addUniqueRooms:room];
//    }
//}

- (void)renderErrorMessage:(NSError *)err {
    NSString *errorString = [NSString stringWithFormat:@"Fetch failed: %@", [err localizedDescription]];
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [av show];
}

- (void)setHeaderLogo {
    [[self navigationItem]setTitleView:nil];
    UIImageView *logoView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 40.0f)];
    logoView.contentMode = UIViewContentModeScaleAspectFill;
    UIImage *logoImage = [UIImage imageNamed:@"leveredgeLogo.png"];
    [logoView setImage:logoImage];
    self.navigationItem.titleView = logoView;
}

#pragma mark - Video
-(BOOL)startMediaBrowserFromViewController:(UIViewController *)controller usingDelegate:(id)delegate {
    //    Validations to pick from existent location
    if (([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO)
        || (delegate == nil)
        || (controller == nil)) {
        return NO;
    }
    //    Define the picker, its source and media type
    UIImagePickerController *mediaUI = [UIImagePickerController new];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    mediaUI.mediaTypes = [[NSArray alloc]initWithObjects:(NSString *)kUTTypeMovie, nil];
    //    Toggle the ability to edit video
    mediaUI.allowsEditing = YES;
    mediaUI.delegate = delegate;
    
    [controller presentViewController:mediaUI animated:YES completion:^{/* No callback*/}];
    
    return YES;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // Get the mediatype
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    // Dismiss the controller
    [self dismissViewControllerAnimated:YES completion:^{/* No callback*/}];
    // Handling the movie capture
    if(CFStringCompare((__bridge_retained CFStringRef)mediaType, kUTTypeMovie, 0)== kCFCompareEqualTo) {
        // Play the video
        MPMoviePlayerViewController *theMovie = [[MPMoviePlayerViewController alloc]initWithContentURL:[info objectForKey:UIImagePickerControllerMediaURL]];
        [self presentMoviePlayerViewControllerAnimated:theMovie];
        // Register for playback finished notification
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(myMovieFinishedCallback:) name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
    }
}

// Release the controller from the notification when the movie is done
- (void)myMovieFinishedCallback:(NSNotification *)aNotification {
    [self dismissMoviePlayerViewControllerAnimated];
    MPMoviePlayerController *theMovie = [aNotification object];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
}

// When the user taps cancel and not choose
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:^{/* No callback*/}];
}

@end
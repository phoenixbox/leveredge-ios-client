//
//  SDRVideosListViewController.m
//  Leveredge
//
//  Created by Shane Rogers on 5/15/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRHotelsListViewController.h"
#import "SDRHotelViewController.h"
#import "SDRViewConstants.h"
#import "SDRAppConstants.h"
#import "SDRHotelsTableViewCell.h"
#import "SDRHotelStore.h"
#import "SDRHotelsTableViewCell.h"
#import "SDRHotel.h"

// Networking
#import "AFNetworking.h"
// Amazon S3
#import <AWSRuntime/AWSRuntime.h>

@interface SDRHotelsListViewController ()

@end

@implementation SDRHotelsListViewController

@synthesize s3 = _s3;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initAppearance];
        [self initializeS3];
        [self fetchHotels];
    }
    return self;
}

- (void)initializeS3 {
    // Initialize the S3 Client.
    //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    // This sample App is for demonstration purposes only.
    // It is not secure to embed your credentials into source code.
    // DO NOT EMBED YOUR CREDENTIALS IN PRODUCTION APPS.
    // We offer two solutions for getting credentials to your mobile App.
    // Please read the following article to learn about Token Vending Machine:
    // * http://aws.amazon.com/articles/Mobile/4611615499399490
    // Or consider using web identity federation:
    // * http://aws.amazon.com/articles/Mobile/4617974389850313
    //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    self.s3 = [[AmazonS3Client alloc] initWithAccessKey:kAccessKeyId withSecretKey:kSecretKey];
    self.s3.endpoint = [AmazonEndpoints s3Endpoint:US_WEST_2];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self renderHotelsTable];
    
    [self renderTakeVideoButton];
    
    [self initFilterForm];
}

- (void)initAppearance
{
    // Set appearance info
    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlackOpaque];
    [[UINavigationBar appearance] setBarTintColor:kLeveredgeBlue];
    
    [[UIToolbar appearance] setBarStyle:UIBarStyleBlackOpaque];
    [[UIToolbar appearance] setBarTintColor:kLeveredgeBlue];
    [self setHeaderLogo];
    [self addNavigationItems];
}

-(void)initFilterForm {
    self.filterFormView = [[UIView alloc] initWithFrame:CGRectMake(0,-568,320, 568)];
    [self.filterFormView setBackgroundColor:kLeveredgeBlue];
    [self.view addSubview:self.filterFormView];
    [self applyFilterFormDynamics];
    [self addFilterViewComponents];
}

- (void)applyFilterFormDynamics {
    // Init the animator with self.view as the reference view
    self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    // Init the gravity behavior with the filter form view
    self.gravity = [[UIGravityBehavior alloc]initWithItems:@[self.filterFormView]];
    // Apply the gravity property to it
    self.gravity.angle = -M_PI_2;
    self.gravity.magnitude = 1.0;
    // Add the behavior to the animator
    [self.animator addBehavior:self.gravity];
    
    // Init collision with the filter form view - Add boundaries to the top and bottom of the page
    self.collision = [[UICollisionBehavior alloc] initWithItems:@[self.filterFormView]];
    CGSize filterFormSize = self.filterFormView.bounds.size;
    CGSize listViewSize = self.view.bounds.size;
    
    [self.collision addBoundaryWithIdentifier:@"TopOfView"
                                    fromPoint:CGPointMake(0., -filterFormSize.height)
                                      toPoint:CGPointMake(listViewSize.width, -filterFormSize.height)];
    [self.collision addBoundaryWithIdentifier:@"BottomOfView"
                                    fromPoint:CGPointMake(0., listViewSize.height)
                                      toPoint:CGPointMake(listViewSize.width, listViewSize.height)];
    [self.animator addBehavior:self.collision];
}


- (void)addFilterViewComponents {
    // TODO: Programatically set the center of the apply button
    UIButton *applyFilterButton = [[UIButton alloc] initWithFrame:CGRectMake(35.0f,200.0f, 250.0f, 40.0f)];
    [applyFilterButton setTitle:@"Apply" forState:UIControlStateNormal];
    [applyFilterButton setBackgroundColor:kLoginButtonColor];
    [applyFilterButton setTitleColor:kPureWhite forState:UIControlStateNormal];
    [applyFilterButton addTarget:self action:@selector(applyFilters:) forControlEvents:UIControlEventTouchUpInside];
    [self.filterFormView addSubview:applyFilterButton];
}

- (void)applyFilters:(UIButton *)applyButton{
    self.gravity.angle = -M_PI_2;
    self.navigationItem.rightBarButtonItem.enabled = YES;
}

- (void)addNavigationItems{
    UIImage *filterImage = [UIImage imageNamed:@"filterIconSmall.png"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:filterImage landscapeImagePhone:filterImage style:UIBarButtonItemStylePlain target:self action:@selector(toggleFilter)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
}

- (void)toggleFilter {
    self.gravity.angle = M_PI_2;
    self.navigationItem.rightBarButtonItem.enabled = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)renderHotelsTable {
    [self formathotelsTable];
    [self.view addSubview:self.hotelsTable];
}

- (void)formathotelsTable {
    self.hotelsTable = [self buildhotelsTable];
    [self.hotelsTable registerClass:[UITableViewCell class] forCellReuseIdentifier:khotelsTableCellIdentifier];
    self.hotelsTable.delegate = self;
    self.hotelsTable.dataSource = self;
    self.hotelsTable.alwaysBounceVertical = NO;
    self.hotelsTable.scrollEnabled = YES;
    self.hotelsTable.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.hotelsTable.separatorColor = [UIColor blueColor];
    
    [self.hotelsTable setBackgroundColor:[UIColor whiteColor]];
}

- (UITableView *)buildhotelsTable {
    float tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    float width = self.view.bounds.size.width;
    float height = self.view.bounds.size.height - tabBarHeight*2;
    CGRect tableFrame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, width, height);
    UITableView *hotelsTable = [[UITableView alloc] initWithFrame:tableFrame];
    return hotelsTable;
}

- (void)renderTakeVideoButton {
    self.takeVideoButton = [self buildTakeVideoButton];
    [self.takeVideoButton setBackgroundColor:kLeveredgeBlue];
    [self.takeVideoButton setTitle:@"Add a Hotel" forState:UIControlStateNormal];
    [self.takeVideoButton setTitleColor:kPureWhite forState:UIControlStateNormal];
    [self.takeVideoButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
    [self.takeVideoButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
    [self.takeVideoButton addTarget:self action:@selector(selectOrTakeVideo:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.takeVideoButton];
}

- (SDRLeveredgeButton *)buildTakeVideoButton{
    float hotelsTableWidth = self.hotelsTable.frame.size.width;
    float hotelsTableHeight = self.hotelsTable.frame.size.height;

    CGRect buttonFrame = CGRectMake(10.0f,self.view.frame.origin.y+hotelsTableHeight,hotelsTableWidth-20,40.0f);
    
    SDRLeveredgeButton *takeVideoButton = [[SDRLeveredgeButton alloc]initWithFrame:buttonFrame];
    return takeVideoButton;
}

- (void)selectOrTakeVideo:(SDRLeveredgeButton *)button {
    NSString *actionSheetTitle = @"Take a new video or use an existing one?";
    NSString *newVideo = kTakeNewVideoButton;
    NSString *existingVideo = kUseExistingVideoButton;
    NSString *cancelTitle = @"Cancel";
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:actionSheetTitle
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:newVideo, existingVideo, nil];
    
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    
    if  ([buttonTitle isEqualToString:kTakeNewVideoButton]) {
        [self startCameraControllerFromViewController:self usingDelegate:self];
    }
    if ([buttonTitle isEqualToString:kUseExistingVideoButton]) {
        [self startMediaBrowserFromViewController:self usingDelegate:self];
    }
    if ([buttonTitle isEqualToString:@"Cancel"]) {
        [actionSheet dismissWithClickedButtonIndex:[actionSheet cancelButtonIndex] animated:YES];
        actionSheet = nil;
    }
}

- (void)playVideo:(SDRLeveredgeButton *)button {
    [self startMediaBrowserFromViewController:self usingDelegate:self];
}

#pragma UITableViewDelgate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[SDRHotelStore sharedStore] allHotels] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SDRHotel *hotel = [[[SDRHotelStore sharedStore] allHotels] objectAtIndex:[indexPath row]];
    
    SDRHotelsTableViewCell *cell = (SDRHotelsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:khotelsTableCellIdentifier];
    
    if([tableView isEqual:self.hotelsTable]){
        cell = [[SDRHotelsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:khotelsTableCellIdentifier];
        
        //  Set the cell attributes
        [cell.hotelNameLabel setText:hotel.name];
        [cell.videoThumbnail addTarget:self action:@selector(playVideo:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //  Init the detail view controller
    SDRHotelViewController *hotelViewController = [[SDRHotelViewController alloc]init];
    
    //  Find the selected hotel per touch
    NSArray *hotels = [[SDRHotelStore sharedStore] allHotels];
    
    SDRHotel *selectedhotel = [hotels objectAtIndex:[indexPath row]];
    
    [hotelViewController setViewWithHotel:selectedhotel];
    
    [[self navigationController] pushViewController:hotelViewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return khotelsTableCellHeight;
}

- (void)fetchHotels {
    [self setActivityIndicator];
    
    void(^completionBlock)(NSArray *hotels, NSError *err)=^(NSArray *hotels, NSError *err){
        
        [self setHeaderLogo];
        [hotels enumerateObjectsUsingBlock:^(SDRHotel *hotel, NSUInteger idx, BOOL *stop) {
            [[SDRHotelStore sharedStore] addUniqueHotels:hotel];
        }];

        if(!err){
            [[self hotelsTable] reloadData];
        } else {
            [self renderErrorMessage:err];
        }
    };
    
    [[SDRHotelStore sharedStore] fetchHotelsWithCompletion:completionBlock];
}

- (void)setActivityIndicator {
}

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

// Video Selection
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
// ** callbacks **
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    // Get the mediatype
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    [self dismissViewControllerAnimated:YES completion:^{/* No callback*/}];
    // Handling the movie capture
    if(CFStringCompare((__bridge_retained CFStringRef)mediaType, kUTTypeMovie, 0)== kCFCompareEqualTo) {
        NSString *moviePath = (NSString *)[[info objectForKey:UIImagePickerControllerMediaURL] path];
        
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(moviePath)) {
            // Save the video
            UISaveVideoAtPathToSavedPhotosAlbum(moviePath, self,
                                                @selector(video:didFinishSavingWithError:contextInfo:), nil);

            NSError *error = nil;
            NSData *videoData = [[NSData alloc] initWithContentsOfFile:moviePath
                                                               options:NSDataReadingMappedIfSafe
                                                                 error:&error];
            
            S3PutObjectRequest *por = [[S3PutObjectRequest alloc] initWithKey:@"mule-video" inBucket:@"mule.inventoryvideos"];
            por.contentType = @"video/mp4";
            por.data = videoData;
            por.delegate = self;
            [por setDelegate:self];
            por.contentLength = [videoData length];
            [self.s3 putObject:por];
            
            //  Create the hotel add to store & push atop the stack
            SDRHotel *newhotel = [SDRHotel new];
            [newhotel setName:@"New hotel Banana"];
//            [newhotel setVideo_url:@"placeholder.s3"]; #TODO: Comment back in hotel video url
            [[SDRHotelStore sharedStore] addUniqueHotels:newhotel];
            
            SDRHotelViewController *hotelViewController = [SDRHotelViewController new];
            [hotelViewController setViewWithHotel:newhotel];
            
            [[self navigationController] pushViewController:hotelViewController                                                   animated:YES];
        } else {
            // Play the video
            MPMoviePlayerViewController *theMovie = [[MPMoviePlayerViewController alloc]initWithContentURL:[info objectForKey:UIImagePickerControllerMediaURL]];
            [self presentMoviePlayerViewControllerAnimated:theMovie];
            // Register for playback finished notification
            [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(myMovieFinishedCallback:) name:MPMoviePlayerPlaybackDidFinishNotification object:theMovie];
        }
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

// Video Recording
-(BOOL)startCameraControllerFromViewController:(UIViewController *)controller usingDelegate:(id)delegate {
    // Validations to ensure no crash
    if(([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]==NO)
       ||(delegate == nil)
       ||(controller == nil)) {
        return NO;
    }
    // Get image picker
    UIImagePickerController *cameraUI = [UIImagePickerController new];
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    // Enable choosing movie captured
    cameraUI.mediaTypes = [[NSArray alloc]initWithObjects:(NSString *)kUTTypeMovie, nil];
    // Disable user controls
    cameraUI.allowsEditing = NO;
    cameraUI.delegate = delegate;
    // Display image picker
    [controller presentViewController:cameraUI animated:YES completion:^{/*No callback*/}];
    return YES;
}

-(void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if(error){
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Video Saving Failed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Video Saved" message:@"Saved to Photo Album" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}
@end
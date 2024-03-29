//
//  SDRSlideMenu.m
//  Leveredge
//
//  Created by Shane Rogers on 7/12/14.
//  Copyright (c) 2014 Shane Rogers. All rights reserved.
//

#import "SDRSlideMenu.h"
#import "SDRViewConstants.h"

@interface SDRSlideMenu()

@property (nonatomic, strong) UIView *_menuView;
@property (nonatomic, strong) UIView *_backgroundView;
@property (nonatomic, strong) UIView *_targetView;
@property (nonatomic, strong) UITableView *_optionsTableView;
@property (nonatomic, strong) NSArray *_menuOptions;
@property (nonatomic, strong) NSArray *_menuOptionImages;
@property (nonatomic, strong) UIDynamicAnimator *_animator;
@property (nonatomic) MenuDirectionOptions _menuDirection;
@property (nonatomic) CGRect _menuFrame;
@property (nonatomic) CGRect _menuInitialFrame;
@property (nonatomic) BOOL _isMenuShown;

// Block to be executed on selection
@property (nonatomic, strong) void(^_selectionHandler)(NSInteger);

-(void)setupMenuView;

-(void)setupBackgroundView;

-(void)setupOptionsTableView;

-(void)setInitialTableViewSettings;

-(void)setupSwipeGestureRecognizer;

-(void)hideMenuWithGesture:(UISwipeGestureRecognizer *)gesture;

@end

@implementation SDRSlideMenu

-(id)initWithFrame:(CGRect)frame targetView:(UIView *)targetView direction:(MenuDirectionOptions)direction options:(NSArray *)options optionImages:(NSArray *)optionImages {
    if (self = [super init]) {
        self._menuFrame = frame;
        self._targetView = targetView;
        self._menuOptions = options;
        self._menuOptionImages = optionImages;
    };
    
    // POST INITIALIZATION
    [self setupBackgroundView];
    [self setupMenuView];
    [self setupOptionsTableView];
    [self setInitialTableViewSettings];
    [self setupSwipeGestureRecognizer];
    [self initDynamicProperties];
    
    
    return self;
}

#pragma mark - Public method implementation

// Parent view triggers this function passing in a block that is persisted as the selection handler
-(void)showMenuWithSelectionHandler:(void (^)(NSInteger))handler {
    if (!self._isMenuShown) {
        self._selectionHandler = handler;
        
        [self toggleMenu];
        
        self._isMenuShown = YES;
    }
}

#pragma mark - Private method implementation

- (void)initDynamicProperties {
    // Set the public properties of the class
    self._animator = [[UIDynamicAnimator alloc] initWithReferenceView:self._targetView];
    self.optionCellHeight = 50.0;
    self.acceleration = 15.0;
    self._isMenuShown = NO;
}

-(void)setupBackgroundView {
    self._backgroundView = [[UIView alloc]initWithFrame:self._targetView.frame];
    [self._backgroundView setBackgroundColor:[UIColor grayColor]];
    [self._backgroundView setAlpha:0.0];
    [self._targetView addSubview:self._backgroundView];
}

-(void)setupMenuView {
    if(self._menuDirection == menuDirectionLeftToRight){
        self._menuInitialFrame = CGRectMake(-self._menuFrame.size.width,
                                           self._menuFrame.origin.y,
                                           self._menuFrame.size.width,
                                           self._menuFrame.size.height);
    } else {
        // TODO test the difference between the dimensions of the target and menu frame
        self._menuInitialFrame = CGRectMake(self._targetView.frame.size.width,
                                           self._menuFrame.origin.y,
                                           self._menuFrame.size.width,
                                           self._menuFrame.size.height);
    }
    self._menuView = [[UIView alloc] initWithFrame:self._menuInitialFrame];
    [self._menuView setBackgroundColor:kQLYellow];
    
    [self._menuView.layer setBorderWidth:1.0];
    [self._menuView.layer setBorderColor:kLeveredgeGrey.CGColor];
    
    [self._targetView addSubview:self._menuView];
}

-(void)setupOptionsTableView {
    self._optionsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.0, 0.0, self._menuFrame.size.width, self._menuFrame.size.height) style:UITableViewStylePlain];
    [self._optionsTableView setBackgroundColor:[UIColor clearColor]];
    // TODO: Try to add scroll with nested menu items
    [self._optionsTableView setScrollEnabled:NO];
    [self._optionsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self._menuView addSubview:self._optionsTableView];
    
    [self._optionsTableView setDelegate:self];
    [self._optionsTableView setDataSource:self];
}

-(void)setInitialTableViewSettings {
    self.tableSettings = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                          [UIFont fontWithName:@"American Typewriter" size:15.0], @"font",
                          [NSNumber numberWithInt:NSTextAlignmentLeft],@"textAlignment",
                          [UIColor whiteColor],@"textColor",
                          [NSNumber numberWithInt:UITableViewCellSelectionStyleGray],@"selectionStyle",
                          nil];
}

-(void)setupSwipeGestureRecognizer {
    UISwipeGestureRecognizer *hideMenuGesture = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(hideMenuWithGesture:)];
    if (self._menuDirection == menuDirectionLeftToRight) {
        hideMenuGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    } else {
        hideMenuGesture.direction = UISwipeGestureRecognizerDirectionRight;
    }
    [self._menuView addGestureRecognizer:hideMenuGesture];
}

-(void)hideMenuWithGesture:(UISwipeGestureRecognizer *)gesture {
    [self toggleMenu];
}

-(void)toggleMenu {
    [self._animator removeAllBehaviors];
    CGFloat gravityDirectionX;
    CGPoint collisionPointFrom, collisionPointTo;
    CGFloat pushMagnitude = self.acceleration;
    
    // TODO: Refactor common components passing operators into the functions
    if(!self._isMenuShown){ // Show the Menu
        if (self._menuDirection == menuDirectionLeftToRight) {
            gravityDirectionX = 1.0;
            collisionPointFrom = CGPointMake(self._menuFrame.size.width, self._menuFrame.origin.y);
            collisionPointTo = CGPointMake(self._menuFrame.size.width, self._menuFrame.size.height);        } else {
                gravityDirectionX = -1.0;
                collisionPointFrom = CGPointMake(self._targetView.frame.size.width - self._menuFrame.size.width, self._menuFrame.origin.y);
                collisionPointTo = CGPointMake(self._targetView.frame.size.width - self._menuFrame.size.width, self._menuFrame.size.height);
                pushMagnitude = (-1) *pushMagnitude;
            }
        // Up the opacity to add focus to the menu
        [self._backgroundView setAlpha:0.25];
        self._isMenuShown = YES;
    } else { // Hide the Menu
        if (self._menuDirection == menuDirectionLeftToRight) {
            gravityDirectionX = -1.0;
            // X values are inverse of the menu not shown
            collisionPointFrom = CGPointMake(-self._menuFrame.size.width, self._menuFrame.origin.y);
            collisionPointTo = CGPointMake(-self._menuFrame.size.width, self._menuFrame.size.height);
            
            pushMagnitude = (-1) * pushMagnitude;
        } else {
            gravityDirectionX = 1.0;
            // Addition instead of subtraction
            collisionPointFrom = CGPointMake(self._targetView.frame.size.width + self._menuFrame.size.width, self._menuFrame.origin.y);
            collisionPointTo = CGPointMake(self._targetView.frame.size.width + self._menuFrame.size.width, self._menuFrame.size.height);        }
        // Remove the opacity to return focus to the main view
        [self._backgroundView setAlpha:0.0];
        self._isMenuShown = NO;
    }
    
    // Add all the behaviors
    [self addGravityBehavior:gravityDirectionX];
    [self addCollisionBehaviorFrom:collisionPointFrom to:collisionPointTo];
    [self addItemElasticityBehavior];
    [self addMagnitudeBehavior:pushMagnitude];
}

- (void)addGravityBehavior:(CGFloat)gravityDirectionX {
    UIGravityBehavior *gravityBehavior = [[UIGravityBehavior alloc] initWithItems:@[self._menuView]];
    [gravityBehavior setGravityDirection:CGVectorMake(gravityDirectionX, 0.0)];
    [self._animator addBehavior:gravityBehavior];
};

- (void)addCollisionBehaviorFrom:(CGPoint)from to:(CGPoint)to{
    // Collision behaviors can be added to multiple items
    UICollisionBehavior *collisionBehavior = [[UICollisionBehavior alloc]initWithItems:@[self._menuView]];
    // Whats the significance of the identifier?
    [collisionBehavior addBoundaryWithIdentifier:@"collisionBoundary"
                                       fromPoint:from toPoint:to];
    [self._animator addBehavior:collisionBehavior];
};

// RESTART: Fix the collision boundaries - refactor to separate components - brand and implement email

- (void)addItemElasticityBehavior {
    // General purpose for setting the elasticity of the collision between the boundary and the view
    // TODO: adjust the density for collision tweaks - resistance and friction
    // Overrides defaults
    UIDynamicItemBehavior *itemBehavior = [[UIDynamicItemBehavior alloc]initWithItems:@[self._menuView]];
    [itemBehavior setElasticity:0.35];
    [self._animator addBehavior:itemBehavior];
};

- (void)addMagnitudeBehavior:(CGFloat)magnitude{
    UIPushBehavior *pushBehavior = [[UIPushBehavior alloc]initWithItems:@[self._menuView] mode:UIPushBehaviorModeInstantaneous];
    [pushBehavior setMagnitude:magnitude];
    [self._animator addBehavior:pushBehavior];
};

#pragma mark - UITable Delegate & DataSource Protocol Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // TODO: Implement sections with accordian style submenus
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self._menuOptions count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.optionCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"optionCell"];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"optionCell"];
        // Note: Map selectionStytle to an NSNumber to this [NSNumber numberWithInt:UITableViewCellSelectionStyleGray]
        // Note the use of intValue message for lookup with correct type
        [cell setSelectionStyle:[[self.tableSettings objectForKey:@"selectionStyle"]intValue]];

        // Key into the menuOptions passed in on initialization
        [cell.textLabel setText:[self._menuOptions objectAtIndex:indexPath.row]];
        [cell.textLabel setFont:[self.tableSettings objectForKey:@"font"]];
        [cell.textLabel setTextAlignment:[[self.tableSettings objectForKey:@"textAlignment"] intValue]];
        [cell.textLabel setTextColor:[self.tableSettings objectForKey:@"textColor"]];
        
//        if (self._menuOptionImages != nil) {
//            [cell.imageView setImage:[UIImage imageNamed:[self._menuOptionImages objectAtIndex:indexPath.row]]];
//            [cell.imageView setTintColor:[UIColor whiteColor]];
//        }
        
        [cell setBackgroundColor:[UIColor clearColor]];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self._selectionHandler) {
        self._selectionHandler(indexPath.row);
    }
}

@end

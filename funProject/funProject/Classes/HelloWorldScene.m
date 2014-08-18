//
//  HelloWorldScene.m
//  funProject
//
//  Created by Ji Pei on 8/8/14.
//  Copyright LUSS 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "HelloWorldScene.h"
#import "IntroScene.h"
#import "GADBannerView.h"
#import "gameOver.h"


// -----------------------------------------------------------------------
#pragma mark - HelloWorldScene
// -----------------------------------------------------------------------

@implementation HelloWorldScene
{
    GADBannerView *bannerView_;
    CCSprite *_sprite;
    CCLabelTTF *scoreLabel;
    NSInteger r;
    NSInteger score;
    NSInteger error;
}

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (HelloWorldScene *)scene
{
    return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    error = 0;  //init error
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
    
    // Create a colored background (Dark Grey)
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f]];
    [self addChild:background];
    
    r = 0;  //init the initial arrow scene
    
    // Add a sprite
    _sprite = [CCSprite spriteWithImageNamed:@"swipe_up.png"];
    _sprite.position  = ccp(self.contentSize.width/2,self.contentSize.height/2);
    [self addChild:_sprite];
    
    // Create a back button
    CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.85f, 0.85f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
    
    
    // admob implementation
    bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerLandscape];
    
    // Specify the ad unit ID.
    bannerView_.adUnitID = @"ca-app-pub-6314301496407347/5426208517";
    
    // Let the runtime know which UIViewController to restore after taking
    // the user wherever the ad goes and add it to the view hierarchy.
    bannerView_.rootViewController = [CCDirector sharedDirector];
    
    // Initiate a generic request to load it with an ad.
    GADRequest *request = [GADRequest request];
    request.testDevices = @[ GAD_SIMULATOR_ID ];
    [bannerView_ loadRequest:[GADRequest request]];
    
    // add bannerview
    [[[CCDirector sharedDirector] view] addSubview:bannerView_];
    
    
    //add swipe gesture recog
    UISwipeGestureRecognizer *swipeRegUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeRegUp.direction = UISwipeGestureRecognizerDirectionUp;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeRegUp];
    
    UISwipeGestureRecognizer *swipeRegDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeRegDown.direction = UISwipeGestureRecognizerDirectionDown;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeRegDown];
    
    UISwipeGestureRecognizer *swipeRegLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeRegLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeRegLeft];
    
    UISwipeGestureRecognizer *swipeRegRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeRegRight.direction = UISwipeGestureRecognizerDirectionRight;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeRegRight];
    
    
    // add string score
    scoreLabel = [[CCLabelTTF alloc] initWithString:@"score" fontName:@"Verdana" fontSize:20.0];
    scoreLabel.color = [CCColor blackColor];
    scoreLabel.positionType = CCPositionTypeNormalized;
    scoreLabel.position = ccp(0.5f,0.15f);
    [self addChild:scoreLabel];
    score = 0;
    
    
    
    // done
	return self;
}

// -----------------------------------------------------------------------

- (void)dealloc
{
    // clean up code goes here
}

// -----------------------------------------------------------------------
#pragma mark - Enter & Exit
// -----------------------------------------------------------------------

- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInteractionEnabled for the individual nodes
    // Per frame update is automatically enabled, if update is overridden
    
}

// -----------------------------------------------------------------------

- (void)onExit
{
    // always call super onExit last
    [super onExit];
}

// -----------------------------------------------------------------------
#pragma mark - Touch Handler
// -----------------------------------------------------------------------

-(void) touchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    //    CGPoint touchLoc = [touch locationInNode:self];
    //
    //    // Log touch location
    //    CCLOG(@"Move sprite to @ %@",NSStringFromCGPoint(touchLoc));
    //
    //    // Move our sprite to touch location
    //    CCActionMoveTo *actionMove = [CCActionMoveTo actionWithDuration:1.0f position:touchLoc];
    //    [_sprite runAction:actionMove];
}

-(void) didSwipe:(UISwipeGestureRecognizer *) swipeGestureRecognizer{
    if (swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        NSLog(@"up");
        if(r == 0)
            score++;
        else
            error++;
    }else if(swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionDown){
        NSLog(@"down");
        if(r == 1)
            score++;
        else
            error++;
    }else if(swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionLeft){
        NSLog(@"left");
        if(r == 2)
            score++;
        else
            error++;
    }else if(swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionRight){
        NSLog(@"right");
        if(r == 3)
            score++;
        else
            error ++;
    }
    [self checkGameIsOver];  //check whether game is over
    [self changeArrow];
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}

// -----------------------------------------------------------------------



// -----------------------------------------------------------------------
#pragma mark - Random logic
// -----------------------------------------------------------------------

- (void)changeArrow
{
    int r2 = arc4random()%4;
    while (r2 == r) {
        r2 = arc4random()%4;
    }
    r = r2;
    if (r == 0) {
        [_sprite setTexture:[[CCSprite spriteWithImageNamed:@"swipe_up.png"] texture]];
    }else if(r == 1){
        [_sprite setTexture:[[CCSprite spriteWithImageNamed:@"swipe_down.png"] texture]];
    }else if(r == 2){
        [_sprite setTexture:[[CCSprite spriteWithImageNamed:@"swipe_left.png"] texture]];
    }else if(r == 3){
        [_sprite setTexture:[[CCSprite spriteWithImageNamed:@"swipe_right.png"] texture]];
    }
}

//- (void)updateScore{
//    [scoreLabel setString:[NSString stringWithFormat:@"%ld",(long)score]];
//    if (score > 5) {
//        [self onGameOver];
//    }
//}



// add a logic for game over


- (void)checkGameIsOver
{
    [scoreLabel setString:[NSString stringWithFormat:@"%ld",(long)score]];
    if (error >= 1){
        [self onGameOver];
    }
}


- (void)onGameOver
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[gameOver sceneWithScore:score]
                               withTransition:[CCTransition transitionCrossFadeWithDuration:1.0f]];
}

// -----------------------------------------------------------------------



@end

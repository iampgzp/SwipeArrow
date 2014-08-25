//
//  IntroScene.m
//  funProject
//
//  Created by Ji Pei on 8/8/14.
//  Copyright LUSS 2014. All rights reserved.
//
// -----------------------------------------------------------------------

// Import the interfaces
#import "IntroScene.h"
#import "SwipeScene.h"
#import "GameWiki.h"
#import "GADBannerView.h"

// -----------------------------------------------------------------------
#pragma mark - IntroScene
// -----------------------------------------------------------------------

@implementation IntroScene{
    
    GADBannerView *bannerView_;
}

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (IntroScene *)scene
{
	return [[self alloc] init];
}

// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    // Create a colored background
    CCNodeColor *bg_color = [CCNodeColor nodeWithColor:[CCColor whiteColor]];
    [self addChild:bg_color];
    
    // Game Title
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Swipe Hero" fontName:@"Noteworthy-bold" fontSize:40.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor redColor];
    label.position = ccp(0.5f, 0.75f); // Middle of screen
    [self addChild:label];
    
    // Start Button
    CCButton *startButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"play.png"]];
    startButton.positionType = CCPositionTypeNormalized;
    startButton.position = ccp(0.30f, 0.45f);
    [startButton setTarget:self selector:@selector(onSpinningClicked:)];
    [self addChild:startButton];
    
    
    // Introduction to the game
    CCButton *wikiButton = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"Question.png"]];
    wikiButton.positionType = CCPositionTypeNormalized;;
    wikiButton.position = ccp(0.70f, 0.45f);
    [wikiButton setTarget:self selector:@selector(showGameCenter)];
    [self addChild:wikiButton];

    
    // admob implementation
    GADBannerView *testBanner = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait];
    bannerView_ = [[GADBannerView alloc] initWithAdSize:kGADAdSizeSmartBannerPortrait origin:CGPointMake(0, [[CCDirector sharedDirector] viewSize].height - testBanner.frame.size.height )];

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
    
    // done
	return self;
}

// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

- (void)onSpinningClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[SwipeScene scene]
                               withTransition:[CCTransition transitionCrossFadeWithDuration:1.0f]];
}


// -----------------------------------------------------------------------

- (void)onClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[GameWiki scene]
                               withTransition:[CCTransition transitionCrossFadeWithDuration:1.0f]];
}

//-------------------------------------------------------------------------
- (void) showGameCenter
{
//    GKGameCenterViewController *gameCenterController = [[GKGameCenterViewController alloc] init];
//    if (gameCenterController != nil)
//    {
//        gameCenterController.gameCenterDelegate = self;
//        [[CCDirector sharedDirector] presentViewController: gameCenterController animated: YES completion:nil];
//    }
}



@end

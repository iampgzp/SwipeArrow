//
//  gameOver.m
//  funProject
//
//  Created by Ji Pei on 8/11/14.
//  Copyright (c) 2014 LUSS. All rights reserved.
//

#import "gameOver.h"
#import "introScene.h"


@implementation gameOver


+ (gameOver *)sceneWithScore:(NSInteger) score
{
    gameOver* scene = [[self alloc] initWithScore:score];
    return scene;
}

- (id)initWithScore:(NSInteger) score
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    // Hello world
    CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Game Over"] fontName:@"Chalkduster" fontSize:36.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor redColor];
    label.position = ccp(0.5f, 0.5f); // Middle of screen
    [self addChild:label];
    
    CCLabelTTF *scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%ld", (long)score] fontName:@"Chalkduster" fontSize:36.0f];
    scoreLabel.positionType = CCPositionTypeNormalized;
    scoreLabel.color = [CCColor redColor];
    scoreLabel.position = ccp(0.5f, 0.40f); // Middle of screen
    [self addChild:scoreLabel];
    
    
    CCButton *retryButton = [CCButton buttonWithTitle:@"[ Retry ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    retryButton.positionType = CCPositionTypeNormalized;
    retryButton.position = ccp(0.25f, 0.25f);
    [retryButton setTarget:self selector:@selector(onRetryClicked:)];
    [self addChild:retryButton];
    
    
    CCButton *shareButton = [CCButton buttonWithTitle:@"[ Share ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    shareButton.positionType = CCPositionTypeNormalized;
    shareButton.position = ccp(0.75f, 0.25f);
    [shareButton setTarget:self selector:@selector(onShareClicked:)];
    [self addChild:shareButton];
    
    // done
	return self;
}

- (void)onRetryClicked:(CCButton *) sender{
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene] withTransition:[CCTransition transitionMoveInWithDirection:CCTransitionDirectionDown duration:1.0f]];
}

- (void)onShareClicked:(CCButton *) sender{
    
}



@end

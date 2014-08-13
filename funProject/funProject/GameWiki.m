//
//  GameWiki.m
//  funProject
//
//  Created by Li, Xiaoping on 8/12/14.
//  Copyright 2014 LUSS. All rights reserved.
//

#import "GameWiki.h"
#import "IntroScene.h"


@implementation GameWiki


+ (GameWiki *)scene
{
	return [[self alloc] init];
}


- (id) init
{
    self = [super init];
    if (!self) return(nil);
    
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Game Built by \n Luss Studio."] fontName:@"Chalkduster" fontSize:36.0f];
    
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor redColor];
    label.position = ccp(0.5f, 0.5f); // Middle of screen
    [self addChild:label];
    
    
    CCButton *retryButton = [CCButton buttonWithTitle:@"[ Back to start ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    retryButton.positionType = CCPositionTypeNormalized;
    retryButton.position = ccp(0.25f, 0.25f);
    [retryButton setTarget:self selector:@selector(onBackStartClicked:)];
    [self addChild:retryButton];
    return self;
}

- (void)onBackStartClicked:(CCButton *) sender{
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene] withTransition:[CCTransition transitionMoveInWithDirection:CCTransitionDirectionDown duration:1.0f]];
}


@end

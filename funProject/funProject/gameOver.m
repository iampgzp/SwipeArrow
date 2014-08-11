//
//  gameOver.m
//  funProject
//
//  Created by Ji Pei on 8/11/14.
//  Copyright (c) 2014 LUSS. All rights reserved.
//

#import "gameOver.h"


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
    CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Game Over %ld", (long)score] fontName:@"Chalkduster" fontSize:36.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor redColor];
    label.position = ccp(0.5f, 0.5f); // Middle of screen
    [self addChild:label];

    
    // done
	return self;
}


@end

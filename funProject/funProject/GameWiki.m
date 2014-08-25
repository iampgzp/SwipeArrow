//
//  GameWiki.m
//  funProject
//
//  Created by Li, Xiaoping on 8/12/14.
//  Copyright 2014 LUSS. All rights reserved.
//

#import "GameWiki.h"
#import "IntroScene.h"
#import "CCAnimation.h"

@implementation GameWiki{
    CCSprite *hero;
    NSMutableArray *animationArray;
}


+ (GameWiki *)scene
{
	return [[self alloc] init];
}


- (id) init
{
    self = [super init];
    if (!self) return(nil);
    
    hero = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithTexture:[CCTexture textureWithFile:@"hero.png"] rectInPixels:CGRectMake(32.0f, 0, 32.0f, 32.0f) rotated:NO offset:CGPointMake(0, 0) originalSize:CGSizeMake(32.0f, 32.0f)]];
    hero.position = ccp(self.contentSize.width/2,self.contentSize.height/2);
    hero.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, hero.contentSize} cornerRadius:0];
    [self addChild:hero];
    
    [self setupAnimation];
    
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
    
    CCSprite *brick = [CCSprite spriteWithImageNamed:@"brick.png"];
    [brick setScale:0.1f];
    brick.position = ccp(self.contentSize.width/3,self.contentSize.height/3);
    [self addChild:brick];
    
    
                    
    return self;
}

- (void)setupAnimation{
    float x,y = 0.0f;
    animationArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; i ++) {
        NSMutableArray * array = [[NSMutableArray alloc] init];
        for (int j = 0; j < 3; j ++) {
            
            CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:[CCTexture textureWithFile:@"hero.png"] rectInPixels:CGRectMake(x, y, 32.0f, 32.0f) rotated:NO offset:CGPointMake(0, 0) originalSize:CGSizeMake(32.0f, 32.0f)];
            [array addObject:frame];
            
            x = x + 32.0f;
        }
        x = 0;
        y = y + 32.0f;
        [animationArray addObject:array];
    }
    }

- (void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event{
    [hero stopAllActions];
    CCAction *move = [CCActionMoveTo actionWithDuration:2.0f position:[touch locationInNode:self]];
    [hero runAction:move];
    float x,y,i,j = 0;
    x = [touch locationInNode:self].x;
    y = [touch locationInNode:self].y;
    i = hero.position.x;
    j = hero.position.y;
    if(abs((x-i)) > abs((y - j))){
        if (x > i) {
            CCAnimation *animation = [CCAnimation animationWithSpriteFrames:[animationArray objectAtIndex:2]delay:0.2f];
            [hero runAction:[CCActionRepeatForever actionWithAction:[CCActionAnimate actionWithAnimation:animation]]];
        }else{
            CCAnimation *animation = [CCAnimation animationWithSpriteFrames:[animationArray objectAtIndex:1]delay:0.2f];
            [hero runAction:[CCActionRepeatForever actionWithAction:[CCActionAnimate actionWithAnimation:animation]]];
        }
    }else{
        if (y > j) {
            CCAnimation *animation = [CCAnimation animationWithSpriteFrames:[animationArray objectAtIndex:3]delay:0.2f];
            [hero runAction:[CCActionRepeatForever actionWithAction:[CCActionAnimate actionWithAnimation:animation]]];
        }else{
            CCAnimation *animation = [CCAnimation animationWithSpriteFrames:[animationArray objectAtIndex:0]delay:0.2f];
            [hero runAction:[CCActionRepeatForever actionWithAction:[CCActionAnimate actionWithAnimation:animation]]];
        }
    }
    
}



@end

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
    CCPhysicsNode *physicWorld;
}


+ (GameWiki *)scene
{
	return [[self alloc] init];
}


- (id) init
{
    self = [super init];
    if (!self) return(nil);
    
    physicWorld = [CCPhysicsNode node];
    [physicWorld setGravity:ccp(0, -29.8)];
//    [physicWorld setDebugDraw:YES];
    [physicWorld setCollisionDelegate:self];
    [self addChild:physicWorld];
    
    hero = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithTexture:[CCTexture textureWithFile:@"hero.png"] rectInPixels:CGRectMake(32.0f, 0, 32.0f, 32.0f) rotated:NO offset:CGPointMake(0, 0) originalSize:CGSizeMake(32.0f, 32.0f)]];
    hero.position = ccp(self.contentSize.width/2,self.contentSize.height/2);
    hero.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero, hero.contentSize} cornerRadius:0];
    [hero.physicsBody setMass:50];
    [physicWorld addChild:hero];
    [hero.physicsBody setAllowsRotation:NO];
    [hero.physicsBody setCollisionGroup:@"playerGroup"];
    [hero.physicsBody setCollisionType:@"heroCollision"];
    [self setupAnimation];
    
    CCSprite *boss = [CCSprite spriteWithSpriteFrame:[CCSpriteFrame frameWithTexture:[CCTexture textureWithFile:@"boss.png"] rectInPixels:CGRectMake(32.0f, 0, 32.0f, 32.0f) rotated:NO offset:CGPointZero originalSize:CGSizeMake(32.0f, 32.0f)]];
    boss.position = ccp(self.contentSize.width/2, self.contentSize.height - 60.0f);
    boss.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect) {CGPointZero, boss.contentSize} cornerRadius:0.0f];
    [boss.physicsBody setType:CCPhysicsBodyTypeStatic];
    [boss.physicsBody setCollisionType:@"bossCollision"];
    [boss.physicsBody setCollisionGroup:@"bossGroup"];
    [physicWorld addChild:boss];
    
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"You shall never reach me!" fontName:@"new" fontSize:20.0];
    label.position = ccp(self.contentSize.width/2, self.contentSize.height - 30.0f);
    [self addChild:label];
    [label setName:@"title"];
    // Enable touch handling on scene node
    self.userInteractionEnabled = YES;
    
    CCSprite *ground = [CCSprite spriteWithImageNamed:@"brick.png"];
    [ground setScaleY:0.2];
    [ground setScaleX:2.0];
    ground.position = ccp(0, 0);
    ground.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero,ground.contentSize} cornerRadius:0];
    [ground.physicsBody setType:CCPhysicsBodyTypeStatic];
    [physicWorld addChild:ground];
    
    [self schedule:@selector(addBrick) interval:1.0f];
                    
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
    
    float x,y,i,j = 0;
    x = [touch locationInNode:self].x;
    y = [touch locationInNode:self].y;
    i = hero.position.x;
    j = hero.position.y;
    float distance = sqrtf(powf(x - i, 2.0f) + powf(y - j, 2.0f));
    
    CCAction *move = [CCActionMoveTo actionWithDuration:(distance/150) position:[touch locationInNode:self]];
    [hero runAction:move];
    
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

- (void)addBrick{
    
    CCSprite *brick = [CCSprite spriteWithImageNamed:@"brick.png"];
    [brick setScale:0.1f];
    [brick.physicsBody setMass:5];
    [brick.physicsBody setElasticity:0.0];
    brick.position = ccp(self.contentSize.width/(arc4random()%20+1),self.contentSize.height/(arc4random()%3+1));
    brick.physicsBody = [CCPhysicsBody bodyWithRect:(CGRect){CGPointZero,brick.contentSize} cornerRadius:0];
    [brick.physicsBody setCollisionGroup:@"bossGroup"];
    [brick.physicsBody setCollisionType:@"brickCollision"];
    [physicWorld addChild:brick];

}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair bossCollision:(CCNode *)boss heroCollision:(CCNode *)hero{
    CCLabelTTF *label = (CCLabelTTF *)[self getChildByName:@"title" recursively:NO];
    [label setString:@"OK! I'm yours! "];
    
    return YES;
}

- (BOOL)ccPhysicsCollisionBegin:(CCPhysicsCollisionPair *)pair brickCollision:(CCNode *)brick heroCollision:(CCNode *)hero{
    CCLabelTTF *label = (CCLabelTTF *)[self getChildByName:@"title" recursively:NO];
    [label setString:@"Stop You Fool!!!!!!!!!!"];
    return YES;
}


@end

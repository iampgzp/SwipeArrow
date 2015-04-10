//
//  gameOver.m
//  funProject
//
//  Created by Ji Pei on 8/11/14.
//  Copyright (c) 2014 LUSS. All rights reserved.
//

#import "gameOver.h"
#import "introScene.h"
#import "WXApi.h"


@implementation gameOver{
    NSString *_score;
}


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
    CCSprite* backgroundWithPic = [CCSprite spriteWithImageNamed:@"swipers-introscene.png"];
    backgroundWithPic.anchorPoint = CGPointMake(0, 0);
    [self addChild:backgroundWithPic];
    
    //bg
//    CCNodeColor *bg_color = [[CCNodeColor alloc] initWithColor:[CCColor whiteColor]];
//    [self addChild:bg_color];
    
    // Hello world
    CCLabelTTF *label = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Game Over"] fontName:@"Chalkduster" fontSize:36.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor redColor];
    label.position = ccp(0.5f, 0.75f); // Middle of screen
    [self addChild:label];
    
    _score = [NSString stringWithFormat:@"%ld", (long)score];
    CCLabelTTF *scoreLabel = [CCLabelTTF labelWithString:_score fontName:@"Chalkduster" fontSize:36.0f];
    scoreLabel.positionType = CCPositionTypeNormalized;
    scoreLabel.color = [CCColor redColor];
    scoreLabel.position = ccp(0.5f, 0.65f); // Middle of screen
    [self addChild:scoreLabel];
    
    
    CCButton *retryButton = [CCButton buttonWithTitle:@"[ Retry ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    [retryButton setColor:[CCColor blackColor]];
    retryButton.positionType = CCPositionTypeNormalized;
    retryButton.position = ccp(0.25f, 0.5f);
    [retryButton setTarget:self selector:@selector(onRetryClicked:)];
    [self addChild:retryButton];
    
    
    CCButton *shareButton = [CCButton buttonWithTitle:@"[ Share ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    [shareButton setColor:[CCColor blackColor]];
    shareButton.positionType = CCPositionTypeNormalized;
    shareButton.position = ccp(0.75f, 0.5f);
    [shareButton setTarget:self selector:@selector(onShareClicked:)];
    [self addChild:shareButton];
    
    // done
	return self;
}

- (void)onRetryClicked:(CCButton *) sender{
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene] withTransition:[CCTransition transitionFadeWithDuration:1.0f]];
}

- (void)onShareClicked:(CCButton *) sender{
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    WXMediaMessage *message = [[WXMediaMessage alloc] init];
    WXWebpageObject *web =[[WXWebpageObject alloc] init];
    [web setWebpageUrl:@"www.google.com"];
    
    message.title = [NSString stringWithFormat:@"I scored %@, beat me if you can!", _score];
    [message setMediaObject:web];
    [req setMessage:message];
    req.bText = NO;
    req.scene = WXSceneTimeline;
    [WXApi sendReq:req];

}



@end

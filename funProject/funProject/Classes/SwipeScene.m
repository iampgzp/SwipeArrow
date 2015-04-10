//
//  HelloWorldScene.m
//  funProject
//
//  Created by Ji Pei on 8/8/14.
//  Copyright LUSS 2014. All rights reserved.
//
// -----------------------------------------------------------------------

#import "SwipeScene.h"
#import "IntroScene.h"
#import "gameOver.h"
#import "Arrow.h"


// -----------------------------------------------------------------------
#pragma mark - HelloWorldScene
// -----------------------------------------------------------------------

@implementation SwipeScene
{
    CCSprite *_sprite;
    CCLabelTTF *scoreLabel;
    NSInteger score;
    NSInteger error;
    NSMutableArray *arrayOfArrow;
//    NSMutableDictionary *dictOfArrow;
}

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------

+ (SwipeScene *)scene
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
    //CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f]];
    
    // add background picture
    CCSprite* backgroundWithPic = [CCSprite spriteWithImageNamed:@"background.png"];
    backgroundWithPic.anchorPoint = CGPointMake(0, 0);
    [self addChild:backgroundWithPic];
    
   // [self addChild:background];
    
    
    //init NSMutableArray which contains all the arrows
    if (!arrayOfArrow) {
        arrayOfArrow = [[NSMutableArray alloc] init];
    }
    
    // Create a back button
    CCButton *backButton = [CCButton buttonWithTitle:@"[ Menu ]" fontName:@"Verdana-Bold" fontSize:20.0f];
    [backButton setColor:[CCColor blackColor]];
    backButton.positionType = CCPositionTypeNormalized;
    backButton.position = ccp(0.15f, 0.95f); // Top Right of screen
    [backButton setTarget:self selector:@selector(onBackClicked:)];
    [self addChild:backButton];
    
 //--------------------------------------------------------------------------------------------------------------
    //add swipe gesture recog to the scene
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
    
    
    UISwipeGestureRecognizer *swipeRegRightVersa = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeRegRightVersa.direction = UISwipeGestureRecognizerDirectionLeft;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeRegRightVersa];
    
    UISwipeGestureRecognizer *swipeRegLeftVersa = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeRegLeftVersa.direction = UISwipeGestureRecognizerDirectionRight;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeRegLeftVersa];
    
    
    UISwipeGestureRecognizer *swipeRegUpVersa = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeRegUpVersa.direction = UISwipeGestureRecognizerDirectionDown;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeRegUpVersa];
    
    UISwipeGestureRecognizer *swipeRegDownVersa = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(didSwipe:)];
    swipeRegDownVersa.direction = UISwipeGestureRecognizerDirectionUp;
    [[[CCDirector sharedDirector] view] addGestureRecognizer:swipeRegDownVersa];
//----------------------------------------------------------------------------------------------------------------
    
 
    
    
    // add string score
    scoreLabel = [[CCLabelTTF alloc] initWithString:@"score" fontName:@"Verdana-bold" fontSize:20.0];
    scoreLabel.color = [CCColor blackColor];
    scoreLabel.positionType = CCPositionTypeNormalized;
    scoreLabel.position = ccp(0.85f,0.95f);
    [self addChild:scoreLabel];
    score = 0;
    error = 0;
    
    [self schedule:@selector(checkGameIsOver) interval:0.5f];
    
    //add an arrow each seconds, and add it into array.
    [self schedule:@selector(generateRandomSprite) interval:1.0f];   //generate arrow each second
    
    [self schedule:@selector(checkArraySize) interval: 0.5f];
    
    // done
	return self;
}

- (void) generateRandomSprite
{
    Arrow *randomArrow = [[Arrow alloc]init];
    [self addChild:randomArrow.sprite];  //add sprite into scene
    [arrayOfArrow addObject:randomArrow]; //add the arrow to array
    CCSprite *randomSprite = randomArrow.sprite;
    randomSprite.position = ccp(self.contentSize.width/2,self.contentSize.height/2);
    
}

- (void) checkArraySize{
    if (arrayOfArrow.count >= 2){
        NSLog(@"current array size larger than 1");
        [self onGameOver];
    }
}

// logic of how to decide game continue or over
-(void) didSwipe:(UISwipeGestureRecognizer *) swipeGestureRecognizer{

    NSLog(@"detected swipe gesture ..");
    
    // we only allow one arrow
    if (arrayOfArrow.count >= 2){
        NSLog(@"current array size larger than 1");
        [self onGameOver];
    }
    Arrow * currentArrow;
    for (Arrow *arrow in arrayOfArrow){
        int r = arrow.r;
        if (swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionUp) {
            NSLog(@"up");
            if(r == 0 || r == 5) {  //if the swipe is right, delete the arrow in the array, and destroy the  sprite on the page.
                score++;
                [self removeChild:arrow.sprite];
            }
            else{
                NSLog(@"current r");
                error++;
            }
        }else if(swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionDown){
            NSLog(@"down");
            if(r == 1 || r == 4){
                score++;
                [self removeChild:arrow.sprite];
            }
            else{
                error++;
            }
        }else if(swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionLeft){
            NSLog(@"left");
            if(r == 2 || r == 7){
                score++;
                [self removeChild:arrow.sprite];
            }
            else{
                error++;
            }
        }else if(swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionRight){
            NSLog(@"right");
            if(r == 3 || r == 6){
                score++;
                [self removeChild:arrow.sprite];
            }
            else{
                error++;
            }
        }
        currentArrow = arrow;
    }
    
    [arrayOfArrow removeObject: currentArrow];
    [self checkGameIsOver];  //check whether game is over
//    [self changeArrow];
}


//generate random sprite
// need to insert not only sprite, also r which denotes sprite
- (void) generateRandomSprite2
{
    Arrow *randomArrow = [[Arrow alloc]init];
    [self addChild:randomArrow.sprite];  //add sprite into scene
    [arrayOfArrow addObject:randomArrow]; //add the arrow to array
    randomArrow.sprite.position = ccp(self.contentSize.width/2,self.contentSize.height);
    CCSprite *randomSprite = randomArrow.sprite;
    randomSprite.position = ccp(self.contentSize.width/2,self.contentSize.height/2);
    //switch duration according how many arrows generated
    int rangeDuration = 0;
    
    int maxDuration = 5.0;
    int midDuration = 4.0;
    int minDuration = 3.0;
    
    if (arrayOfArrow.count <= 5){
        rangeDuration = maxDuration;
    }else if (arrayOfArrow.count <= 10){
        rangeDuration = midDuration;
    }else if (arrayOfArrow.count <= 15){
        rangeDuration = minDuration;
    }else{
        rangeDuration = 1.0;
    }
    
    CCAction *actionMove = [CCActionMoveTo actionWithDuration:rangeDuration position:CGPointMake(self.contentSize.width/2, 0)];
    [randomArrow.sprite runAction:actionMove];
    
}







- (void)dealloc
{
    // clean up code goes here
}


- (void)onEnter
{
    // always call super onEnter first
    [super onEnter];
    
    // In pre-v3, touch enable and scheduleUpdate was called here
    // In v3, touch is enabled by setting userInteractionEnabled for the individual nodes
    // Per frame update is automatically enabled, if update is overridden
    
}


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





// confirm the location of where did the swipe start.
// so we can decide remove which arrows from the arrow array




// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------

-(void)onBackClicked:(id)sender
{
    // back to intro scene with transition
    [[CCDirector sharedDirector] replaceScene:[IntroScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionRight duration:1.0f]];
}



// add a logic for game over


- (void)checkGameIsOver
{
    [scoreLabel setString:[NSString stringWithFormat:@"%ld",(long)score]]; //update score
    NSLog(@"check game is over or not... current score is %d", score);
    if (error >= 1){
        NSLog(@"game is over due to error is %d", error);
        [self onGameOver];
    }
    // disable this part for now.
//    if (_sprite.position.y < 0){
//        [self onGameOver];
//    }
    
}


- (void)onGameOver
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[gameOver sceneWithScore:score]
                               withTransition:[CCTransition transitionFadeWithDuration:1.0f]];
    [self removeGesture];
    
}


//remove gesture from the scene

- (void)removeGesture{
    while ([[CCDirector sharedDirector] view].gestureRecognizers.count) {
        [[[CCDirector sharedDirector] view] removeGestureRecognizer:[[[CCDirector sharedDirector] view].gestureRecognizers objectAtIndex:0]];
    }
}

// -----------------------------------------------------------------------



@end

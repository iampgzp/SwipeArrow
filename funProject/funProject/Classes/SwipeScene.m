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
    NSInteger r;
    NSInteger score;
    NSInteger error;
    NSMutableArray *arrayOfArrow;
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
    CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f]];
    [self addChild:background];
    
    
    //init NSMutableArray which contains all the arrows
    if (!arrayOfArrow) {
        arrayOfArrow = [[NSMutableArray alloc] init];
    }
    
    Arrow *firstArrow = [[Arrow alloc]init];
    r = firstArrow.r;
    
    
  //  NSLog(@"this is %d",r);
    
   // r = 0;  //init the key r which correspond to up-arrow
    
    // Add a sprite
    //_sprite = [CCSprite spriteWithImageNamed:@"swipe_up.png"];
    
    
    if (!firstArrow.sprite){
        NSLog(@"it is null");
    }
    _sprite = firstArrow.sprite;
    _sprite.position  = ccp(self.contentSize.width/2,self.contentSize.height/2);
    [self addChild:_sprite];
    
    
    
    

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
    
    
    UITapGestureRecognizer *tapReg = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap)];
    
    
    // add string score
    scoreLabel = [[CCLabelTTF alloc] initWithString:@"score" fontName:@"Verdana-bold" fontSize:20.0];
    scoreLabel.color = [CCColor blackColor];
    scoreLabel.positionType = CCPositionTypeNormalized;
    scoreLabel.position = ccp(0.85f,0.95f);
    [self addChild:scoreLabel];
    score = 0;
    
    [self schedule:@selector(checkGameIsOver) interval:0.5f];
    
    
    //add an arrow each seconds, and add it into array.
    [self schedule:@selector(generateRandomSprite) interval:1.0f];
    
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
        if(r == 0 || r == 5)
            score++;
        else
            error++;
    }else if(swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionDown){
        NSLog(@"down");
        if(r == 1 || r == 4)
            score++;
        else
            error++;
    }else if(swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionLeft){
        NSLog(@"left");
        if(r == 2 || r == 7)
            score++;
        else
            error++;
    }else if(swipeGestureRecognizer.direction == UISwipeGestureRecognizerDirectionRight){
        NSLog(@"right");
        if(r == 3 || r == 6)
            score++;
        else
            error++;
    }
    NSLog(@"%f", _sprite.position.y);
    [self checkGameIsOver];  //check whether game is over
    [self changeArrow];
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

// -----------------------------------------------------------------------



// -----------------------------------------------------------------------
#pragma mark - Random logic
// -----------------------------------------------------------------------

- (void)changeArrow
{
    int r2 = arc4random()%8;
    while (r2 == r) {
        r2 = arc4random()%8;
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
    }else if(r == 4){
        [_sprite setTexture:[[CCSprite spriteWithImageNamed:@"swipe_top_red.png"] texture]];
    }else if(r == 5){
        [_sprite setTexture:[[CCSprite spriteWithImageNamed:@"swipe_down_red.png"] texture]];
    }else if(r == 6){
        [_sprite setTexture:[[CCSprite spriteWithImageNamed:@"swipe_left_red.png"] texture]];
    }else if(r == 7){
        [_sprite setTexture:[[CCSprite spriteWithImageNamed:@"swipe_right_red.png"] texture]];
    }
    _sprite.position = ccp(self.contentSize.width/2,self.contentSize.height);
    int maxDuration = 6.0;
    int rangeDuration = maxDuration;
    
    //move to middle end
    
   // CCAction *actionMove1 = [CCActionBezierTo actionWithDuration:rangeDuration scale:6];
    CCAction *actionMove = [CCActionMoveTo actionWithDuration:rangeDuration position:CGPointMake(self.contentSize.width/2, 5)];
    
   // CCActionSpeed *actionMove = [[CCActionSpeed alloc]init];
    
    
    
   // actionMove s
    
    // CCAction *actionRemove = [CCActionRemove action];
    [_sprite runAction:actionMove];
}

//- (void)updateScore{
//    [scoreLabel setString:[NSString stringWithFormat:@"%ld",(long)score]];
//    if (score > 5) {
//        [self onGameOver];
//    }
//}



//generate random sprite
// need to insert not only sprite, also r which denotes sprite
- (void) generateRandomSprite
{
//    CCSprite *randomSprite;
//    int r2 = arc4random()%8;
//    
//    if (r2 == 0) {
//        [_sprite setTexture:[[CCSprite spriteWithImageNamed:@"swipe_up.png"] texture]];
//    }else if(r2 == 1){
//        [_sprite setTexture:[[CCSprite spriteWithImageNamed:@"swipe_down.png"] texture]];
//    }else if(r2 == 2){
//        [_sprite setTexture:[[CCSprite spriteWithImageNamed:@"swipe_left.png"] texture]];
//    }else if(r2 == 3){
//        [_sprite setTexture:[[CCSprite spriteWithImageNamed:@"swipe_right.png"] texture]];
//    }else if(r2 == 4){
//        [_sprite setTexture:[[CCSprite spriteWithImageNamed:@"swipe_top_red.png"] texture]];
//    }else if(r2 == 5){
//        [_sprite setTexture:[[CCSprite spriteWithImageNamed:@"swipe_down_red.png"] texture]];
//    }else if(r2 == 6){
//        [_sprite setTexture:[[CCSprite spriteWithImageNamed:@"swipe_left_red.png"] texture]];
//    }else if(r2 == 7){
//        [_sprite setTexture:[[CCSprite spriteWithImageNamed:@"swipe_right_red.png"] texture]];
//    }
    
    Arrow *randomArrow = [[Arrow alloc]init];
    [arrayOfArrow addObject:randomArrow];
}



// add a logic for game over


- (void)checkGameIsOver
{
    [scoreLabel setString:[NSString stringWithFormat:@"%ld",(long)score]]; //update score
    if (error >= 1){
        [self onGameOver];
    }
    if (_sprite.position.y < 0){
        [self onGameOver];
    }
    
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

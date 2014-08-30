//
//  Arrow.m
//  funProject
//
//  Created by Li, Xiaoping on 8/30/14.
//  Copyright (c) 2014 LUSS. All rights reserved.
//

#import "Arrow.h"

@implementation Arrow

-(id) init
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
    return self;
}

@end

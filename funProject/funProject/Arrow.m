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
    while (r2 == _r) {
        r2 = arc4random()%8;
    }
    _r = r2;
    
    //init arrow with random image
    if (_r == 0) {
        _sprite = [CCSprite spriteWithImageNamed:@"swipe_up.png"] ;
    }else if(_r == 1){
        _sprite = [CCSprite spriteWithImageNamed:@"swipe_down.png"];
    }else if(_r == 2){
        _sprite = [CCSprite spriteWithImageNamed:@"swipe_left.png"];
    }else if(_r == 3){
        _sprite = [CCSprite spriteWithImageNamed:@"swipe_right.png"];
    }else if(_r == 4){
        _sprite = [CCSprite spriteWithImageNamed:@"swipe_top_red.png"];
    }else if(_r == 5){
        _sprite = [CCSprite spriteWithImageNamed:@"swipe_down_red.png"];
    }else if(_r == 6){
        _sprite = [CCSprite spriteWithImageNamed:@"swipe_left_red.png"];
    }else if(_r == 7){
        _sprite = [CCSprite spriteWithImageNamed:@"swipe_right_red.png"];
    }
    return self;
}



@end

//
//  gameOver.h
//  funProject
//
//  Created by Ji Pei on 8/11/14.
//  Copyright (c) 2014 LUSS. All rights reserved.
//
// Importing cocos2d.h and cocos2d-ui.h, will import anything you need to start using cocos2d-v3
#import "cocos2d.h"
#import "cocos2d-ui.h"
#import "CCScene.h"

@interface gameOver : CCScene

+(gameOver *)sceneWithScore:(NSInteger)score;
- (id)initWithScore:(NSInteger) score;

@end

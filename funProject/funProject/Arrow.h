//
//  Arrow.h
//  funProject
//
//  Created by Li, Xiaoping on 8/30/14.
//  Copyright (c) 2014 LUSS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface Arrow : NSURLProtocol
{
     NSInteger r;  //denote the key
     CCSprite * _sprite;
}

- (id) init;

@end

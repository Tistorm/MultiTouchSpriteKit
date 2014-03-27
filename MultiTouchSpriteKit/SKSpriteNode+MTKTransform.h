//
//  SKSpriteNode+MTKTransform.h
//  MTKDemo
//
//  Created by Simon Voelker on 26.03.14.
//  Copyright (c) 2014 i10. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SKSpriteNode (MTKTransform)

/**
 *  Calculates the original size of the sprite if both scale values would be 1
 *
 *  @return The original size as CGSize.
 */
-(CGSize)originalSize;

-(NSDictionary*)calculateTransformationToSprite:(SKSpriteNode*)sprite;
-(void)transformToSprite:(SKSpriteNode*)sprite;

-(NSDictionary*)calculateTransformationToRect:(CGRect)rect inSprite:(SKSpriteNode*)sprite;
-(void)transformToRect:(CGRect)rect inSprite:(SKSpriteNode*)sprite;


@end

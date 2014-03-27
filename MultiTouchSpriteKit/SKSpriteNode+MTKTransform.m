//
//  SKSpriteNode+MTKTransform.m
//  MTKDemo
//
//  Created by Simon Voelker on 26.03.14.
//  Copyright (c) 2014 i10. All rights reserved.
//

#import "SKSpriteNode+MTKTransform.h"
#import "NSValue+CGElements.h"
#import "SKNode+MTKTransform.h"
@implementation SKSpriteNode (MTKTransform)


-(CGSize)originalSize
{
   return  CGSizeMake(self.size.width * 1.0f/self.xScale, self.size.height * 1.0f/self.yScale);
}
-(NSDictionary*)calculateTransformationToSprite:(SKSpriteNode *)sprite
{
    
    CGPoint firstStartPoint = CGPointMake(0, 0);
    CGPoint secondStartPoint = CGPointMake([self originalSize].width, [self originalSize].height);
    
    CGPoint firstEndPoint = CGPointMake(0, 0);
    CGPoint secondEndPoint = CGPointMake([sprite originalSize].width, [sprite originalSize].height);
    
    return [self transformFromPoints:@[[NSValue valueWithCGPoint:firstStartPoint],[NSValue valueWithCGPoint:secondStartPoint]] inCoordinatesOfNode:self toPoints:@[[NSValue valueWithCGPoint:firstEndPoint],[NSValue valueWithCGPoint:secondEndPoint]]inCoordinatesOfNode:sprite];
}
-(void)transformToSprite:(SKSpriteNode *)sprite
{
    NSDictionary* values = [self calculateTransformationToSprite:sprite];
    
    self.xScale = [[values objectForKey:@"scale"] CGSizeValue].width;
    self.yScale =[[values objectForKey:@"scale"] CGSizeValue].height;
    self.position = [[values objectForKey:@"position"] CGPointValue];
    self.zRotation = [[values objectForKey:@"angle"] floatValue];
}

-(NSDictionary*)calculateTransformationToRect:(CGRect)rect inSprite:(SKSpriteNode*)sprite
{
    CGPoint firstStartPoint = CGPointMake(0, 0);
    CGPoint secondStartPoint = CGPointMake([self originalSize].width, [self originalSize].height);
    
    CGPoint firstEndPoint = rect.origin;
    CGPoint secondEndPoint = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
    
    return [self transformFromPoints:@[[NSValue valueWithCGPoint:firstStartPoint],[NSValue valueWithCGPoint:secondStartPoint]] inCoordinatesOfNode:self toPoints:@[[NSValue valueWithCGPoint:firstEndPoint],[NSValue valueWithCGPoint:secondEndPoint]]inCoordinatesOfNode:sprite];
    
}
-(void)transformToRect:(CGRect)rect inSprite:(SKSpriteNode*)sprite
{
    NSDictionary* values = [self calculateTransformationToRect:rect inSprite:sprite];
    
    self.xScale = [[values objectForKey:@"scale"] CGSizeValue].width;
    self.yScale =[[values objectForKey:@"scale"] CGSizeValue].height;
    self.position = [[values objectForKey:@"position"] CGPointValue];
    self.zRotation = [[values objectForKey:@"angle"] floatValue];
}

@end

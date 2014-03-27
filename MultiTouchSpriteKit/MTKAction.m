//
//  MTKAction.m
//  MultiTouchKitDemo
//
//  Created by Simon Voelker and Moritz Wittenhagen on 05.02.14.
//  Copyright (c) 2014 i10. All rights reserved.
//

#import "MTKAction.h"
#import "SKSpriteNode+MTKTransform.h"



@interface SKAction (MTKCustomAction)



@end

@implementation SKAction (MTKCustomAction)
// ------------------------------------------------------
+(SKAction * )customActionWithDuration:(NSTimeInterval)duration setupBlock:(id (^)(SKNode *node))setup actionBlock:(void (^)(SKNode *node, CGFloat elapsedTime, CGFloat duration, id initialState))actionBlock tearDownBlock:(id (^)(SKNode *node))teardown
// ------------------------------------------------------
{
    __block id initialState;
    SKAction *setupAction = [SKAction customActionWithDuration:0 actionBlock:^(SKNode *node, CGFloat elapsedTime) {
        initialState = setup(node);
    }];
    
    SKAction *action = [SKAction customActionWithDuration:duration actionBlock:^(SKNode *node, CGFloat elapsedTime) {
        actionBlock(node, elapsedTime, duration, initialState);
    }];
    
    SKAction *teardownAction = [SKAction customActionWithDuration:0 actionBlock:^(SKNode *node, CGFloat elapsedTime) {
        teardown(node);
    }];
    
    return [SKAction sequence:@[setupAction, action,teardownAction]];
}


@end


@implementation MTKAction
// ------------------------------------------------------
- (id)initWithDuration:(NSTimeInterval)duration
// ------------------------------------------------------
{
    self = [super init];
    if(self)
    {
        
        _skAction = [SKAction customActionWithDuration:duration setupBlock:^id(SKNode *node) {
            [self setup:node];
            return nil;
        } actionBlock:^(SKNode *node, CGFloat elapsedTime, CGFloat duration, id initialState) {
            [self update:node elapsedTime:elapsedTime];
        } tearDownBlock:^id(SKNode *node) {
            [self teardown:node];
            return nil;
        }
                     ];
    }
    return self;
}
// ------------------------------------------------------
-(CGFloat)duration
// ------------------------------------------------------
{
    return [self.skAction duration];
}

// ------------------------------------------------------
-(void)setup:(SKNode *)node;
// ------------------------------------------------------
{
    @throw [NSException exceptionWithName:@"MTKAction" reason:@"You have to subclass MTKAction" userInfo:nil];
}
// ------------------------------------------------------
-(void)update:(SKNode *)node elapsedTime:(CGFloat)elapsedTime;
// ------------------------------------------------------
{
    @throw [NSException exceptionWithName:@"MTKAction" reason:@"You have to subclass MTKAction" userInfo:nil];
}
// ------------------------------------------------------
-(void)teardown:(SKNode*)node
// ------------------------------------------------------
{
     @throw [NSException exceptionWithName:@"MTKAction" reason:@"You have to subclass MTKAction" userInfo:nil];
}

@end


typedef NS_ENUM(NSUInteger, MTKTransformationType) {
    MTKNodeTransformation,
    MTKSpriteTransformation,
};

// =================================================================================================================
@implementation MTKTransformationAction
// =================================================================================================================
{
    //SKNode transformations
    NSArray*    _startPoints;
     NSArray*   _endPoints;
    SKNode*     _startNode;
    SKNode*     _endNode;
    BOOL        _setupDone;
    
    MTKTransformationType _type;
    
    
    //SKSpriteNode transformations
    
    
    
    
    
    
    
}
#pragma mark -
#pragma mark public methods

// ------------------------------------------------------
+(MTKTransformationAction *)transformToSprite:(SKSpriteNode*)sprite duration:(NSTimeInterval)sec
// ------------------------------------------------------
{
    return [[MTKTransformationAction alloc] initSpriteTransformationToRect:CGRectMake(0, 0, 0, 0) inSprite:sprite duration:sec];
}

// ------------------------------------------------------
+(MTKTransformationAction *)transformToRect:(CGRect)rect inSprite:(SKSpriteNode*)sprite duration:(NSTimeInterval)sec
// ------------------------------------------------------
{
    return [[MTKTransformationAction alloc] initSpriteTransformationToRect:rect inSprite:sprite duration:sec];
}

// ------------------------------------------------------
+ (MTKTransformationAction *)transformFromScenePoints:(NSArray*)startPoints toScenePoints:(NSArray*)endPoints  duration:(NSTimeInterval)sec
// ------------------------------------------------------
{
    return [[MTKTransformationAction alloc ]initTransformationActionFromPoints:startPoints inCoordinatesOfNode:nil toPoints:endPoints inCoordinatesOfNode:nil andDuration:sec];
}

#pragma mark -
#pragma mark privat methods

// ------------------------------------------------------
-(id)initSpriteTransformationToRect:(CGRect)rect inSprite:(SKSpriteNode*)sprite  duration:(NSTimeInterval)sec
// ------------------------------------------------------
{
    self = [super initWithDuration:sec];
    if (self)
    {
        _setupDone  = NO;
        _endNode    = sprite;
        _type       = MTKSpriteTransformation;
        
    }
    return self;
}
// ------------------------------------------------------
-(id)initTransformationActionFromPoints:(NSArray*)startPoints inCoordinatesOfNode:(SKNode*)startNode toPoints:(NSArray*)endPoints inCoordinatesOfNode:(SKNode*)endNode andDuration:(NSTimeInterval)duration
// ------------------------------------------------------
{
    self = [super initWithDuration:duration];
    if (self)
    {
        _setupDone      = NO;
        _startPoints    = startPoints;
        _endPoints      = endPoints;
        _startNode      = startNode;
        _endNode        = endNode;
        _type           = MTKNodeTransformation;
       
    }
    return self;
}

// ------------------------------------------------------
-(void)setup:(SKNode *)node
// ------------------------------------------------------
{

    NSDictionary* values;
    if (_type == MTKNodeTransformation)
    {
        values =  [node transformFromPoints:_startPoints inCoordinatesOfNode:_startNode toPoints:_endPoints inCoordinatesOfNode:_endNode];
    }
    else if(_type == MTKSpriteTransformation)
    {
        if (![node isKindOfClass:[SKSpriteNode class]])
        {
            return;
        }
        SKSpriteNode* sprite = (SKSpriteNode*)node;
        values = [sprite calculateTransformationToRect:CGRectMake(0, 0, 0, 0) inSprite:(SKSpriteNode*)_endNode];
        
    }
 
    [node runAction:[SKAction group:
                     @[
                       [SKAction scaleXTo:[[values objectForKey:@"scale"] CGSizeValue].width y:[[values objectForKey:@"scale"]CGSizeValue].height duration:self.duration],
                       [SKAction rotateToAngle:[[values objectForKey:@"angle"] floatValue] duration:self.duration shortestUnitArc:YES],
                       [SKAction moveTo:[[values objectForKey:@"position"] CGPointValue] duration:self.duration]]]];
    NSLog(@"%f",[[values objectForKey:@"angle"] floatValue]);
    
}
// ------------------------------------------------------
-(void)update:(SKNode *)node elapsedTime:(CGFloat)elapsedTime
// ------------------------------------------------------
{
    
}

// ------------------------------------------------------
-(void)teardown:(SKNode *)node
// ------------------------------------------------------
{
    
}
@end


//
//  MTKAction.m
//  MultiTouchKitDemo
//
//  Created by Simon Voelker and Moritz Wittenhagen on 05.02.14.
//  Copyright (c) 2014 i10. All rights reserved.
//

#import "MTKAction.h"



@interface SKAction (MTKCustomAction)



@end

@implementation SKAction (MTKCustomAction)

+(SKAction * )customActionWithDuration:(NSTimeInterval)duration setupBlock:(id (^)(SKNode *node))setup actionBlock:(void (^)(SKNode *node, CGFloat elapsedTime, CGFloat duration, id initialState))actionBlock tearDownBlock:(id (^)(SKNode *node))teardown
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

- (id)initWithDuration:(NSTimeInterval)duration
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

-(CGFloat)duration
{
    return [self.skAction duration];
}


-(void)setup:(SKNode *)node;
{
    //throw shit
    @throw [NSException exceptionWithName:@"MTKAction" reason:@"You have to subclass MTKAction" userInfo:nil];
}

-(void)update:(SKNode *)node elapsedTime:(CGFloat)elapsedTime;
{
    //throw shit
    @throw [NSException exceptionWithName:@"MTKAction" reason:@"You have to subclass MTKAction" userInfo:nil];
}

-(void)teardown:(SKNode*)node
{
     @throw [NSException exceptionWithName:@"MTKAction" reason:@"You have to subclass MTKAction" userInfo:nil];
}

@end





@implementation MTKTransformAction
{
    NSArray* _startPoints;
     NSArray* _endPoints;
    SKNode* _startNode;
    SKNode* _endNode;
    
}


+ (MTKTransformAction *)transformForm:(NSArray*)startPoints to:(NSArray*)endPoints  duration:(NSTimeInterval)sec
{
    return [[MTKTransformAction alloc ]initTransformationActionFromPoints:startPoints inCoordinatesOfNode:nil toPoints:endPoints inCoordinatesOfNode:nil andDuration:sec];
}

-(id)initTransformationActionFromPoints:(NSArray*)startPoints inCoordinatesOfNode:(SKNode*)startNode toPoints:(NSArray*)endPoints inCoordinatesOfNode:(SKNode*)endNode andDuration:(NSTimeInterval)duration
{
    self = [super initWithDuration:duration];
    if (self)
    {
        _startPoints = startPoints;
        _endPoints = endPoints;
        _startNode = startNode;
        _endNode    = endNode;
       
    }
    return self;
}


-(void)setup:(SKNode *)node
{
    

   NSDictionary* values =  [node transformFromPoints:_startPoints inCoordinatesOfNode:_startNode toPoints:_endPoints inCoordinatesOfNode:_endNode];
 

    [node runAction:[SKAction group:
                     @[
                       [SKAction scaleXTo:[[values objectForKey:@"scale"] CGSizeValue].width y:[[values objectForKey:@"scale"]CGSizeValue].height duration:self.duration],
                       [SKAction rotateToAngle:[[values objectForKey:@"angle"] floatValue] duration:self.duration],
                       [SKAction moveTo:[[values objectForKey:@"position"] CGPointValue] duration:self.duration]]]];
    
 
}

-(void)update:(SKNode *)node elapsedTime:(CGFloat)elapsedTime
{
    
}


@end



//@implementation MyMoveAction
//{
//    CGPoint _initialLocation;
//}
//
//-(void)setup:(SKNode *)node
//{
//    [node runAction:[SKAction moveByX:-10 y:0 duration:self.duration]];
//}
//
//-(void)update:(SKNode *)node elapsedTime:(CGFloat)elapsedTime
//{
//}
//
//-(void)teardown:(SKNode *)node
//{
//   
//}
//@end;

//
//  MTKAction.m
//  MultiTouchKitDemo
//
//  Created by Simon Voelker and Moritz Wittenhagen on 05.02.14.
//  Copyright (c) 2014 i10. All rights reserved.
//

#import "MTKAction.h"
#import "SKSpriteNode+MTKTransform.h"
#import "MTKShapeNode.h"
#import "NSMutableDictionary+NonRetainedObjectKey.h"
#import "MTKUtil.h"



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

// =================================================================================================================

@interface MTKPropertyAction: MTKAction


-(instancetype)initWithTargetValue:(id)targetValue asAbsoluteTarget:(BOOL)absoluteTarget forVariable:(NSString*)variableName Duration:(NSTimeInterval)duration;
@end


// =================================================================================================================

@implementation MTKAction
{
     NSMutableDictionary* _actionData;
    
}

// ------------------------------------------------------
+(MTKAction*)animateProperty:(NSString*)name to:(id)targetValue withDuration:(NSTimeInterval)duration
// ------------------------------------------------------
{
    return [[MTKPropertyAction alloc] initWithTargetValue:targetValue  asAbsoluteTarget:YES forVariable:name Duration:duration];
}

// ------------------------------------------------------
+(MTKAction*)animateProperty:(NSString*)name by:(id)targetValue withDuration:(NSTimeInterval)duration
// ------------------------------------------------------
{
   return [[MTKPropertyAction alloc] initWithTargetValue:targetValue  asAbsoluteTarget:NO forVariable:name Duration:duration];
}

// ------------------------------------------------------
- (id)initWithDuration:(NSTimeInterval)duration
// ------------------------------------------------------
{
    self = [super init];
    if(self)
    {
        
        _actionData = [NSMutableDictionary dictionary];
        _skAction = [SKAction customActionWithDuration:duration setupBlock:^id(SKNode *node) {
            [self prepareForNode:node];
            return nil;
        } actionBlock:^(SKNode *node, CGFloat elapsedTime, CGFloat duration, id initialState) {
            [self update:node elapsedTime:elapsedTime];
        } tearDownBlock:^id(SKNode *node) {
            [self cleanupForNode:node];
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
-(NSMutableDictionary*)actionDataForNode:(SKNode*)node
// ------------------------------------------------------
{
    return [_actionData objectForNonRetainedKey:node];
}

// ------------------------------------------------------
-(NSMutableDictionary*)actionData
// ------------------------------------------------------
{
    return _actionData;
}


// ------------------------------------------------------
-(id)dataForNode:(SKNode*)node andKey:(NSString*)key
// ------------------------------------------------------
{
    return [[self actionDataForNode:node] objectForKey:key];
}

// ------------------------------------------------------
-(void)setData:(id)data forNode:(SKNode*)node andKey:(NSString*)key
// ------------------------------------------------------
{
    [[self actionDataForNode:node] setObject:data forKey:key];
}

// ------------------------------------------------------
-(void)prepareForNode:(SKNode*)node
// ------------------------------------------------------
{
    if (![_actionData objectForNonRetainedKey:node])
    {
        [_actionData setObject:[NSMutableDictionary dictionary] forNonRetainedKey:node];
        [self setup:node];
    }
   
}

// ------------------------------------------------------
-(void)cleanupForNode:(SKNode*)node
// ------------------------------------------------------
{
    if ([_actionData objectForNonRetainedKey:node])
    {
        [self teardown:node];
        NSMutableDictionary* dict = [self actionDataForNode:node];
        [dict removeAllObjects];
        [_actionData removeObjectForNonRetainedKey:node];
    }
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

// =================================================================================================================

@implementation MTKPropertyAction
{
    NSString* _key;
    id _target;
    BOOL _absoluteTarget;
    BOOL _targetIsAnObject;
    
}
// ------------------------------------------------------
-(instancetype)initWithTargetValue:(id)targetValue asAbsoluteTarget:(BOOL)absoluteTarget forVariable:(NSString*)variableName Duration:(NSTimeInterval)duration
// ------------------------------------------------------
{
    self = [super initWithDuration:duration];
    if (self)
    {
        
        _absoluteTarget = absoluteTarget;
        _key = variableName;
        _target = [targetValue copy];
        //Test if target is NSNumber or NSvalue
        if ([targetValue isKindOfClass:[NSNumber class]] ||[targetValue isKindOfClass:[NSValue class]] )
        {
           //  _type = [NSString stringWithUTF8String: [targetValue objCType]];
            _targetIsAnObject = NO;
        }
        // if target is  other Object
        else if([targetValue isKindOfClass:[NSObject class]])
        {
             @throw [NSException exceptionWithName:@"MTKAction" reason:@"Only NSNumber and NSValues are currently supported" userInfo:nil];
            _targetIsAnObject = YES;
        }
    }
    return self;
}

// ------------------------------------------------------
-(void)setup:(SKNode *)node
// ------------------------------------------------------
{
    NSMutableDictionary* data =  [self actionDataForNode:node];
    if ([node respondsToSelector:NSSelectorFromString(_key)])
    {
        id propertyType = [node valueForKey:_key];
        
        
        if ([propertyType isKindOfClass:[NSNumber class]] ||[propertyType isKindOfClass:[NSValue class]] )
        {
            // if target is NSNumber or NSvalue check for stored Type
            NSString* keyType = [NSString stringWithUTF8String: [propertyType  objCType]];
            NSString* targetType = [NSString stringWithUTF8String:[_target objCType]];
            
            
            //check if target is supported
            if (!([targetType isEqualToString:@"i"] || [targetType isEqualToString:@"f"]  || [targetType isEqualToString:@"d"] || [NSString stringWithUTF8String: @encode(CGPoint)]))
            {
                 @throw [NSException exceptionWithName:@"MTKAction" reason:[NSString stringWithFormat:@"Type of property %@ is currently not supported(Only int,float,double, and CGPoints are supported)",_key] userInfo:nil];
            }
            
            if([targetType isEqualToString:keyType])
            {
                // If target and property have the same object Type store stare value and continue
                [data setObject:[node valueForKey:_key] forKey:@"startValue"];
                [data setObject:keyType forKey:@"propertyType"];
            }
            else if([keyType isEqualToString:@"d"] && ([targetType isEqualToString:@"i"] ||  [targetType isEqualToString:@"f"]))
            {
                // special Case: floats if the property is a float (double) and the target value an int/float/double also continue
                [data setObject:[node valueForKey:_key] forKey:@"startValue"];
                [data setObject:keyType forKey:@"propertyType"];
            }
            else
            {
                // throw execption if target and property type does not match
                @throw [NSException exceptionWithName:@"MTKAction" reason:[NSString stringWithFormat:@"Variable type with name %@ does not match the type of the target Value %@",_key,_target] userInfo:nil];
            }
        }
    }
}
// ------------------------------------------------------
-(void)update:(SKNode *)node elapsedTime:(CGFloat)elapsedTime
// ------------------------------------------------------
{
    NSMutableDictionary* data = [self actionDataForNode:node];
    id startValue = [data objectForKey:@"startValue"];
    
    if ([node respondsToSelector:NSSelectorFromString(_key)])
    {
        if (!_targetIsAnObject)
        {
            NSString* propertyType = [data objectForKey:@"propertyType"];
            //float (double)
            if([propertyType isEqualToString:@"d"])
            {
                CGFloat overallChange = [_target floatValue];
                if(_absoluteTarget)
                {
                    overallChange = [_target floatValue] - [startValue floatValue];
                }
                CGFloat value  = [startValue floatValue] + overallChange *( elapsedTime/self.duration);
                [node setValue:@(value) forKey:_key];
            }
            // int (NSInteger)
            else if([propertyType isEqualToString:@"i"])
            {
                int overallChange = [_target intValue];
                if(_absoluteTarget)
                {
                    overallChange = [_target intValue] - [startValue intValue];
                }
                int value  = [startValue intValue] + overallChange *(elapsedTime/self.duration);
                [node setValue:@(value) forKey:_key];

            }
            // CGPoint
            else if([propertyType isEqualToString:[NSString stringWithUTF8String: @encode(CGPoint)]])
            {
                CGPoint overallChange = [_target CGPointValue];
                if(_absoluteTarget)
                {
                    overallChange = MTKPointSubstractPoint([_target CGPointValue], [startValue CGPointValue]);
                }
                CGPoint value = MTKPointAddPoint([startValue CGPointValue], MTKPointMultiplyWithScalar(overallChange, elapsedTime/self.duration));
                [node setValue:[NSValue valueWithCGPoint:value] forKey:_key];
            }
        }
    }
}

// ------------------------------------------------------
-(void)teardown:(SKNode *)node
// ------------------------------------------------------
{
    
}


@end



// =================================================================================================================
@implementation MTKTransformationAction
// =================================================================================================================
{
    //SKNode transformations
    NSArray*    _startPoints;
     NSArray*   _endPoints;
    SKNode*     _startNode;
    SKNode*     _endNode;
    
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
        [[self actionData] setObject:[NSValue valueWithCGRect:rect] forKey:@"rect"];
        [[self actionData] setObject:sprite forKey:@"targetSprite"];
        [[self actionData] setObject:@"sprite" forKey:@"type"];
        
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
        _startPoints    = startPoints;
        _endPoints      = endPoints;
        _startNode      = startNode;
        _endNode        = endNode;
         [[self actionData] setObject:@"node" forKey:@"type"];
       
    }
    return self;
}

// ------------------------------------------------------
-(void)setup:(SKNode *)node
// ------------------------------------------------------
{

    NSDictionary* values;
    if ([[[self actionData] objectForKey:@"type"] isEqualToString:@"node"])
    {
        values =  [node transformFromPoints:_startPoints inCoordinatesOfNode:_startNode toPoints:_endPoints inCoordinatesOfNode:_endNode];
    }
    else if([[[self actionData] objectForKey:@"type"] isEqualToString:@"sprite"])
    {
        if (![node isKindOfClass:[SKSpriteNode class]])
        {
            return;
        }
        SKSpriteNode* sprite = (SKSpriteNode*)node;
        values = [sprite calculateTransformationToRect:[[[self actionData] objectForKey:@"rect"]CGRectValue] inSprite:(SKSpriteNode*)[[self actionData]objectForKey:@"targetSprite"]];
        
    }
 
    [node runAction:[SKAction group:
                     @[
                       [SKAction scaleXTo:[[values objectForKey:@"scale"] CGSizeValue].width y:[[values objectForKey:@"scale"]CGSizeValue].height duration:self.duration],
                       [SKAction rotateToAngle:[[values objectForKey:@"angle"] floatValue] duration:self.duration shortestUnitArc:YES],
                       [SKAction moveTo:[[values objectForKey:@"position"] CGPointValue] duration:self.duration]]]];
    
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





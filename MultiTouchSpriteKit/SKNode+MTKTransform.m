//
//  SKNode+MTKTransform.m
//  MultiTouchKitDemo
//
//  Created by Simon Voelker on 04.02.14.
//  Copyright (c) 2014 i10. All rights reserved.
//

#import "SKNode+MTKTransform.h"
#import "MTKUtil.h"

#define scaleAngleOfDeviation 0.14


@implementation SKNode (MTKTransform)




#pragma mark -
#pragma mark Transformations

// ------------------------------------------------------
-(void)setTransformationConstraints:(MTKNodeTransformationConstraints)transformationConstraints
// ------------------------------------------------------
{
    [self checkUserData];
    [self.userData setObject:[NSNumber numberWithInteger:transformationConstraints] forKey:@"MTKTransformationConstraints"];
    
}

// ------------------------------------------------------
-(MTKNodeTransformationConstraints)transformationConstraints
// ------------------------------------------------------
{
    [self checkUserData];
    NSNumber* number = [self.userData objectForKey:@"MTKTransformationConstraints"];
    if (number)
    {
        return [number integerValue];
    }
    else
    return MTKNoteTransformable;
}

// ------------------------------------------------------
-(void)setTouchable:(BOOL)touchable
// ------------------------------------------------------
{
    [self checkUserData];
    [self.userData setObject:[NSNumber numberWithBool:touchable] forKey:@"MTKTouchable"];
}

// ------------------------------------------------------
-(BOOL)isTouchable
// ------------------------------------------------------
{
    if (!self.userData)
    {
        return NO;
    }
    [self checkUserData];
    return [[self.userData objectForKey:@"MTKTouchable"] boolValue];
}


// ------------------------------------------------------
-(void)setSeperatelyScalable:(BOOL)seperatelyScalable
// ------------------------------------------------------
{
    [self checkUserData];
    [self.userData setObject:[NSNumber numberWithBool:seperatelyScalable] forKey:@"MTKSeparatelyScalable"];
}

// ------------------------------------------------------
-(BOOL)isSeperatelyScalable
// ------------------------------------------------------
{
    if (!self.userData)
    {
        return NO;
    }
    [self checkUserData];
    return [[self.userData objectForKey:@"MTKSeparatelyScalable"] boolValue];
}



// ------------------------------------------------------
-(void)checkUserData
// ------------------------------------------------------
{
    if (self.userData == NULL)
    {
        self.userData = [NSMutableDictionary dictionary];
    }
}


#if TARGET_OS_IPHONE
// ------------------------------------------------------
-(void)transformWithUITouches:(NSSet *)touches
// ------------------------------------------------------
{


    if ([touches count] == 1)
    {
          CGPoint touch1Location = [[touches anyObject] locationInNode:self.parent];
          CGPoint touch1previousLocation = [[touches anyObject] previousLocationInNode:self.parent];
        self.position = MTKPointSubstractPoint(self.position,MTKPointSubstractPoint(touch1previousLocation, touch1Location));
    }
    if ([touches count] >= 2)
    {
        NSArray* allTouches  =    [touches allObjects];
        UITouch* firstTouch =     [allTouches objectAtIndex:0];
    	UITouch* secondTouch =   [allTouches objectAtIndex:1];
        
        CGPoint touch1Location = [firstTouch locationInNode:self.parent];
        CGPoint touch2Location = [secondTouch locationInNode:self.parent];
        
        CGPoint touch1previousLocation = [firstTouch previousLocationInNode:self.parent];
        CGPoint touch2previousLocation = [secondTouch previousLocationInNode:self.parent];

        
        NSDictionary* values = [self transformFromScenePoints:@[[NSValue valueWithCGPoint:touch1previousLocation],[NSValue valueWithCGPoint:touch2previousLocation]] toScenePoints:@[[NSValue valueWithCGPoint:touch1Location],[NSValue valueWithCGPoint:touch2Location]]];
        
        self.xScale = [[values objectForKey:@"scale"] CGSizeValue].width;
        self.yScale =[[values objectForKey:@"scale"] CGSizeValue].height;
        self.position = [[values objectForKey:@"position"] CGPointValue];
        self.zRotation = [[values objectForKey:@"angle"] floatValue];
    }
    
}
#endif

// ------------------------------------------------------
-(NSDictionary*)transformFromScenePoints:(NSArray*)startPoints toScenePoints:(NSArray*)endPoints;
// ------------------------------------------------------
{
    return [self transformFromPoints:startPoints inCoordinatesOfNode:nil toPoints:endPoints inCoordinatesOfNode:nil];
}

// ------------------------------------------------------
-(NSDictionary*)transformFromPoints:(NSArray*)startPoints inCoordinatesOfNode:(SKNode*)startNode toPoints:(NSArray*)endPoints inCoordinatesOfNode:(SKNode*)endNode
{
// ------------------------------------------------------
    
    CGPoint firstStartPoint = [[startPoints objectAtIndex:0] CGPointValue];
    CGPoint secondStartPoint = [[startPoints objectAtIndex:1] CGPointValue];
    
    CGPoint firstEndPoint = [[endPoints objectAtIndex:0] CGPointValue];
    CGPoint secondEndPoint = [[endPoints objectAtIndex:1] CGPointValue];
    if (!startNode)
    {
        startNode = self.scene;
    }
    
    if (!endNode)
    {
        endNode = self.scene;
    }
    
    if (endNode != self.parent)
    {
        firstEndPoint = [endNode convertPoint: firstEndPoint toNode:self.parent];
       secondEndPoint  = [endNode convertPoint: secondEndPoint toNode:self.parent];
    }
    if ( startNode != self.parent)
    {
        firstStartPoint = [self.parent convertPoint:   firstStartPoint fromNode:startNode];
        secondStartPoint = [self.parent convertPoint:  secondStartPoint fromNode:startNode];
    }
    
    
 //float xScaleFactor = (firstEndPoint.x - secondEndPoint.x)/(firstStartPoint.x - secondStartPoint.x);
   // float yScaleFactor = (firstEndPoint.y - secondEndPoint.y) /(firstStartPoint.y - secondStartPoint.y);
    
    float relativeScaleFactor =  MTKPointDistanceBetweenPoints(firstEndPoint,secondEndPoint)/ MTKPointDistanceBetweenPoints(firstStartPoint, secondStartPoint);
    
    if (!(self.transformationConstraints & (MTKNoteScalabe | MTKNoteTransformable)))
    {
        relativeScaleFactor = 1.0f;
    }
    
    float hScale = 1.0f;
    float vScale = 1.0f;
    
    if (self.isSeperatelyScalable) {
        //Get the angle between the 2 touching points and the rotation of the object modulo PI
        float angleBetween2Points = atan((secondStartPoint.y-firstStartPoint.y)/(secondStartPoint.x-firstStartPoint.x));
        float moduloAngle = fmod(self.zRotation-angleBetween2Points, (M_PI));
        
        if(moduloAngle < 0)
            moduloAngle += (M_PI);
        
        //Check if the 2 touching points are aligned on one line +- scaleAngleOfDeviation (horizontal and vertical)
        if(moduloAngle > M_PI-scaleAngleOfDeviation || moduloAngle < scaleAngleOfDeviation)
        {
            hScale = relativeScaleFactor;
        }
        else if(moduloAngle > M_PI_2-scaleAngleOfDeviation && moduloAngle < M_PI_2+scaleAngleOfDeviation)
        {
            vScale = relativeScaleFactor;
        }
        else
        {
            hScale = relativeScaleFactor;
            vScale = relativeScaleFactor;
        }
    }
    
    
    CGPoint globalVector = MTKPointVectorBetweenPoints(firstEndPoint,secondEndPoint);
    CGPoint previousGlobalVector = MTKPointVectorBetweenPoints(firstStartPoint, secondStartPoint);
    
    
    float relativeAngle = MTKPointVectorAngle(globalVector)-MTKPointVectorAngle(previousGlobalVector);
    if (!(self.transformationConstraints & (MTKNoteRotatable | MTKNoteTransformable)))
    {
        relativeAngle = 0.0f;
    }
    
    CGPoint localVector = [self convertPoint:firstStartPoint fromNode:self.parent];
    
    CGSize scale = CGSizeMake(self.xScale * hScale , self.yScale * vScale);
     float rotationAngle = self.zRotation + relativeAngle;
    
    
    CGAffineTransform localToGlobal =  CGAffineTransformScale(CGAffineTransformRotate(CGAffineTransformIdentity, rotationAngle ),scale.width , scale.height);
    
    CGPoint position = MTKPointSubstractPoint(firstEndPoint, CGPointApplyAffineTransform(localVector, localToGlobal));
    
    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:
                          [NSValue valueWithCGPoint:position],@"position",
                          [NSValue valueWithCGSize:scale],@"scale",
                          [NSNumber numberWithFloat:rotationAngle],@"angle",
                          nil];
    
    
    return dict;
}






@end


//
//  Created by Simon Voelker on 04.02.14.
//  Copyright (c) 2014 i10. All rights reserved.
//

/***********************************************************************************
*
* Copyright (c) 2014 Simon Voelker
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NON INFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*
***********************************************************************************/

#import <SpriteKit/SpriteKit.h>
#import "MTKUtil.h"
#import "NSValue+CGElements.h"


/**
 *  These constraints can be used to define which properties of the node are modified by the transformation.
 */
typedef NS_OPTIONS(NSInteger, MTKNodeTransformationConstraints)
{
    /**
     *  The transformation moves the node.
     */
    MTKNoteMoveable = 1 << 0,
    /**
     *  The transformation scales the node..
     */
    MTKNoteScalabe  = 1 << 1,
    /**
     *  The transformation rotates the node.
     */
    MTKNoteRotatable  = 1 << 2,
    /**
     *  The transformation moves, scales, and rotates the node.
     */
    MTKNoteTransformable  = 1 << 3,
    /**
     *  The transformation does not do anything to the node.
     */
    MTKNoteFixed = 1 << 5
};

/**
 *  This SKNode category allows to transform the node accordantly to a set of CGPoints.
 */
@interface SKNode (MTKTransform)

@property(getter=isTouchable) BOOL touchable;

@property(getter=isSeperatelyScalable) BOOL seperatelyScalable;

@property(nonatomic)MTKNodeTransformationConstraints transformationConstraints;

#pragma mark -
#pragma mark Transformations

/** @name Core methods */
/**
  This method transform the node accordinaly to the points in startPoints and EndPoints.
 
   @param startPoints An NSArray containing CGPoints as NSValues.
   @param startNode   The coordinatesytem of the startPoints.
  @param endPoints   An NSArray containing CGPoints as NSValues.
   @param endNode     The coordinatesytem of the startPoints.
 
 
   @return The dictionary contains the absoulte transformation values for:
    * For the key "position" the position of the node as CGPoint stored in a NSValue.
 * For the key "scale" the scale of the node as CGSize stored in a NSValue.
 * For the key "angle" the rotationAngle of the node as float stored in a NSNumber.
 
  @discussion This method currently only takes the first two points of the array to calculated the transformation.
 */

-(NSDictionary*)transformFromPoints:(NSArray*)startPoints inCoordinatesOfNode:(SKNode*)startNode toPoints:(NSArray*)endPoints inCoordinatesOfNode:(SKNode*)endNode;

-(NSDictionary*)transformFromScenePoints:(NSArray*)startPoints toScenePoints:(NSArray*)endPoints;

#if TARGET_OS_IPHONE
/**
 *  Takes the first two touches and transforms the node accordingly. The node will be transformed with respect to the transformationConstraints.
 *
 * @discussion Method only accessible on iOS 
 *  @param touches A set of UITouches.
 */

-(void)transformWithUITouches:(NSSet *)touches;
#endif


#pragma mark -
#pragma mark Utilities
/** @name Utilities */


/**
 *  This method check if the userData property of the SKNode is initialized. If not it will create the NSMutableDictionary
 */
-(void)checkUserData;


@end
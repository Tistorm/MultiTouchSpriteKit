//
//  MTKShapeNode.h
//  MultiTouchKit
//
//  Created by Simon Voelker on 28.03.14.
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
#import "MTKLayerNode.h"

/**
 *  MTKShape Hit Mode
 */
typedef NS_ENUM(NSUInteger, MTKShapeHitMode) {
    /**
     *  Sets the bounding box of the shape as hit testing area.
     */
    MTKSHapeHitModeBoundingBox,
    /**
     *  Sets the fill area of the shape as hit testing area.
     */
    MTKSHapeHitModeFillArea,
    /**
     *  Sets the stroke area of the shape as the hit testing area. This also includes linWidth.
     */
    MTKShapeHitModeStrokeArea,
    /**
     *  Sets the fill and the stroke area as hit testing area.
     */
    MTKShapeHitModePolygonArea
};

@interface MTKShapeNode : MTKLayerNode



+(instancetype)shapeWithRoundedRect:(CGRect)rect cornerWidth:(CGFloat)cornerWidth cornerHeight:(CGFloat)cornerHeight;
+(instancetype)shapeWithRect:(CGRect)rect;


@property (SK_NONATOMIC_IOSONLY) CGPathRef path;

/**
 The color to draw the path with. (for no stroke use [SKColor clearColor]). Defaults to [SKColor whiteColor].
 */
@property (SK_NONATOMIC_IOSONLY, retain) SKColor *strokeColor;
/**
 The color to fill the path with. Defaults to [SKColor clearColor] (no fill).
 */
@property (SK_NONATOMIC_IOSONLY, retain) SKColor *fillColor;

/**
 The width used to stroke the path. Defaults value: 1.0.
 */
@property (SK_NONATOMIC_IOSONLY) CGFloat lineWidth;

/**
 Add a glow to the path stroke of the specified width. Defaults to 0.0 (no glow)
 */
@property (SK_NONATOMIC_IOSONLY) CGFloat glowWidth;

/* @name CAShapeLayer properties */


/* These values define the subregion of the path used to draw the
 * stroked outline. The values must be in the range [0,1] with zero
 * representing the start of the path and one the end. Values in
 * between zero and one are interpolated linearly along the path
 * length. strokeStart defaults to zero and strokeEnd to one. Both are
 * animatable. */

@property (SK_NONATOMIC_IOSONLY) CGFloat strokeStart, strokeEnd;


/* The miter limit used when stroking the path. Defaults to ten.
 * Animatable. */

@property  (SK_NONATOMIC_IOSONLY) CGFloat miterLimit;

/* The cap style used when stroking the path. Options are `butt', `round'
 * and `square'. Defaults to `butt'. */

@property(copy) NSString *lineCap;

/* The join style used when stroking the path. Options are `miter', `round'
 * and `bevel'. Defaults to `miter'. */

@property(copy) NSString *lineJoin;

/* The phase of the dashing pattern applied when creating the stroke.
 * Defaults to zero. Animatable. */

@property  (SK_NONATOMIC_IOSONLY) CGFloat lineDashPhase;

/* The dash pattern (an array of NSNumbers) applied when creating the
 * stroked version of the path. Defaults to nil. */

@property(copy) NSArray *lineDashPattern;

/**
 *  Changing this Bool to YES changes the hit testing from the method [SKNode]containsPoint: such that it only returns true if the point is inside the path */
@property(nonatomic)BOOL useShapeForHitTesting;


/**
 *   The HitTesting Mode for the Shape.
 * @discussion The possible values for this property are listed in MTKShapeHitMode. The default value of this property is MTKShapeHitModePolygonArea.
 */
@property(nonatomic)MTKShapeHitMode hitTestMode;


/**
 *  Checks if the given point  is inside the path
 *
 *  @param point Point that should be tested.
 *  @param node  The coordiante system of the point. If the node is nil the current Scene is used as the coordinate system of the point.
 *
 *  @return YES if the point is inside the path.
 */
-(BOOL)shapeContainsPoint:(CGPoint)point fromNode:(SKNode*)node;



@end

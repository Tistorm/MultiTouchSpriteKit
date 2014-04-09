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

@interface MTKShapeNode : MTKLayerNode

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


+(instancetype)shapeWithRoundedRect:(CGRect)rect cornerWidth:(CGFloat)cornerWidth cornerHeight:(CGFloat)cornerHeight;
+(instancetype)shapeWithRect:(CGRect)rect;

@end

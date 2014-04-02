//
//  MTKUtil.h
//  MultiTouchKit
//
//  Created by Simon Voelker on 15.07.13.
//  Copyright (c) 2013 i10. All rights reserved.

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
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>


// Point and Vector operations
// =================================================================================================================
/**
 *  Adds up two CGPoints component wise
 *
 *  @param augend first CGPoint
 *  @param addend second CGPoint
 *
 *  @return Sum of both CGPoints as CGPoint
 */
CG_INLINE CGPoint MTKPointAddPoint(CGPoint augend,CGPoint addend)
{
     return CGPointMake(augend.x + addend.x, augend.y + addend.y);
}

/**
 *  Substracts one CGPoint component wise from the other
 *
 *  @param minuend    The CGPoint which will be substract.
 *  @param subtrahend The CGPoint that is used to substract.
 *
 *  @return result as CGPoint
 */

CG_INLINE CGPoint MTKPointSubstractPoint(CGPoint minuend,CGPoint subtrahend)
{
    return CGPointMake(minuend.x - subtrahend.x, minuend.y - subtrahend.y);
}


/**
 *  Multiplies the components of two CGPoints.
 *
 *  @param multiplicand The first CGPoint.
 *  @param multiplier The second CGPoint.
 *
 *  @return The result as CGPoint.
 */
CG_INLINE CGPoint MTKPointMultiplyWithPoint(CGPoint multiplicand,CGPoint multiplier)
{
      return CGPointMake(multiplicand.x * multiplier.x, multiplicand.y * multiplier.y);
}

/**
 *  Divides one CGPoint component wise by a other.
 *
 *  @param dividend The first CGPoint.
 *  @param divisor  The second CGPoint,
 *
 *  @return The result as CGPoint.
 */

CG_INLINE CGPoint MTKPointDivideByPoint(CGPoint dividend,CGPoint divisor)
{
    return CGPointMake(dividend.x / divisor.x, dividend.y / divisor.y);
}


// ------------------------------------------------------
/**
 *  Add a float to each of the components of a CGPoint
 *
 *  @param augend  The CGPoint.
 *  @param xAddend The value that is added to the x component of the CGPoint.
 *  @param yAddend The value that is added to the y component of the CGPoint.
 *
 *  @return result as CGPoint
 */
CG_INLINE CGPoint MTKPointAddValues(CGPoint augend,CGFloat xAddend,CGFloat yAddend)
{
    return CGPointMake(augend.x + xAddend, augend.y + yAddend);
}
/**
 *  Substract a float each of the components of a CGPoint
 *
 *  @param minuend     The CGPoint.
 *  @param xSubtrahend The value that is substracted from the x component of the CGPoint.
 *  @param ySubtrahend The value that is substracted from the y component of the CGPoint.
 *
 *  @return The Result as CGPoint.
 */

CG_INLINE CGPoint MTKPointSubstractValues(CGPoint minuend,CGFloat xSubtrahend,CGFloat ySubtrahend)
{
    return CGPointMake(minuend.x - xSubtrahend, minuend.y - ySubtrahend);
}

/**
 *  Multiply a float with each of the components of a CGPoint.
 *
 *  @param multiplicand The CGPoint.
 *  @param xMultiplier  The value that is multiplied with the x component of the CGPoint.
 *  @param yMultiplier  The value that is multiplied with the y component of the CGPoint.
 *
 *  @return The result as a CGPoint.
 */
CG_INLINE CGPoint MTKPointMultiplyWithValues(CGPoint multiplicand,CGFloat xMultiplier,CGFloat yMultiplier)
{
    return CGPointMake(multiplicand.x * xMultiplier, multiplicand.y * yMultiplier);
}

/**
 *  Divide each component of a CGPoint by a float.
 *
 *  @param dividend The CGPoint.
 *  @param xDivisor The value with which the x component of the CGPoint is devided.
 *  @param yDivisor The value with which the y component of the CGPoint is devided.
 *
 *  @return The result as CGPoint
 */

CG_INLINE CGPoint MTKPointDivideByValues(CGPoint dividend,CGFloat xDivisor,CGFloat yDivisor)
{
    return CGPointMake(dividend.x / xDivisor, dividend.y / yDivisor);
}


// ------------------------------------------------------

CG_INLINE CGPoint MTKPointAddScalar(CGPoint augend,CGFloat addend)
{
    return CGPointMake(augend.x + addend, augend.y + addend);
}

CG_INLINE CGPoint MTKPointSubstractScalar(CGPoint minuend,CGFloat subtrahend)
{
    return CGPointMake(minuend.x - subtrahend, minuend.y - subtrahend);
}

CG_INLINE CGPoint MTKPointMultiplyWithScalar(CGPoint multiplicand,CGFloat multiplier)
{
    return CGPointMake(multiplicand.x * multiplier, multiplicand.y * multiplier);
}

CG_INLINE CGPoint MTKPointDivideByScalar(CGPoint dividend,CGFloat divisor)
{
    return CGPointMake(dividend.x / divisor, dividend.y / divisor);
}

// ------------------------------------------------------
/**
 *  Returns the length of a CGPoint which is interpreted as a vector
 *
 *  @param vector The Vector as CGPoint.
 *
 *  @return The length of the Vector as CGFloat.
 */
CG_INLINE CGFloat MTKPointLength(CGPoint vector)
{
    return sqrtf(vector.x * vector.x + vector.y * vector.y);
    
}

/**
 *  Returns a normalized version of a vector
 *
 *  @param vector The vector that should be normalized.
 *
 *  @return The normalized vector as CGPoint
 */
CG_INLINE CGPoint MTKPointNormalize(CGPoint vector)
{
    CGFloat length = MTKPointLength(vector);
    return CGPointMake(vector.x / length, vector.y / length);
}

/**
 *  Compares each component of two CGPoint
 *
 *  @param p1 first CGPoint
 *  @param p2 second CGPoint
 *
 *  @return  YES if both components of each CGPoint are equal.
 */

CG_INLINE BOOL MTKPointIsEqualToPoint(CGPoint p1,CGPoint p2)
{
     return (p1.x == p2.x) && (p1.y == p2.y);
}
/**
 *  Calculates the vector from one point to a other point
 *
 *  @param start The start point of the vector.
 *  @param end   The end Point of the vector.
 *
 *  @return The vector form the start point to the end point.
 */
CG_INLINE CGPoint MTKPointVectorBetweenPoints(CGPoint start, CGPoint end)
{
    return CGPointMake(end.x - start.x,end.y - start.y);

}

/**
 *  Calculates the angle of a vector relative to the base vector (1,0)
 *
 *  @param vector The vector as CGPoint.
 *
 *  @return The angle of the vector in radiant.
 */
CG_INLINE CGFloat MTKPointVectorAngle(CGPoint vector)
{
    return atan2f(vector.y, vector.x);
}
/**
 *  Calculates the distance between to points
 *
 *  @param p1   The first point.
 *  @param p2   The second point.
 *
 *  @return The distance between both points.
 */
CG_INLINE CGFloat MTKPointDistanceBetweenPoints(CGPoint p1,CGPoint p2)
{
     return MTKPointLength(MTKPointVectorBetweenPoints(p1, p2));
}


CG_INLINE CGFloat MTKPointDotProduct(CGPoint v1, CGPoint v2)
{
    return v1.x * v2.x + v1.y * v2.y;
}

CG_INLINE CGFloat MTKPointAngleBetweenVectors(CGPoint v1, CGPoint v2)
{
    CGFloat v1Angle = MTKPointVectorAngle(v1);
    CGFloat v2Angle = MTKPointVectorAngle(v2);
    if(v1Angle > v2Angle)
    {
        return v1Angle - v2Angle;
    }
    else
    {
        return v2Angle - v1Angle;
    }
}

// ------------------------------------------------------

CG_INLINE CGFloat MTKUtilDegreeToRadiant(CGFloat degrees)
{
    return degrees * (M_PI / 180);
}
CG_INLINE CGFloat MTKUtilRadiantToDegree(CGFloat radians)
{
    return radians * (180 / M_PI);
}
// ------------------------------------------------------
CG_INLINE CGPoint MTKPointFlip(CGPoint point)
{
    return CGPointMake(point.y, point.x);
    
}

CG_INLINE CGSize MTKSizeFlip(CGSize size)
{
    return CGSizeMake(size.height, size.width);
    
}

CG_INLINE CGVector MTKVectorFlip(CGVector vector)
{
    return CGVectorMake(vector.dy, vector.dx);
    
}
// Convert functions CGPoint <-> CGSize <-> CGVector
// ------------------------------------------------------
CG_INLINE CGSize CGPointToSize(CGPoint point)
{
    return CGSizeMake(point.x, point.y);
}

CG_INLINE CGSize CGVectorToSize(CGVector vector)
{
    return CGSizeMake(vector.dx, vector.dy);
}

CG_INLINE CGPoint CGSizeToPoint(CGSize size)
{
    return CGPointMake(size.width , size.height);
}

CG_INLINE CGPoint CGVectorToPoint(CGVector vector)
{
     return CGPointMake(vector.dx, vector.dy);
}

CG_INLINE CGVector CGSizeToVector(CGSize size)
{
    return CGVectorMake(size.width , size.height);
}

CG_INLINE CGVector CGPointToVector(CGPoint point)
{
    return CGVectorMake(point.x , point.y);
}


// ------------------------------------------------------
CG_INLINE CGPoint CGSizeCenter(CGSize  size)
{
    return CGPointMake(size.width/2.0, size.height/2.0);
}


CGContextRef createBitmapContext(const size_t pixelsWide, const size_t pixelsHigh);




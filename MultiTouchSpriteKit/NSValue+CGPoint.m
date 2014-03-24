//
//  NSValue+CGPoint.m
//  MultiTouchKit
//
//  Created by Simon Voelker on 24.03.14.
//  Copyright (c) 2014 i10. All rights reserved.
//

#import "NSValue+CGPoint.h"

@implementation NSValue (CGElements)
+(instancetype)CGVectorValue:(CGVector)vector
{
    return [NSValue value:&vector withObjCType:@encode(CGVector)];
}


- (CGVector)CGVectorValue
{
    CGVector vector;
    [self getValue:&vector];
    return vector;
}
#ifdef TARGET_OS_IPHONE

#else
+(instancetype)CGPointValue:(CGPoint)point
{
    return [NSValue valueWithPoint:point];
}
+(instancetype)CGSizeValue:(CGSize)size
{
    return [NSValue value:&size withObjCType:@encode(CGSize)];

}
+(instancetype)CGRectValue:(CGRect)rect
{
     return [NSValue value:&rect withObjCType:@encode(CGRect)];
}

- (CGPoint)CGPointValue
{
    return [self pointValue];
}
- (CGSize)CGSizeValue
{
    CGSize size;
    [self getValue:&size];
    return size;
}
- (CGRect)CGRectValue
{
    CGRect rect;
    [self getValue:&rect];
    return rect;
}
#endif

@end

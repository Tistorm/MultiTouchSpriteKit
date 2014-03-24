//
//  NSValue+CGElements.m
//  MultiTouchKit
//
//  Created by Simon Voelker on 24.03.14.
//  Copyright (c) 2014 i10. All rights reserved.
//

#import "NSValue+CGElements.h"

@implementation NSValue (CGElements)

+(instancetype)valueWithCGVector:(CGVector)vector
{
    return [NSValue value:&vector withObjCType:@encode(CGVector)];
}


- (CGVector)CGVectorValue
{
    CGVector vector;
    [self getValue:&vector];
    return vector;
}

#if TARGET_OS_IPHONE
#else
+(instancetype)valueWithCGPoint:(CGPoint)point
{
     return [NSValue value:&point withObjCType:@encode(CGPoint)];
}
+(instancetype)valueWithCGSize:(CGSize)size
{
    return [NSValue value:&size withObjCType:@encode(CGSize)];
    
}
+(instancetype)valueWithCGRect:(CGRect)rect
{
    return [NSValue value:&rect withObjCType:@encode(CGRect)];
}

- (CGPoint)CGPointValue
{
    CGPoint point;
    [self getValue:&point];
    return point;
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

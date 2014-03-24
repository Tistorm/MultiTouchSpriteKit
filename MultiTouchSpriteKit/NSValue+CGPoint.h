//
//  NSValue+CGPoint.h
//  MultiTouchKit
//
//  Created by Simon Voelker on 24.03.14.
//  Copyright (c) 2014 i10. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
/**
 *  Extention for NSValue
 */
@interface NSValue (CGElements)


+(instancetype)CGVectorValue:(CGVector)vector;
- (CGVector)CGVectorValue;


#ifdef TARGET_OS_IPHONE

#else
+(instancetype)CGPointValue:(CGPoint)point;
+(instancetype)CGSizeValue:(CGSize)size;
+(instancetype)CGRectValue:(CGRect)rect;

- (CGPoint)CGPointValue;
- (CGSize)CGSizeValue;
- (CGRect)CGRectValue;
#endif
@end

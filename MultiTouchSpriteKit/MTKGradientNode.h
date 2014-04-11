//
//  MTKGradientNode.h
//  MultiTouchKit
//
//  Created by Simon Voelker on 03.04.14.
//  Copyright (c) 2014 i10. All rights reserved.
//

#import <MultiTouchKit/MultiTouchKit.h>

@interface MTKGradientNode : MTKLayerNode


@property(copy)NSArray* colors;

@property(copy)NSArray* locations;
@property(nonatomic)CGPoint startPoint;
@property(copy,nonatomic)NSString* type;

@property(nonatomic)CGFloat radius;

-(instancetype)initWithSize:(CGSize)size;



@end

NSString * const kMTKGradientAxial;
NSString * const kMTKGradientRadial;

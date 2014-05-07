//
//  MTKGradientNode.m
//  MultiTouchKit
//
//  Created by Simon Voelker on 03.04.14.
//  Copyright (c) 2014 i10. All rights reserved.
//

#import "MTKGradientNode.h"

@interface MTKLayerNode (subclass)

@property(nonatomic)CAGradientLayer* layer;
@property(nonatomic,readwrite)SKSpriteNode* sprite;
@property(nonatomic)CGContextRef cgContextRef;
-(void)updateTexture;

@end

NSString *const kMTKGradientAxial   = @"kMTKGradientAxial";
NSString *const kMTKGradientRadial   = @"kMTKGradientRadial";


// =================================================================================================================
@implementation MTKGradientNode
{
    NSString* _type;
    CGFloat _radius;
}


// ------------------------------------------------------
-(instancetype)initWithSize:(CGSize)size
// ------------------------------------------------------
{
    self = [super initWithColor:[SKColor clearColor] size:size];
    if (self) {
        
        
        _type = kMTKGradientRadial;
        
        self.sprite.anchorPoint = CGPointMake(0, 0);
        self.layer = [[CAGradientLayer alloc] init];
       
        self.layer.frame = CGRectMake(0, 0, size.width, size.height);
       self.layer.backgroundColor = [[SKColor clearColor] CGColor];
        
        self.layer.colors = [NSArray arrayWithObjects:
                             (id)[[SKColor greenColor] CGColor], (id)[[SKColor blueColor] CGColor],(id)[[SKColor greenColor] CGColor] , nil];

        [self updateTexture];
        self.startPoint = CGPointMake(0, 0);
       // self.radius = 100;
    }
    return self;
}


// ------------------------------------------------------
-(void)drawTexture
// ------------------------------------------------------
{
    
    if ([self.type isEqualToString:kMTKGradientAxial])
    {
         [self.layer renderInContext:self.cgContextRef];
    }
   
    else if ([self.type isEqualToString:kMTKGradientRadial])
    {
       [self drawInContext:self.cgContextRef];
    }
}

// ------------------------------------------------------
-(void)setColors:(NSArray *)colors
// ------------------------------------------------------
{
    self.layer.colors = colors;
    [self updateTexture];
}
// ------------------------------------------------------
-(NSArray*)colors
// ------------------------------------------------------
{
    return self.layer.colors;
}

// ------------------------------------------------------
-(void)setLocations:(NSArray *)locations
//------------------------------------------------------
{
    self.layer.locations = locations;
    [self updateTexture];
}
// ------------------------------------------------------
-(NSArray*)locations
// ------------------------------------------------------
{
    return self.layer.locations;
}

// ------------------------------------------------------
-(void)setStartPoint:(CGPoint)startPoint
// ------------------------------------------------------
{
    self.layer.startPoint = startPoint;
        [self updateTexture];
}
// ------------------------------------------------------
-(CGPoint)startPoint
// ------------------------------------------------------
{
    return self.layer.startPoint;
}

// ------------------------------------------------------
-(void)setRadius:(CGFloat)radius
// ------------------------------------------------------
{
    _radius = radius;
    [self updateTexture];
}



-(CGFloat)radius
{
    return _radius;
}

// ------------------------------------------------------
-(void)setType:(NSString *)type
// ------------------------------------------------------
{
    _type = type;
    [self updateTexture];
}
// ------------------------------------------------------
-(NSString*)type
// ------------------------------------------------------
{
    return _type;
}



// ------------------------------------------------------
- (void)drawInContext:(CGContextRef)theContext
// ------------------------------------------------------
{
    if (self.radius == 0)
    {
        _radius = self.layer.frame.size.width;
    }
    if (!self.locations)
    {
       // NSMutableArray* loc = [NSMutableArray arrayWithCapacity:self.colors.count];
        for (int i =0 ; i < self.colors.count; i++)
        {
            
        }
    }
    NSArray* loc = @[@(0),@(0.5),@(1)];
    
    NSInteger numberOfLocations = loc.count;
    NSInteger numbOfComponents = 0;
    CGColorSpaceRef colorSpace = NULL;
    
    if (self.colors.count) {
        CGColorRef colorRef = (__bridge CGColorRef)([self.colors objectAtIndex:0]);
        numbOfComponents = CGColorGetNumberOfComponents(colorRef);
        colorSpace = CGColorGetColorSpace(colorRef);
    }
    
    CGFloat gradientLocations[numberOfLocations];
    CGFloat gradientComponents[numberOfLocations * numbOfComponents];
    
    for (NSInteger locationIndex = 0; locationIndex < numberOfLocations; locationIndex++) {
        
        gradientLocations[locationIndex] = [loc[locationIndex] floatValue];
        const CGFloat *colorComponents = CGColorGetComponents((__bridge CGColorRef)self.colors[locationIndex]);
        
        for (NSInteger componentIndex = 0; componentIndex < numbOfComponents; componentIndex++) {
            gradientComponents[numbOfComponents * locationIndex + componentIndex] = colorComponents[componentIndex];
        }
    }
    CGGradientRef myGradient = CGGradientCreateWithColorComponents(colorSpace, gradientComponents, gradientLocations, numberOfLocations);
 
    CGContextDrawRadialGradient(theContext, myGradient, self.startPoint,0, self.startPoint, self.radius, kCGGradientDrawsBeforeStartLocation);
    CGGradientRelease(myGradient);
}





@end

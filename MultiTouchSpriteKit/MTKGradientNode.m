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
-(void)updateTexture;
-(void)updateLayerToSize:(CGSize)size;

@end
// =================================================================================================================
@implementation MTKGradientNode

// ------------------------------------------------------
-(instancetype)initWithColor:(SKColor *)color size:(CGSize)size
// ------------------------------------------------------
{
    self = [super initWithColor:color size:size];
    if (self) {
        
        self.anchorPoint = CGPointMake(0, 0);
        self.layer = [[CAGradientLayer alloc] init];
        self.layer.frame = CGRectMake(0, 0, size.width, size.height);
       self.layer.backgroundColor = [color CGColor];
        
        self.layer.colors = [NSArray arrayWithObjects:
                             (id)[[SKColor greenColor] CGColor], (id)[[SKColor blueColor] CGColor],(id)[[SKColor greenColor] CGColor] , nil];

        [self updateTexture];
    }
    return self;
}

// ------------------------------------------------------
-(void)setColors:(NSArray *)colors
// ------------------------------------------------------
{
    self.layer.colors = colors;
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
}
// ------------------------------------------------------
-(CGPoint)startPoint
// ------------------------------------------------------
{
    return self.layer.startPoint;
}

// ------------------------------------------------------
-(void)setEndPoint:(CGPoint)endPoint
// ------------------------------------------------------
{
    self.layer.endPoint = endPoint;
}
// ------------------------------------------------------
-(CGPoint)endPoint
// ------------------------------------------------------
{
    return self.layer.endPoint;
}

// ------------------------------------------------------
-(void)setType:(NSString *)type
// ------------------------------------------------------
{
    self.layer.type = type;
}
// ------------------------------------------------------
-(NSString*)type
// ------------------------------------------------------
{
    return self.layer.type;
}




@end

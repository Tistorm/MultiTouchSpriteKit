//
//  MTKShapeNode.m
//  MultiTouchKit
//
//  Created by Simon Voelker on 28.03.14.
//  Copyright (c) 2014 i10. All rights reserved.
//

#import "MTKShapeNode.h"
#import "MTKUtil.h"

@implementation MTKShapeNode
{
    CGContextRef _cgContextRef;
    CAShapeLayer* _layer;

}
// ------------------------------------------------------
+(instancetype)shapeWithRect:(CGRect)rect
// ------------------------------------------------------
{
    MTKShapeNode* node = [[MTKShapeNode alloc] init];
    node.path =  CGPathCreateWithRect(rect, nil);
    return node;
}

// ------------------------------------------------------
+(instancetype)shapeWithRoundedRect:(CGRect)rect cornerWidth:(CGFloat)cornerWidth cornerHeight:(CGFloat)cornerHeight
// ------------------------------------------------------
{
    MTKShapeNode* node = [[MTKShapeNode alloc] init];
    node.path =  CGPathCreateWithRoundedRect(rect, cornerWidth, cornerWidth, nil);
    return node;
}

// ------------------------------------------------------
- (instancetype)init
// ------------------------------------------------------
{
    self = [super init];
    if (self)
    {
        self.anchorPoint = CGPointMake(0, 0);
        _layer = [[CAShapeLayer alloc] init];
        _layer.strokeColor = [[SKColor blackColor] CGColor];
        _layer.fillColor = Nil;
    }
    return self;
}


// ------------------------------------------------------
-(void)setStrokeColor:(SKColor *)strokeColor
// ------------------------------------------------------
{
    _layer.strokeColor = [strokeColor CGColor];
     [self updateTexture];
}
// ------------------------------------------------------
-(SKColor*)strokeColor
// ------------------------------------------------------
{
    return  [SKColor colorWithCGColor:_layer.strokeColor];
}





// ------------------------------------------------------
-(void)setFillColor:(SKColor *)fillColor
// ------------------------------------------------------
{
    _layer.fillColor = [fillColor CGColor];
    [self updateTexture];
}
// ------------------------------------------------------
-(SKColor*)fillColor
// ------------------------------------------------------
{
    return  [SKColor colorWithCGColor:_layer.fillColor];
}

// ------------------------------------------------------
-(void)setLineWidth:(CGFloat)lineWidth
// ------------------------------------------------------
{
    _layer.lineWidth = lineWidth;
    [self updateTexture];
}

// ------------------------------------------------------
-(CGFloat)lineWidth
// ------------------------------------------------------
{
    return _layer.lineWidth;
}


// ------------------------------------------------------
-(CGPathRef)path
// ------------------------------------------------------
{
    return _layer.path;
}
// ------------------------------------------------------
-(void)setPath:(CGPathRef)path
// ------------------------------------------------------
{
    [self updatedTextureWithPath:path];
}



// ------------------------------------------------------
-(void)setStrokeEnd:(CGFloat)strokeEnd
// ------------------------------------------------------
{
    _layer.strokeEnd = strokeEnd;
    [self updateTexture];
}

// ------------------------------------------------------
-(CGFloat)strokeEnd
// ------------------------------------------------------
{
    return _layer.strokeEnd;
}

// ------------------------------------------------------
-(void)setStrokeStart:(CGFloat)strokeStart
// ------------------------------------------------------
{
    _layer.strokeStart = strokeStart;
    [self updateTexture];
}

// ------------------------------------------------------
-(CGFloat)strokeStart
// ------------------------------------------------------
{
    return _layer.strokeStart;
}
// ------------------------------------------------------
-(void)setMiterLimit:(CGFloat)miterLimit
// ------------------------------------------------------
{
    _layer.miterLimit = miterLimit;
    [self updateTexture];
}

// ------------------------------------------------------
-(CGFloat)miterLimit
// ------------------------------------------------------
{
    return _layer.miterLimit;
}

// ------------------------------------------------------
-(void)setLineCap:(NSString *)lineCap
// ------------------------------------------------------
{
    _layer.lineCap = lineCap;
    [self updateTexture];
}

// ------------------------------------------------------
-(NSString*)lineCap
// ------------------------------------------------------
{
    return _layer.lineCap;
}

// ------------------------------------------------------
-(void)setLineJoin:(NSString *)lineJoin
// ------------------------------------------------------
{
    _layer.lineJoin = lineJoin;
     [self updateTexture];
}

// ------------------------------------------------------
-(NSString*)lineJoin
// ------------------------------------------------------
{
    return _layer.lineJoin;
}

// ------------------------------------------------------
-(void)setLineDashPhase:(CGFloat)lineDashPhase
// ------------------------------------------------------
{
    _layer.lineDashPhase = lineDashPhase;
     [self updateTexture];
}
// ------------------------------------------------------
-(CGFloat)lineDashPhase
// ------------------------------------------------------
{
    return _layer.lineDashPhase;
}

// ------------------------------------------------------
-(void)setLineDashPattern:(NSArray *)lineDashPattern
// ------------------------------------------------------
{
    _layer.lineDashPattern = lineDashPattern;
}

// ------------------------------------------------------
-(NSArray*)lineDashPattern
// ------------------------------------------------------
{
    return _layer.lineDashPattern;
}


// ------------------------------------------------------
-(void)updatedTextureWithPath:(CGPathRef)path
// ------------------------------------------------------
{
    CGContextRelease(_cgContextRef);
    
    CGRect boundingBox = CGPathGetBoundingBox(path);
    float space = 20;
    CGSize textureSize  = CGSizeMake(boundingBox.origin.x+boundingBox.size.width +space , boundingBox.origin.y+boundingBox.size.height +space);
    _cgContextRef = createBitmapContext(textureSize.width,textureSize.height);
    self.size = textureSize;
    
    _layer.frame = CGRectMake(0, 0,textureSize.width ,textureSize.height);
    
    _layer.path = path;
    
    [self updateTexture];
    
    
}

// ------------------------------------------------------
-(void)updateTexture
// ------------------------------------------------------
{
    CGContextClearRect(_cgContextRef, _layer.frame);
    
    [_layer renderInContext:_cgContextRef];
    CGContextSetAllowsAntialiasing(_cgContextRef, YES);
    CGImageRef imageref = CGBitmapContextCreateImage(_cgContextRef);
    
    SKTexture* texture1 = [SKTexture textureWithCGImage:imageref];
    
    CGImageRelease(imageref);
    
    [self setTexture:texture1];
    
}



// ------------------------------------------------------
-(void)dealloc
// ------------------------------------------------------
{
    CGContextRelease(_cgContextRef);
}

@end

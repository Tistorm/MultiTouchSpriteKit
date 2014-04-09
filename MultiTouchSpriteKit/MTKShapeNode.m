//
//  MTKShapeNode.m
//  MultiTouchKit
//
//  Created by Simon Voelker on 28.03.14.
//  Copyright (c) 2014 i10. All rights reserved.
//

#import "MTKShapeNode.h"
#import "MTKUtil.h"


@interface MTKLayerNode (subclass)

@property(nonatomic)CAShapeLayer* layer;
@property(nonatomic)SKSpriteNode* sprite;
@property(nonatomic)CGContextRef cgContextRef;

-(void)updateTexture;
-(CGPoint)calculatedLayerPosition;
-(CGSize)calculatedTextureSize;

@end

@implementation MTKShapeNode
{
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
        self.layer = [[CAShapeLayer alloc] init];
        self.layer.strokeColor = [[SKColor blackColor] CGColor];
        self.layer.fillColor = Nil;
       // self.layer.backgroundColor = [[SKColor greenColor] CGColor];
        //self.layer.shadowOpacity = 1;
    }
    return self;
}


// ------------------------------------------------------
-(void)setStrokeColor:(SKColor *)strokeColor
// ------------------------------------------------------
{
    self.layer.strokeColor = [strokeColor CGColor];
     [self updateTexture];
}
// ------------------------------------------------------
-(SKColor*)strokeColor
// ------------------------------------------------------
{
    return  [SKColor colorWithCGColor:self.layer.strokeColor];
}





// ------------------------------------------------------
-(void)setFillColor:(SKColor *)fillColor
// ------------------------------------------------------
{
    self.layer.fillColor = [fillColor CGColor];
    [self updateTexture];
}
// ------------------------------------------------------
-(SKColor*)fillColor
// ------------------------------------------------------
{
    return  [SKColor colorWithCGColor:self.layer.fillColor];
}

// ------------------------------------------------------
-(void)setLineWidth:(CGFloat)lineWidth
// ------------------------------------------------------
{
    self.layer.lineWidth = lineWidth;
    [self updatedTextureWithPath:self.layer.path];
}

// ------------------------------------------------------
-(CGFloat)lineWidth
// ------------------------------------------------------
{
    return self.layer.lineWidth;
}


// ------------------------------------------------------
-(CGPathRef)path
// ------------------------------------------------------
{
    return self.layer.path;
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
    self.layer.strokeEnd = strokeEnd;
    [self updateTexture];
}

// ------------------------------------------------------
-(CGFloat)strokeEnd
// ------------------------------------------------------
{
    return self.layer.strokeEnd;
}

// ------------------------------------------------------
-(void)setStrokeStart:(CGFloat)strokeStart
// ------------------------------------------------------
{
    self.layer.strokeStart = strokeStart;
    [self updateTexture];
}

// ------------------------------------------------------
-(CGFloat)strokeStart
// ------------------------------------------------------
{
    return self.layer.strokeStart;
}
// ------------------------------------------------------
-(void)setMiterLimit:(CGFloat)miterLimit
// ------------------------------------------------------
{
    self.layer.miterLimit = miterLimit;
    [self updatedTextureWithPath:self.layer.path];
}

// ------------------------------------------------------
-(CGFloat)miterLimit
// ------------------------------------------------------
{
    return self.layer.miterLimit;
}

// ------------------------------------------------------
-(void)setLineCap:(NSString *)lineCap
// ------------------------------------------------------
{
    self.layer.lineCap = lineCap;
   [self updatedTextureWithPath:self.layer.path];
}

// ------------------------------------------------------
-(NSString*)lineCap
// ------------------------------------------------------
{
    return self.layer.lineCap;
}

// ------------------------------------------------------
-(void)setLineJoin:(NSString *)lineJoin
// ------------------------------------------------------
{
    self.layer.lineJoin = lineJoin;
    [self updatedTextureWithPath:self.layer.path];
}

// ------------------------------------------------------
-(NSString*)lineJoin
// ------------------------------------------------------
{
    return self.layer.lineJoin;
}

// ------------------------------------------------------
-(void)setLineDashPhase:(CGFloat)lineDashPhase
// ------------------------------------------------------
{
    self.layer.lineDashPhase = lineDashPhase;
     [self updateTexture];
}
// ------------------------------------------------------
-(CGFloat)lineDashPhase
// ------------------------------------------------------
{
    return self.layer.lineDashPhase;
}

// ------------------------------------------------------
-(void)setLineDashPattern:(NSArray *)lineDashPattern
// ------------------------------------------------------
{
    self.layer.lineDashPattern = lineDashPattern;
    [self updateTexture];
}

// ------------------------------------------------------
-(NSArray*)lineDashPattern
// ------------------------------------------------------
{
    return self.layer.lineDashPattern;
}


// ------------------------------------------------------
-(void)updatedTextureWithPath:(CGPathRef)path
// ------------------------------------------------------
{
    
    CGRect boundingBox = CGPathGetBoundingBox(path);
    
    CGPoint test = MTKPointVectorBetweenPoints(boundingBox.origin, CGPointMake(self.layer.lineWidth/2.0, self.layer.lineWidth /2.0));
    
    CGAffineTransform transform = CGAffineTransformMakeTranslation(test.x,test.y);
    self.layer.path = CGPathCreateCopyByTransformingPath(path, &transform);
    CGSize textureSize  = CGSizeMake(boundingBox.size.width +self.layer.lineWidth , boundingBox.size.height +self.layer.lineWidth);
    self.layer.frame = CGRectMake(0,0, textureSize.width, textureSize.height);
    self.layer.position = boundingBox.origin;
    [self updateTexture];
    
}





@end

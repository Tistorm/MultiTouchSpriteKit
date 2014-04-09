//
//  MTKLayerNode.m
//  MultiTouchKit
//
//  Created by Simon Voelker on 02.04.14.
//  Copyright (c) 2014 i10. All rights reserved.
//

#import "MTKLayerNode.h"
#import "MTKUtil.h"

@interface MTKLayerNode()

@property(nonatomic)CALayer* layer;
@property(nonatomic)SKSpriteNode* sprite;
@property(nonatomic)CGContextRef cgContextRef;


@end

@implementation MTKLayerNode
{
    CGPoint _anchorPoint;
}

// TODO: Shadow size...


// ------------------------------------------------------
-(instancetype)initWithColor:(SKColor *)color size:(CGSize)size
// ------------------------------------------------------
{
    self = [super init];
    if (self) {
        
       
        self.sprite = [SKSpriteNode spriteNodeWithColor:color size:size];
         [self addChild:self.sprite];
        self.layer = [[CALayer alloc] init];
        //self.anchorPoint = CGPointMake(0, 0);
        self.layer.frame = CGRectMake(0, 0, size.width,size.height);
        self.layer.backgroundColor = [color CGColor];
       
        self.cgContextRef = createBitmapContextWithSize(self.sprite.size);
        
        [self updateTexture];
    }
    return self;
}

// ------------------------------------------------------
-(void)updateTexture
// ------------------------------------------------------
{
    CGSize newSize = [self calculatedTextureSize];
    if (!MTKSizeIsEqualToSize(newSize, self.sprite.size))
    {
        CGContextRelease(self.cgContextRef);
        self.sprite.size = newSize;
        self.cgContextRef = createBitmapContextWithSize(self.sprite.size);
    }
    CGPoint newPosition =  [self calculatedLayerPosition];
    
    if (!MTKPointIsEqualToPoint(newPosition, self.layer.position))
    {
        self.layer.position = newPosition;
        
        CGContextTranslateCTM(self.cgContextRef,  self.layer.position.x,  self.layer.position.y);
    }
   self.sprite.anchorPoint = CGPointMake((self.layer.position.x + self.anchorPoint.x * self.layer.frame.size.width ) / self.sprite.size.width, (self.layer.position.y + self.anchorPoint.y * self.layer.frame.size.height)  / self.sprite.size.height);
    
    [self drawTexture];
    
}

// ------------------------------------------------------
-(void)drawTexture
// ------------------------------------------------------
{
    float clearAreaOffset = self.layer.shadowRadius * 4;
    CGContextClearRect(self.cgContextRef, CGRectMake(-clearAreaOffset, -clearAreaOffset, self.sprite.size.width+clearAreaOffset, self.sprite.size.height+clearAreaOffset));
    
    [self.layer renderInContext:self.cgContextRef];
    
    
    CGContextSetAllowsAntialiasing(self.cgContextRef, YES);
    CGImageRef imageref = CGBitmapContextCreateImage(self.cgContextRef);
    
    SKTexture* texture1 = [SKTexture textureWithCGImage:imageref];
    
    CGImageRelease(imageref);
    
    
    [self.sprite setTexture:texture1];
}

// ------------------------------------------------------
- (instancetype)init
// ------------------------------------------------------
{
    self = [super init];
    if (self) {
        self.sprite = [SKSpriteNode spriteNodeWithColor:[SKColor clearColor] size:CGSizeMake(1, 1)];
          self.sprite.anchorPoint = CGPointMake(0, 0);
        [self addChild:self.sprite];
        self.layer = [[CALayer alloc] init];
       // self.anchorPoint = CGPointMake(0, 0);
    }
    return self;
}

// ------------------------------------------------------
-(CGPoint)calculatedLayerPosition;
// ------------------------------------------------------
{
    if (self.layer.shadowOpacity == 0)
    {
        return CGPointMake(0, 0);
    }
    else
    {
        CGPoint returnPoint = CGPointMake(0, 0);
        if (self.layer.shadowOffset.width <= self.layer.shadowRadius * 2)
        {
         returnPoint = CGPointMake(  self.layer.shadowRadius * 2 - self.shadowOffset.width ,  self.layer.shadowRadius * 2);
        }
        else
        {
            returnPoint = CGPointMake( 0 ,  returnPoint.y);
        }
        if (self.layer.shadowOffset.height <= self.layer.shadowRadius * 2)
        {
            returnPoint = CGPointMake( returnPoint.x, self.layer.shadowRadius * 2 - self.shadowOffset.height);
        }
        else
        {
            returnPoint = CGPointMake( returnPoint.x ,  0);
        }
    //Nur wenn offset negative ist..
    
        return returnPoint;
    }
}


// ------------------------------------------------------
-(CGSize)calculatedTextureSize
// ------------------------------------------------------
{
    if (self.layer.shadowOpacity == 0)
    {
        return self.layer.frame.size;
    }
    
    //Shadow size: 2* shadow radius in each direction shifted by the offset
    // if object 100 and shadow radius 20 offset 0 => texture has to be 180
    else
    {
        CGSize returnSize =  CGSizeMake(self.layer.frame.size.width + 4 * self.layer.shadowRadius, self.layer.frame.size.height+ 4 * self.layer.shadowRadius);
        
        if (fabs(self.layer.shadowOffset.width)  > self.layer.shadowRadius * 2)
        {
            returnSize = CGSizeMake(returnSize.width + fabsf(self.layer.shadowOffset.width) - (2 * self.layer.shadowRadius), returnSize.height);
        }
        if (fabs(self.layer.shadowOffset.height) > self.layer.shadowRadius * 2)
        {
            returnSize = CGSizeMake(returnSize.width,returnSize.height + fabsf(self.layer.shadowOffset.height) - (2 * self.layer.shadowRadius));
        }
        return returnSize;
    }
   
}

// ------------------------------------------------------
-(void)setAnchorPoint:(CGPoint)anchorPoint
// ------------------------------------------------------
{
    _anchorPoint = anchorPoint;
    [self updateTexture];
}
// ------------------------------------------------------
-(CGPoint)anchorPoint
// ------------------------------------------------------
{
    return _anchorPoint;
}


// ------------------------------------------------------
-(void)setBackgroundColor:(SKColor*)backgroundColor
// ------------------------------------------------------
{
    self.layer.backgroundColor = [backgroundColor CGColor];
    [self updateTexture];
}
// ------------------------------------------------------
-(SKColor*)backgroundColor
// ------------------------------------------------------
{
    return [SKColor colorWithCGColor:self.layer.backgroundColor];
}

// ------------------------------------------------------
-(void)setCornerRadius:(CGFloat)cornerRadius
// ------------------------------------------------------
{
    self.layer.cornerRadius = cornerRadius;
    [self updateTexture];
}

// ------------------------------------------------------
-(CGFloat)cornerRadius
// ------------------------------------------------------
{
    return self.layer.cornerRadius;
}

// ------------------------------------------------------
-(void)setBorderWidth:(CGFloat)borderWidth
// ------------------------------------------------------
{
    self.layer.borderWidth = borderWidth;
    [self updateTexture];
}

// ------------------------------------------------------
-(CGFloat)borderWidth
// ------------------------------------------------------
{
    return self.layer.borderWidth;
}


// ------------------------------------------------------
-(void)setBorderColor:(SKColor *)borderColor
// ------------------------------------------------------
{
    self.layer.borderColor = [borderColor CGColor];
    [self updateTexture];
}

// ------------------------------------------------------
-(SKColor*)borderColor
// ------------------------------------------------------
{
    return  [SKColor colorWithCGColor:self.layer.borderColor];
}

// ------------------------------------------------------
-(void)setOpacity:(float)opacity
// ------------------------------------------------------
{
    self.layer.opacity = opacity;
    [self updateTexture];
}

// ------------------------------------------------------
-(float)opacity
// ------------------------------------------------------
{
    return self.layer.opacity;
}

// ------------------------------------------------------
-(void)setShadowColor:(SKColor*)shadowColor
// ------------------------------------------------------
{
    self.layer.shadowColor = [shadowColor CGColor];
    [self updateTexture];
}

// ------------------------------------------------------
-(SKColor*)shadowColor
// ------------------------------------------------------
{
    return  [SKColor colorWithCGColor:self.layer.shadowColor];
}

// ------------------------------------------------------
-(void)setShadowOpacity:(float)shadowOpacity
// ------------------------------------------------------
{
    self.layer.shadowOpacity = shadowOpacity;
    [self updateTexture];
}

// ------------------------------------------------------
-(float)shadowOpacity
// ------------------------------------------------------
{
    return self.layer.shadowOpacity;
}

// ------------------------------------------------------
-(void)setShadowOffset:(CGSize)shadowOffset
// ------------------------------------------------------
{
    self.layer.shadowOffset = shadowOffset;
    [self updateTexture];
    
}

// ------------------------------------------------------
-(CGSize)shadowOffset
// ------------------------------------------------------
{
    return self.layer.shadowOffset;
}

// ------------------------------------------------------
-(void)setShadowRadius:(CGFloat)shadowRadius
// ------------------------------------------------------
{
    self.layer.shadowRadius = shadowRadius;
    [self updateTexture];
}

// ------------------------------------------------------
-(CGFloat)shadowRadius
// ------------------------------------------------------
{
    return self.layer.shadowRadius;
}








// ------------------------------------------------------
-(void)dealloc
// ------------------------------------------------------
{
    CGContextRelease(_cgContextRef);
}



@end

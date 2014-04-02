//
//  SKTexture+CALayer.m
//  MultiTouchKit
//
//  Created by Simon Voelker on 30.03.14.
//  Copyright (c) 2014 i10. All rights reserved.
//

#import "SKTexture+CALayer.h"
#import "MTKUtil.h"

@implementation SKTexture (CALayer)


+(SKTexture*)textureWithCALayer:(CALayer*)layer
{
    if (!layer)
    {
        return nil;
    }
   CGContextRef context = createBitmapContext(layer.frame.size.width,layer.frame.size.height);
    
    [layer renderInContext:context];
    CGContextSetAllowsAntialiasing(context, YES);
    CGImageRef imageref = CGBitmapContextCreateImage(context);
    
    SKTexture* texture = [SKTexture textureWithCGImage:imageref];
    
    CGImageRelease(imageref);
    CGContextRelease(context);
    
    return texture;
}


@end

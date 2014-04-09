//
//  MTKUtil.m
//  MultiTouchKit
//
//  Created by Simon Voelker on 15.07.13.
//  Copyright (c) 2013 i10. All rights reserved.
//

#import "MTKUtil.h"

// ------------------------------------------------------
CGContextRef createBitmapContextWithSize(CGSize size)
// ------------------------------------------------------
{
    return createBitmapContext(size.width, size.height);
}



// ------------------------------------------------------
CGContextRef createBitmapContext(const size_t pixelsWide, const size_t pixelsHigh)
// ------------------------------------------------------
{
    CGContextRef    context = NULL;
    CGColorSpaceRef colorSpace;
    void *          bitmapData;
    //int             bitmapByteCount;
    size_t             bitmapBytesPerRow;
    
    bitmapBytesPerRow   = (pixelsWide * 4);// 1
    //bitmapByteCount     = (bitmapBytesPerRow * pixelsHigh);
    
    colorSpace = CGColorSpaceCreateDeviceRGB();
    bitmapData = NULL;
    
#define kBitmapInfo     kCGImageAlphaPremultipliedLast
    //#define kBitmapInfo       kCGImageAlphaPremultipliedFirst
    //#define kBitmapInfo       kCGImageAlphaNoneSkipFirst
    // According to http://stackoverflow.com/a/18921840/129202 it should be safe to just cast
    CGBitmapInfo bitmapinfo = (CGBitmapInfo)kBitmapInfo; //kCGImageAlphaNoneSkipFirst; //0; //kCGBitmapAlphaInfoMask; //kCGImageAlphaNone; //kCGImageAlphaNoneSkipFirst;
    context = CGBitmapContextCreate (bitmapData,// 4
                                     pixelsWide,
                                     pixelsHigh,
                                     8,      // bits per component
                                     bitmapBytesPerRow,
                                     colorSpace,
                                     bitmapinfo
                                     );
    if (context== NULL)
    {
        free (bitmapData);// 5
        fprintf (stderr, "Context not created!");
        return NULL;
    }
    CGColorSpaceRelease( colorSpace );// 6
    
    return context;// 7
}
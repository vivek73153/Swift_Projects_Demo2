//
//  UIImage+Alpha.swift
//  Weekend In Lviv
//
//  Created by Admin on 18.06.14.
//  Copyright (c) 2014 rnd. All rights reserved.
//

import Foundation

extension UIImage {
    
    func hasAlpha() -> Bool
    {
        let alpha:CGImageAlphaInfo = CGImageGetAlphaInfo(self.CGImage)
        return (alpha == CGImageAlphaInfo.First ||
                alpha == CGImageAlphaInfo.Last ||
                alpha == CGImageAlphaInfo.PremultipliedFirst ||
                alpha == CGImageAlphaInfo.PremultipliedLast)
    }
    
    func imageWithAlpha() -> UIImage
    {
        if self.hasAlpha() {
            return self
        }
        
        let imageRef:CGImageRef = self.CGImage
        let width:size_t  = CGImageGetWidth(imageRef)
        let height:size_t = CGImageGetHeight(imageRef)
    
        // The bitsPerComponent and bitmapInfo values are hard-coded to prevent an "unsupported parameter combination" error
        let offscreenContext:CGContextRef = CGBitmapContextCreate(nil, width, height, 8, 0,
                                                                CGImageGetColorSpace(imageRef),
                                                                CGBitmapInfo.ByteOrderDefault/* | CGImageAlphaInfo.PremultipliedFirst*/)
        // Draw the image into the context and retrieve the new image, which will now have an alpha layer
        CGContextDrawImage(offscreenContext, CGRectMake(0, 0, CGFloat(width), CGFloat(height)), imageRef)
        let imageRefWithAlpha:CGImageRef = CGBitmapContextCreateImage(offscreenContext)
        let imageWithAlpha:UIImage = UIImage(CGImage:imageRefWithAlpha)
    
        // Clean up
        CGContextRelease(offscreenContext);
        CGImageRelease(imageRefWithAlpha);
        
        return imageWithAlpha;
    }
    
    func transparentBorderImage(#borderSize:Int) -> UIImage
    {
        let image:UIImage = self.imageWithAlpha()
        // TO DO !!!!!
        let newRect:CGRect = CGRectMake(0, 0, image.size.width + CGFloat(borderSize) * 2, image.size.height + CGFloat(borderSize) * 2)
        
        // Build a context that's the same dimensions as the new size
        let bitmap:CGContextRef = CGBitmapContextCreate(nil,
                                                        UInt(newRect.size.width), UInt(newRect.size.height),
                                                        CGImageGetBitsPerComponent(self.CGImage),
                                                        0,
                                                        CGImageGetColorSpace(self.CGImage),
                                                        CGImageGetBitmapInfo(self.CGImage))
        // Draw the image in the center of the context, leaving a gap around the edges
        let imageLocation:CGRect = CGRectMake(CGFloat(borderSize), CGFloat(borderSize), image.size.width, image.size.height)
        CGContextDrawImage(bitmap, imageLocation, self.CGImage)
        let borderImageRef:CGImageRef = CGBitmapContextCreateImage(bitmap)
        
        // Create a mask to make the border transparent, and combine it with the image
        let maskImageRef:CGImageRef = self.newBorderMask(borderSize:borderSize, size:newRect.size)
        let transparentBorderImageRef:CGImageRef = CGImageCreateWithMask(borderImageRef, maskImageRef)
        let transparentBorderImage:UIImage = UIImage(CGImage:transparentBorderImageRef)
        
        // Clean up
        CGContextRelease(bitmap)
        CGImageRelease(borderImageRef)
        CGImageRelease(maskImageRef)
        CGImageRelease(transparentBorderImageRef)
        
        return transparentBorderImage
    }
    
    func newBorderMask(#borderSize:Int, size:CGSize) -> CGImageRef
    {
        let colorSpace:CGColorSpaceRef = CGColorSpaceCreateDeviceGray()
        
        // Build a context that's the same dimensions as the new size
        let maskContext:CGContextRef = CGBitmapContextCreate(nil,
                                                            UInt(size.width), UInt(size.height),
                                                            8, // 8-bit grayscale
                                                            0,
                                                            colorSpace,
                                                            CGBitmapInfo.ByteOrderDefault/* | CGImageAlphaInfo.None*/)
        
        // Start with a mask that's entirely transparent
        CGContextSetFillColorWithColor(maskContext, UIColor.blackColor().CGColor)
        CGContextFillRect(maskContext, CGRectMake(0, 0, size.width, size.height))
        
        // Make the inner part (within the border) opaque
        CGContextSetFillColorWithColor(maskContext, UIColor.whiteColor().CGColor)
        CGContextFillRect(maskContext, CGRectMake(CGFloat(borderSize),
                                                    CGFloat(borderSize),
                                                    size.width - CGFloat(borderSize) * 2,
                                                    size.height - CGFloat(borderSize) * 2))
        
        // Get an image of the context
        let maskImageRef:CGImageRef = CGBitmapContextCreateImage(maskContext)
        
        // Clean up
        CGContextRelease(maskContext);
        CGColorSpaceRelease(colorSpace);
        
        return maskImageRef;
    }
    
}

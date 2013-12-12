//
//  ProcessImageBuffer.m
//  TrackingRGBACamera
//
//  Created by zgw on 13-12-12.
//  Copyright (c) 2013年 lunajin. All rights reserved.
//

#import "ProcessImageBuffer.h"

@implementation ProcessImageBuffer


- (NSArray *)getTouchPointRGBAByImageBuffer:(CVImageBufferRef)imageBuffer theTouchPoint:(CGPoint)currentTouchPoint theTouchView:(UIView *)view
{

    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    size_t bufferHeight = CVPixelBufferGetHeight(imageBuffer);
    size_t bufferWidth = CVPixelBufferGetWidth(imageBuffer);
    
    int scaledVideoPointX = round((view.bounds.size.width - currentTouchPoint.x) * (CGFloat)bufferHeight / view.bounds.size.width);
    int scaledVideoPointY = round(currentTouchPoint.y * (CGFloat)bufferWidth / view.bounds.size.height);
    uint8_t *rowBase = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer);
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    uint8_t *pixel = rowBase + (scaledVideoPointX * bytesPerRow) + (scaledVideoPointY * 4);
    
    NSNumber *alpha = [NSNumber numberWithFloat:(float)pixel[3]];
    NSNumber *red   = [NSNumber numberWithFloat:(float)pixel[2]];
    NSNumber *green = [NSNumber numberWithFloat:(float)pixel[1]];
    NSNumber *blue  = [NSNumber numberWithFloat:(float)pixel[0]];
    NSArray *touchPointRGBA = [NSArray arrayWithObjects:red, green, blue, alpha, nil];
    return touchPointRGBA;
    
}

@end

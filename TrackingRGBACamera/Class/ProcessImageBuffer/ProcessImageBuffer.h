//
//  ProcessImageBuffer.h
//  TrackingRGBACamera
//
//  Created by zgw on 13-12-12.
//  Copyright (c) 2013年 lunajin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProcessImageBuffer : NSObject


- (NSArray *)getTouchPointRGBAByImageBuffer:(CVImageBufferRef)imageBuffer theTouchPoint:(CGPoint)currentTouchPoint theTouchView:(UIView *)view;

- (UIImage *)imageFromImageBufferRef:(CVImageBufferRef)imageBuffer;

@end

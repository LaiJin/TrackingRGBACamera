//
//  TrackingRGBACamera.h
//  TrackingRGBACamera
//
//  Created by xyooyy on 13-12-11.
//  Copyright (c) 2013年 lunajin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <CoreMedia/CoreMedia.h>

@protocol TarckingRGBADelegate;

@interface TrackingRGBACamera : NSObject


@property (readonly) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (weak, nonatomic) id<TarckingRGBADelegate>delegate;

@end


@protocol TarckingRGBADelegate <NSObject>

- (void)showVideoPreviewLayer;
- (void)processImageBuffer:(CVImageBufferRef)imageBuffer;

@end

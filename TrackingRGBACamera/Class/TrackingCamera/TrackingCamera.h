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

@protocol TarckingDelegate;

@interface TrackingCamera : NSObject


@property (readonly) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (weak, nonatomic) id<TarckingDelegate>delegate;

-(void)startTrackingCamera;

@end


@protocol TarckingDelegate <NSObject>

- (void)showVideoPreviewLayer;
- (void)processImageBuffer:(CVImageBufferRef)imageBuffer;

@end

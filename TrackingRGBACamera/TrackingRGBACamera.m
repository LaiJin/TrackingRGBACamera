        //
//  TrackingRGBACamera.m
//  TrackingRGBACamera
//
//  Created by xyooyy on 13-12-11.
//  Copyright (c) 2013年 lunajin. All rights reserved.
//

#import "TrackingRGBACamera.h"

@interface TrackingRGBACamera () <AVCaptureVideoDataOutputSampleBufferDelegate>{
    
	AVCaptureSession *captureSession;
	AVCaptureDeviceInput *videoInput;
	AVCaptureVideoDataOutput *videoOutput;
    
}

@end

@implementation TrackingRGBACamera
@synthesize delegate = _delegate;
@synthesize videoPreviewLayer = _videoPreviewLayer;

#pragma mark -
#pragma mark Initiallization

- (id)init
{
    self = [super init];
    if (self) {
        
        [self setupCaptureSession];
        
    }
    
    return self;
}


#pragma mark -
#pragma mark Prvate Methods

#pragma mark -setupCaptureSession
- (void)setupCaptureSession
{
    
    NSError *error = nil;
    AVCaptureDevice *rearCamera = [[AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo] objectAtIndex:0];
    videoInput = [AVCaptureDeviceInput deviceInputWithDevice:rearCamera error:&error];
    if (!error){
        
        captureSession = [[AVCaptureSession alloc] init];
        [captureSession beginConfiguration];
        [captureSession addInput:videoInput];
        [captureSession addOutput:[self createCaptureVideoDataOutput]];
        [captureSession setSessionPreset:AVCaptureSessionPresetPhoto];
        [captureSession commitConfiguration];
        
        if (![captureSession isRunning]) {
            
             [captureSession startRunning];
        }
        
    }
    else NSLog(@"not input");
    
}


#pragma mark -createCaptureVideoDataOutput
- (AVCaptureVideoDataOutput *)createCaptureVideoDataOutput
{
    
    AVCaptureVideoDataOutput *captureVideoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    NSDictionary* videoSettings = [NSDictionary dictionaryWithObject:[NSNumber numberWithUnsignedInt:kCVPixelFormatType_32BGRA]
                                                              forKey:(NSString*)kCVPixelBufferPixelFormatTypeKey];
    [captureVideoDataOutput setVideoSettings:videoSettings];
    [captureVideoDataOutput setAlwaysDiscardsLateVideoFrames:YES];
    [captureVideoDataOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    
    AVCaptureConnection *captureConnection = [captureVideoDataOutput connectionWithMediaType:AVMediaTypeVideo];
    [captureConnection setVideoMaxFrameDuration:CMTimeMake(1, 20)];
    [captureConnection setVideoMinFrameDuration:CMTimeMake(1, 10)];
    
    return captureVideoDataOutput;
    
}


#pragma mark -
#pragma mark AVCaputreVideoDataOutputSampleBufferDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection
{
    
    CVImageBufferRef pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    [self.delegate processImageBuffer:pixelBuffer];
    
}


#pragma mark -
#pragma mark Accessors

- (AVCaptureVideoPreviewLayer *)videoPreviewLayer;
{
    
	if (!_videoPreviewLayer){
        _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:captureSession];
        
        if ([_videoPreviewLayer.connection isVideoOrientationSupported]){
            [_videoPreviewLayer.connection setVideoOrientation:AVCaptureVideoOrientationPortrait];
        }
        [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
	}
	
	return _videoPreviewLayer;
    
}



@end

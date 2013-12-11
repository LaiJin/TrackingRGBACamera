//
//  TrackingRGBACameraViewController.m
//  TrackingRGBACamera
//
//  Created by xyooyy on 13-12-11.
//  Copyright (c) 2013年 lunajin. All rights reserved.
//

#import "TrackingRGBACameraViewController.h"

@interface TrackingRGBACameraViewController ()

@property (strong, nonatomic) TrackingRGBACamera *trackingCamera;

@end

@implementation TrackingRGBACameraViewController
@synthesize trackingCamera = _trackingCamera;

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)loadView
{
    
    self.trackingCamera = [[TrackingRGBACamera alloc] init];
    
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark TrackingRGBACameraDelegate

-(void)showVideoPreviewLayer
{
    
    self.trackingCamera.videoPreviewLayer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.trackingCamera.videoPreviewLayer];
    
}

-(void)processImageBuffer:(CVImageBufferRef)imageBuffer
{
    
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
	size_t bufferHeight = CVPixelBufferGetHeight(imageBuffer);
	size_t bufferWidth = CVPixelBufferGetWidth(imageBuffer);
	
	if (shouldGetTouchPointRGBA){
        
		int scaledVideoPointX = round((self.view.bounds.size.width - currentTouchPoint.x) * (CGFloat)bufferHeight / self.view.bounds.size.width);
		int scaledVideoPointY = round(currentTouchPoint.y * (CGFloat)bufferWidth / self.view.bounds.size.height);
        
		uint8_t *rowBase = (uint8_t *)CVPixelBufferGetBaseAddress(imageBuffer);
		size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
		uint8_t *pixel = rowBase + (scaledVideoPointX * bytesPerRow) + (scaledVideoPointY * 4);
		
		CGFloat red   = (float)pixel[2];
		CGFloat green = (float)pixel[1];
		CGFloat blue  = (float)pixel[0];
        NSLog(@"%f, %f, %f", red, green, blue);
		shouldGetTouchPointRGBA = NO;
        
	}
    
	CVPixelBufferUnlockBaseAddress(imageBuffer, 0);

}


#pragma mark -
#pragma mark Touch handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
	currentTouchPoint = [[touches anyObject] locationInView:self.view];
	shouldGetTouchPointRGBA = YES;
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
{
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
}


@end

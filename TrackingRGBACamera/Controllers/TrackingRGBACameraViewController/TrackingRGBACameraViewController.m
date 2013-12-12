//
//  TrackingRGBACameraViewController.m
//  TrackingRGBACamera
//
//  Created by xyooyy on 13-12-11.
//  Copyright (c) 2013年 lunajin. All rights reserved.
//

#import "TrackingRGBACameraViewController.h"
#import "ProcessImageBuffer.h"

@interface TrackingRGBACameraViewController (){
    
    ProcessImageBuffer *processImageBuffer;
    
}

@property (strong, nonatomic) TrackingCamera *trackingCamera;

@end

@implementation TrackingRGBACameraViewController
@synthesize trackingCamera = _trackingCamera;

- (id)init
{
    self = [super init];
    if (self) {
        
        self.trackingCamera = [[TrackingCamera alloc] init];
        processImageBuffer = [[ProcessImageBuffer alloc] init];
        
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.trackingCamera.delegate = self;
    [self.trackingCamera startTrackingCamera];

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
    
	if (shouldGetTouchPointRGBA){
        
        NSArray *pointRGBA = [processImageBuffer getTouchPointRGBAByImageBuffer:imageBuffer
                                                                  theTouchPoint:currentTouchPoint theTouchView:self.view];
        
		CGFloat red   = [[pointRGBA objectAtIndex:0] floatValue];
		CGFloat green = [[pointRGBA objectAtIndex:1] floatValue];
		CGFloat blue  = [[pointRGBA objectAtIndex:2] floatValue];
        CGFloat alpha = [[pointRGBA objectAtIndex:3] floatValue];
        
        NSLog(@"%f, %f, %f, %f", red, green, blue, alpha);
		shouldGetTouchPointRGBA = NO;
        
	}
    

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

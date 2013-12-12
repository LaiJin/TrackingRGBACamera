//
//  TrackingRGBACameraViewController.h
//  TrackingRGBACamera
//
//  Created by xyooyy on 13-12-11.
//  Copyright (c) 2013年 lunajin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrackingCamera.h"

@interface TrackingRGBACameraViewController : UIViewController<TarckingDelegate>{
    
    BOOL shouldGetTouchPointRGBA;
	CGPoint currentTouchPoint;
    
}

@end

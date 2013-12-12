//
//  TrackingRGBACameraViewController.h
//  TrackingRGBACamera
//
//  Created by xyooyy on 13-12-11.
//  Copyright (c) 2013年 lunajin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TrackingRGBACamera.h"

@interface TrackingRGBACameraViewController : UIViewController<TarckingRGBADelegate>{
    
    BOOL shouldGetTouchPointRGBA;
	CGPoint currentTouchPoint;
    
}

@end

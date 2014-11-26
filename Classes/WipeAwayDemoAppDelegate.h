//
//  WipeAwayDemoAppDelegate.h
//  WipeAwayDemo
//
//  Created by Craig on 12/9/10.
//

#import <UIKit/UIKit.h>
#import "WipeAwayDemoViewController.h"

@interface WipeAwayDemoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    WipeAwayDemoViewController *main;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;

@end


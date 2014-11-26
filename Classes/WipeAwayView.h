//
//  WipeAwayView.h
//  WipeAway
//
//  Created by Craig on 12/6/10.
//

#import <UIKit/UIKit.h>

@protocol WipeAwayViewDelegate <NSObject>
@optional
- (void)wipeAwayViewDidCleanWithPercentage:(float)percentage;

@end

@interface WipeAwayView : UIView {

	CGPoint		location;
	CGImageRef	imageRef;
	UIImage		*eraser;
	BOOL		wipingInProgress;
	UIColor		*maskColor;
	CGFloat		eraseSpeed;
	
}

@property(nonatomic, assign) id<WipeAwayViewDelegate> delegate;


- (void)newMaskWithColor:(UIColor *)color eraseSpeed:(CGFloat)speed;

@end

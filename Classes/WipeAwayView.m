//
//  WipeAwayView.m
//  WipeAway
//
//  Created by Craig on 12/6/10.
//
//  See http://craigcoded.com/2010/12/08/erase-top-uiview-to-reveal-content-underneath/ for full explanation
//

#import "WipeAwayView.h"

@implementation WipeAwayView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		wipingInProgress = NO;
		eraser = [[UIImage alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"eraser" ofType:@"png"]];
		[self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

- (void)newMaskWithColor:(UIColor *)color eraseSpeed:(CGFloat)speed {
	
	wipingInProgress = NO;
	
	eraseSpeed = speed;
	
	maskColor = color;
	
	[self setNeedsDisplay];
	
}

- (void)findAverageColor {
    //Get the RGBA value from the current image ref.
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char rgba[4];
    CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), imageRef);
    
    //Release memory
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    
    //In order to find the current wiped percentage, we can use the average alpha of the image. If the alpha is 0, the view is fully wiped. The actual alpha values ranges from 0 to 255.
    if (_delegate && [_delegate respondsToSelector:@selector(wipeAwayViewDidCleanWithPercentage:)]) {
        [_delegate wipeAwayViewDidCleanWithPercentage:100 - ((CGFloat)rgba[3] / 255 * 100)];
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

	wipingInProgress = YES;
	
}
	
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	
	if ([touches count] == 1) {
		UITouch *touch = [touches anyObject];
		location = [touch locationInView:self];
		location.x -= [eraser size].width/2;
		location.y -= [eraser size].width/2;
		[self setNeedsDisplay];
	}
	
}

- (void)drawRect:(CGRect)rect {

    [self findAverageColor];

	CGContextRef context = UIGraphicsGetCurrentContext();

	if (wipingInProgress) {
		if (imageRef) {
			// Restore the screen that was previously saved
			CGContextTranslateCTM(context, 0, rect.size.height);
			CGContextScaleCTM(context, 1.0, -1.0);
			
			CGContextDrawImage(context, rect, imageRef);
			CGImageRelease(imageRef);

			CGContextTranslateCTM(context, 0, rect.size.height);
			CGContextScaleCTM(context, 1.0, -1.0);
		}

		// Erase the background -- raise the alpha to clear more away with eash swipe
		[eraser drawAtPoint:location blendMode:kCGBlendModeDestinationOut alpha:eraseSpeed];
	} else {
		// First time in, we start with a solid color
		CGContextSetFillColorWithColor( context, maskColor.CGColor );
		CGContextFillRect( context, rect );
	}

	// Save the screen to restore next time around
	imageRef = CGBitmapContextCreateImage(context);
	
}



@end

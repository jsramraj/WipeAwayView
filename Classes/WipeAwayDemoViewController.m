//
//  WipeAwayDemoViewController.m
//  WipeAwayDemo
//
//  Created by Craig on 12/9/10.
//

#import "WipeAwayDemoViewController.h"
#import "WipeAwayView.h"

@interface WipeAwayDemoViewController () <WipeAwayViewDelegate>

@end

@implementation WipeAwayDemoViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
	
	WipeAwayView *mask = [[WipeAwayView alloc] initWithFrame:CGRectMake(0,0,320,480)];
    [mask newMaskWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.95] eraseSpeed:1];
	[self.view addSubview:mask];
    [mask setDelegate:self];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - WipeAwayDelegate

-(void)wipeAwayViewDidCleanWithPercentage:(float)percentage{
    NSLog(@"%1.2f", percentage);
    [percentageLabel setText:[NSString stringWithFormat:@"%1.2f %%", percentage]];
}

@end

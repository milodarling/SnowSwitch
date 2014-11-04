#import "FSSwitchDataSource.h"
#import "FSSwitchPanel.h"
#import <UIKit/UIKit.h>
#import "VENSnowOverlayView/VENSnowOverlayView/VENSnowOverlayView.h"

@interface SnowSwitch : NSObject <FSSwitchDataSource> {
VENSnowOverlayView *overlayView;
bool enabled;
}
@end

@implementation SnowSwitch

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier {

	if (enabled) {
		return FSSwitchStateOn;
	} else {
		return FSSwitchStateOff;
	}
}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier {

	if (newState == FSSwitchStateIndeterminate) {
		return;
	} else if (newState == FSSwitchStateOn) {
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
            CGRect frame = [UIScreen mainScreen].bounds;
            UIWindow *window = [[UIWindow alloc] initWithFrame:frame];
            window.windowLevel = 100000.0f;
            overlayView = [[VENSnowOverlayView alloc] initWithFrame:frame];
            [window addSubview:overlayView];
            window.userInteractionEnabled = NO;
            window.hidden = NO;
            [overlayView beginSnowAnimation];
            [pool drain];
        }];
		enabled = YES;
		return;
	} else {
		[overlayView endSnowAnimation];
		CFPreferencesSetAppValue ( CFSTR("enabled"), kCFBooleanFalse, CFSTR("com.milodarling.snowswitch") );
		enabled = NO;
		return;
	}
}

@end

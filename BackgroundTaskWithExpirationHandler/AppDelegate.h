#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
@private
	UIBackgroundTaskIdentifier bti;
}

- (void)longRunningOperation:(UIApplication *)application;

@end

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidEnterBackground:(UIApplication *)application {
	bti = [application beginBackgroundTaskWithExpirationHandler:^{
		dispatch_async(dispatch_get_main_queue(), ^{
			if(bti != UIBackgroundTaskInvalid) {
				[application endBackgroundTask:bti];
				bti = UIBackgroundTaskInvalid;
			}
		});
	}];
	
	dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
		
		[self longRunningOperation:application]; // <- HERE
		
		dispatch_async(dispatch_get_main_queue(), ^{
			if(bti != UIBackgroundTaskInvalid) {
				[application endBackgroundTask:bti];
				bti = UIBackgroundTaskInvalid;
			}
		});
	});
}

- (void)longRunningOperation:(UIApplication *)application {
	NSLog(@"I'm going to perform long running operation now.");
	NSLog(@"I have %lf remaining to complete my tasks.", [application backgroundTimeRemaining]);
	NSLog(@"I'm going to sleep 5 secound now.");
	NSLog(@"Zzzzz.....");
	[NSThread sleepForTimeInterval:5.0];
	NSLog(@"After shor nap I have still %lf secounds remaining.", [application backgroundTimeRemaining]);
}

@end

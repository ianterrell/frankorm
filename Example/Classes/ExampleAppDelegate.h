//
//  ExampleAppDelegate.h
//  Example
//
//  Created by Ian Terrell on 4/16/09.
//  Copyright Ian Terrell 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ExampleViewController;

@interface ExampleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ExampleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ExampleViewController *viewController;

@end


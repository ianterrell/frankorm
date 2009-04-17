//
//  ExampleAppDelegate.m
//  Example
//
//  Created by Ian Terrell on 4/16/09.
//  Copyright Ian Terrell 2009. All rights reserved.
//

#import "ExampleAppDelegate.h"
#import "ExampleViewController.h"
#import "User.h"
#import "Group.h"
#import "Opinion.h"

@implementation ExampleAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {        
  // Override point for customization after app launch    
  [window addSubview:viewController.view];
  [window makeKeyAndVisible];
  BOOL success;
  
  NSLog(@"There are %d users and %d opinions from the last run.", [User count], [Opinion count]);
  success = [User destroyAll] && [Opinion destroyAll];
  NSLog(@"After a destroy all with success %d, there are now %d users and %d opinions", success, [User count], [Opinion count]);
  
  User *frank = [User alloc];
  frank.username = @"frank";
  frank.password = @"secret";
  NSLog(@"Before saving, Frank's pk is %d", [frank.pk intValue]);
  success = [frank save];
  NSLog(@"Frank's save had success %d and his pk is now %d", success, [frank.pk intValue]);
  NSLog(@"There is now %d user", [User count]);
  
  User *jeff = [User alloc];
  jeff.username = @"jeff";
  jeff.password = @"secret";
  NSLog(@"Before saving, Jeff's pk is %d", [jeff.pk intValue]);
  success = [jeff save];
  NSLog(@"Jeff's save had success %d and his pk is now %d", success, [jeff.pk intValue]);
  NSLog(@"There are now %d users", [User count]);
  
  User *brian = [User alloc];
  brian.username = @"brian";
  brian.password = @"top'secret";
  NSLog(@"Before saving, Brian's pk is %d", [brian.pk intValue]);
  success = [brian save];
  NSLog(@"Brian's save had success %d and his pk is now %d", success, [brian.pk intValue]);
  NSLog(@"There are now %d users", [User count]);
  
  NSLog(@"There are %d users with the password 'secret', they are:", [User countWhere:@"password = ?", @"secret"]);
  for (User *u in [User findWhere:@"password = ?", @"secret"])
    NSLog(u.username);
    
  NSLog(@"User 3 is...");
  User *user3 = [User findByPk:[NSNumber numberWithInt:3]];
  NSLog(@"%@ identified by %@", user3.username, user3.password);
  
  Opinion *o1 = [Opinion alloc];
  o1.value = @"French fries are delicious.";
  [o1 setUser:brian];
  [o1 save];
  NSLog(@"Who thinks french fries are delicious?  %@ does", o1.user.username);
  Opinion *o2 = [Opinion alloc];
  o2.value = @"Hamburgers are delicious.";
  o2.userPk = brian.pk;
  [o2 save];
  NSLog(@"Who thinks hamburgers are delicious?  %@ does", o2.user.username);
  
  NSLog(@"Brian has %d opinions... they are:", [brian opinionsCount]);
  for (Opinion *o in brian.opinions)
    NSLog(o.value);
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end

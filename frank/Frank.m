//
//  Frank.m
//  FrankORM
//
//  Created by Ian Terrell on 4/16/09.
//  Copyright 2009 Ian Terrell. MIT Licensed.
//

#import "Frank.h"
#import "FileUtils.h"

#define kFrankDatabaseBundleKey @"Frank Database Name"
#define kFrankDatabaseSuffix @"db"

@implementation Frank

FMDatabase *_sharedDatabase;

+(FMDatabase *)sharedDatabase {
  if (_sharedDatabase == nil) {
    NSString *databaseName = [[[NSBundle mainBundle] infoDictionary] objectForKey:kFrankDatabaseBundleKey];
    if (databaseName == nil)
      NSLog(@"Frank says:  You must tell me your database's name in the '%@' property in your main bundle!", kFrankDatabaseBundleKey);
    NSString *databaseFilename = [NSString stringWithFormat:@"%@.%@", databaseName, kFrankDatabaseSuffix];
    if (![FileUtils documentsFileExists:databaseFilename]) {
      if (![FileUtils copyToDocumentsResource:databaseName ofType:kFrankDatabaseSuffix]) {
        NSLog(@"Frank says:  You must have created a database named '%@' and put it in your main resources folder!", databaseFilename);
        return nil;
      }
    }
    _sharedDatabase = [FMDatabase databaseWithPath:[FileUtils pathForDocumentsFile:databaseFilename]];
    if (_sharedDatabase == nil) {
      NSLog(@"Frank says:  Shite!  Something went wrong when I tried to get all instantiated.  Sorry.");
    } else {
      [_sharedDatabase retain];
      if ([_sharedDatabase open]) {
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:_sharedDatabase selector:@selector(close) name:UIApplicationWillTerminateNotification object:nil];
      } else {
        NSLog(@"Frank says:  Shite!  Something went wrong when I tried to open the database.  Sorry.");
      }
    }
  }
  return _sharedDatabase;
}

@end

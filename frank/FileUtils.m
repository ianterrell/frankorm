//
//  FileUtils.h
//  FrankORM!
// 
//  Extracted from www.zippytweet.com
//
//  Created by Ian Terrell on 3/23/09.
//  Copyright 2009 Ian Terrell. MIT Licensed.
//

#import "FileUtils.h"

@implementation FileUtils

+(NSString *)pathForDocumentsFile:(NSString *)filename {
  NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); 
  NSString *documentFolderPath = [searchPaths objectAtIndex: 0]; 
  return [documentFolderPath stringByAppendingPathComponent:filename]; 
}

+(BOOL)documentsFileExists:(NSString *)filename {
  return [[NSFileManager defaultManager] fileExistsAtPath:[FileUtils pathForDocumentsFile:filename]]; 
}

+(BOOL)copyToDocumentsResource:(NSString *)resourceName ofType:(NSString *)resourceType {
  BOOL success = NO;
  NSString *backupDbPath = [[NSBundle mainBundle] pathForResource:resourceName ofType:resourceType];
  if (backupDbPath != nil)
    success = [[NSFileManager defaultManager] copyItemAtPath:backupDbPath toPath:[FileUtils pathForDocumentsFile:[NSString stringWithFormat:@"%@.%@", resourceName, resourceType]] error:nil]; 
  return success;
}

+(BOOL)write:(id)serializableObject toFile:(NSString *)filename {
  NSString *errorString = nil;
  NSData *data = [NSPropertyListSerialization dataFromPropertyList:serializableObject format:NSPropertyListBinaryFormat_v1_0 errorDescription:&errorString];
  if (errorString) {
    NSLog(@"Failure serializing object to file '%@':  '%@'", filename, errorString);
    [errorString release];
    return NO;
  }
  NSError *error = nil;
  return [data writeToFile:[FileUtils pathForDocumentsFile:filename] options:NSAtomicWrite error:&error];
}

+(id)loadFromFile:(NSString *)filename {
  NSString *errorString = nil;
  NSError *error = nil;
  NSPropertyListFormat format;
  NSData *data = [NSData dataWithContentsOfFile:[FileUtils pathForDocumentsFile:filename] options:NSMappedRead error:&error];
  if (error) {
    NSLog(@"Error loading data! '%@'", [error localizedDescription]);
    return nil;
  }
  id mutableObject = [NSPropertyListSerialization propertyListFromData:data mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorString];
  if (errorString){
    NSLog(@"Failure deserializing object from file '%@':  '%@'", filename, errorString);
    [errorString release];
    return nil;
  }
  else
    return mutableObject;
}

@end

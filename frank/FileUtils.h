//
//  FileUtils.h
//  FrankORM!
// 
//  Extracted from www.zippytweet.com
//
//  Created by Ian Terrell on 3/23/09.
//  Copyright 2009 Ian Terrell. MIT Licensed.
//

#import <Foundation/Foundation.h>

@interface FileUtils : NSObject {

}

+(NSString *)pathForDocumentsFile:(NSString *)filename;
+(BOOL)documentsFileExists:(NSString *)filename;
+(BOOL)copyToDocumentsResource:(NSString *)resourceName ofType:(NSString *)resourceType;

+(BOOL)write:(id)serializableObject toFile:(NSString *)filename;
+(id)loadFromFile:(NSString *)filename;

@end

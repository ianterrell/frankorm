//
//  FrankObject.h
//  FrankORM
//
//  Created by Ian Terrell on 4/16/09.
//  Copyright 2009 Ian Terrell. MIT Licensed.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface FrankObject : NSObject {
  NSNumber *pk;
}

@property(nonatomic, retain) NSNumber *pk;

// Configuration
+(NSString *)tableName;

// Create & Update
-(BOOL)save;

// Retrieve
+(id)findByPk:(NSNumber *)pk;
+(NSArray *)findAll;
+(NSArray *)findWhere:(NSString *)whereClause arguments:(va_list)args;
+(NSArray *)findWhere:(NSString*)whereClause, ...;

// Query
+(int)count;
+(int)countWhere:(NSString *)whereClause arguments:(va_list)args;
+(int)countWhere:(NSString*)whereClause, ...;

// Delete
-(BOOL)destroy;
+(BOOL)destroyAll;
+(BOOL)destroyWhere:(NSString *)whereClause arguments:(va_list)args;
+(BOOL)destroyWhere:(NSString*)whereClause, ...;

// Helper methods
+(NSNumber *)lastInsertRowId;
-(BOOL)isNewRecord;
+(NSArray *)buildArrayFromResultSet:(FMResultSet *)rs;
+(id)buildFromResultSetRow:(FMResultSet *)rs;

@end

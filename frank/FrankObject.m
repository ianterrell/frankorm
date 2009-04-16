//
//  FrankObject.m
//  FrankORM
//
//  Created by Ian Terrell on 4/16/09.
//  Copyright 2009 Ian Terrell. MIT Licensed.
//

#import "FrankObject.h"
#import "Frank.h"

#define kDefaultArraySize 10

@implementation FrankObject

@synthesize pk;

#pragma mark Retrieve

+(id)findByPk:(NSNumber *)pk {
  FMDatabase *db = [Frank sharedDatabase];
  FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE pk = ?;", [self tableName]], pk];
  id item = nil;
  if ([rs next])
    item = [self buildFromResultSetRow:rs];
  [rs close];
  return item;
}

+(NSArray *)findAll {
  FMDatabase *db = [Frank sharedDatabase];
  FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@;", [self tableName]]];
  NSArray *array = [self buildArrayFromResultSet:rs];
  [rs close];
  return array;
}

+(NSArray *)findWhere:(NSString *)whereClause arguments:(va_list)args {
  FMDatabase *db = [Frank sharedDatabase];
  FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@;", [self tableName], whereClause] arguments:args];
  NSArray *array = [self buildArrayFromResultSet:rs];
  [rs close];
  return array;
}

+(NSArray *)findWhere:(NSString*)whereClause, ... {
  va_list args;
  va_start(args, whereClause);
  id array = [self findWhere:whereClause arguments:args];
  va_end(args);
  return array;
}

#pragma mark Query

+(int)count {
  FMDatabase *db = [Frank sharedDatabase];
  FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"SELECT COUNT(*) FROM %@;", [[self class] tableName]]];
  int count = 0;
  if ([rs next])
    count = [rs intForColumnIndex:0];
  [rs close];
  return count;
}

+(int)countWhere:(NSString *)whereClause arguments:(va_list)args {
  FMDatabase *db = [Frank sharedDatabase];
  FMResultSet *rs = [db executeQuery:[NSString stringWithFormat:@"SELECT COUNT(*) FROM %@ WHERE %@;", [[self class] tableName], whereClause] arguments:args];
  int count = 0;
  if ([rs next])
    count = [rs intForColumnIndex:0];
  [rs close];
  return count;
}

+(int)countWhere:(NSString*)whereClause, ... {
  va_list args;
  va_start(args, whereClause);
  int count = [self countWhere:whereClause arguments:args];
  va_end(args);
  return count;
}

#pragma mark Delete

-(BOOL)destroy {
  FMDatabase *db = [Frank sharedDatabase];
  BOOL success = [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE pk = ?;", [[self class] tableName]], pk];
  if (success)
    self.pk = nil;
  return success;
}

+(BOOL)destroyAll {
  FMDatabase *db = [Frank sharedDatabase];
  return [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@;", [self tableName]]];
}

+(BOOL)destroyWhere:(NSString *)whereClause arguments:(va_list)args {
  FMDatabase *db = [Frank sharedDatabase];
  return [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ WHERE %@;", [self tableName], whereClause] arguments:args];
}

+(BOOL)destroyWhere:(NSString*)whereClause, ... {
  va_list args;
  va_start(args, whereClause);
  BOOL result = [self destroyWhere:whereClause arguments:args];
  va_end(args);
  return result;
}


#pragma mark Helper Methods

+(NSNumber *)lastInsertRowId {
  FMDatabase *db = [Frank sharedDatabase];
  FMResultSet *rs = [db executeQuery:@"SELECT last_insert_rowid();"];
  NSNumber *pk = nil;
  if ([rs next])
    pk = [[NSNumber numberWithInt:[rs intForColumnIndex:0]] autorelease];
  [rs close];
  return pk;
}

-(BOOL)isNewRecord {
  return (self.pk == nil);
}

+(NSArray *)buildArrayFromResultSet:(FMResultSet *)rs {
  NSMutableArray *array = [NSMutableArray arrayWithCapacity:kDefaultArraySize];
  while ([rs next])
    [array addObject:[self buildFromResultSetRow:rs]];
  return array;
}

#pragma mark Override in subclasses!

+(NSString *)tableName {
  return nil;
}

-(BOOL)save {
  return NO;
}

+(id)buildFromResultSetRow:(FMResultSet *)rs {
  return nil;
}

#pragma mark Boilerplate

-(void)dealloc {
  [pk release];
  [super dealloc];
}

@end

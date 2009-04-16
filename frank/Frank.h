//
//  Frank.h
//  FrankORM
//
//  Created by Ian Terrell on 4/16/09.
//  Copyright 2009 Ian Terrell. MIT Licensed.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface Frank : NSObject {

}

+(FMDatabase *)sharedDatabase;

@end

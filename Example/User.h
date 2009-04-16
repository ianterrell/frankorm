//
//  User.h
//  FrankApp
//
//  Generated by Ian Terrell on 04/16/2009.
//  Copyright 2009 Ian Terrell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FrankObject.h"


@interface User : FrankObject {
  NSString *username;
  NSString *password;
  NSNumber *awesomenessCode;
}

@property(nonatomic,retain) NSString *username;
@property(nonatomic,retain) NSString *password;
@property(nonatomic,retain) NSNumber *awesomenessCode;


@end

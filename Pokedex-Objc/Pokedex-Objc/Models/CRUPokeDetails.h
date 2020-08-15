//
//  CRUPokeDetails.h
//  Pokedex-Objc
//
//  Created by patelpra on 8/15/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_SWIFT_NAME(PokeDetails)
@interface CRUPokeDetails : NSObject

@property (nonatomic, copy, readonly, nonnull) NSString *name;
@property (nonatomic, readonly, nonnull) NSNumber *identifier;
@property (nonatomic, readonly, nullable) NSURL *spriteURL;
@property (nonatomic, copy, readonly, nonnull) NSString *abilities;

- (nonnull instancetype)initWithName:(nonnull NSString *)name
                          identifier:(nonnull NSNumber *)identifier
                           spriteURL:(nonnull NSURL *)spriteURL
                           abilities:(nonnull NSString *)abilities;

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

@end



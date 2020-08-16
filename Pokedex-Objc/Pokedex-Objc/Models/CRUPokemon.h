//
//  CRUPokemon.h
//  Pokedex-Objc
//
//  Created by patelpra on 8/15/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CRUPokemonDetail;

NS_SWIFT_NAME(Pokemon)
@interface CRUPokemon : NSObject

@property (nonatomic, copy, readonly, nonnull) NSString *name;
@property (nonatomic, readonly, nullable) NSURL *detailsURL;

@property (nonatomic, readwrite, nullable) CRUPokemonDetail *details;
@property (nonatomic, readwrite, nullable) UIImage *sprite;

- (nonnull instancetype)initWithName:(nonnull NSString *)name
                                 URL:(nullable NSURL *)detailsURL;

- (nullable instancetype)initWithDictionary:(nonnull NSDictionary *)dictionary;

@end


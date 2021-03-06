//
//  CRUPokemon.m
//  Pokedex-Objc
//
//  Created by patelpra on 8/15/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

#import "CRUPokemon.h"
#import "CRUPokemonDetail.h"
#import "NSURL+Secure.h"

@implementation CRUPokemon

- (instancetype)initWithName:(NSString *)name URL:(NSURL *)detailsURL
{
    if (self = [super init]) {
        _name = name.copy;
        _detailsURL = detailsURL;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    NSString *name = [[dictionary objectForKey:@"name"] capitalizedString];
    if (![name isKindOfClass:[NSString class]]) return nil;
    
    NSString *URLString = [dictionary objectForKey:@"url"];
    if (![URLString isKindOfClass:[NSString class]]) return nil;
    
    NSURL *URL = [NSURL URLWithString:URLString].URLUsingHTTPS;
    
    return [self initWithName:name URL:URL];
    
}

@end

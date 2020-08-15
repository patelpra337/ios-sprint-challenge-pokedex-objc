//
//  NSURL+Secure.m
//  Pokedex-Objc
//
//  Created by patelpra on 8/15/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

#import "NSURL+Secure.h"

@implementation NSURL (Secure)

- (nullable NSURL *)URLUsingHTTPS
{
    NSURL *url = [self absoluteURL];
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:url resolvingAgainstBaseURL:YES];
    
    if (!components) return nil;
    components.scheme = @"https";
    return components.URL;
}

@end

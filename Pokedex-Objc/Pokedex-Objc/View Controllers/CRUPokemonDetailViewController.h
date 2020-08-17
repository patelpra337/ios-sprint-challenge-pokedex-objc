//
//  CRUPokemonDetailViewController.h
//  Pokedex-Objc
//
//  Created by patelpra on 8/17/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CRUPokemonDetail;
@class CRUPokemon;

@interface CRUPokemonDetailViewController : UIViewController

@property (nonatomic, nullable) CRUPokemon *pokemon;
@property (nonatomic, nullable) CRUPokemonDetail *pokemonDetail;
@property (nonatomic, copy, nullable) NSString *name;
@property (nonatomic, nullable) NSURL *detailsURL;

@end



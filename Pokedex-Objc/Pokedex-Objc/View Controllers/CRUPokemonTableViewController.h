//
//  CRUPokemonTableViewController.h
//  Pokedex-Objc
//
//  Created by patelpra on 8/17/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CRUPokemon;

@interface CRUPokemonTableViewController : UITableViewController

@property (nonatomic, copy, nonnull) NSArray<CRUPokemon *> *pokemon;

@end



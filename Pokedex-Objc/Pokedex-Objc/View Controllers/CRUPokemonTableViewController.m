//
//  CRUPokemonTableViewController.m
//  Pokedex-Objc
//
//  Created by patelpra on 8/17/20.
//  Copyright © 2020 Crus Technologies. All rights reserved.
//

#import "CRUPokemonTableViewController.h"
#import "CRUPokemonDetailViewController.h"
#import "CRUPokemon.h"
#import "Pokedex_Objc-Swift.h"

@interface CRUPokemonTableViewController ()

@end

@implementation CRUPokemonTableViewController

- (instancetype)init
{
    if (self = [super init]) {
        _pokemon = [NSArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [CRUPokemonAPI.sharedController fetchAllPokemonWithCompletionHandler:^(NSArray<CRUPokemon *> *pokemon, NSError *error) {
        if (error) {
            NSLog(@"Error fetching all pokemon: %@", error);
        }
        
        if (pokemon) {
            self.pokemon = pokemon;
            [self.tableView reloadData];
        }
            
    }];
}

- (NSInteger)pokemonCount
{
    return _pokemon.count;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self pokemonCount];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PokemonCell" forIndexPath:indexPath];
    
    CRUPokemon *pokemon = [self.pokemon objectAtIndex:indexPath.row];
    [cell.textLabel setText:pokemon.name];
    
    return cell;
}



#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowPokemonDetailSegue"]) {
        CRUPokemonDetailViewController *pokemonDetailVC = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        CRUPokemon *pokemon = [self.pokemon objectAtIndex:indexPath.row];
        
        pokemonDetailVC.pokemon = pokemon;
        pokemonDetailVC.name = pokemon.name;
        pokemonDetailVC.detailsURL = pokemon.detailsURL;
        
        [CRUPokemonAPI.sharedController fillInDetailsForPokemon:pokemon];
    }
}

@end

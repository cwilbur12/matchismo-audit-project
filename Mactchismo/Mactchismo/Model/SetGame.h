//
//  SetGame.h
//  Mactchismo
//
//  Created by Cory Wilbur on 9/27/13.
//  Copyright (c) 2013 Cory Wilbur. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface SetGame : NSObject

@property (strong,nonatomic) Deck *deckUsedForGame;
@property (strong,nonatomic) NSArray *gameCards; //array of cards used for the game

//designated initializer
- (id)initWithCardCount:(NSUInteger)numCards;

- (NSAttributedString *)runGame;

- (Card *)cardAtIndex:(NSUInteger)index;

@end

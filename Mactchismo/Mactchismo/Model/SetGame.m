//
//  SetGame.m
//  Mactchismo
//
//  Created by Cory Wilbur on 9/27/13.
//  Copyright (c) 2013 Cory Wilbur. All rights reserved.
//

#import "SetGame.h"
#import "SetGameCard.h"
#import "SetGameCardDeck.h"

@implementation SetGame

- (id)initWithCardCount:(NSUInteger)numCards{
    self = [super init];
    
    if(self){
        Deck *deck = [self deckUsedForGame];
        NSMutableArray *mutCards = [[NSMutableArray alloc]init];
        for(NSUInteger i = 0; i < numCards;i++){
            [mutCards addObject:[deck drawRandomCard]];
        }
        self.gameCards = mutCards;
        
    }
    return self;
}

- (NSAttributedString *)runGame{
    SetGameCardDeck *deck = (SetGameCardDeck *)[self deckUsedForGame];
    
    SetGameCard *card = (SetGameCard *)[deck drawRandomCard];
    
    return [card attContents];
}

//lazy instantiation for the deck in the set game
-(Deck *)deckUsedForGame{
    if(!_deckUsedForGame){
        _deckUsedForGame = [[SetGameCardDeck alloc] init];
    }
    
    return _deckUsedForGame;
}

- (Card *)cardAtIndex:(NSUInteger)index{
    return self.gameCards[index];
}


@end

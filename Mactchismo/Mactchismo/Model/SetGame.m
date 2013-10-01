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

- (void)selectCardAtIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
    
    card.faceUp = !card.faceUp;
    
    NSMutableArray *cardsSelected = [[NSMutableArray alloc]init];
    
    for(Card *cardToMatch in self.gameCards){
        if(cardToMatch.isFaceUp && !cardToMatch.unplayable){
            [cardsSelected addObject:cardToMatch];
            if([cardsSelected count] == 3){
                NSUInteger score = [card match:cardsSelected];
                NSLog([NSString stringWithFormat:@"Score: %d",score], @"score");
                for(Card *cardsToUnplayable in cardsSelected){

                    //if positive match score then make them unplayable
                    if(score == 100){
                        cardsToUnplayable.unplayable = YES;
                        
                    //else make them not faceup which is essentially unselecting them
                    }else{
                        cardsToUnplayable.faceUp = NO;
                    }
                
                }
                self.score += score;
            }
        }
        
    }
}

- (void)setInformationStringFromArray:(NSArray *)infoCards{
    NSUInteger numOfCards = [infoCards count];
    NSAttributedString *infoString = [[NSAttributedString alloc] init];
    
    if(numOfCards == 1){
        SetGameCard *card = infoCards[0];
        //add string logic
        //still unsure how exactly you have to do the string concatination from a att string to a string
        //and if i use a normal string will all its attributs go away 
    }
}


@end

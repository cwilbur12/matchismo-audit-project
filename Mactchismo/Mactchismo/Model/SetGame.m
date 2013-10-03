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

@interface SetGame()

@property (nonatomic)BOOL isSet;

@end

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
                        self.isSet = YES;
                        
                    //else make them not faceup which is essentially unselecting them
                    }else{
                        cardsToUnplayable.faceUp = NO;
                        self.isSet = NO;
                    }
                
                }
                self.score += score;
            }
        }
        
    }
    
    [self setInformationStringFromArray:cardsSelected];
}

- (void)setInformationStringFromArray:(NSArray *)infoCards{
    NSUInteger numOfCards = [infoCards count];
    
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:12],
                                 NSForegroundColorAttributeName: [UIColor blackColor]};
    
    if(numOfCards == 1){
        SetGameCard *card = infoCards[0];
        
        NSMutableAttributedString *attInfoString = [[card attContents] mutableCopy];
        
        NSMutableAttributedString *attStringToAppend = [[NSMutableAttributedString alloc] initWithString:@"  is selected"
                                                                                              attributes:attributes];
        [attInfoString appendAttributedString:attStringToAppend];
        
        self.informationString = attInfoString;
        
    }else if (numOfCards == 2){
        SetGameCard *firstCard = infoCards[0];
        SetGameCard *secondCard = infoCards[1];
        NSMutableAttributedString *firstCardAttContents = [[firstCard attContents] mutableCopy];
        NSMutableAttributedString *secondCardAttContents = [[secondCard attContents] mutableCopy];
        
        NSMutableAttributedString *firstInfoString = [[NSMutableAttributedString alloc] initWithString: @"  and  "
                                                                                            attributes:attributes];
        NSMutableAttributedString *secondInfoString = [[NSMutableAttributedString alloc] initWithString: @"  are selected  "
                                                                                             attributes:attributes];
        
        [firstCardAttContents appendAttributedString:firstInfoString];
        
        [secondCardAttContents appendAttributedString:secondInfoString];
        
        [firstCardAttContents appendAttributedString:secondCardAttContents];
        
        self.informationString = firstCardAttContents;

    }else if(numOfCards == 3){
        SetGameCard *firstCard = infoCards[0];
        SetGameCard *secondCard = infoCards[1];
        SetGameCard *thirdCard = infoCards[2];
        
        NSMutableAttributedString *firstCardAttContents = [[firstCard attContents] mutableCopy];
        NSMutableAttributedString *secondCardAttContents = [[secondCard attContents] mutableCopy];
        NSMutableAttributedString *thirdCardAttContents = [[thirdCard attContents] mutableCopy];
        
        NSMutableAttributedString *firstInfoString = [[NSMutableAttributedString alloc] initWithString: @","
                                                                                            attributes:attributes];
        NSMutableAttributedString *secondInfoString = [[NSMutableAttributedString alloc] initWithString: @" selected no set  "
                                                                                             attributes:attributes];
        
        NSMutableAttributedString *winInfoString = [[NSMutableAttributedString alloc] initWithString: @" set found!"
                                                                                             attributes:attributes];

        [firstCardAttContents appendAttributedString:firstInfoString];
        
        [secondCardAttContents appendAttributedString:firstInfoString];
        
        [firstCardAttContents appendAttributedString:secondCardAttContents];
        
        
        if (self.isSet) {
            [thirdCardAttContents appendAttributedString:winInfoString];

        }else{
            [thirdCardAttContents appendAttributedString:secondInfoString];
        }
        
        [firstCardAttContents appendAttributedString:thirdCardAttContents];
        
        self.informationString = firstCardAttContents;
        
    }else{//if the card is unselected or the cards array is 0;
        
        self.informationString = [[NSAttributedString alloc] initWithString:@""];
        
    }
}


@end

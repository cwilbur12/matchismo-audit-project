//
//  CardMatchingGame.h
//  Mactchismo
//
//  Created by Cory Wilbur on 9/21/13.
//  Copyright (c) 2013 Cory Wilbur. All rights reserved.
//

#import "CardGame.h"
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

//designated initializer
- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck;

- (void)flipCardAtIndex: (NSUInteger) index;

- (void)flipCardAtIndexThreeGameTwoCard:(NSUInteger)index;

- (void)flipCardAtIndexThreeGameThreeCard:(NSUInteger)index;

- (Card *)cardAtIndex: (NSUInteger) index;

@property (readonly, nonatomic) int score;
@property (strong, nonatomic)NSString *informationString;
@property (nonatomic)NSUInteger cardsFaceUp;

@end

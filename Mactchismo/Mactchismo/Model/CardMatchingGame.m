//
//  CardMatchingGame.m
//  Mactchismo
//
//  Created by Cory Wilbur on 9/21/13.
//  Copyright (c) 2013 Cory Wilbur. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (readwrite, nonatomic) int score;
@property (strong, nonatomic)NSMutableArray *cards; //of cards

@end

@implementation CardMatchingGame

- (id)initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck{
    
    self = [super init];
    
    if(self){
        
        for (int i=0; i< count; i++){
            Card *card = [deck drawRandomCard];
            if(card){
                self.cards[i] = card;
            }else{
                self=nil;
                break;
            }
        }
    }
    return self;
}

- (Card *)cardAtIndex: (NSUInteger) index{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}


- (NSMutableArray *)cards{
    if(!_cards){
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

#define MATCH_BONUS 4
#define MISMATCH_PENALTY 2
#define FLIP_COST 1

- (void)flipCardAtIndex: (NSUInteger) index{
    Card *card = [self cardAtIndex:index];
    
    if(card && !card.isUnplayable){
        if(!card.isFaceUp){
            for(Card *otherCard in self.cards){
                if(otherCard.isFaceUp && !otherCard.isUnplayable){
                    int matchScore = [card match:@[otherCard]];
                    if(matchScore){
                        card.unplayable = YES;
                        otherCard.unplayable = YES;
                        self.score += matchScore * MATCH_BONUS;
                        self.informationString = [NSString stringWithFormat:@"Match of %@ and %@ for %d points", card.contents,otherCard.contents, matchScore*MATCH_BONUS];
                    }else{
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.informationString = [NSString stringWithFormat:@"%@ and %@ don't match, %d point penalty",card.contents,otherCard.contents, MISMATCH_PENALTY];
                    }
                    break;
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }
    
    
}

- (void)flipCardAtIndexThreeGameTwoCard:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    
    if(card && !card.isUnplayable){
        if(!card.isFaceUp){
            for(Card *otherCard in self.cards){
                if(otherCard.isFaceUp && !otherCard.isUnplayable){
                    int matchScore = [card match:@[otherCard]];
                    if(matchScore){
                        self.score += matchScore * MATCH_BONUS;
                        self.informationString = [NSString stringWithFormat:@"Match of %@ and %@ for %d points", card.contents,otherCard.contents, matchScore*MATCH_BONUS];
                    }else{
                        otherCard.faceUp = NO;
                        self.score -= MISMATCH_PENALTY;
                        self.informationString = [NSString stringWithFormat:@"%@ and %@ don't match, %d point penalty",card.contents,otherCard.contents, MISMATCH_PENALTY];
                    }
                    break;
                }
            }
            self.score -= FLIP_COST;
        }
        card.faceUp = !card.isFaceUp;
    }  
    
}

- (void)flipCardAtIndexThreeGameThreeCard:(NSUInteger)index{
    
    Card *card = [self cardAtIndex:index];
    
    NSMutableArray *otherCards = [[NSMutableArray alloc]init];
    
    if(card && !card.isUnplayable){
        if(!card.isFaceUp){
            for(Card *otherCard in self.cards){
                if(otherCard.isFaceUp && !otherCard.isUnplayable){
                    [otherCards addObject:otherCard];
                }
            }
            int matchScore = [card match:otherCards];
            Card *otherCard1 = otherCards[0];
            Card *otherCard2 = otherCards[1];
            if(matchScore){
                card.unplayable = YES;
                for(Card *otherCardsToUnplayable in otherCards){
                    otherCardsToUnplayable.unplayable = YES;
                }
                self.score += matchScore * (MATCH_BONUS*2);
                
                
                self.informationString = [NSString stringWithFormat:@"%@, %@, and %@ match for %d points!", card.contents, otherCard1.contents, otherCard2.contents, matchScore*(MATCH_BONUS*2)];
            }else{
                for(Card *otherCardsToFaceDown in otherCards){
                    otherCardsToFaceDown.faceUp = NO;
                }
                self.score -= MISMATCH_PENALTY;
                self.score -= FLIP_COST;
                self.informationString = [NSString stringWithFormat:@"%@, %@, and %@ don't match %d penalty", card.contents, otherCard1.contents, otherCard2.contents, MISMATCH_PENALTY];

            }

        }
        card.faceUp = !card.isFaceUp;
    }
    
}


@end
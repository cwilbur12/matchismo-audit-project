//
//  SetGameCardDeck.m
//  Mactchismo
//
//  Created by Cory Wilbur on 9/27/13.
//  Copyright (c) 2013 Cory Wilbur. All rights reserved.
//

#import "SetGameCardDeck.h"
#import "SetGameCard.h"

@implementation SetGameCardDeck

- (id)init{
    self = [super init];
    
    if (self){
        //for loop that creates the valid deck
        
        for(NSUInteger i = 0; i <= 2; i++ ){
            for(NSUInteger j = 0; j<= 2; j++){
                for(NSUInteger k = 0; k<= 2; k++){
                    for(NSUInteger m = 0; m <= 2 ; m++){
                        SetGameCard *card = [[SetGameCard alloc]init];
                        card.numOfSymbols = i;
                        card.typeOfSymbol = j;
                        card.colorOfSymbol = k;
                        card.shadeOfSymbol = m;
                        [self addCard:card atTop:YES];
                    }
                }
            }
        }
    }
    return self;
}

@end

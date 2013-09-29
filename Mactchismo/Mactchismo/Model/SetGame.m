//
//  SetGame.m
//  Mactchismo
//
//  Created by Cory Wilbur on 9/27/13.
//  Copyright (c) 2013 Cory Wilbur. All rights reserved.
//

#import "SetGame.h"
#import "SetGameCard.h"

@implementation SetGame

- (NSAttributedString *)runGame{
    SetGameCard *setCard = [[SetGameCard alloc] init];
    
    setCard.colorOfSymbol =0;
    setCard.typeOfSymbol = 1;
    setCard.shadeOfSymbol = 1;
    setCard.numOfSymbols = 1;
    
    NSAttributedString *contents = [setCard attContents];
    
    return contents;
}

@end

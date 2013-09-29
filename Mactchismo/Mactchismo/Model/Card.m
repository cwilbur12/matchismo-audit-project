//
//  Card.m
//  Mactchismo
//
//  Created by Cory Wilbur on 9/21/13.
//  Copyright (c) 2013 Cory Wilbur. All rights reserved.
//

#import "Card.h"

@interface Card()

@end

@implementation Card

-(int)match:(NSArray *)otherCards{
    int score = 0;
    
    for(Card *card in otherCards){
        
        if([card.contents isEqualToString:self.contents]){
            score = 1;
        }
        
    }
    
    return score;
}

@end

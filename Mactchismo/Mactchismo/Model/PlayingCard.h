//
//  PlayingCard.h
//  Mactchismo
//
//  Created by Cory Wilbur on 9/21/13.
//  Copyright (c) 2013 Cory Wilbur. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic)  NSString *suit;
@property (nonatomic)  NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSArray *)rankStrings;
+ (NSUInteger)maxRank;

@end

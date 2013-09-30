//
//  SetGameCard.h
//  Mactchismo
//
//  Created by Cory Wilbur on 9/27/13.
//  Copyright (c) 2013 Cory Wilbur. All rights reserved.
//

#import "Card.h"

@interface SetGameCard : Card

@property (nonatomic)NSUInteger numOfSymbols;
@property (nonatomic)NSUInteger typeOfSymbol;
@property (nonatomic)NSUInteger colorOfSymbol;
@property (nonatomic)NSUInteger shadeOfSymbol;// 0 for empty, 1 for shaded, 2 for full
@property (strong,nonatomic)NSAttributedString *attContents;

+ (NSArray *)validSymbols;
+ (NSUInteger)maxSymbols;
+ (NSArray *) validColors;
+ (NSArray *) validShades;//jave to figure out how to display the shades

- (NSUInteger)match:(NSArray *)selectedCards;

@end

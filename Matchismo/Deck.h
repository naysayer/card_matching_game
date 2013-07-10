//
//  Deck.h
//  Matchismo
//
//  Created by Joshua Shuster on 5/13/13.
//  Copyright (c) 2013 josh_matchismo_stanford. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

-(Card *)drawRandomCard;

@end

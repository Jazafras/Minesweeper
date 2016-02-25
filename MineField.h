//
//  MineField.h
//  minesweeper
//
//  Created by Jasmine D Emerson on 4/24/15.
//  Copyright (c) 2015 Jasmine D Emerson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cell.h"

@interface MineField : NSObject

@property (readonly, nonatomic) NSMutableArray *cells;  // grid of cells
@property (readonly, nonatomic) int numMines;           // total number of mines
@property (readonly, nonatomic) int numExposedCells;    // num of cells exposed
@property (readonly, nonatomic) BOOL kablooey;          // mine field detonated

-(instancetype)initWithWidth:(int)w Height:(int)h Mines:(int)m;
-(int)width;
-(int)height;
-(Cell*)cellAtRow:(int)r Col:(int)c;
-(void)reset;
-(int)unexposedCells;
-(int)exposeCellAtRow:(int)r Col:(int)c;

@end

//
//  ViewController.m
//  minesweeper
//
//  Created by Jasmine D Emerson on 4/14/15.
//  Copyright (c) 2015 Jasmine D Emerson. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

//
// Scan the minefield model, and update
// the minefieldMatrix view.
//
-(void)updateMinefieldMatrix {
    const int W = self.mineField.width;
    const int H = self.mineField.height;
    for (int r = 0; r < H; r++)
        for (int c = 0; c < W; c++) {
            Cell *cell = [self.mineField cellAtRow:r Col:c];
            NSButtonCell *bcell = [self.minefieldMatrix cellAtRow:r column:c];
            if (cell.exposed) {
                if (cell.numSurroundingMines == 0)
                    bcell.title = @"";
                else
                    bcell.title = [NSString stringWithFormat:@"%d", cell.numSurroundingMines];
                bcell.enabled = NO;
                bcell.state = NSOnState;
            } else if (cell.marked) {
                bcell.title = @"P";
            } else {
                bcell.title = @"";
                bcell.enabled = YES;
                bcell.state = NSOffState;
            }
        }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    self.bombImage = [NSImage imageNamed:@"bomb"];
    self.flagImage = [NSImage imageNamed:@"flag"];
    
    self.mineField = [[MineField alloc] initWithWidth:(int) self.minefieldMatrix.numberOfColumns
                                               Height:(int) self.minefieldMatrix.numberOfRows
                                                Mines:10];
    [self updateMinefieldMatrix];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}

- (IBAction)newGame:(id)sender {
    NSLog(@"newGame:");
    [self.mineField reset];
    [self updateMinefieldMatrix];
    // XXX update score
}

- (IBAction)levelSelected:(NSPopUpButton *)sender {
    const NSInteger index = sender.indexOfSelectedItem;
    NSLog(@"levelSelected: %d", (int) index);
}

-(void)rightClicked:(NSMatrix*)sender {
    NSLog(@"rightClicked:");
    const int row = (int) sender.selectedRow;
    const int col = (int) sender.selectedColumn;
    NSButtonCell *bcell = sender.selectedCell;
    Cell *cell = [self.mineField cellAtRow:row Col:col];
    cell.marked = !cell.marked;
    if (cell.marked)
        bcell.title = @"P";
    else
        bcell.title = @"";
    [self.minefieldMatrix deselectSelectedCell];
}

- (IBAction)minefieldMatrixCellSelected:(NSMatrix *)sender {
    const int row = (int) sender.selectedRow;
    const int col = (int) sender.selectedColumn;
    NSLog(@"minefieldMatrixCellSelected: row=%d, col=%d", (int) row, (int)col);
    
    BOOL shiftKeyDown = ([[NSApp currentEvent] modifierFlags] &
                         (NSShiftKeyMask | NSAlphaShiftKeyMask)) !=0;
    
    Cell *cell = [self.mineField cellAtRow:row Col:col];
    NSButtonCell *bcell = [self.minefieldMatrix cellAtRow:row column:col];
    
    if (shiftKeyDown) { // user is marking a mine
        [self rightClicked:sender];
        return;
    }
    
    const int v = [self.mineField exposeCellAtRow:row Col:col];
    
    
    if (v == -1) {
        // BOOM!
        self.minefieldMatrix.enabled = NO;
        bcell.title = @"X";
        // XXX
    } else if (v == 0) { // multiple cell safely exposed
        [self updateMinefieldMatrix];
    } else if (1 <= v && v <= 8) { // a single cell safely exposed
        [self updateMinefieldMatrix]; // only need to update one bcell
    } else {
        NSLog(@"Exposed cell already exposed");
    }
    
}

@end
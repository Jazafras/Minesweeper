//
//  ViewController.h
//  minesweeper
//
//  Created by Jasmine D Emerson on 4/14/15.
//  Copyright (c) 2015 Jasmine D Emerson. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "MineField.h"

@interface ViewController : NSViewController

@property (weak) IBOutlet NSTextField *scoreTextField;
@property (weak) IBOutlet NSMatrix *minefieldMatrix;

- (IBAction)newGame:(id)sender;
- (IBAction)levelSelected:(NSPopUpButton *)sender;
- (IBAction)minefieldMatrixCellSelected:(NSMatrix *)sender;

@property (strong, nonatomic) MineField *mineField;

@property (strong, nonatomic) NSImage *bombImage;
@property (strong, nonatomic) NSImage *flagImage;

-(void)rightClicked:(NSMatrix*)sender;

@end


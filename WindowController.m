/*
   Project: ColorSeeker

   Copyright (C) 2021 Free Software Foundation

   Author: Sergei Golovin

   Created: 2021-01-25 19:51:31 +0400 by dev

   This application is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.

   This application is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU General Public
   License along with this library; if not, write to the Free
   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111 USA.
*/

#import "WindowController.h"

@implementation WindowController

- (int)intValue255:(float)v
{
  return [[NSNumber numberWithFloat: 255*v] intValue];
}

- (IBAction)showText:(id)sender
{
  float r = [rSlider floatValue];
  float g = [gSlider floatValue];
  float b = [bSlider floatValue];
  float a = [aSlider floatValue];

  int ir = [self intValue255: r];
  int ig = [self intValue255: g];
  int ib = [self intValue255: b];
  int ia = [self intValue255: a];
  
  NSString *hex = [NSString stringWithFormat:
           @"// hex: %.2X %.2X %.2X %.2X ( %.2X%.2X%.2X%.2X )\n",
           ir, ig, ib, ia, ir, ig, ib, ia];
  NSString *decimal = [NSString stringWithFormat: @"// decimal: %i %i %i %i\n", ir, ig, ib, ia];
  NSString *comment = [NSString stringWithFormat: @"// RGBA:\n%@%@", 
       hex, decimal];
  NSString *code = [NSString stringWithFormat:
  @"[NSColor colorWithDeviceRed: %f\n\tgreen: %f\n\tblue: %f\n\talpha: %f]", r, g, b, a];
  NSString *text = [NSString stringWithFormat: @"%@\n%@", comment, code];
  [textArea setText: text];

  NSLog(@"%@",[NSGraphicsContext currentContext]);
  
  [colorBox lockFocus];
  NSRect rect = [colorBox bounds]; // -[frame] produces a different rect
  NSColor *color = [NSColor colorWithDeviceRed: r green: g blue: b alpha: a];
  [color setFill];
  NSRectFill(rect);
  [colorBox unlockFocus];
}

- (IBAction)update:(id)sender
{
  [rSlider setFloatValue: 0.3];
  [gSlider setFloatValue: 0.4];
  [bSlider setFloatValue: 0.5];
  [aSlider setFloatValue: 1.0];

  [self showText: sender];
}

- (IBAction)copyToClipboard:(id)sender
{
   NSString *text = [textArea string];
   NSPasteboard *board =  [NSPasteboard pasteboardWithName: NSGeneralPboard];
   NSArray *types = [NSArray arrayWithObject: NSStringPboardType];
   [board declareTypes: types owner: nil];
   [board setString: text forType: NSStringPboardType];
}

- (void)windowDidBecomeKey:(NSNotification *)aNotification
{
  [self showText: self];
}

// window controller
- (void)windowDidLoad
{
  NSLog(@"DidLoad");
}

// temporary... just to show the bug/feature (to be removed)
int _update = 0; 

- (void)windowDidUpdate:(NSNotification *)aNotification
{
  // the threshold when mostly works and mostly doesn't work can vary...
  // on my system less than 4 doesn't work at all, 8 or greater mostly works, only occasionally doesn't
  if (_update < 4) { 
    [self showText: self];
    _update++;
  }
}
// end of temporary

@end

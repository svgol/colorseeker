/* -*- objc -*-
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

#ifndef _WINDOWCONTROLLER_H_
#define _WINDOWCONTROLLER_H_

#import <AppKit/AppKit.h>

@interface WindowController : NSWindowController
{
  id rSlider;
  id gSlider;
  id bSlider;
  id aSlider;
  id textArea;
  id colorBox;
  id clipboardButton;
}

/**
*  Shows the message [NSColor color...] in the text area.
*/
- (IBAction)showText:(id)sender;

/* updates from a slider */
- (IBAction)update:(id)sender;

/* copies to clipboard the text area */
- (IBAction)copyToClipboard:(id)sender;

- (void)windowDidBecomeKey:(NSNotification *)aNotification;
- (void)windowDidUpdate:(NSNotification *)aNotification;
- (void)windowDidLoad;

@end

#endif // _WINDOWCONTROLLER_H_


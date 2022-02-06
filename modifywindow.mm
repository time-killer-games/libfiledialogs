/*

 MIT License

 Copyright © 2021 Samuel Venable

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.

*/

#include "modifywindow.h"

#include <Cocoa/Cocoa.h>

void modifywindow(void *window) {
  [[(NSWindow *)window standardWindowButton:NSWindowCloseButton] setHidden:NO];
  [[(NSWindow *)window standardWindowButton:NSWindowMiniaturizeButton] setHidden:YES];
  [[(NSWindow *)window standardWindowButton:NSWindowZoomButton] setHidden:YES];
  [[(NSWindow *)window standardWindowButton:NSWindowCloseButton] setEnabled:YES];
  [[(NSWindow *)window standardWindowButton:NSWindowMiniaturizeButton] setEnabled:NO];
  [[(NSWindow *)window standardWindowButton:NSWindowZoomButton] setEnabled:NO];
}

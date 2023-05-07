/*

 MIT License

 Copyright © 2021-2022 Samuel Venable

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

#include <cstring>
#include <iostream>
#if defined(__APPLE__) && defined(__MACH__)
#include <AppKit/AppKit.h>
#endif

#include "filedialogs.hpp"

#if defined(_WIN32)
#undef main
#endif

#if (defined(_WIN32) && defined(_MSC_VER))
#pragma comment(linker, "/subsystem:windows /ENTRY:mainCRTStartup")
#endif

using namespace ngs::imgui;

static std::string remove_trailing_zeros(double numb) {
  std::string strnumb = std::to_string(numb);
  while (!strnumb.empty() && strnumb.find('.') != std::string::npos && (strnumb.back() == '.' || strnumb.back() == '0'))
    strnumb.pop_back();
  return strnumb;
}

int main(int argc, const char **argv) {
  #if defined(__APPLE__) && defined(__MACH__)
  [[NSApplication sharedApplication] setActivationPolicy:(NSApplicationActivationPolicy)1];
  [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
  #endif
  if (argc <= 2) {
    if (argc == 1 || (argc == 2 && strcmp(argv[1], "--help") == 0)) {
      std::cout << "usage: filedialogs [options]                       " << "\n";
      std::cout << "  options:                                         " << "\n";
      std::cout << "    --help                                         " << "\n";
      std::cout << "    --show-message           msg                   " << "\n";
      std::cout << "    --show-question          msg                   " << "\n";
      std::cout << "    --show-question-ext      msg                   " << "\n";
      std::cout << "    --get-string             msg    def            " << "\n";
      std::cout << "    --get-number             msg    def            " << "\n";
      std::cout << "    --get-open-filename      filter fname          " << "\n";
      std::cout << "    --get-open-filename-ext  filter fname dir title" << "\n";
      std::cout << "    --get-open-filenames     filter fname          " << "\n";
      std::cout << "    --get-open-filenames-ext filter fname dir title" << "\n";
      std::cout << "    --get-save-filename      filter fname          " << "\n";
      std::cout << "    --get-save-filename-ext  filter fname dir title" << "\n";
      std::cout << "    --get-directory          dname                 " << "\n";
      std::cout << "    --get-directory-alt      capt   root           " << "\n";
    }
    return 0;
  } else if (argc == 3 && strcmp(argv[1], "--show-message") == 0) {
    std::cout << show_message(argv[2]) << "\n";
  } else if (argc == 3 && strcmp(argv[1], "--show-question") == 0) {
    std::cout << show_question(argv[2]) << "\n";
  } else if (argc == 3 && strcmp(argv[1], "--show-question-ext") == 0) {
    std::cout << show_question_ext(argv[2]) << "\n";
  } else if (argc == 4 && strcmp(argv[1], "--get-string") == 0) {
    std::cout << get_string(argv[2], argv[3]) << "\n";
  } else if (argc == 4 && strcmp(argv[1], "--get-number") == 0) {
    std::cout << remove_trailing_zeros(get_number(argv[2], strtod(argv[3], nullptr))) << "\n";
  } else if (argc == 4 && strcmp(argv[1], "--get-open-filename") == 0) {
    std::cout << get_open_filename(argv[2], argv[3]) << "\n";
  } else if (argc == 6 && strcmp(argv[1], "--get-open-filename-ext") == 0) {
    std::cout << get_open_filename_ext(argv[2], argv[3], argv[4], argv[5]) << "\n";
  } else if (argc == 4 && strcmp(argv[1], "--get-open-filenames") == 0) {
    std::cout << get_open_filenames(argv[2], argv[3]) << "\n";
  } else if (argc == 6 && strcmp(argv[1], "--get-open-filenames-ext") == 0) {
    std::cout << get_open_filenames_ext(argv[2], argv[3], argv[4], argv[5]) << "\n";
  } else if (argc == 4 && strcmp(argv[1], "--get-save-filename") == 0) {
    std::cout << get_save_filename(argv[2], argv[3]) << "\n";
  } else if (argc == 6 && strcmp(argv[1], "--get-save-filename-ext") == 0) {
    std::cout << get_save_filename_ext(argv[2], argv[3], argv[4], argv[5]) << "\n";
  } else if (argc == 3 && strcmp(argv[1], "--get-directory") == 0) {
    std::cout << get_directory(argv[2]) << "\n";
  } else if (argc == 4 && strcmp(argv[1], "--get-directory-alt") == 0) {
    std::cout << get_directory_alt(argv[2], argv[3]) << "\n";
  }
  return 0;
}

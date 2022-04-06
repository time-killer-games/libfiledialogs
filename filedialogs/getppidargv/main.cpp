/*

 MIT License
 
 Copyright © 2021 Samuel Venable
 Copyright © 2021 Lars Nilsson
 
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
#include <string>
#include <cstdio>

#include "apiprocess/process.h"

namespace {

  void message_pump() {
    #if defined(_WIN32) 
    MSG msg; while (PeekMessage(&msg, nullptr, 0, 0, PM_REMOVE)) {
      TranslateMessage(&msg);
      DispatchMessage(&msg);
    }
    #endif
  }

  std::string string_replace_all(std::string str, std::string substr, std::string nstr) {
    std::size_t pos = 0; while ((pos = str.find(substr, pos)) != std::string::npos) {
      message_pump(); str.replace(pos, substr.length(), nstr);
      pos += nstr.length();
    }
    return str;
  }

} // anonymous namespace

int main(int argc, char **argv) {
  ngs::proc::PROCID ppid = ngs::proc::parent_proc_id_from_self();
  ngs::proc::PROCINFO kinfo = ngs::proc::proc_info_from_proc_id_ex(ppid, KINFO_ARGV);
  for (unsigned i = 1; i < ngs::proc::commandline_length(kinfo); i++)
  printf("\"%s\" ", string_replace_all(string_replace_all(ngs::proc::commandline(kinfo, i), "\\", "\\\\"), "\"", "\\\"").c_str());
  return 0;
}

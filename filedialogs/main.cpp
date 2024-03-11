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
#if defined(_WIN32)
#include <fstream>
#include <thread>
#include <chrono>
#include <string>
#include <cstdio>
#include <windows.h>
#include "resources.h"
#include "filesystem.hpp"
#elif defined(__APPLE__) && defined(__MACH__)
#include <AppKit/AppKit.h>
#include <AvailabilityMacros.h>
#endif

#include "filedialogs.hpp"

#if defined(_WIN32)
#undef main
#if defined(_MSC_VER)
#pragma comment(linker, "/subsystem:windows /ENTRY:mainCRTStartup")
#endif
namespace {
  HRSRC        res[159];
  HGLOBAL      glb[159];
  DWORD        siz[159];
  void        *buf[159];
  std::string  pth[159] = {
    "filedialogs\\fonts\\LICENSE"
    "filedialogs\\fonts\\000-notosans-regular.ttf",
    "filedialogs\\fonts\\001-notokufiarabic-regular.ttf",
    "filedialogs\\fonts\\002-notomusic-regular.ttf",
    "filedialogs\\fonts\\003-notonaskharabic-regular.ttf",
    "filedialogs\\fonts\\004-notonaskharabicui-regular.ttf",
    "filedialogs\\fonts\\005-notonastaliqurdu-regular.ttf",
    "filedialogs\\fonts\\006-notosansadlam-regular.ttf",
    "filedialogs\\fonts\\007-notosansadlamunjoined-regular.ttf",
    "filedialogs\\fonts\\008-notosansanatolianhieroglyphs-regular.ttf",
    "filedialogs\\fonts\\009-notosansarabic-regular.ttf",
    "filedialogs\\fonts\\010-notosansarabicui-regular.ttf",
    "filedialogs\\fonts\\011-notosansarmenian-regular.ttf",
    "filedialogs\\fonts\\012-notosansavestan-regular.ttf",
    "filedialogs\\fonts\\013-notosansbamum-regular.ttf",
    "filedialogs\\fonts\\014-notosansbassavah-regular.ttf",
    "filedialogs\\fonts\\015-notosansbatak-regular.ttf",
    "filedialogs\\fonts\\016-notosansbengali-regular.ttf",
    "filedialogs\\fonts\\017-notosansbengaliui-regular.ttf",
    "filedialogs\\fonts\\018-notosansbhaiksuki-regular.ttf",
    "filedialogs\\fonts\\019-notosansbrahmi-regular.ttf",
    "filedialogs\\fonts\\020-notosansbuginese-regular.ttf",
    "filedialogs\\fonts\\021-notosansbuhid-regular.ttf",
    "filedialogs\\fonts\\022-notosanscanadianaboriginal-regular.ttf",
    "filedialogs\\fonts\\023-notosanscarian-regular.ttf",
    "filedialogs\\fonts\\024-notosanscaucasianalbanian-regular.ttf",
    "filedialogs\\fonts\\025-notosanschakma-regular.ttf",
    "filedialogs\\fonts\\026-notosanscham-regular.ttf",
    "filedialogs\\fonts\\027-notosanscherokee-regular.ttf",
    "filedialogs\\fonts\\028-notosanscoptic-regular.ttf",
    "filedialogs\\fonts\\029-notosanscuneiform-regular.ttf",
    "filedialogs\\fonts\\030-notosanscypriot-regular.ttf",
    "filedialogs\\fonts\\031-notosansdeseret-regular.ttf",
    "filedialogs\\fonts\\032-notosansdevanagari-regular.ttf",
    "filedialogs\\fonts\\033-notosansdevanagariui-regular.ttf",
    "filedialogs\\fonts\\034-notosansdisplay-regular.ttf",
    "filedialogs\\fonts\\035-notosansduployan-regular.ttf",
    "filedialogs\\fonts\\036-notosansegyptianhieroglyphs-regular.ttf",
    "filedialogs\\fonts\\037-notosanselbasan-regular.ttf",
    "filedialogs\\fonts\\038-notosansethiopic-regular.ttf",
    "filedialogs\\fonts\\039-notosansgeorgian-regular.ttf",
    "filedialogs\\fonts\\040-notosansglagolitic-regular.ttf",
    "filedialogs\\fonts\\041-notosansgothic-regular.ttf",
    "filedialogs\\fonts\\042-notosansgrantha-regular.ttf",
    "filedialogs\\fonts\\043-notosansgujarati-regular.ttf",
    "filedialogs\\fonts\\044-notosansgujaratiui-regular.ttf",
    "filedialogs\\fonts\\045-notosansgurmukhi-regular.ttf",
    "filedialogs\\fonts\\046-notosansgurmukhiui-regular.ttf",
    "filedialogs\\fonts\\047-notosanshanifirohingya-regular.ttf",
    "filedialogs\\fonts\\048-notosanshanunoo-regular.ttf",
    "filedialogs\\fonts\\049-notosanshatran-regular.ttf",
    "filedialogs\\fonts\\050-notosanshebrew-regular.ttf",
    "filedialogs\\fonts\\051-notosansimperialaramaic-regular.ttf",
    "filedialogs\\fonts\\052-notosansindicsiyaqnumbers-regular.ttf",
    "filedialogs\\fonts\\053-notosansinscriptionalpahlavi-regular.ttf",
    "filedialogs\\fonts\\054-notosansinscriptionalparthian-regular.ttf",
    "filedialogs\\fonts\\055-notosansjavanese-regular.ttf",
    "filedialogs\\fonts\\056-notosanskaithi-regular.ttf",
    "filedialogs\\fonts\\057-notosanskannada-regular.ttf",
    "filedialogs\\fonts\\058-notosanskannadaui-regular.ttf",
    "filedialogs\\fonts\\059-notosanskayahli-regular.ttf",
    "filedialogs\\fonts\\060-notosanskharoshthi-regular.ttf",
    "filedialogs\\fonts\\061-notosanskhmer-regular.ttf",
    "filedialogs\\fonts\\062-notosanskhmerui-regular.ttf",
    "filedialogs\\fonts\\063-notosanskhojki-regular.ttf",
    "filedialogs\\fonts\\064-notosanskhudawadi-regular.ttf",
    "filedialogs\\fonts\\065-notosanslao-regular.ttf",
    "filedialogs\\fonts\\066-notosanslaoui-regular.ttf",
    "filedialogs\\fonts\\067-notosanslepcha-regular.ttf",
    "filedialogs\\fonts\\068-notosanslimbu-regular.ttf",
    "filedialogs\\fonts\\069-notosanslineara-regular.ttf",
    "filedialogs\\fonts\\070-notosanslinearb-regular.ttf",
    "filedialogs\\fonts\\071-notosanslisu-regular.ttf",
    "filedialogs\\fonts\\072-notosanslycian-regular.ttf",
    "filedialogs\\fonts\\073-notosanslydian-regular.ttf",
    "filedialogs\\fonts\\074-notosansmahajani-regular.ttf",
    "filedialogs\\fonts\\075-notosansmalayalam-regular.ttf",
    "filedialogs\\fonts\\076-notosansmalayalamui-regular.ttf",
    "filedialogs\\fonts\\077-notosansmandaic-regular.ttf",
    "filedialogs\\fonts\\078-notosansmanichaean-regular.ttf",
    "filedialogs\\fonts\\079-notosansmarchen-regular.ttf",
    "filedialogs\\fonts\\080-notosansmath-regular.ttf",
    "filedialogs\\fonts\\081-notosansmayannumerals-regular.ttf",
    "filedialogs\\fonts\\082-notosansmeeteimayek-regular.ttf",
    "filedialogs\\fonts\\083-notosansmendekikakui-regular.ttf",
    "filedialogs\\fonts\\084-notosansmeroitic-regular.ttf",
    "filedialogs\\fonts\\085-notosansmiao-regular.ttf",
    "filedialogs\\fonts\\086-notosansmodi-regular.ttf",
    "filedialogs\\fonts\\087-notosansmongolian-regular.ttf",
    "filedialogs\\fonts\\088-notosansmono-regular.ttf",
    "filedialogs\\fonts\\089-notosansmro-regular.ttf",
    "filedialogs\\fonts\\090-notosansmultani-regular.ttf",
    "filedialogs\\fonts\\091-notosansmyanmar-regular.ttf",
    "filedialogs\\fonts\\092-notosansmyanmarui-regular.ttf",
    "filedialogs\\fonts\\093-notosansnabataean-regular.ttf",
    "filedialogs\\fonts\\094-notosansnewa-regular.ttf",
    "filedialogs\\fonts\\095-notosansnewtailue-regular.ttf",
    "filedialogs\\fonts\\096-notosansnko-regular.ttf",
    "filedialogs\\fonts\\097-notosansogham-regular.ttf",
    "filedialogs\\fonts\\098-notosansolchiki-regular.ttf",
    "filedialogs\\fonts\\099-notosansoldhungarian-regular.ttf",
    "filedialogs\\fonts\\100-notosansolditalic-regular.ttf",
    "filedialogs\\fonts\\101-notosansoldnortharabian-regular.ttf",
    "filedialogs\\fonts\\102-notosansoldpermic-regular.ttf",
    "filedialogs\\fonts\\103-notosansoldpersian-regular.ttf",
    "filedialogs\\fonts\\104-notosansoldsogdian-regular.ttf",
    "filedialogs\\fonts\\105-notosansoldsoutharabian-regular.ttf",
    "filedialogs\\fonts\\106-notosansoldturkic-regular.ttf",
    "filedialogs\\fonts\\107-notosansoriya-regular.ttf",
    "filedialogs\\fonts\\108-notosansoriyaui-regular.ttf",
    "filedialogs\\fonts\\109-notosansosage-regular.ttf",
    "filedialogs\\fonts\\110-notosansosmanya-regular.ttf",
    "filedialogs\\fonts\\111-notosanspahawhhmong-regular.ttf",
    "filedialogs\\fonts\\112-notosanspalmyrene-regular.ttf",
    "filedialogs\\fonts\\113-notosanspaucinhau-regular.ttf",
    "filedialogs\\fonts\\114-notosansphagspa-regular.ttf",
    "filedialogs\\fonts\\115-notosansphoenician-regular.ttf",
    "filedialogs\\fonts\\116-notosanspsalterpahlavi-regular.ttf",
    "filedialogs\\fonts\\117-notosansrejang-regular.ttf",
    "filedialogs\\fonts\\118-notosansrunic-regular.ttf",
    "filedialogs\\fonts\\119-notosanssamaritan-regular.ttf",
    "filedialogs\\fonts\\120-notosanssaurashtra-regular.ttf",
    "filedialogs\\fonts\\121-notosanssharada-regular.ttf",
    "filedialogs\\fonts\\122-notosansshavian-regular.ttf",
    "filedialogs\\fonts\\123-notosanssiddham-regular.ttf",
    "filedialogs\\fonts\\124-notosanssinhala-regular.ttf",
    "filedialogs\\fonts\\125-notosanssinhalaui-regular.ttf",
    "filedialogs\\fonts\\126-notosanssorasompeng-regular.ttf",
    "filedialogs\\fonts\\127-notosanssundanese-regular.ttf",
    "filedialogs\\fonts\\128-notosanssylotinagri-regular.ttf",
    "filedialogs\\fonts\\129-notosanssymbols2-regular.ttf",
    "filedialogs\\fonts\\130-notosanssymbols-regular.ttf",
    "filedialogs\\fonts\\131-notosanssyriac-regular.ttf",
    "filedialogs\\fonts\\132-notosanstagalog-regular.ttf",
    "filedialogs\\fonts\\133-notosanstagbanwa-regular.ttf",
    "filedialogs\\fonts\\134-notosanstaile-regular.ttf",
    "filedialogs\\fonts\\135-notosanstaitham-regular.ttf",
    "filedialogs\\fonts\\136-notosanstaiviet-regular.ttf",
    "filedialogs\\fonts\\137-notosanstakri-regular.ttf",
    "filedialogs\\fonts\\138-notosanstamil-regular.ttf",
    "filedialogs\\fonts\\139-notosanstamilsupplement-regular.ttf",
    "filedialogs\\fonts\\140-notosanstamilui-regular.ttf",
    "filedialogs\\fonts\\141-notosanstelugu-regular.ttf",
    "filedialogs\\fonts\\142-notosansteluguui-regular.ttf",
    "filedialogs\\fonts\\143-notosansthaana-regular.ttf",
    "filedialogs\\fonts\\144-notosansthai-regular.ttf",
    "filedialogs\\fonts\\145-notosansthaiui-regular.ttf",
    "filedialogs\\fonts\\146-notosanstibetan-regular.ttf",
    "filedialogs\\fonts\\147-notosanstifinagh-regular.ttf",
    "filedialogs\\fonts\\148-notosanstirhuta-regular.ttf",
    "filedialogs\\fonts\\149-notosansugaritic-regular.ttf",
    "filedialogs\\fonts\\150-notosansvai-regular.ttf",
    "filedialogs\\fonts\\151-notosanswarangciti-regular.ttf",
    "filedialogs\\fonts\\152-notosansyi-regular.ttf",
    "filedialogs\\fonts\\153-notosanstc-regular.otf",
    "filedialogs\\fonts\\154-notosansjp-regular.otf",
    "filedialogs\\fonts\\155-notosanskr-regular.otf",
    "filedialogs\\fonts\\156-notosanssc-regular.otf",
    "filedialogs\\fonts\\157-notosanshk-regular.otf"
  };
  
  void resources_init() {
    CreateDirectoryA("C:\\Windows\\Temp\\filedialogs", nullptr);
    CreateDirectoryA("C:\\Windows\\Temp\\filedialogs\\fonts", nullptr);
    for (int i = 0; i < 159; i++) {
      res[i] = FindResource(nullptr, MAKEINTRESOURCE(i + 1), RT_RCDATA);
      if (!res[i]) return;
      glb[i]  = LoadResource(nullptr, res[i]);
      if (!glb[i]) return;
      siz[i]  = SizeofResource(nullptr, res[i]);
      if (!siz) return;
      buf[i]  = LockResource(glb[i]);
      if (!buf[i]) return;
      std::ofstream outfile(("C:\\Windows\\Temp\\" + pth[i]).c_str(), std::ios::binary);
      if (!outfile.is_open()) return;
      outfile.write((char *)buf[i], siz[i]);
      outfile.close();
    }
  }
}
#endif

using namespace ngs::imgui;

static std::string remove_trailing_zeros(double numb) {
  std::string strnumb = std::to_string(numb);
  while (!strnumb.empty() && strnumb.find('.') != std::string::npos && (strnumb.back() == '.' || strnumb.back() == '0'))
    strnumb.pop_back();
  return strnumb;
}

int main(int argc, const char **argv) {
  #if defined(_WIN32)
  resources_init();
  if (ngs::fs::environment_get_variable("IMGUI_FONT_PATH").empty() && 
  ngs::fs::environment_get_variable("IMGUI_FONT_FILES").empty()) {
    ngs::fs::environment_set_variable("IMGUI_FONT_PATH", "C:\\Windows\\Temp\\filedialogs\\fonts\\");
  }
  #elif defined(__APPLE__) && defined(__MACH__)
  [[NSApplication sharedApplication] setActivationPolicy:(NSApplicationActivationPolicy)1];
  #if __MAC_OS_X_VERSION_MAX_ALLOWED < 140000
  [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
  #else
  [[NSApplication sharedApplication] yieldActivationToApplication:[NSRunningApplication currentApplication]];
  [[NSApplication sharedApplication] activate];
  #endif
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

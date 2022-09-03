# ImGui File Dialogs - CLI and Client Library

Based on [ImFileDialog](https://github.com/dfranx/ImFileDialog) by [dfranx](https://github.com/dfranx), with many bugs/crashes fixed and overall improvements. The 'Quick Access' sidebar actually remembers what favorites were previously saved to it from previous runs of your application now, by saving the settings to a text file in a hidden ".config" subfolder of your home folder. Allows for full localization among many other good things you'll find useful. To create your own default list of favorites for your application, here is a minimal example program for easy testing purposes:

```
/*
** Alternative main.cpp - replace libfiledialogs/filedialogs/main.cpp with this exact code
** then if on Windows open the solution in Visual Studio and build with that otherwise run
** the build.sh script if you are building with g++ or clang++, depending on the target OS
*/

#include <iostream> // std::cout, std::endl
#include <string>   // std::string, std::to_string
#include <vector>   // std::vector
#include <cstddef>  // std::size_t

#if defined(_WIN32)
#include "filesystem.hpp" // GHC File System
#endif

#include "ImFileDialogMacros.h" // Easy Localization
#include "filedialogs.h"        // NGS File Dialogs
#include "filesystem.h"         // NGS File System

#if defined(__APPLE__) && defined(__MACH__)
// Compile with: -framework AppKit -ObjC++
#include <AppKit/AppKit.h> // NSApplication
#endif

/* setup home directory
environment variable */
#if !defined(HOME_PATH)
#if defined(_WIN32) // Windows
#define HOME_PATH "USERPROFILE"
#else // Unix-likes
#define HOME_PATH "HOME"
#endif
#endif

// for SDL2
#if defined(_WIN32)
#undef main
#endif

// for MSVC
#if defined(_MSC_VER)
#pragma comment(linker, "/subsystem:windows /ENTRY:mainCRTStartup")
#endif

namespace {
  void init() {
    #if defined(__APPLE__) && defined(__MACH__)
    // hide icon from dock on macOS to match all the other platforms
    [[NSApplication sharedApplication] setActivationPolicy:(NSApplicationActivationPolicy)1];
    [[NSApplication sharedApplication] activateIgnoringOtherApps:YES];
    #endif

    // set imgui file dialogs window width and height; default is 600x400 pixels
    ngs::fs::environment_set_variable("IMGUI_DIALOG_WIDTH", std::to_string(800));
    ngs::fs::environment_set_variable("IMGUI_DIALOG_HEIGHT", std::to_string(400));
    
    // load all *.ttf and *.otf fonts of varying languages and combine them into one font from directory
    ngs::fs::environment_set_variable("IMGUI_FONT_PATH", ngs::fs::executable_get_directory() + "fonts");
    ngs::fs::environment_set_variable("IMGUI_FONT_SIZE", std::to_string(24)); // font size for dialogbox

    // setup imgui file dialog favorites config file absolute pathname
    ngs::fs::environment_set_variable("IMGUI_CONFIG_HOME", HOME_PATH);
    ngs::fs::environment_set_variable("IMGUI_CONFIG_FOLDER", "imfiledialogs");
    ngs::fs::environment_set_variable("IMGUI_CONFIG_FILE", "fdfavorites.txt");
    
    // if imgui file dialog favorites config file absolute pathname does not exist, then create one
    if (!ngs::fs::file_exists("${IMGUI_CONFIG_HOME}/.config/${IMGUI_CONFIG_FOLDER}/${IMGUI_CONFIG_FILE}")) {
      // setup favorites std::vector
      std::vector<std::string> favorites;
      favorites.push_back(ngs::fs::environment_get_variable(HOME_PATH));
      favorites.push_back(ngs::fs::directory_get_desktop_path());
      favorites.push_back(ngs::fs::directory_get_documents_path());
      favorites.push_back(ngs::fs::directory_get_downloads_path());
      favorites.push_back(ngs::fs::directory_get_music_path());
      favorites.push_back(ngs::fs::directory_get_pictures_path());
      favorites.push_back(ngs::fs::directory_get_videos_path());
      // add custom favorites to config text file; this file is not encrypted and may be easily edited by any software
      int desc = ngs::fs::file_text_open_write("${IMGUI_CONFIG_HOME}/.config/${IMGUI_CONFIG_FOLDER}/${IMGUI_CONFIG_FILE}");
      if (desc != -1) { // success; file can now be written to
        for (std::size_t i = 0; i < favorites.size(); i++) {
          // write favorite from vector at current index "i"
          ngs::fs::file_text_write_string(desc, favorites[i]);
          ngs::fs::file_text_writeln(desc); // write new line
        }
        // close file descriptor    
        ngs::fs::file_text_close(desc);
      }
    }
  }
} // anonymous namespace

int main() {
  init(); // setup all initialization related settings
  std::cout << ngs::imgui::get_open_filename("Portable Network Graphic (*.png)|*.png|" +
  std::string("Graphic Interchange Format (*.gif)|*.gif"), "Untitled.png") << std::endl;
  return 0;
}
```

# Platforms

Supports Windows, macOS, Linux, FreeBSD, DragonFly BSD, NetBSD, OpenBSD, and SunOS. 

![win32](https://github.com/time-killer-games/filedialogs/blob/main/win32.png?raw=true)

![macos](https://github.com/time-killer-games/filedialogs/blob/main/macos.png?raw=true)

![linux](https://github.com/time-killer-games/filedialogs/blob/main/linux.png?raw=true)

![sunos](https://github.com/time-killer-games/filedialogs/blob/main/sunos.png?raw=true)

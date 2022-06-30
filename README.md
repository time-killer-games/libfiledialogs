# ImGui File Dialogs - CLI and Client Library

Based on [ImFileDialog](https://github.com/dfranx/ImFileDialog) by [dfranx](https://github.com/dfranx), with many bugs/crashes fixed and overall improvements. The 'Quick Access' sidebar actually remembers what favorites were previously saved to it from previous runs of your application now, by saving the settings to a text file in your home folder. The absolute file path of this text file may be overridden using two environment variables, ("IMGUI_CONFIG_PATH" for the recursive folder path to create, and "IMGUI_CONFIG_FILE" for the name of the text file to be stored in that folder path). Allows for full localization among many other good things you'll find useful. To create your own default list of favorites for your application, here is a minimal example program/application:

```
/*
** Alternative main.cpp - replace libfiledialogs/filedialogs/main.cpp with below contents
** then if on Windows open the solution in Visual Studio and build with that otherwise run
** the build.sh script if you are on macOS, Linux, FreeBSD, DragonFly, NetBSD, or OpenBSD
*/

#include <iostream> // std::cout, std::endl
#include <string>   // std::string, std::to_string
#include <vector>   // std::vector

#include <cstddef> // std::size_t
#if !defined(_WIN32) && !defined(__APPLE__) && !defined(__MACH__)
// Linux, FreeBSD, DragonFly, NetBSD, and OpenBSD
#include <cstring> // strlen
#include <climits> // PATH_MAX
#include <cstdio>  // FILE, popen, fgets, pclose
#endif

#if defined(_WIN32)
#include "filesystem.hpp" // GHC File System
#endif

#include "ImFileDialogMacros.h" // Easy Localization
#include "filedialogs.h"        // NGS File Dialogs
#include "filesystem.h"         // NGS File System

#if defined(_WIN32)
#include <Shlobj.h>
#elif defined(__APPLE__) && defined(__MACH__)
// Compile with: -framework AppKit -ObjC++
#include <AppKit/AppKit.h> // NSApplication
#include <sysdir.h> // sysdir_* functions
#endif

/* setup home directory
environment variable */
#if !defined(HOME_PATH)
#if defined(_WIN32) // Windows x86 and Window x86-64
#define HOME_PATH "USERPROFILE"
#else // macOS, Linux, FreeBSD, DragonFly, NetBSD, and OpenBSD
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

    // setup imgui file dialog favorites config text file absolute pathname
    ngs::fs::environment_set_variable("IMGUI_CONFIG_PATH", ngs::fs::directory_get_temporary_path());
    ngs::fs::environment_set_variable("IMGUI_CONFIG_FILE", "imfiledialog.tmp");
    
    // get favorites config text file absolute pathname
    std::string path = ngs::fs::environment_get_variable("IMGUI_CONFIG_PATH");
    std::string file = ngs::fs::environment_get_variable("IMGUI_CONFIG_FILE");
    
    // if favorites config text file does not exist
    if (!ngs::fs::file_exists(path + "/" + file)) {
      // setup favorites std::vector
      std::vector<std::string> favorites;
      favorites.push_back(ngs::fs::environment_get_variable(HOME_PATH));
      favorites.push_back(ngs::fs::directory_get_desktop_path());
      favorites.push_back(ngs::fs::directory_get_documents_path());
      favorites.push_back(ngs::fs::directory_get_downloads_path());
      favorites.push_back(ngs::fs::directory_get_music_path());
      favorites.push_back(ngs::fs::directory_get_pictures_path());
      favorites.push_back(ngs::fs::directory_get_videos_path());
      // add custom favorites to config text file
      int desc = ngs::fs::file_text_open_write(path + "/" + file);
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
  std::cout << ngs::imgui::get_open_filename("Portable Network Graphic (*.png)|\
  *.png|Graphic Interchange Format (*.gif)|*.gif", "Untitled.png") << std::endl;
  return 0;
}
```

# Platforms

Supports Windows, macOS, Linux, FreeBSD, DragonFly, NetBSD, and OpenBSD. Uses platform-specific code that is not-mandatory to get the executable path, which can easily be replaced with getting the working directory with `getcwd()` should you need more platforms supported. 

![win32](https://github.com/time-killer-games/filedialogs/blob/main/win32.png?raw=true)

![macos](https://github.com/time-killer-games/filedialogs/blob/main/macos.png?raw=true)

![linux](https://github.com/time-killer-games/filedialogs/blob/main/linux.png?raw=true)

![bsd's](https://github.com/time-killer-games/filedialogs/blob/main/bsd's.png?raw=true)

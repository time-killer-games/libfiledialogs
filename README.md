# Dear ImGui File Dialogs - CLI and Client Library

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
      #if defined(_WIN32) // Windows x86 and Window x86-64
      wchar_t *ptr = nullptr; // get all system folders for Windows user profile folder
      if (SUCCEEDED(SHGetKnownFolderPath(FOLDERID_Desktop, KF_FLAG_CREATE | KF_FLAG_DONT_UNEXPAND, nullptr, &ptr)))
        favorites.push_back(ghc::filesystem::path(ptr).string()); // Desktop
      CoTaskMemFree(ptr); ptr = nullptr; // free memory even on failure as Microsoft documentation specifies
      if (SUCCEEDED(SHGetKnownFolderPath(FOLDERID_Downloads, KF_FLAG_CREATE | KF_FLAG_DONT_UNEXPAND, nullptr, &ptr)))
        favorites.push_back(ghc::filesystem::path(ptr).string()); // Downloads
      CoTaskMemFree(ptr); ptr = nullptr; // free memory even on failure as Microsoft documentation specifies
      if (SUCCEEDED(SHGetKnownFolderPath(FOLDERID_Documents, KF_FLAG_CREATE | KF_FLAG_DONT_UNEXPAND, nullptr, &ptr)))
        favorites.push_back(ghc::filesystem::path(ptr).string()); // Documents
      CoTaskMemFree(ptr); ptr = nullptr; // free memory even on failure as Microsoft documentation specifies
      if (SUCCEEDED(SHGetKnownFolderPath(FOLDERID_Music, KF_FLAG_CREATE | KF_FLAG_DONT_UNEXPAND, nullptr, &ptr)))
        favorites.push_back(ghc::filesystem::path(ptr).string()); // Music
      CoTaskMemFree(ptr); ptr = nullptr; // free memory even on failure as Microsoft documentation specifies
      if (SUCCEEDED(SHGetKnownFolderPath(FOLDERID_Pictures, KF_FLAG_CREATE | KF_FLAG_DONT_UNEXPAND, nullptr, &ptr)))
        favorites.push_back(ghc::filesystem::path(ptr).string()); // Pictures
      CoTaskMemFree(ptr); ptr = nullptr; // free memory even on failure as Microsoft documentation specifies
      if (SUCCEEDED(SHGetKnownFolderPath(FOLDERID_Videos, KF_FLAG_CREATE | KF_FLAG_DONT_UNEXPAND, nullptr, &ptr)))
        favorites.push_back(ghc::filesystem::path(ptr).string()); // Videos
      CoTaskMemFree(ptr); ptr = nullptr; // free memory even on failure as Microsoft documentation specifies
      #elif defined(__APPLE__) && defined(__MACH__) // macOS
      // get all system folders for macOS user folder mask
      char buf[PATH_MAX]; sysdir_search_path_enumeration_state state;
      state = sysdir_start_search_path_enumeration(SYSDIR_DIRECTORY_DESKTOP, SYSDIR_DOMAIN_MASK_USER);       // Desktop
      while ((state = sysdir_get_next_search_path_enumeration(state, buf))) if (buf[0] == '~') favorites.push_back(buf);
      state = sysdir_start_search_path_enumeration(SYSDIR_DIRECTORY_DOWNLOADS, SYSDIR_DOMAIN_MASK_USER);     // Downloads
      while ((state = sysdir_get_next_search_path_enumeration(state, buf))) if (buf[0] == '~') favorites.push_back(buf);
      state = sysdir_start_search_path_enumeration(SYSDIR_DIRECTORY_ALL_LIBRARIES, SYSDIR_DOMAIN_MASK_USER); // Library
      while ((state = sysdir_get_next_search_path_enumeration(state, buf))) if (buf[0] == '~') favorites.push_back(buf);
      state = sysdir_start_search_path_enumeration(SYSDIR_DIRECTORY_SHARED_PUBLIC, SYSDIR_DOMAIN_MASK_USER); // Public
      while ((state = sysdir_get_next_search_path_enumeration(state, buf))) if (buf[0] == '~') favorites.push_back(buf);
      state = sysdir_start_search_path_enumeration(SYSDIR_DIRECTORY_DOCUMENT, SYSDIR_DOMAIN_MASK_USER);      // Documents
      while ((state = sysdir_get_next_search_path_enumeration(state, buf))) if (buf[0] == '~') favorites.push_back(buf);
      state = sysdir_start_search_path_enumeration(SYSDIR_DIRECTORY_MUSIC, SYSDIR_DOMAIN_MASK_USER);         // Music
      while ((state = sysdir_get_next_search_path_enumeration(state, buf))) if (buf[0] == '~') favorites.push_back(buf);
      state = sysdir_start_search_path_enumeration(SYSDIR_DIRECTORY_PICTURES, SYSDIR_DOMAIN_MASK_USER);      // Pictures
      while ((state = sysdir_get_next_search_path_enumeration(state, buf))) if (buf[0] == '~') favorites.push_back(buf);
      state = sysdir_start_search_path_enumeration(SYSDIR_DIRECTORY_MOVIES, SYSDIR_DOMAIN_MASK_USER);        // Movies
      while ((state = sysdir_get_next_search_path_enumeration(state, buf))) if (buf[0] == '~') favorites.push_back(buf);
      for (std::size_t i = 0; i < favorites.size(); i++) { // loop through each favorite
        std::string str = favorites[i]; // copy current favorite to string
        if (str[0] == '~') { // if tilde is the first character in string
          // expand tilde to home folder for current user based on environment
          favorites[i].replace(0, 1, ngs::fs::environment_get_variable(HOME_PATH));
        }
      }
      #else // Linux, FreeBSD, DragonFly, NetBSD, and OpenBSD
      /* user directories on these platforms are set by a
      text file named "${HOME}/.config/user-dirs.dirs" */
      std::string conf = ngs::fs::environment_get_variable(HOME_PATH) + "/.config/user-dirs.dirs";
      if (ngs::fs::file_exists(conf)) { // if the file exists
        int dirs = ngs::fs::file_text_open_read(conf); // open it for reading
        if (dirs != -1) { // if opening the text file succeeded
          std::vector<std::string> xdg; // vector of xdg keys
          xdg.push_back("XDG_DESKTOP_DIR=");     // Desktop
          xdg.push_back("XDG_DOWNLOAD_DIR=");    // Downloads
          xdg.push_back("XDG_TEMPLATES_DIR=");   // Templates
          xdg.push_back("XDG_PUBLICSHARE_DIR="); // Public
          xdg.push_back("XDG_DOCUMENTS_DIR=");   // Documents
          xdg.push_back("XDG_MUSIC_DIR=");       // Music
          xdg.push_back("XDG_PICTURES_DIR=");    // Pictures
          xdg.push_back("XDG_VIDEOS_DIR=");      // Videos
          while (!ngs::fs::file_text_eof(dirs)) { // while not at end of file
            std::string line = ngs::fs::file_text_read_string(dirs); // read line contents
            ngs::fs::file_text_readln(dirs); // skip line feed character and go to next line
            for (std::size_t i = 0; i < xdg.size(); i++) { // for each member of the vector
              std::size_t pos = line.find(xdg[i], 0); // look for a matching xdg key in line
              if (pos != std::string::npos) { // if a match was found out of the expected keys
                // expand environment variables found in string using the echo command's output
                FILE *fp = popen(("echo " + line.substr(pos + xdg[i].length())).c_str(), "r");
                if (fp) { // if echo command was found and executed ok
                  char buf[PATH_MAX];
                  // read output and copy to buffer
                  if (fgets(buf, PATH_MAX, fp)) { // if output was read ok
                    std::string str = buf; // copy output to string
                    // inspect the string's end for a line feed character
                    std::size_t pos = str.find("\n", strlen(buf) - 1);
                    if (pos != std::string::npos) // if a line feed was found
                      str.replace(pos, 1, ""); // remove the line feed
                    // add favorite from output
                    favorites.push_back(str);
                  }
                  // close file
                  pclose(fp);
                }
              }
            }
          }
          // close file descriptor
          ngs::fs::file_text_close(dirs);
        }
      }
      #endif
    
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

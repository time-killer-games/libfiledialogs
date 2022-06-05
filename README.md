# Dear ImGui File Dialogs - CLI and Client Library

Based on [ImFileDialog](https://github.com/dfranx/ImFileDialog) by [dfranx](https://github.com/dfranx), with many bugs/crashes fixed and overall improvements. The 'Quick Access' sidebar actually remembers what favorites were previously saved to it from previous runs of your application now, by saving the settings to a text file in your home folder. The absolute file path of this text file may be overridden using two environment variables, ("IMGUI_CONFIG_PATH" for the recursive folder path to create, and "IMGUI_CONFIG_FILE" for the name of the text file to be stored in that folder path). Allows for full localization among many other good things you'll find useful. To create your own default list of favorites for your application, here is a minimal example program/application:

    /* setup home directory 
    environment variable */
    #if !defined(HOME_PATH)
    #if defined(_WIN32)
    #define HOME_PATH "USERPROFILE"
    #else
    #define HOME_PATH "HOME"
    #endif
    #endif
    
    #include <iostream> // std::cout, std::endl
    #include <string>   // std::string, std::to_string
    #include <vector>   // std::vector
    #include <cstddef>  // std::size_t
  
    #include "libfiledialogs/filedialogs/ImFileDialogMacros.h" // Easy Localization
    #include "libfiledialogs/filedialogs/filedialogs.h"        // NGS File Dialogs
    #include "libfiledialogs/filedialogs/filesystem.h"         // NGS File System
    
    namespace {
      void init() {
        // set imgui file dialogs window width and height; default is 600x400 pixels
        ngs::fs::environment_set_variable("IMGUI_DIALOG_WIDTH", std::to_string(800));
        ngs::fs::environment_set_variable("IMGUI_DIALOG_HEIGHT", std::to_string(400));
        
        // load all *.ttf and *.otf fonts of varying languages and combine them into one font from directory
        ngs::fs::environment_set_variable("IMGUI_FONT_PATH", ngs::fs::executable_get_directory() + "fonts");
        
        // setup favorites std::vector
        std::vector<std::string> favorites;
        // use forward slashes as path separator to allow for cross-platform development
        favorites.push_back(ngs::fs::environment_get_variable(HOME_PATH) + "/Desktop");
        favorites.push_back(ngs::fs::environment_get_variable(HOME_PATH) + "/Documents");
        favorites.push_back(ngs::fs::environment_get_variable(HOME_PATH) + "/Downloads");
        favorites.push_back(ngs::fs::environment_get_variable(HOME_PATH) + "/Pictures");
        favorites.push_back(ngs::fs::environment_get_variable(HOME_PATH) + "/Music");
        
        // get favorites config text file absolute pathname
        std::string path = ngs::fs::environment_get_variable("IMGUI_CONFIG_PATH");
        std::string file = ngs::fs::environment_get_variable("IMGUI_CONFIG_FILE");
        
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
    } // anonymous namespace
    
    int main() {
      init(); // setup all initialization related settings
      std::cout << ngs::imgui::get_save_filename("Portable Network Graphic (*.png)|\
      *.png|Graphic Interchange Format (*.gif)|*.gif", "Untitled.png") << std::endl;
      reutnrn 0;
    }

# Platforms

Supports Windows, macOS, Linux, FreeBSD, DragonFly, NetBSD, and OpenBSD. Uses platform-specific code that is not-mandatory to get the executable path, which can easily be replaced with getting the working directory with `getcwd()` should you need more platforms supported quickly and easily in most cases. 

![win32](https://github.com/time-killer-games/filedialogs/blob/main/win32.png?raw=true)

![macos](https://github.com/time-killer-games/filedialogs/blob/main/macos.png?raw=true)

![linux](https://github.com/time-killer-games/filedialogs/blob/main/linux.png?raw=true)

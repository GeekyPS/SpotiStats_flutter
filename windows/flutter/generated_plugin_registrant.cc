//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <flutter_secure_storage_windows/flutter_secure_storage_windows_plugin.h>
#include <modal_progress_hud_nsn/modal_progress_hud_nsn_plugin.h>
#include <url_launcher_windows/url_launcher_windows.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  FlutterSecureStorageWindowsPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterSecureStorageWindowsPlugin"));
  ModalProgressHudNsnPluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ModalProgressHudNsnPlugin"));
  UrlLauncherWindowsRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("UrlLauncherWindows"));
}

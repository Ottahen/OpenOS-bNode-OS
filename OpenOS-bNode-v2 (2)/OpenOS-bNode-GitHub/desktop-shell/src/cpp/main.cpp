// Aurora Glass style reminder: the native demonstration exercises clear spatial state and accessibility-aware effects before a full compositor is integrated.
#include "ShellState.hpp"

#include <cstdlib>
#include <iostream>

extern "C" {
#include "system_bridge.h"
}

int main(int argc, char **argv) {
  const bool low_memory = argc > 1 && std::string_view(argv[1]) == "--low-memory";
  openos::AccessibilityPreferences preferences{.reduced_motion = low_memory, .high_contrast = false, .ui_scale_percent = 125};
  openos::ShellState shell(preferences);

  shell.activate_command_palette();
  shell.switch_workspace(2);
  shell.open_quick_settings();

  const auto tier = openos_select_render_tier(low_memory, preferences.reduced_motion);
  std::cout << shell.status_summary();
  std::cout << "render_tier=" << openos_render_tier_name(tier) << "\n";
  std::cout << "cpu_avx=" << (openos_cpu_has_avx() ? "available" : "not-advertised") << "\n";
  return EXIT_SUCCESS;
}

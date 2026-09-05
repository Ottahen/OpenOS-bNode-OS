// Aurora Glass style reminder: the C++ model keeps spatial workspaces, visible focus, and clear window hierarchy at the centre of the experience.
#pragma once

#include <string>

namespace openos {

enum class FocusSurface { CommandBar, WorkspaceRail, Desktop, Dock, QuickSettings };

struct AccessibilityPreferences {
  bool reduced_motion{false};
  bool high_contrast{false};
  int ui_scale_percent{100};
};

class ShellState {
 public:
  explicit ShellState(AccessibilityPreferences preferences);

  void activate_command_palette();
  void switch_workspace(int workspace);
  void open_quick_settings();
  [[nodiscard]] std::string status_summary() const;

 private:
  AccessibilityPreferences preferences_;
  FocusSurface focused_surface_{FocusSurface::Desktop};
  int active_workspace_{1};
  bool command_palette_open_{false};
  bool quick_settings_open_{false};

  [[nodiscard]] static std::string surface_name(FocusSurface surface);
};

}  // namespace openos

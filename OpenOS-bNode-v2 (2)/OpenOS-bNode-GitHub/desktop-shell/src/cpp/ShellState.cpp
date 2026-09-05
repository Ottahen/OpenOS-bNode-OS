// Aurora Glass style reminder: interactions are swift, focus remains obvious, and visual effects give way to accessibility preferences.
#include "ShellState.hpp"

#include <algorithm>
#include <sstream>

namespace openos {

ShellState::ShellState(AccessibilityPreferences preferences) : preferences_(preferences) {
  preferences_.ui_scale_percent = std::clamp(preferences_.ui_scale_percent, 100, 200);
}

void ShellState::activate_command_palette() {
  command_palette_open_ = true;
  quick_settings_open_ = false;
  focused_surface_ = FocusSurface::CommandBar;
}

void ShellState::switch_workspace(int workspace) {
  active_workspace_ = std::clamp(workspace, 1, 9);
  command_palette_open_ = false;
  focused_surface_ = FocusSurface::WorkspaceRail;
}

void ShellState::open_quick_settings() {
  quick_settings_open_ = true;
  command_palette_open_ = false;
  focused_surface_ = FocusSurface::QuickSettings;
}

std::string ShellState::status_summary() const {
  std::ostringstream status;
  status << "OpenOS/bNode Aurora Glass shell\n"
         << "workspace=" << active_workspace_ << "\n"
         << "focused_surface=" << surface_name(focused_surface_) << "\n"
         << "command_palette=" << (command_palette_open_ ? "open" : "closed") << "\n"
         << "quick_settings=" << (quick_settings_open_ ? "open" : "closed") << "\n"
         << "reduced_motion=" << (preferences_.reduced_motion ? "enabled" : "disabled") << "\n"
         << "high_contrast=" << (preferences_.high_contrast ? "enabled" : "disabled") << "\n"
         << "ui_scale=" << preferences_.ui_scale_percent << "%\n";
  return status.str();
}

std::string ShellState::surface_name(FocusSurface surface) {
  switch (surface) {
    case FocusSurface::CommandBar:
      return "command-bar";
    case FocusSurface::WorkspaceRail:
      return "workspace-rail";
    case FocusSurface::Desktop:
      return "desktop";
    case FocusSurface::Dock:
      return "dock";
    case FocusSurface::QuickSettings:
      return "quick-settings";
  }
  return "unknown";
}

}  // namespace openos

/* Aurora Glass style reminder: effects degrade gracefully before clarity or input response is compromised. */
#include "system_bridge.h"

OpenOSRenderTier openos_select_render_tier(int low_memory_mode, int reduced_motion) {
  if (low_memory_mode) {
    return OPENOS_RENDER_OPAQUE;
  }
  if (reduced_motion) {
    return OPENOS_RENDER_REDUCED_EFFECTS;
  }
  return OPENOS_RENDER_GLASS;
}

const char *openos_render_tier_name(OpenOSRenderTier tier) {
  switch (tier) {
    case OPENOS_RENDER_GLASS:
      return "glass";
    case OPENOS_RENDER_REDUCED_EFFECTS:
      return "reduced-effects";
    case OPENOS_RENDER_OPAQUE:
      return "opaque";
    default:
      return "unknown";
  }
}

/* Aurora Glass style reminder: this C boundary supplies small, predictable system facts to the translucent desktop shell. */
#ifndef OPENOS_SYSTEM_BRIDGE_H
#define OPENOS_SYSTEM_BRIDGE_H

#ifdef __cplusplus
extern "C" {
#endif

typedef enum OpenOSRenderTier {
  OPENOS_RENDER_GLASS = 0,
  OPENOS_RENDER_REDUCED_EFFECTS = 1,
  OPENOS_RENDER_OPAQUE = 2
} OpenOSRenderTier;

int openos_cpu_has_avx(void);
OpenOSRenderTier openos_select_render_tier(int low_memory_mode, int reduced_motion);
const char *openos_render_tier_name(OpenOSRenderTier tier);

#ifdef __cplusplus
}
#endif

#endif

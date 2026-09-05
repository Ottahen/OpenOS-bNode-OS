// Aurora Glass style reminder: the renderer chooses readable material tiers before decorative blur and never animates critical keyboard interactions.
#[derive(Debug, PartialEq)]
enum MaterialTier {
    Glass,
    ReducedEffects,
    Opaque,
}

fn select_material(low_memory: bool, reduced_motion: bool) -> MaterialTier {
    if low_memory {
        MaterialTier::Opaque
    } else if reduced_motion {
        MaterialTier::ReducedEffects
    } else {
        MaterialTier::Glass
    }
}

fn material_description(tier: MaterialTier) -> &'static str {
    match tier {
        MaterialTier::Glass => "surface=rgba(18,36,58,0.68), blur=restrained, edge=1px",
        MaterialTier::ReducedEffects => "surface=rgba(22,45,72,0.84), blur=off, motion=off",
        MaterialTier::Opaque => "surface=#07111F, blur=off, memory-priority=high",
    }
}

fn main() {
    let low_memory = std::env::args().any(|arg| arg == "--low-memory");
    let reduced_motion = std::env::args().any(|arg| arg == "--reduced-motion");
    let tier = select_material(low_memory, reduced_motion);
    println!("OpenOS/bNode Aurora Glass renderer demo");
    println!("tier={tier:?}");
    println!("{}", material_description(tier));
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn low_memory_takes_priority_over_effects() {
        assert_eq!(select_material(true, false), MaterialTier::Opaque);
    }

    #[test]
    fn reduced_motion_uses_a_stable_surface() {
        assert_eq!(select_material(false, true), MaterialTier::ReducedEffects);
    }
}

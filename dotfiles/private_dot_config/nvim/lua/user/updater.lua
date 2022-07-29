return {
  -- Configure AstroNvim updates
  updater = {
    channel = "stable", -- "stable" or "nightly"
    version = "v1.7.0", -- "latest", tag name, or regex search like "v1.*" to only do updates before v2 (STABLE ONLY)
    show_changelog = true, -- show the changelog after performing an update
    skip_prompts = true,
  },
}

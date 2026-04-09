return {
  -- LazyVim's Python extra wires up:
  --   pyright      → LSP (completions, go-to-def, hover docs, diagnostics)
  --   ruff         → fast linter + formatter (replaces flake8/black/isort)
  --   treesitter   → syntax highlighting and text objects for Python
  --   neotest      → test runner integration (pytest)
  -- Mason auto-installs all of the above on first open.
  { import = "lazyvim.plugins.extras.lang.python" },
}

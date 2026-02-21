-- This module serves as the central loader for all autocommand definitions. It
-- imports domain-specific submodules each responsible for a cohesive set of
-- editor behaviours.

require("autocmds.core")
require("autocmds.templates")
require("autocmds.terminal")
require("autocmds.lsp")

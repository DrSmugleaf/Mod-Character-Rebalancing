MOD_NAME = "Mod Character Rebalancing"
MOD_PREFIX = "MCR"
MOD_ID = "385300215"
MOD_VERSION = "2.1.1"

-- This library function allows us to use a file in a specified location.
-- Allows use to call global environment variables without initializing them in our files.
modimport("libs/env.lua")

-- use "libs/mod_env"(env)

-- These lines of code prevent keystrokes from happening during critical moments.
use "data/widgets/controls"
use "data/screens/chatinputscreen"
use "data/screens/consolescreen"
-- End prevention of keystrokes.

-- Scripts Initialization.
use "data/scripts/init"

-- Actions Initialization.
use "data/actions/init"

-- Character Initialization.
use "data/characters/init"

-- Component Initialization.
use "data/components/init"
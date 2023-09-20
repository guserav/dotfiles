vim.cmd([[
    set runtimepath^=~/.vim runtimepath+=~/.vim/after
    let &packpath = &runtimepath
    source ~/.vimrc
]])

local ok, config_local_mod = pcall(require, 'config-local')
if ok then
    config_local_mod.setup {
        -- Default options (optional)

        -- Config file patterns to load (lua supported)
        config_files = { ".nvim.lua", ".nvimrc", ".exrc" },

        -- Where the plugin keeps files data
        hashfile = vim.fn.stdpath("data") .. "/config-local",

        autocommands_create = true, -- Create autocommands (VimEnter, DirectoryChanged)
        commands_create = true,     -- Create commands (ConfigLocalSource, ConfigLocalEdit, ConfigLocalTrust, ConfigLocalIgnore)
        silent = false,             -- Disable plugin messages (Config loaded/ignored)
        lookup_parents = true,     -- Lookup config files in parent directories
    }
end

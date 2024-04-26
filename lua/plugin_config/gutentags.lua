local _M = {}

function _M.config()
    vim.g.gutentags_ctags_exclude = {
        '*.git',
        '*.svg',
        '*.hg',
        '*/tests/*',
        'build',
        'dist',
        '*sites/*/files/*',
        'bin',
        'node_modules',
        'bower_components',
        'cache',
        'compiled',
        'docs',
        'example',
        'bundle',
        'vendor',
        '*.md',
        '*-lock.json',
        '*.lock',
        '*bundle*.js',
        '*build*.js',
        '.*rc*',
        '*.json',
        '*.min.*',
        '*.map',
        '*.bak',
        '*.zip',
        '*.pyc',
        '*.class',
        '*.sln',
        '*.Master',
        '*.csproj',
        '*.tmp',
        '*.csproj.user',
        '*.cache',
        '*.pdb',
        'tags*',
        'cscope.*',
        -- '*.css',
        -- '*.less',
        -- '*.scss',
        '*.exe',
        '*.dll',
        '*.mp3',
        '.md',
        '*.ogg',
        '*.flac',
        '*.swp',
        '*.swo',
        '*.bmp',
        '*.gif',
        '*.ico',
        '*.jpg',
        '*.png',
        '*.rar',
        '*.zip',
        '*.tar',
        '*.tar.gz',
        '*.tar.xz',
        '*.tar.bz2',
        '*.pdf',
        '*.doc',
        '*.docx',
        '*.ppt',
        '*.pptx',
    }

    vim.g.gutentags_add_default_project_roots = false
    vim.g.gutentags_project_root = { 'package.json', '.git', '.svn', '.root', '.hg', '.vscode', '.project' }
    vim.g.gutentags_ctags_tagfile = '.tags'

    vim.g.gutentags_cache_dir = vim.fn.stdpath("cache") .. '/ctags'
    vim.g.gutentags_ctags_extra_args = { '--tag-relative=yes', '--fields=+ailmnS', '--extra=+q',
        '--c++-kinds=+px', '--c-kinds=+px' }

    -- custom
    vim.g.gutentags_modules = { 'ctags' }

    if vim.fn.isdirectory(vim.g.gutentags_cache_dir) == 0 then
        os.execute("mkdir -p " .. vim.g.gutentags_cache_dir)
    end
end

return _M

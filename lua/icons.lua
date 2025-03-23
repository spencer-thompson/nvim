local M = {}

--- Diagnostic severities.
M.diagnostics = {
    ERROR = '',
    WARN = '',
    HINT = '',
    INFO = '',
}

--- For folding.
M.arrows = {
    right = '',
    left = '',
    up = '',
    down = '',
}

M.shapes = {
    circle = {
        filled = '●',
        outline = '󰄰',
        dot = '󰻃',
        plus = '󰐙',
    },
    cube = {
        outline = '󰆧',
        solid = '󰆦',
    },
}

M.dot = '●'

M.symbols = {
    dict = '󱗖',
    book = '󰂾',
}

--- LSP symbol kinds.
M.symbol_kinds = {
    Array = '󰅪', -- 󰦨
    Class = '󱡠', -- 󰙅  󱡠
    Color = '󰏘',
    Constant = '󰏿',
    Constructor = '󰒓', -- 󰒓 
    Enum = '󰦨', -- 󰦨 
    EnumMember = '', -- 󰦨
    Event = '󱐋', -- 
    Field = '󰜢',
    File = '󰈙',
    Folder = '󰉋',
    Function = '󰊕', -- 󰆧
    Interface = '󰙅', -- 󱌢 
    Keyword = '󰻾', -- 󰌋 󰻾 󱥒
    Method = '󰆦', -- 󰆦 󰆧
    Module = '',
    Operator = '󰆕',
    Property = '󰜢',
    Reference = '󰬲', -- 󰈇
    Snippet = '󰬚', --  󱄽 󰞘 󰬀 󰬚
    Struct = '󱉯', -- 󰕮  󱉯
    Text = '󰉿', -- 󰉿 
    TypeParameter = '󰙩', --  󰬛 󰙩
    Unit = '󰪚', -- 󰪚 
    Value = '', -- 󰦨
    Variable = '󰀫',
}

M.git = {
    add = '',
    mod = '',
    rem = '',
}

--- Shared icons that don't really fit into a category.
M.misc = {
    bug = '',
    glasses = '󰓠',
    book = '󱗖',
    emoji = '󰚜',
    ellipsis = '…',
    git = '',
    search = '',
    vertical_bar = '│',
    dashed_bar = '┊',
}

M.lines = {
    left = {
        vertical_thin = '▏',
        vertical = '▎',
    },
    center = {
        vertical = '│',
        vertical_dashed = '┊',
    },
    right = {
        vertical_thin = '▕',
    },
}

return M

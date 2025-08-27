local nrs_map = function(lhs, rhs, desc)
    vim.keymap.set("n", lhs, rhs, {noremap = true, silent = true, desc = desc})
end

nrs_map("ff", function() require("fff").find_files() end, "FFF files")

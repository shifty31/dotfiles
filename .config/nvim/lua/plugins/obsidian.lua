local Input = require("nui.input")
local event = require("nui.utils.autocmd").event

local input = Input({
  position = "50%",
  size = {
    width = 20,
  },
  border = {
    style = "single",
    text = {
      top = "[Note Title]",
      top_align = "left",
    },
  },
  win_options = {
    winhighlight = "Normal:Normal,FloatBorder:Normal",
  },
}, {
  prompt = "> ",
  default_value = "",
  on_submit = function(value)
    local note = require("obsidian").get_client():new_note(value)
    vim.api.nvim_command("e " .. tostring(note.path))
  end,
})

local wk = require("which-key")
wk.register({
  ["<leader>o"] = { name = "+Obsidian" },
})

return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = false,
  ft = "markdown",
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        path = "~/personal/notes/",
      },
    },
    daily_notes = {
      folder = "Daily",
    },
    ui = {
      checkboxes = {
        [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        ["x"] = { char = "", hl_group = "ObsidianDone" },
        [">"] = { char = "", hl_group = "ObsidianRightArrow" },
        ["~"] = { char = "󰰱", hl_group = "ObsidianTilde" },
      },
    },

    note_id_func = function(title)
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "_"):gsub("[^A-Za-z0-9-]", "_"):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.date("%Y_%m_%d")) .. "_" .. suffix
    end,

    completion = {
      new_note_location = "notes_subdir",
    },
    templates = {
      subdir = "templates",
    },
  },
  keys = {
    { "<leader>ot", "<cmd>ObsidianToday<CR>", desc = "Open Today's Daily Note" },
    {
      "<leader>on",
      function()
        input:mount()
        input:on(event.BufLeave, function()
          input:unmount()
        end)
      end,
      desc = "Create New Note",
    },
    { "<leader>os", "<cmd>ObsidianQuickSwitch<CR>", desc = "Search Through Notes" },
  },
}

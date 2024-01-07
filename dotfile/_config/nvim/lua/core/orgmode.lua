require("orgmode").setup_ts_grammar()

require("orgmode").setup(
    {
        org_agenda_files = "~/org/*",
        org_default_notes_file = "~/org/refile.org",
        org_archive_location = "~/org/archive/%s_archive::",
        org_log_into_drawer = "LOGBOOK",
        org_todo_keywords = {
            "TODO(t)",
            "NEXT(n)",
            "STRT(s)",
            "WAIT(w)",
            "HOLD(h)",
            "|",
            "DONE(d)",
            "KILL(k)",
            "MEET",
            "CALL",
            "CHAT",
            "WORK"
        },
        org_todo_keyword_faces = {
            TODO = ':foreground "red" :weight bold',
            NEXT = ':foreground "magenta" :weight bold',
            STAT = ':foreground "blue" :weight bold',
            DONE = ':foreground "forest green" :weight bold',
            HOLD = ':foreground "orange" :weight bold',
            WAIT = ':foreground "orange" :weight bold',
            KILL = ':background "gray" :foreground "black"',
            MEET = ':foreground "green" :weight bold',
            CALL = ':foreground "green" :weight bold',
            CHAT = ':foreground "green" :weight bold',
            WORK = ':foreground "green" :weight bold'
        },
        org_capture_templates = {
            t = {
                description = "Todo",
                template = "* TODO %?\n %u",
                target = "~/org/refile.org"
            },
            j = {
                description = "Journal",
                template = "\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?",
                target = "~/org/journal.org"
            }
        },
        org_indent_mode = "noindent",
        org_hide_leading_stars = true
    }
)

;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Zhang Honbey"
      user-mail-address "git@honbey.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'tango)
;;(load-theme 'tango t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/.org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")

(tool-bar-mode 0)
(menu-bar-mode 1)
(scroll-bar-mode 0)

(setq make-backup-files nil)
(setq inhibit-startup-message t)

(setq python-shell-virtualenv-path "/Users/user/working/pyenv/work")
(setq system-time-locale "C")

(setq default-tab-width 2)
(setq indent-tabs-mode nil)
(setq-default mac-option-modifier 'meta)
(setq writeroom-fullscreen-effect 'maximized)
(global-set-key (kbd "C-x w f") 'toggle-frame-fullscreen)

;;(setq browse-url-browser-function 'browse-url-chromium)

(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))


(setq doom-font (font-spec :family "Inconsolata" :size 12) ; :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Monaco") ; inherits `doom-font''s :size
      doom-unicode-font (font-spec :family "CodeNewRoman Nerd Font Mono" :size 12)
      doom-big-font (font-spec :family "Monaco" :size 19))

(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))
(setenv "PATH" (concat "/Library/TeX/texbin" ":" (getenv "PATH")))
(setq exec-path (append '("/Library/TeX/texbin") exec-path))

(after! org
  (setq org-preview-latex-default-process 'dvisvgm)
  (setq org-latex-create-formula-image-program 'dvisvgm)

(setq org-todo-keywords
      '((sequence "TODO(t!/!)" "NEXT(n!/!)" "STRT(s!/!)" "|" "DONE(d!)")
        (sequence "WAIT(w@/!)" "HOLD(h@/!)" "|" "KILL(k@/!)" "CALL" "MEET" "WORK" "CHAT")))

(setq org-todo-keyword-faces
      '(("TODO" :foreground "red" :weight bold)
        ("NEXT" :foreground "magenta" :weight bold)
        ("STAT" :foreground "blue" :weight bold)
        ("DONE" :foreground "forest green" :weight bold)
        ("HOLD" :foreground "orange" :weight bold)
        ("WAIT" :foreground "orange" :weight bold)
        ("KILL" :background "gray" :foreground "black")
        ("MEET" :foreground "green" :weight bold)
        ("CALL" :foreground "green" :weight bold)
        ("CHAT" :foreground "green" :weight bold)
        ("WORK" :foreground "green" :weight bold)
       ))

(setq org-todo-state-tags-triggers
      (quote (("KILL" ("KILL" . t))
              ("WAIT" ("WAIT" . t))
              ("HOLD" ("WAIT") ("HOLD" . t))
              (done ("WAIT") ("HOLD"))
              ("TODO" ("WAIT") ("KILL") ("HOLD"))
              ("NEXT" ("WAIT") ("KILL") ("HOLD"))
              ("STAT" ("WAIT") ("KILL") ("HOLD"))
              ("DONE" ("WAIT") ("KILL") ("HOLD")))))

(setq org-log-done 'time)
(setq org-log-into-drawer t)
(setq org-clock-into-drawer t)
(setq org-clock-out-remove-zero-time-clocks t)
(setq org-directory "~/.org")
(setq org-agenda-files (list org-directory))

(setq org-default-notes-file "~/.org/refile.org")
(setq org-capture-templates
      '(
        ("t" "Todo"
         entry (file+headline org-default-notes-file "Todo")
         "* TODO %?\n%U\n%a\n"
         :clock-in t
         :clock-resume t)
        ("r" "Respond"
         entry (file+headline org-default-notes-file "Respond Email")
         "* NEXT Respond to ~%:from~ on /%:subject/ :email:\nSCHEDULED: %t\n%U\n%a\n"
         :clock-in t
         :clock-resume t
         :immediate-finish t)
        ("i" "Interrupt"
         entry (file org-default-notes-file)
         "* NEXT Respond to %^{Who?} on /%^{What?}/\nSCHEDULED: %T\n%U\n%a\n"
         :clock-in t
         :clock-resume t)
        ("n" "Note"
         entry (file+headline org-default-notes-file "Note")
         "* %? :note:\n%i\n%U\n%a"
         :clock-in t
         :clock-resume t)
        ("l" "Link" entry
         (file+headline org-default-notes-file "Link")
         "* [[%c][%?]] :bookmark:\n%i\n%U\n"
         :clock-in t
         :clock-resume t)
        ("j" "Journal"
         entry (file+datetree "~/.org/journal.org")
         "* %?\n%i\n%U\n%a\n"
         :clock-in t
         :clock-resume t
         :tree-type month)
        ("J" "Repeated Journal"
         entry (file+headline "~/.org/journal.org" "Journal")
         "* NEXT %?\n:PROPERTIES:\n:STYLE: repeated journal\n:REPEAT_TO_STATE: NEXT\n:END:\n%U%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a ++1w/1m>>\")\n")
        ("h" "Habit"
         entry (file+headline "~/.org/journal.org" "Habit")
         "* NEXT %?\n:PROPERTIES:\n:STYLE: habit\n:REPEAT_TO_STATE: NEXT\n:END:\n%U%a\nSCHEDULED: %(format-time-string \"%<<%Y-%m-%d %a .+1d/3d>>\")\n")
        ))
  (setq org-id-link-to-org-use-id 'create-if-interactive)
  (add-hook 'org-capture-prepare-finalize-hook 'org-id-get-create)
  (org-babel-do-load-languages
    'org-babel-load-languages
    '(
      ;;(ditaa . t)
      ;;(plantuml . t)
      (dot . t)
      (python . t)
      (sh .t )
      (latex . t)
			(org . t)
      (javascript . t)
  ))
  (setq org-confirm-babel-evaluate nil)
)


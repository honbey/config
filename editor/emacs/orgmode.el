(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")

(tool-bar-mode 0)
(menu-bar-mode 1)
(scroll-bar-mode 0)

(setq make-backup-files nil)
(setq inhibit-startup-message t)
(setq system-time-locale "C")

;;(setenv "PATH" (concat "/Library/TeX/texbin" ":" (getenv "PATH")))
(setq exec-path (append '("/Library/TeX/texbin") exec-path))
(setq python-shell-virtualenv-path "/Users/user/working/pyenv/work")
(setq org-preview-latex-default-process 'dvisvgm)
(setq org-latex-create-formula-image-program 'dvisvgm)

(setq default-tab-width 2)
(setq indent-tabs-mode nil)
(setq-default mac-option-modifier 'meta)
(setq writeroom-fullscreen-effect 'maximized)
(global-set-key (kbd "C-x w f") 'toggle-frame-fullscreen)

(set-frame-width (selected-frame) 80)

(add-to-list 'default-frame-alist
             '(font . "CodeNewRoman Nerd Font Mono-16"))

;;(require 'package)
;;(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;;(package-initialize)

(setq browse-url-browser-function 'browse-url-chromium)

(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)

(add-to-list 'auto-mode-alist '("\\.\\(org\\|org_archive\\|txt\\)$" . org-mode))

(setq org-todo-keywords
      '((sequence "TODO(t!)" "NEXT(n)" "|" "DONE(d!)")
        (sequence "WAITING(w@/!)" "HOLD(h@/!)" "|" "CANCELLED(c@/!)" "PHONE" "MEETING" "WEWORK" "WECHAT")))

(setq org-todo-keyword-faces
      '(("TODO" . (:foreground "red" :weight bold))
        ("NEXT" . (:foreground "blue" :weight bold))
        ("DONE" . (:foreground "forest green" bold))
        ("WAITING" . (:foreground "red" :weight bold))
        ("HOLD" . (:foreground "magenta" :weight bold))
        ("CANCELLED" . (:background "gray" :foreground "black"))
        ("PHONE" . (:foreground "green" :weight bold))
        ("MEETING" . (:foreground "green" :weight bold))
        ("WEWORK" . (:foreground "green" :weight bold))
        ("WECHAT" . (:foreground "green" :weight bold))
        ))

(setq org-log-done 'time)
(setq org-directory "~/.org")
(setq org-agenda-files (list org-directory))

(setq org-default-notes-file "~/.org/notes.org")
(setq org-capture-templates
      '(
        ("t" "Todo" entry (file+headline "~/.org/todo.org" "Todo")
         "* TODO %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%U\n%a\n" :clock-in t :clock-resume t)
        ("T" "wTodo" entry (file+headline "~/.org/wtodo.org" "wTodo")
         "* TODO %?\nSCHEDULED: %(org-insert-time-stamp (org-read-date nil t \"+0d\"))\n%U\n%a\n" :clock-in t :clock-resume t)
        ("r" "Respond" entry (file "~/.org/notes.org")
         "* NEXT Respond to %:from on %:subject\nSCHEDULED: %t\n%U\n%a\n" :clock-in t :clock-resume t :immediate-finish t)
        ("n" "Notes" entry (file+headline "~/.org/notes.org" "Notes")
         "* %?   \n  %i\n  %u\n  %a")
        ("l" "Links" entry (file+headline "~/.org/links.org" "Links")
         "* %?\n  %i\n  %U\n")
        ("j" "Journal" entry (file+datetree "~/.org/journal.org")
         "* %?\nEntered on %U\n %i\n %a")
        ("J" "wJournal" entry (file+datetree "~/.org/wjournal.org")
         "* %?\nEntered on %U\n %i\n %a")
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
       (javascript . t)))
(setq org-confirm-babel-evaluate nil)

(require 'org-mobile)
(setq org-mobile-directory "~/org/mobile")
(setq org-mobile-force-id-on-agenda-items nil)
(add-hook 'org-mobile-post-push-hook
            (lambda () (shell-command "scp -r ~/org/mobile/* root@remotehost:/var/www/webdav/org/")))

;Requirements:
; - Tex Live
; - Graphviz

(require 'mu4e)
(setq mail-user-agent 'mu4e-user-agent)
(setq mu4e-maildir "~/.mail")
(setq mu4e-get-mail-command "offlineimap -u quiet")
(setq mu4e-update-interval 600)

(setq mu4e-sent-folder    "/Sends")
(setq mu4e-drafts-folder  "/Drafts")
(setq mu4e-trash-folder   "/Delete")
(setq mu4e-refile-folder  "/Archive")

(setq mu4e-view-show-images t)

(setq mu4e-maildir-shortcuts
      '( ("/INBOX"   . ?i)
         ("/Sends"   . ?s)
         ("/Delete"  . ?t)))

(setq user-mail-address "no-reply@email.com"
      user-full-name  "Name")

(require 'smtpmail)
(setq message-send-mail-function 'smtpmail-send-it
      smtpmail-default-smtp-server "smtp.email.com"
      smtpmail-smtp-server "smtp.email.com"
;;      starttls-gnutls-program "gnutls-cli"
;;      starttls-use-gnutls t
      smtpmail-stream-type 'ssl
      smtpmail-smtp-servic 465)


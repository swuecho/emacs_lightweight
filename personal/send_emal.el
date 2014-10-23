#!/usr/bin/emacs --script

(setq send-mail-function 'smtpmail-send-it)
(setq smtpmail-smtp-server "smtp.gmail.com")

(progn
    (mail) 
    (mail-to) (insert "echowuhao@gmail.com")
    (mail-subject) (insert "the subject")
    (mail-text) (insert "body of mail")
    (mail-send))

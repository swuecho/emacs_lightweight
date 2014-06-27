;;; echo-init.el --- utility subroutine used by myself
     
;;; no copy right

;; Author: Hao Wu <echowuhao@gmail.com>
;; Version: 0.1
;; Package-Requires:
;; Keywords: self 

     
;;; Commentary:

;; This package provides a minor mode to frobnicate and/or
;; bifurcate any flanges you desire.  To activate it, just type

;;;;;;;;;;;  UI ;;;;;;;;;;

(menu-bar-mode -1)

; turn on line number display
(global-linum-mode t)
(setq linum-format "%3d  ")

;; auto complete
;company
;(add-hook 'after-init-hook 'global-company-mode)


(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/personal/dict")
(ac-config-default)


;; Perl

(setq cperl-hairy t) ;; Turns on most of the CPerlMode options
(setq guru-warn-only t) ;; only show warn 

;; Spell checker 
;;(setq prelude-flyspell nil) ;; disable spell checker, FIXME: add dictionary
;;; auto-complete

;; Lisp
;; slime-helepr
;; use sbcl 

;;(when (eq current-user 'echo)
(load (expand-file-name "~/quicklisp/slime-helper.el"))	
(setq inferior-lisp-program "sbcl")
(require 'evil)
(evil-mode 1)
;; my lib
;; for now, the file in personal directory are automatically loaded
;; (load-file "~/.emacs.d/echo/me.el")
;; (require 'echo)
;; (load-file "~/.emacs.d/echo/echo-org.el")


;; ocaml mode

(setq opam-share (substring (shell-command-to-string "opam config var share") 0 -1))
(add-to-list 'load-path (concat opam-share "/emacs/site-lisp"))
(require 'merlin)

;; Enable Merlin for ML buffers
(add-hook 'tuareg-mode-hook 'merlin-mode)

;; So you can do it on a mac, where `C-<up>` and `C-<down>` are used
;; by spaces.
(define-key merlin-mode-map
  (kbd "C-c <up>") 'merlin-type-enclosing-go-up)
(define-key merlin-mode-map
  (kbd "C-c <down>") 'merlin-type-enclosing-go-down)
(set-face-background 'merlin-type-face "#88FF44")

;; -- enable auto-complete -------------------------------
;; Not required, but useful along with merlin-mode
(require 'auto-complete)
(add-hook 'tuareg-mode-hook 'auto-complete-mode)


;; tuareg
(add-hook 'tuareg-mode-hook 'tuareg-imenu-set-imenu)
(setq auto-mode-alist
      (append '(("\\.ml[ily]?$" . tuareg-mode)
                ("\\.topml$" . tuareg-mode))
              auto-mode-alist)) 
(autoload 'utop-setup-ocaml-buffer "utop" "Toplevel for OCaml" t)
(add-hook 'tuareg-mode-hook 'utop-setup-ocaml-buffer)
(add-hook 'tuareg-mode-hook 'merlin-mode)
(setq merlin-use-auto-complete-mode t)
(setq merlin-error-after-save nil)


(provide 'echo-init)     



;;TODO write a blog about how to write a package in elisp

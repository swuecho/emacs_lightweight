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
(menu-bar-mode 1)
(tool-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode t)
;;(rainbow-mode 1)
;;(diminish 'rainbow-mode)
(global-auto-revert-mode t)

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



;; save scratch
(defun save-persistent-scratch ()
    "Write the contents of *scratch* to the file name
`persistent-scratch-file-name'."
    (with-current-buffer (get-buffer-create "*scratch*")
      (write-region (point-min) (point-max) "~/.emacs-persistent-scratch")))

(defun load-persistent-scratch ()
    "Load the contents of `persistent-scratch-file-name' into the
  scratch buffer, clearing its contents first."
    (if (file-exists-p "~/.emacs-persistent-scratch")
	(with-current-buffer (get-buffer "*scratch*")
	  (delete-region (point-min) (point-max))
	  (insert-file-contents "~/.emacs-persistent-scratch"))))

(push #'load-persistent-scratch after-init-hook)
(push #'save-persistent-scratch kill-emacs-hook)

(run-with-idle-timer 300 t 'save-persistent-scratch)


;; save desktop
(desktop-save-mode 1)

(setq desktop-restore-eager 10)


;; save desktop every 5 minutes

(defun echo-desktop-save ()
  "Write the desktop save file to ~/.emacs.d"
  (desktop-save "/home/hwu/.emacs.d/"))

(run-with-idle-timer 300 t 'echo-desktop-save)


;;;;;; util function ;;;;;

(defun gnulinuxp ()
  "Returns t if the system is a GNU/Linux machine, otherwise nil"
  (string-equal system-type "gnu/linux"))



(defun osxp ()
  "Returns t if the system is a Mac OS X machine, otherwise nil"
    (string-equal system-type "darwin"))





(provide 'echo-init)     



;;TODO write a blog about how to write a package in elisp


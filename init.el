;;; init.el --- Prelude's configuration entry point.
;;; no copy right

;; Author: Hao Wu <echowuhao@gmail.com>
;; Version: 0.1
;;
;;;; so can load packages
(require 'package)
(package-initialize)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; UI
(menu-bar-mode -1)


; turn on line number display
(global-linum-mode t)
(setq linum-format "%3d  ")

;; auto complete
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/personal/dict")
(require 'auto-complete-config)
(ac-config-default)

;; Evil
(require 'evil)
(evil-mode 1)

;; Perl

(setq cperl-hairy t) ;; Turns on most of the CPerlMode options
(setq guru-warn-only t) ;; only show warn 

;;theme
(load-theme 'solarized-dark t)

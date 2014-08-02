;;; init.el 
;;; no copy right

;; Author: Hao Wu <echowuhao@gmail.com>
;; Version: 0.1
;;
;;;; so can load packages
(require 'package)
; this line is necesary to add elpa the module load path
(package-initialize)

(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

;; UI
(menu-bar-mode -1)

; turn on line number display
(global-linum-mode t)
(setq linum-format "%3d  ")

;; Evil
;; have to requrire evil
(require 'evil)
(evil-mode 1)

;; auto complete
;; have to require here or can not find auto-complete
(require 'auto-complete)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/personal/dict")
(require 'auto-complete-config)
(ac-config-default)


;; Magit
(global-set-key (kbd "C-x g") 'magit-status)

;; ido-mode
(require 'ido)
(ido-mode t)
;; Perl
(defalias 'perl-mode 'cperl-mode)
(setq cperl-hairy t) ;; Tqurns on most of the CPerlMode options
(setq guru-warn-only t) ;; only show warn 

;;theme
(load-theme 'solarized-dark t)

;; key binding
(global-set-key (kbd "C-x C-b") 'ibuffer)

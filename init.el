;;; init.el 
;;; no copy right

;; Author: Hao Wu <echowuhao@gmail.com>
;; Version: 0.1
;;
;;;; so can load packages
(require 'package)
; this line is necesary to add elpa the module load path
;; more about auto install package http://stackoverflow.com/questions/10092322
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)
; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents)) 
;; package-refesh-conetents is important
;; add package here 
(setq package-list '(evil auto-complete magit color-theme-solarized))
;; install packages 
; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))
;;
;;(mapc
;; (lambda (package)
;;   (or (package-installed-p package)
;;       (package-install package)))
;;     package-list)

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

;; copied from prelude

(defvar current-dir (file-name-directory load-file-name)
  "The root dir of the Emacs Prelude distribution.")

(defvar prelude-third-party (expand-file-name "third-party" current-dir)
    "The home of Prelude's core functionality.")
(add-to-list 'load-path prelude-third-party)

(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

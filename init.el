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
(setq package-list '(evil smex  auto-complete magit color-theme-solarized))
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

;;autoreload
(global-auto-revert-mode 1)
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


;;(require 'ffap)
;;(ffap-bindings)
;;(setq ffap-require-prefix t)

;; ido-mode
(require 'ido)
(ido-mode t); enable ido-mode
(setq ido-enable-flex-matching t); flexibly match names
(setq ido-everywhere t); use ido-mode everywhere, in buffers and for finding files
(setq ido-use-filename-at-point 'guess); for find-file-at-point

;; Perl
(defalias 'perl-mode 'cperl-mode)
(setq cperl-hairy t) ;; Tqurns on most of the CPerlMode options
(setq guru-warn-only t) ;; only show warn 

;;theme
(load-theme 'solarized-dark t)

;; key binding
(global-set-key (kbd "C-x C-b") 'ibuffer)



;; copied from prelude
;; find the current-dir
(defvar current-dir (file-name-directory load-file-name)
  "The dir of this file, i.e. .emacs.d")

(defvar third-party-package-dir (expand-file-name "third-party" current-dir)
    "The home of third party dir")

(add-to-list 'load-path third-party-package-dir)

;;; ack ;;;;
(require 'ack-and-a-half)
;; Create shorter aliases
(defalias 'ack 'ack-and-a-half)
(defalias 'ack-same 'ack-and-a-half-same)
(defalias 'ack-find-file 'ack-and-a-half-find-file)
(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

;;; keyfreq ;;;
(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

;;(add-to-list 'load-path "/Users/hwu/.opam/4.02.0/share/emacs/site-lisp")
;;(require 'ocp-indent)
;; TODO define home dir
(add-to-list 'load-path "~/.opam/4.02.0/share/tuareg")
(load "tuareg-site-file")

;; smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

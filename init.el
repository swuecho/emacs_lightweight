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
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)
; fetch the list of packages available 
(unless package-archive-contents
  (package-refresh-contents)) 
;; package-refesh-conetents is important
;; add package here 
(setq package-list '(evil evil-leader smex auto-complete magit color-theme-solarized git-messenger js2-mode))
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
(tool-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode t)
;;(rainbow-mode 1)
;;(diminish 'rainbow-mode)


;
;;autoreload
(global-auto-revert-mode 1)
; turn on line number display
(global-linum-mode t)

(setq linum-delay t
      linum-eager nil)

(setq linum-format "%3d  ")

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

(require 'flymake)
;; Perl
(defalias 'perl-mode 'cperl-mode)
(setq cperl-hairy t) ;; Tqurns on most of the CPerlMode options
(setq guru-warn-only t) ;; only show warn 

(add-hook 'cperl-mode-hook (lambda () (flymake-mode t)))

;; JS
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-hook 'js2-mode-hook 'flymake-mode)
(add-hook 'js2-mode-hook 'auto-complete-mode)


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
(defvar echo-dir (expand-file-name "personal" current-dir)
    "The home of my own init files")
(add-to-list 'load-path third-party-package-dir)
(add-to-list 'load-path echo-dir)
(require 'echo)
(require 'kolon-mode)
;;; ack ;;;;
;;(require 'ack-and-a-half)
;; Create shorter aliases
;;(defalias 'ack 'ack-and-a-half)
;;(defalias 'ack-same 'ack-and-a-half-same)
;;(defalias 'ack-find-file 'ack-and-a-half-find-file)
;;(defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

;; smex
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; evil leader
(require 'evil-leader)
(global-evil-leader-mode)
(evil-leader/set-leader ",")
(evil-leader/set-key "w" 'save-buffer)
(evil-leader/set-key "q" 'kill-buffer-and-window)
(evil-leader/set-key "rr" 'evil-show-registers)

;; Evil
;; have to requrire evil
(require 'evil)
(evil-mode 1)

;; diable evil mode in magit
(mapc (function (lambda (mode)
		  (evil-set-initial-state mode 'emacs)))
      '(git-rebase-mode))


;;; keyfreq ;;;
(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

;;(add-to-list 'load-path "/Users/hwu/.opam/4.02.0/share/emacs/site-lisp")
;;(require 'ocp-indent)
;; TODO define home dir
;;(add-to-list 'load-path "~/.opam/4.02.0/share/tuareg")
;;(load "tuareg-site-file")


;; smart complie perl 
(require 'smart-compile)
(add-to-list
    'smart-compile-alist
    '("\\.js\\'"   .   "js-beautify -r  %f"))

(add-to-list
    'smart-compile-alist
    '("\\.t\\'"   .   "perl %f"))

(add-to-list
    'smart-compile-alist
    '("\\.pl\\'"   .   "perl %f"))
 
 
(add-to-list
    'smart-compile-alist
    '("\\.pm\\'"   .   "perl -cw %f"))

(add-to-list 'same-window-buffer-names "*SQL*")
(require 'sql)
(defalias 'sql-get-login 'ignore)

(defun my-sql-save-history-hook ()
  (let ((lval 'sql-input-ring-file-name)
	(rval 'sql-product))
    (if (symbol-value rval)
	(let ((filename
	       (concat "~/.emacs.d/sql/"
		       (symbol-name (symbol-value rval))
		       "-history.sql")))
	  (set (make-local-variable lval) filename))
      (error
       (format "SQL history will not be saved because %s is nil"
	       (symbol-name rval))))))

  (add-hook 'sql-interactive-mode-hook 'my-sql-save-history-hook)




;;;;;; save scratch
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

(require 'git-messenger)

;; do not use the keyboard shoutcuts
;;(add-hook 'prog-mode-hook (lambda ()
;;(local-set-key (kbd "C-x v p") 'git-messenger:popup-message)
;;(evil-leader/set-key "gb" 'git-messenger:popup-message)))


;;TODO write a blog about how to write a package in elisp


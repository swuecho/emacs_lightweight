;;; init.el 
;;; no copy right

;; Author: Hao Wu <echowuhao@gmail.com>
;; Version: 0.1
;;
;;;; so can load packages
;;;
;;;
;;;;;;;;;;;;;;;;;;;;;;;;; load repo source and install package ;;;;;;;;;;;;;;;;;;;;;
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
(setq package-list '(evil evil-leader smex auto-complete magit color-theme-solarized js2-mode tabbar  auto-highlight-symbol web-beautify smart-compile smart-mode-line org-journal))

;; install packages 
; install the missing packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))


     (autoload 'forth-mode "gforth.el")
     (setq auto-mode-alist (cons '("\\.fs\\'" . forth-mode)
     			    auto-mode-alist))
     (autoload 'forth-block-mode "gforth.el")
     (setq auto-mode-alist (cons '("\\.fb\\'" . forth-block-mode)
     			    auto-mode-alist))
     (add-hook 'forth-mode-hook (function (lambda ()
        ;; customize variables here:
        (setq forth-indent-level 4)
        (setq forth-minor-indent-level 2)
        (setq forth-hilight-level 3)
        ;;; ...
     )))

;;;;;;;;;;;;;;;;UI;;;;;;;;;;;;;;;;;;;;;
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

(defalias 'yes-or-no-p 'y-or-n-p)

;; no backup filesw
(setq make-backup-files nil)

;;;;;;;;;;;;;;; find file ;;;;;;;;;;;;;;;;;
;;(require 'ffap)
;;(ffap-bindings)
;;(setq ffap-require-prefix t)


;; buffer management
;; todo change the key
(global-set-key (kbd "M-]") 'next-buffer)
(global-set-key (kbd "M-[") 'previous-buffer)
(global-set-key (kbd "C-;") #'comment-line-or-region)

;; org-journal
(require 'org-journal)
;; ido-mode
(require 'ido)
(ido-mode t); enable ido-mode
(setq ido-enable-flex-matching t); flexibly match names
(setq ido-everywhere t); use ido-mode everywhere, in buffers and for finding files
(setq ido-use-filename-at-point 'guess); for find-file-at-point


;
;;autoreload
(global-auto-revert-mode 1)

; turn on line number display
; TODO: make the linum work with dark theme
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

;;;;; tabbar;;;;;;;;;;;;;;;;;;;;;;
(require 'tabbar)
; turn on the tabbar
(tabbar-mode t)
; define all tabs to be one of 3 possible groups: “Emacs Buffer”, “Dired”,
;“User Buffer”.

(defun tabbar-buffer-groups ()
    "Return the list of group names the current buffer belongs to.
This function is a custom function for tabbar-mode's tabbar-buffer-groups.
This function group all buffers into 3 groups:
Those Dired, those user buffer, and those emacs buffer.
Emacs buffer are those starting with “*”."
    (list
     (cond
      ((string-equal "*" (substring (buffer-name) 0 1))
       "Emacs Buffer"
       )
      ((eq major-mode 'dired-mode)
       "Dired"
       )
      (t
       "User Buffer"
       )
      )))

(setq tabbar-buffer-groups-function 'tabbar-buffer-groups)

(global-set-key [M-s-left] 'tabbar-backward)
(global-set-key [M-s-right] 'tabbar-forward)



;;;;;;;;;;;;;;;;; Programming Lang settings;;;;;;;;;;;


(require 'flymake)
;; Perl
(defalias 'perl-mode 'cperl-mode)
(setq cperl-hairy t) ;; Tqurns on most of the CPerlMode options
(setq guru-warn-only t) ;; only show warn 

(add-hook 'cperl-mode-hook (lambda () (flymake-mode t)))

;; highlight
(require 'auto-highlight-symbol)
(global-auto-highlight-symbol-mode t)


;; JS
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
(add-hook 'js2-mode-hook 'flymake-mode)
(add-hook 'js2-mode-hook 'auto-complete-mode)


;;; web beautify;;;;;
(require 'web-beautify) ;; Not necessary if using ELPA package
(eval-after-load 'js2-mode
  '(define-key js2-mode-map (kbd "C-c b") 'web-beautify-js))
;; Or if you're using 'js-mode' (a.k.a 'javascript-mode')
(eval-after-load 'js
  '(define-key js-mode-map (kbd "C-c b") 'web-beautify-js))

;;(eval-after-load 'json-mode
 ;; '(define-key json-mode-map (kbd "C-c b") 'web-beautify-js))

;;(eval-after-load 'sgml-mode
;;  '(define-key html-mode-map (kbd "C-c b") 'web-beautify-html))

(eval-after-load 'css-mode
  '(define-key css-mode-map (kbd "C-c b") 'web-beautify-css))

(eval-after-load 'js2-mode
  '(add-hook 'js2-mode-hook
	     (lambda ()
	       (add-hook 'before-save-hook 'web-beautify-js-buffer t t))))

;; Or if you're using 'js-mode' (a.k.a 'javascript-mode')
(eval-after-load 'js
  '(add-hook 'js-mode-hook
	     (lambda ()
	       (add-hook 'before-save-hook 'web-beautify-js-buffer t t))))

(eval-after-load 'json-mode
  '(add-hook 'json-mode-hook
	     (lambda ()
	       (add-hook 'before-save-hook 'web-beautify-js-buffer t t))))

(eval-after-load 'sgml-mode
  '(add-hook 'html-mode-hook
	     (lambda ()
	       (add-hook 'before-save-hook 'web-beautify-html-buffer t t))))

(eval-after-load 'css-mode
  '(add-hook 'css-mode-hook
	     (lambda ()
	                      (add-hook 'before-save-hook 'web-beautify-css-buffer t t))))


(load-theme 'solarized-light t)
;; make the fringe stand out from the background
(setq solarized-distinct-fringe-background t)
;;theme
;;(require 'solarized-dark-theme)
;; TODO: fix the theme
;;(load-theme 'solarized-dark t)
;;(defun my-solarized-dark ()
;  (interactive)
;  (solarized-dark-theme)
;  (set-face-attribute 'fringe nil :background "#CCC")
;    (set-face-attribute 'linum nil :background "#CCC"))
;(my-solarized-dark)


;; key binding
(global-set-key (kbd "C-x C-b") 'ibuffer)


;; smex
(require 'smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; try to understand this
(defun smex-prepare-ido-bindings ()
  (define-key ido-completion-map
    (kbd "C-,") 'smex-describe-function)
  (define-key ido-completion-map
    (kbd "C-w") 'smex-where-is)
  (define-key ido-completion-map
    (kbd "C-.") 'smex-find-function)
  (define-key ido-completion-map
    (kbd "C-a") 'move-beginning-of-line)
  ;; (define-key ido-completion-map "\C-i" 'smex-helm)
  ;; (define-key ido-completion-map " " 'smex-helm)
    )


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


;;(add-to-list 'load-path "/Users/hwu/.opam/4.02.0/share/emacs/site-lisp")
;;(require 'ocp-indent)
;; TODO define home dir
;;(add-to-list 'load-path "~/.opam/4.02.0/share/tuareg")
;;(load "tuareg-site-file")

;; TODO cedet
;;(global-ede-mode 1)                      ; Enable the Project management system
;;(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion
;;(global-srecode-minor-mode 1)            ; Enable template insertion menu
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

(evil-leader/set-key "c" 'smart-compile)

;;;;;;;;;;;;;; SQL ;;;;;;;;;;;;;;;;;;;
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

;;;;;;;;;;;; Persistent
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

;; smart-mode-line
(setq sml/no-confirm-load-theme t)
(sml/setup)
(add-to-list 'sml/replacer-regexp-list '("^/home/intellisurvey/versions/7.0/isbase" ":ISB:") t)
(add-to-list 'sml/replacer-regexp-list '("^:ISB:/arch/IS" ":IS:") t)
(add-to-list 'sml/replacer-regexp-list '("^:ISB:/html/admin/app" ":app:") t)
(add-to-list 'sml/replacer-regexp-list '("^:ISB:/html/admin/app" ":app:") t)
(add-to-list 'sml/replacer-regexp-list '("^:ISB:/testing/t" ":test:") t)


;;TODO write a blog about how to write a package in elisp
;;  perl tidy

(require 'perltidy)
;;
;; C-x C-j is provided by dired-x which is part of Emacs, but not loaded by default. See C-h i g (dired-x) Optional Installation Dired Jump, or simply (require 'dired-x)
;;
(require 'dired-x)

;;;###autoload
(defun keys-describe-prefixes ()
  (interactive)
  (with-output-to-temp-buffer "*Bindings*"
    (dolist (letter-group (list
			   (cl-loop for c from ?a to ?z
				    collect (string c))
			   ))
      (dolist (prefix '("" "C-" "M-" "C-M-"))
	(princ (mapconcat
		(lambda (letter)
		  (let ((key (concat prefix letter)))
		    (format ";; (global-set-key (kbd \"%s\") '%S)"
			    key
			    (key-binding (kbd key)))))
		letter-group
		"\n"))
       	        (princ "\n\n")))))

;; http://endlessparentheses.com/implementing-comment-line.html
(defun comment-line-or-region (n)
    "Comment or uncomment current line and leave point after it.
With positive prefix, apply to N lines including current one.
With negative prefix, apply to -N lines above.
If region is active, apply to active region instead."
    (interactive "p")
    (if (use-region-p)
	(comment-or-uncomment-region
	 (region-beginning) (region-end))
      (let ((range
	     (list (line-beginning-position)
		   (goto-char (line-end-position n)))))
	(comment-or-uncomment-region
	 (apply #'min range)
	 (apply #'max range)))
      (forward-line 1)
          (back-to-indentation)))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (org-journal smart-mode-line web-beautify tabbar smex smart-compile magit js2-mode evil-leader color-theme-solarized auto-highlight-symbol auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(linum ((t (:background "black" :foreground "green")))))

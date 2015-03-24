;;; echo.el --- utility subroutine used by myself
     
;;; no copy right

;; Author: Hao Wu <echowuhao@gmail.com>
;; Version: 0.1
;; Package-Requires:
;; Keywords: self 

     
;;; Commentary:

;; This package provides a minor mode to frobnicate and/or
;; bifurcate any flanges you desire.  To activate it, just type

;;(require 'auto-complete-config)
;;(add-to-list 'ac-dictionary-directories "~/.emacs.d/elpa/auot-complete/dict")
;;(require 'auto-complete-config)
;;(ac-config-default)


;; perl Data::Printer
;; TODO add global key map

(defun echo-data-printer () 
  "Insert Data::Printer p " 
  (interactive) 
  (insert "\nuse Data::Printer;\np $self")
)

;; stack trace

(setq stacktrace-code "
    use DDP; 
    use Devel::StackTrace;
    my $trace = Devel::StackTrace->new();

    # from top (most recent) of stack to bottom.
    while (my $frame = $trace->next_frame() ) {
      p $frame;
    }
")

(defun echo-insert-stackrace ()
  "insert code to print out stack trace"
  (interactive)
  (insert stacktrace-code))

;; case transformation
(defun un-camelcase-word-at-point ()
  "un-camelcase the word at point, replacing uppercase chars with
the lowercase version preceded by an underscore.

The first char, if capitalized (eg, PascalCase) is just
downcased, no preceding underscore.
"
  (interactive)
  (save-excursion
    (let ((bounds (bounds-of-thing-at-point 'word)))
      (replace-regexp "\\([A-Z]\\)" "_\\1" nil
                      (1+ (car bounds)) (cdr bounds))
      (downcase-region (car bounds) (cdr bounds)))))

;; from http://tuxicity.se/emacs/elisp/2010/11/16/delete-file-and-buffer-in-emacs.html
;; TODO: set key binding
;(global-set-key (kbd "C-c k") 'delete-this-buffer-and-file)
(defun delete-this-buffer-and-file ()
  "Removes file connected to current buffer and kills buffer."
  (interactive)
  (let ((filename (buffer-file-name))
        (buffer (current-buffer))
        (name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (when (yes-or-no-p "Are you sure you want to remove this file? ")
        (delete-file filename)
        (kill-buffer buffer)
        (message "File '%s' successfully removed" filename)))))


;;TODO write a blog about how to write a package in elisp
;;;;;; util function ;;;;;

(defun gnulinuxp ()
  "Returns t if the system is a GNU/Linux machine, otherwise nil"
  (string-equal system-type "gnu/linux"))


(defun osxp ()
  "Returns t if the system is a Mac OS X machine, otherwise nil"
    (string-equal system-type "darwin"))

;;(require 'git-messenger)

;; do not use the keyboard shoutcuts
;;(add-hook 'prog-mode-hook (lambda ()
;;(local-set-key (kbd "C-x v p") 'git-messenger:popup-message)
;;(evil-leader/set-key "gb" 'git-messenger:popup-message)))


(provide 'echo)     

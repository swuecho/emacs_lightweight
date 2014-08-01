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

(defun echo-add (x y)
  (+ x y))

;; perl Data::Printer
;; TODO add global key map



(defun echo-data-printer () 
  "Insert Data::Printer p " 
  (interactive) 
  (insert "\n") 
  (insert "use Data::Printer;")
  (insert "p $self;") 
  (insert "\n") 
  ) 


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

(provide 'echo)     

;;TODO write a blog about how to write a package in elisp
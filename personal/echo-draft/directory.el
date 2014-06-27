 (directory-files "~/Dropbox/org" t  "org" nil)

;; recurcive iterate files and directories
;; TODO make it right
 (defun print-files (name-string) 
   (if (file-regular-p name-string)
     (print  name-string)
     (mapc 'print-files (directory-files name-string t "org"  nil))))

(print-files "~/Dropbox")
(message  "a")


                                   

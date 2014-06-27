;; very important not have same file name as others
;; or it will have name confilcts

;; org configuration
;; mostly copied from 
;; http://doc.norang.ca/org-mode.html

(defvar echo-org-dir "~/Dropbox/org")
(defvar echo-org-public-dir "~/Dropbox/org_public")


(defun echo-full-org-file-name (file) 
  "helper function to get the absolute file name from relative file name"
  (expand-file-name file echo-org-dir))
                                      
;;(require 'org-publish)
;;(stringp echo-org-dir)
;;(stringp echo-org-public-dir)

(setq org-publish-project-alist
      '(("org-notes"
         :base-directory "~/Dropbox/org/"
         :base-extension "org"
         :publishing-directory "~/Dropbox/org_public"
         :section-numbers nil
         :with-toc nil
         :auto-preamble nil
         :auto-sitemap t
         :html-postamble nil
         :recursive t
         :publishing-function org-html-publish-to-html
         )

        ("org-static"
         :base-directory "~/Dropbox/org"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/Dropbox/org_public"
         :recursive t
         :publishing-function org-publish-attachment
         )
        ("org" :components ("org-notes" "org-static"))))

; remove the footer in html page
(setq org-export-html-postamble nil)

;; add agenda files here
(defvar echo-agenda-files (mapcar 'echo-full-org-file-name
        '("refile.org" 
          "todo.org" 
          "diary_2014.org")))

(setq org-agenda-files echo-agenda-files)

(setq refile-file (echo-full-org-file-name "refile.org"))

(setq org-default-notes-file refile-file)

;; I use C-M-r to start capture mode
(global-set-key (kbd "C-M-r") 'org-capture)

;; TODO -- understand more of this
;; Capture templates for: TODO tasks, Notes, appointments, phone calls, meetings, and org-protocol
;; %a is the link the the initiated file

(setq org-capture-templates
      (quote (("t" "todo" entry (file "~/Dropbox/org/todo.org")
               "* TODO %U %?")
              ("n" "note" entry (file refile-file)
               "* %? :NOTE:\n%U")
              ("j" "Journal" entry (file+datetree "~/Dropbox/org/jounal.org")
               "* %?\n%U\n" :clock-in t :clock-resume t)
             )))



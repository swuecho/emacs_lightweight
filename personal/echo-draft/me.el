(defun me-add (x y)
  (+ x y))

;; perl Data::Printer
;; TODO add global key map



(defun me-data-printer () 
  "Insert Data::Printer p " 
  (interactive) 
  (insert "\n") 
  (insert "use Data::Printer;")
  (insert "p $self;") 
  (insert "\n") 
  ) 

;;TODO what happened with this file?


;;http://192.168.0.60/admin/devtools/appviewer?appid=id

;; host and survey id
(setq host "102")

(setq id "_test_widget_question_0")

(setq ip (concat  "192.168.56." host))

(defun is-viewer-url (id)  (concat "http://" ip "/admin/devtools/appviewer?appid=" id))

(setq url_widget  (is-viewer-url id))

;; "http://192.168.56.102/admin/devtools/appviewer?appid=_test_widget_question_0"

;; (browse-url url_widget)


(setq host   "102")

(setq network "192.168.56")


(setq ip (concat network "." host))


(defun survey-url-from-id (survey-id)
  (concat "http://" ip "/run/" survey-id))


(defun open-survey-from-id ()
  "open a survey url from survey id"
  (interactive)
  (let (p1 p2 survey-id survey-url)
    (search-backward " ")
    (forward-char)
    (setq p1 (point))
    (search-forward " ")
    (backward-char)
    (setq p2 (point))
    (setq survey-id (buffer-substring-no-properties p1 p2))
    (setq survey-url (survey-url-from-id survey-id))
    (browse-url survey-url)
    )
  )





(survey-url survey-id)

(setq survey-test-url (concat "http://" ip "/run/" survey-id "?_test=1"))



(setq data-viewer-url (concat "http://" ip "/admin/devtools/appviewer?appid=" survey-id))

;;(browse-url data-viewer-url)

;;(browse-url survey-url)
 

;;TODO

;;replace all occurance string in current line

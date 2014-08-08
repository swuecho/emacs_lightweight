# module to install

1. evil
2. auto-complete
3. color-theme-solarized
4. magit

;; run this command to install all 
(mapc #'package-install [evil magit auto-complete color-them-solarised])

# elisp

(mapcar #'1+ [1 2 3 4])
;; (2 3 4 5)
(apply '+ '(1 2 3))
;;(reduce #'+ [1 2 3 4] 0)

(length "foobar")

(length [1 2 3])

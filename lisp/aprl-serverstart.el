;;;_* ===== Emacs server start =====
(condition-case nil
    (server-start)
  (error nil))
;; (if (file-exists-p
;;  (concat (getenv "TMPDIR") "emacs"
;;          (number-to-string
;;           (user-real-uid)) "/server"))
;;     nil 
;;   (server-start))
(put 'narrow-to-page 'disabled nil)

;;_* ===== iPython =====
(load (path-join (aprl-search-package 'ipython "~/.emacs.d/site-lisp") "ipython"))
;; (require 'ipython)
;; (when (eq system-type 'darwin)
;;   (setq ipython-command "/opt/local/bin/ipython"))

; use IPython (from http://www.jesshamrick.com/2012/09/18/emacs-as-a-python-ide/)
(setq-default py-shell-name "ipython")
(setq-default py-which-bufname "IPython")
; use the wx backend, for both mayavi and matplotlib
(setq py-force-py-shell-name-p t)

;;_ . clear screen
(defun comint-clear-screen ()
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))

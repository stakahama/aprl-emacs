(defun beautify-json ()
  ;; http://stefan.arentz.ca/beautify-json-in-emacs.html
  (interactive)
  (let ((b (if mark-active (min (point) (mark)) (point-min)))
        (e (if mark-active (max (point) (mark)) (point-max))))
    (shell-command-on-region b e
      "python -mjson.tool" (current-buffer) t)))

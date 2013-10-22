;; installed from https://github.com/shosti/elscreen
;;   not in MELPA repo as advertised

;;;_* ===== Elscreen ====

;;;_ --- load ---
(add-to-list 'load-path (aprl-search-package 'elscreen "~/.emacs.d/site-lisp"))
(load "elscreen" "ElScreen" t)
(elscreen-start) ;new requirement

;;;_ --- key bindings ---
(global-set-key (kbd "<f6>"  ) 'elscreen-reset)
(global-set-key (kbd "<f7>") 'elscreen-next)
(global-set-key (kbd "S-<f7>") 'elscreen-previous)
(global-set-key (kbd "<f8>"    ) 'elscreen-create)
(global-set-key (kbd "S-<f8>"  ) 'elscreen-kill)
(define-key elscreen-map "f" 'elscreen-find-file)
(define-key elscreen-map "r" 'elscreen-reset)
(define-key elscreen-map "l" 'elscreen-create)
(global-set-key (kbd "S-C-<left>") 'elscreen-previous)
(global-set-key (kbd "S-C-<right>") 'elscreen-right)

;;;_ ... functions ---
(defun elscreen-reset ()
  "Cycles through screens so that window configurations are reset (prevents flashing from redraw-frame[?] after each keystroke)"
  (interactive)
  ;; only happens when number of screens > 1
  (when (> (elscreen-get-number-of-screens) 1)
    (let* ((screen-list (elscreen-get-screen-list))
	   (current-screen (elscreen-get-current-screen))
	   (screen-seq (append (delq current-screen screen-list)
			       (list current-screen))))
      (mapc 'elscreen-goto screen-seq))))

(defadvice set-frame-size (after elscreen-set-frame-size activate)
  (elscreen-reset))

;; (defadvice toggle-fullscreen (after elscreen-toggle-fullscreen activate)
;;   (elscreen-reset))

;; (let ()
;;   (ad-disable-advice 'set-frame-size 'after 'elscreen-set-frame-size)
;;   (ad-activate 'set-frame-size))

;;;_* ===== ido mode =====

(if (>= emacs-major-version 22)
    (progn
      (require 'ido)
      (ido-mode t)
      ;; (setq confirm-nonexistent-file-or-buffer nil)
      (add-hook 'ibuffer-mode-hook
		(lambda ()
		  (define-key ibuffer-mode-map [remap ibuffer-visit-buffer] 
		    'ibuffer-like-ido-visit-buffer)
		  (define-key ibuffer-mode-map [remap ibuffer-find-file]
		    'ido-find-file))) ;; added 3/8/2012
      ;; make ibuffer like ido-mode
      (defun ibuffer-like-ido-visit-buffer (&optional single)
	"Visit the buffer on this line.
If optional argument SINGLE is non-nil, then also ensure there is only
one window."
	(interactive "P")
	(let ((buf (ibuffer-current-buffer t)))
	  (bury-buffer (current-buffer))
	  (ido-visit-buffer buf ido-default-buffer-method)
	  (when single
	    (delete-other-windows)))))
  (progn
    (iswitchb-mode t)
    (icomplete-mode t)))

;;;_ . keybindings

(global-set-key (kbd "C-c f") 'ido-find-file-other-frame)
(global-set-key (kbd "C-c b") 'ido-switch-buffer-other-frame)

;;;_ . custom-set-variables

(customize-save-variable 'ido-enable-flex-matching t)
(customize-save-variable 'ido-enable-last-directory-history nil)
(customize-save-variable 'ido-max-work-directory-list 0)
(customize-save-variable 'ido-max-work-file-list 0)
(customize-save-variable 'ido-record-commands nil)
(customize-save-variable 'ido-save-directory-list-file nil)

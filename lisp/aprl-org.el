;;;_* ===== org-mode =====

;; (when (require 'org nil 'noerror);previously: (require 'org-mode nil 'noerror)
(require 'org-install)
(require 'org-latex)
;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-c8" 'org-store-link)	;"\C-cl"
(global-set-key "\C-c9" 'org-agenda)		;"\C-ca"
(global-set-key "\C-c0" 'org-iswitchb)	;"\C-cb"

;;;_ . functions

(defun org-begin-or-end ()
  (interactive)
  (flet ((fn (str &optional suffix) 
	     (save-excursion 
	       ;; env is dynamically-scoped
	       (let (pos) ;; (match-beginning 0) will find last match if nil
		 (setq pos (re-search-backward 
			    (concat 
			     (replace-regexp-in-string "\\#\\+" "\\\\#\\\\+" str) 
			     suffix) () t))
		 (if suffix 
		     (setq env (match-string-no-properties 1)))
		 (or pos 0))))
	 (upcase-add (str &optional env) 
		     (save-excursion 
		       (beginning-of-line)
		       (insert (concat str env))
		       (if (< (point) (line-end-position))
			   (upcase-word 1)))))
    (let ((st "#+BEGIN_")
	  (en "#+END_")
	  env)
      (if (<= (fn st "\\([A-Z]+\\)") (fn en))
	  (upcase-add st)
	(progn
	  (upcase-add en env)
	  (end-of-line))))))

;;;_ . my customizations for export logbook entries
(defvar org-logbook-mode-p nil)
(defvar org-default-vars nil)
(condition-case nil
    (progn
      (require 'aprl-org-logbook)
      (require 'aprl-latex)) ; LaTeX-enclose-expression needs to be defined for keybindings below
  (error nil))

;;;_ . defaults

(defun org-get-defaults ()
  (let ((vars '(org-agenda-files
		org-format-latex-options
		org-export-latex-date-format
		org-export-latex-image-default-option
		org-export-latex-classes)))
    (mapcar (lambda (x) (cons x (eval x))) vars)))

(defun org-restore-defaults (default-vars)
  (interactive)
  (mapc (lambda (x) 
	  (set (car x) (cdr x)))
	default-vars))

(setq org-default-vars (org-get-defaults))
;; restore with 
;; (org-restore-defaults org-default-vars)

;;;_ . further customizations
(add-hook 'org-mode-hook
	  '(lambda ()
	     ;;(auto-fill-mode 1)
	     ;;(org-indent-mode t)
	     (local-set-key [(shift f5)] 'org-export-as-latex)
	     (local-set-key (kbd "C-c e") 
			    (LaTeX-enclose-expression "\\(" "\\)"))
	     (local-set-key (kbd "C-c r")
			    'LaTeX-wrap-environment-around-thing-or-region)
	     (local-set-key (kbd "C-c s")
			    'org-begin-or-end)
	     (define-key org-mode-map "\M-q" 'fill-paragraph)
	     (local-set-key [(shift f6)] 'org-export-as-html)))

;;;_ . --- custom variables ---

(setq-default org-agenda-files nil)

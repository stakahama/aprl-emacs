
;;------------------------------------------------------------------------------
;;
;;    This file is part of aprl-emacs.
;;    
;;    aprl-emacs is free software: you can redistribute it and/or modify
;;    it under the terms of the GNU General Public License as published by
;;    the Free Software Foundation, either version 3 of the License, or
;;    (at your option) any later version.
;;    
;;    aprl-emacs is distributed in the hope that it will be useful,
;;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;    GNU General Public License for more details.
;;    
;;    You should have received a copy of the GNU General Public License
;;    along with aprl-emacs.  If not, see <http://www.gnu.org/licenses/>.
;;
;;------------------------------------------------------------------------------


;;;_* ===== org-mode =====


;; (when (require 'org nil 'noerror);previously: (require 'org-mode nil 'noerror)
;; (add-to-list 'load-path (aprl-search-package 'org "~/.emacs.d/site-lisp"))
(add-to-list 'load-path (aprl-search-package 'org "~/.emacs.d/elpa"))

(require 'org)
;; (require 'org-install)
(condition-case nil
    (require 'org-latex)
  (error nil))

;; The following lines are always needed.  Choose your own keys.
(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(global-set-key "\C-c8" 'org-store-link)	;"\C-cl"
(global-set-key "\C-c9" 'org-agenda)		;"\C-ca"
(global-set-key "\C-c0" 'org-iswitchb)	;"\C-cb"

;;;_ . functions

;; use <s TAB (#+BEGIN_SRC/#+END_SRC) or <e TAB instead of function below
;;
;; (defun org-begin-or-end ()
;;   (interactive)
;;   (flet ((fn (str &optional suffix) 
;; 	     (save-excursion 
;; 	       ;; env is dynamically-scoped
;; 	       (let (pos) ;; (match-beginning 0) will find last match if nil
;; 		 (setq pos (re-search-backward 
;; 			    (concat 
;; 			     (replace-regexp-in-string "\\#\\+" "\\\\#\\\\+" str) 
;; 			     suffix) () t))
;; 		 (if suffix 
;; 		     (setq env (match-string-no-properties 1)))
;; 		 (or pos 0))))
;; 	 (upcase-add (str &optional env) 
;; 		     (save-excursion 
;; 		       (beginning-of-line)
;; 		       (insert (concat str env))
;; 		       (if (< (point) (line-end-position))
;; 			   (upcase-word 1)))))
;;     (let ((st "#+BEGIN_")
;; 	  (en "#+END_")
;; 	  env)
;;       (if (<= (fn st "\\([A-Z]+\\)") (fn en))
;; 	  (upcase-add st)
;; 	(progn
;; 	  (upcase-add en env)
;; 	  (end-of-line))))))

(defun org-mode-view-html-in-browser (arg)
  "Open html file in browser if it exists. 
Use C-c C-e h h to convert to html.
Use C-c C-e h o to convert to html + open."
  ;; only tested on OS X  
  (interactive "P")
  (let ((app (cond
	      ((string-equal system-type "windows-nt") "start") 
	      ((string-equal system-type "darwin") "open")
	      ((string-equal system-type "gnu/linux") "xdg-open")))
	(file-html (concat (file-name-sans-extension (buffer-file-name)) ".html")))
    ;; (if (not arg)
    ;; 	(org-html-export-to-html)) ; C-c C-e h h
    (if (file-exists-p file-html)
	(start-process
	 "org-view" "*Messages*"
	 app file-html))))


;;;_ . further customizations
(add-hook 'org-mode-hook
	  '(lambda ()
	     ;;(auto-fill-mode 1)
	     ;;(org-indent-mode t)
	     (local-set-key (kbd "C-c e") 
			    (LaTeX-enclose-expression "\\(" "\\)"))
	     (local-set-key (kbd "C-c r")
			    'LaTeX-wrap-environment-around-thing-or-region)
	     ;; (local-set-key (kbd "C-c s") 'org-begin-or-end)
	     (define-key org-mode-map "\M-q" 'fill-paragraph)))
	     ;; (local-set-key (kbd "C-c C-v") 'org-mode-view-html-in-browser)))
	     

;;;_ . --- custom variables ---

(setq-default org-agenda-files nil)

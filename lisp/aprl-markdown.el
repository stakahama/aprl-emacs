
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

;;_* ===== markdown-mode =====

;; (load (aprl-path-join (aprl-search-package 'markdown-mode "~/.emacs.d/site-lisp")
;; 		 "markdown-mode"))
;; (setq auto-mode-alist (cons '("\\.md$" . markdown-mode) auto-mode-alist))

(require 'markdown-mode)

(defun markdown-view-md-in-browser ()
  "View html output."
  ;; only tested on OS X  
  (interactive)
  (let ((app (cond
	      ((string-equal system-type "windows-nt") "start") 
	      ((string-equal system-type "darwin") "open")
	      ((string-equal system-type "gnu/linux") "xdg-open"))))
    (start-process
     "markdown-view-in-browser" "*Messages*"
     app (buffer-file-name) )))

(add-hook 'markdown-mode-hook
	    '(lambda ()
	       (local-set-key (kbd "C-c C-v") 'markdown-view-md-in-browser)))

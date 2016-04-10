
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




;; enable latexmk as Tex-command-default
;; designate Preview.app as viewer (OS X)

(add-hook 'LaTeX-mode-hook 
	  (lambda ()
	    (let* ((pdfviewer "Preview")
		   (view-command `("View" 
				   ,(format "open -a \"%s\" %%s.pdf" pdfviewer)
				   TeX-run-discard-or-function t t 
				   :help "Run Viewer")))
	      (setq-default TeX-master nil)
	      (setq TeX-output-view-style
		    `(("^dvi$" "^xdvi$" "xdvi %dS %d")
		      ("^dvi$" "." "open %dS %d")
		      ;;("^pdf$" "." "open %o")
		      ("^pdf$" "." ,(format "open -a \"%s\" %%o" pdfviewer))
		      ("^html?$" "." "open %o")))
	      (setq TeX-command-default "latexmk");;"LaTeX")
	      (setq TeX-PDF-mode t)
	      (setq TeX-command-list 
		    (mapcar (lambda (x) (if (equal (car x) "View") view-command x))
			    TeX-command-list))
	      (add-to-list 'TeX-command-list
			   '("XeLaTeX" "%`xelatex%(mode)%' %t" TeX-run-TeX nil t)))))

(add-hook 'LaTeX-mode-hook 
	  (lambda () 
	    ;; (defadvice TeX-recenter-output-buffer (after TeX-output-buffer-scroll-to-bottom)
	    ;;   (goto-char (point-max)))
	    ;; http://www.stefanom.org/setting-up-a-nice-auctex-environment-on-mac-os-x/
	    (push 
	     '("latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
	       :help "Run latexmk on file")
	     TeX-command-list)))

(eval-after-load "tex-buf" 
  '(progn
     (defun TeX-command-query (name)
       "Query the user for what TeX command to use."
       (let* ((default
		(cond ((if (string-equal name TeX-region)
			   (TeX-check-files (concat name "." (TeX-output-extension))
					    (list name)
					    TeX-file-extensions)
			 (TeX-save-document (TeX-master-file)))
		       TeX-command-default)
		      ((and (memq major-mode '(doctex-mode latex-mode))
			    ;; Want to know if bib file is newer than .bbl
			    ;; We don't care whether the bib files are open in emacs
			    (TeX-check-files (concat name ".bbl")
					     (mapcar 'car
						     (LaTeX-bibliography-list))
					     (append BibTeX-file-extensions
						     TeX-Biber-file-extensions)))
		       ;; We should check for bst files here as well.
		       (if LaTeX-using-Biber TeX-command-Biber TeX-command-BibTeX))
		      ((TeX-process-get-variable name
						 'TeX-command-next
						 ;; TeX-command-Show))
						 TeX-command-default)) ; ST edit
		      ;; (TeX-command-Show)))                          ; ST edit
		      (TeX-command-default)))
	      (completion-ignore-case t)
	      (answer (or TeX-command-force
			  (completing-read
			   (concat "Command: (default " default ") ")
			   (TeX-mode-specific-command-list major-mode) nil t
			   nil 'TeX-command-history))))
	 ;; If the answer is "latex" it will not be expanded to "LaTeX"
	 (setq answer (car-safe (TeX-assoc answer TeX-command-list)))
	 (if (and answer
		  (not (string-equal answer "")))
	     answer
	   default)))))

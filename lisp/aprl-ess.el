
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


;;;_* ===== R/ESS =====

;; (when (file-exists-p (aprl-package-alias "ess"))
;;   (add-to-list 'load-path (concat (aprl-package-alias "ess") "/lisp"))
;; (global-set-key (kbd "C-c R") 'my-start-R-ESS);'my-ess-start-R)

;;;_ . recommended
;;
(require 'ess-site)
;; (require 'ess-eldoc)
;; ---
(setq-default inferior-R-args "--no-restore-history --no-save ")
(setq ess-ask-for-ess-directory nil)
(setq ess-local-process-name "R")
(setq ansi-color-for-comint-mode 'filter)
(setq comint-prompt-read-only t)
(setq comint-scroll-to-bottom-on-input t)
(setq comint-scroll-to-bottom-on-output t)
(setq comint-move-point-for-output t)
(autoload 'ess-rdired "ess-rdired" "View R objects in a dired-like buffer." t)
;; ---
;; (setq-default ess-default-style 'C++)
;; (setq inferior-ess-r-help-command "utils::help(\"%s\", help_type=\"html\")\n") 

(setq ess-default-style 'DEFAULT)

;; (if (eq system-type 'darwin)
;;     (setq inferior-R-args "--arch x86_64"))

;; (if (or (eq system-type 'cygwin)
;; 	(eq system-type 'darwin))
;;     (setq inferior-R-program-name "/usr/bin/R"))

;;;_ . suppress printing of sent commands for speedup

(setq ess-eval-visibly-p nil) ;; from http://www.damtp.cam.ac.uk/user/sje30/ess11
;; (setq ess-eval-visibly-p t)

;; ;; (if (and nil (not ess-eval-visibly-p))
;; ;;     (defun inferior-ess-output-filter (proc string)
;; ;;       "print newline after each evaluation when ess-eval-visibly-p is true
;; ;; if you are not using ess-tracebug. Works only with R
;; ;; from http://old.nabble.com/cat-a-%22%5Cn%22-when-ess-eval-visibly-p-is-nil--td32684429.html"
;; ;;       (let ((pbuf (process-buffer proc))
;; ;; 	    (pmark (process-mark proc))
;; ;; 	    (prompt-regexp "^>\\( [>+]\\)*\\( \\)$")
;; ;; 	    (prompt-replace-regexp "^>\\( [>+]\\)*\\( \\)[^>+\n]"))
;; ;; 	(setq string (replace-regexp-in-string prompt-replace-regexp " \n"
;; ;; 					       string nil nil 2))
;; ;; 	(with-current-buffer pbuf
;; ;; 	  (goto-char pmark)
;; ;; 	  (beginning-of-line)
;; ;; 	  (when (looking-at prompt-regexp)
;; ;; 	    (goto-char pmark)
;; ;; 	    (insert "\n")
;; ;; 	    (set-marker pmark (point)))))
;; ;;       (comint-output-filter proc (inferior-ess-strip-ctrl-g string))))

;;;_ . hooks

(add-hook 'ess-mode-hook
	  '(lambda()
	     (local-set-key (kbd "<C-return>") 'ess-eval-region)
	     (local-set-key (kbd "C-c d") 'ess-rdired)
	     (local-set-key (kbd "C-c 9") 'add-column-offset)))

(add-hook 'inferior-ess-mode-hook
	  '(lambda()
	     (local-set-key [C-up] 'comint-previous-input)
	     (local-set-key [C-down] 'comint-next-input)))

;; ;;;_ . ess-R-data-view
;; (add-to-list 'load-path (concat local-packages "emacs-ctable"))
;; (add-to-list 'load-path (concat local-packages "popup-el"))
;; (add-to-list 'load-path (concat local-packages "ess-R-data-view.el"))
;; (require 'ess-R-data-view)
;; (define-key ess-mode-map (kbd "C-c v") 'ess-R-dv-ctable)
;; (define-key ess-mode-map (kbd "C-c V") 'ess-R-dv-pprint)

;;;_* ===== Sweave =====
;; http://www.mail-archive.com/auctex@gnu.org/msg03386.html
(add-hook 'Rnw-mode-hook
	  (lambda ()
	    (add-to-list 'TeX-command-list
			 '(;;"Sweave" "/usr/bin/R --no-save < %s"
			   "Sweave" "R CMD BATCH --no-save %s /dev/tty"
			   TeX-run-command nil (latex-mode) :help "Run Sweave") t)
	    (add-to-list 'TeX-command-list
			 '("LatexSweave" "%l %(mode) \\input{%s}"
			   TeX-run-TeX nil (latex-mode) :help "Run Latex after Sweave") t)
	    (setq TeX-command-default "Sweave")))

(add-hook 'noweb-minor-mode-hook 
	  '(lambda () 
	     (scroll-conservatively 10000)
	     (visual-line-mode 1)))

;;;_* ===== functions =====
;;-------------------- from my ess-hacks.el --------------------
;;;_* keybindings

(add-hook 'ess-mode-hook
	  '(lambda()
	     (local-set-key (kbd "C-c h") 'ess-seek-help)
	     (local-set-key (kbd "C-c a") 'ess-seek-args)
	     (local-set-key (kbd "C-c p") 'ess-op-fig)
	     (local-set-key (kbd "C-c R") 'ess-start-R)
	     (local-set-key (kbd "C-c s") 'ess-set-proc-name)
	     (local-set-key (kbd "C-c z") 'ess-setwd)))

;;;_* general

(defadvice ess-eval-region
  (after ess-eval-region-deactivate-mark activate)
  "Deactivate mark after executing region 
   (region is preserved after mark is deactivated)"
  (deactivate-mark))

(defun ess-start-R (&optional arg)
  "Runs R interpreter in inferior ESS buffer. Usage: if an R
  script open, e.g., 'script.r', invoke ess-start-R when this
  script buffer is active. If an inferior ESS buffer already
  exists, must use prefix key (e.g., if ess-start-R is bound to
  `C-c R`, the first instance is invoked by `C-c R`; subsequent
  inferior ESS buffers invoked with `C-u C-c R` -- otherwise `C-c
  R` will switch to top exising inferior ESS buffer). If
  'script.r' is the name of the R script, the buffer will be
  named *R<script>* or *R:2<script>*, depending on existing R
  processes.  Inspired by `my-ess-start-R` function in ESS Emacs
  Wiki <http://www.emacswiki.org/emacs/EmacsSpeaksStatistics> and
  implemented to mimic behavior of emacs inferior shell."
  (interactive "P")
  ;; local functions
  (flet ((get-buffer-var (buf var)
			 (save-excursion
			   (set-buffer buf)
			   (eval var)))
	 (find-matching-inferior-r (this-buffer) 
				   ;; return matching inferior R buffer name
				   (let (buflist pattern bufname x)
				     (setq buflist (reverse (buffer-list)))
				     (if (setq pattern 
					       (get-buffer-var this-buffer 
							       'ess-local-process-name))
					 ;; ess local process exists
					 ;; match based on process
					 (dolist (x buflist bufname)
					   (if (and (equal pattern
							   (get-buffer-var x 'ess-local-process-name))
						    (equal 'inferior-ess-mode 
							   (get-buffer-var x 'major-mode)))
					       (setq bufname (buffer-name x))))
				       ;; else: match based on name
				       ;; e.g., file is reopened and ess local process is nil
				       (progn
					 (setq pattern
					       (format "\\*R[:0-9]*\\*<%s>" 
						       (file-name-sans-extension this-buffer)))
					 (let (tmp)
					   (dolist (x buflist bufname)
					     (setq tmp (buffer-name x))
					     (if (and (string-match pattern tmp)
						      (equal 'inferior-ess-mode 
							     (get-buffer-var x 'major-mode)))
						 (setq bufname tmp))))))))
	 (is-wide-p (thres)
		    (> (frame-width) thres)))
    ;; local variables:
    (let ((this-buffer (buffer-name))
	  (r-proc nil)
	  (r-inferior-buffer nil)
	  (maxwidth 160))
      ;; function body:
      (setq r-inferior-buffer (find-matching-inferior-r this-buffer))      
      ;; delete other windows
      (if (is-wide-p maxwidth) 
	  (delete-other-windows)
	(condition-case nil
	    (delete-other-windows-vertically)
	  (error (delete-other-windows))))
      ;; /
      (if (or (not r-inferior-buffer) arg)
	  ;; start new R process
	  (progn
	    (R)
	    (setq r-proc ess-local-process-name)
	    (setq r-inferior-buffer
		  (format "*%s*<%s>"  r-proc
			  (file-name-sans-extension 
			   this-buffer)))
	    (rename-buffer r-inferior-buffer))
	;; else: switch to current R process
	(progn
	  (switch-to-buffer r-inferior-buffer)
	  (setq r-proc ess-local-process-name)))
      ;; split window between script and inferior shell
      (if (is-wide-p maxwidth)
	  (split-window-horizontally)
	(split-window-vertically))
      (switch-to-buffer this-buffer)
      (enlarge-window 10)
      ;; /
      (if r-proc
	  (setq ess-local-process-name r-proc)))))

(defun ess-set-proc-name (R-name)
  (interactive "sEnter R process name: ")
  (setq ess-local-process-name R-name))

(defun ess-setwd ()
  (interactive)
  (ess-eval-linewise (format "setwd(\"%s\")" 
			     (file-name-directory (buffer-file-name)))
		     nil nil nil 'wait))

(defun ess-inferior-scrub-name (&optional arg)
  "remove file name from inferior ESS buffer name"
  (interactive "P")
  (let ((iESS-buffer-name (buffer-name)))
    (if (string-match "\\*R" iESS-buffer-name)
	(rename-buffer 
	 (replace-regexp-in-string "<.+>" "" "*R*<read2_2011-05>"))
      (message "Not iESS buffer"))))

(defun ess-which-script-buffers ()
  "Finds scripts associated with a particular inferior ESS buffer R process. Run this function from an inferior ESS buffer and associated script buffers (major-mode is ess-mode) will be listed in minibuffer region. Requires common lisp extensions: (require 'cl)"
  (interactive)
  (flet ((get-buffer-var (buf var)
			 (save-excursion
			   (set-buffer buf)
			   (eval var)))
	 (get-mode (x) (get-buffer-var x 'major-mode))
	 (get-rproc (x) (get-buffer-var x 'ess-local-process-name))
	 (matchfn (rproc)
		  (lexical-let ((rproc rproc))
		    (lambda (x) 
		      (and (equal 'ess-mode (get-mode x))
			   (equal rproc (get-rproc x)))))))
    (if (equal 'inferior-ess-mode (get-mode (buffer-name)))
	(let (ismatchp)
	  (fset 'ismatchp (matchfn (get-rproc (buffer-name))))
	  (princ (mapconcat 'buffer-name
			    (remove-if-not 'ismatchp (reverse (buffer-list)))
			    "\n")))
      (princ "not inferior ESS buffer"))))

;;;_* send to ess-line (help)

(defun ess-send-to-function (ess-fn)
  (interactive)
  (let (fn-name)
    (setq fn-name
	  (if (region-active-p)
	      (buffer-substring-no-properties
	       (region-beginning) (region-end))
	    (let ((charset "A-Za-z0-9._")
		  pos1 pos2)
	      (save-excursion
		(skip-chars-backward charset)
		(setq pos1 (point))
		(forward-char)
		(skip-chars-forward charset)
		(setq pos2 (point))
		(buffer-substring-no-properties pos1 pos2)))))
    (ess-eval-linewise (format "%s(\"%s\")" ess-fn fn-name)
		       nil nil nil 'wait)))

(defun ess-seek-help () 
  (interactive)
  (ess-send-to-function ".help.ESS"))
(defun ess-seek-args () 
  (interactive)
  (ess-send-to-function "args"))

(defun ess-op-fig (&optional arg)
  "possibly rewrite r-expression as R function to load in .Rprofile"
  (interactive "P")
  (flet ((searchback (dev) 
		     (save-excursion ;; point after dev.off()
		       (if (search-backward-regexp (format "^[ ]*\\(%s(.+[)|\n]\\)" dev) nil t)
			   (match-string-no-properties 1)
			 nil)))
	 (strip-newlines (line)  
			 (replace-regexp-in-string "\n" "" line))
	 (check-lastchar (line)      ;; need in case entire expression is not matched
			 (let* ((nchar-1 (- (length line) 1))
				(lastchar (substring line nchar-1)))
			   (if (equal lastchar ",") 
			       (concat (substring line 0 nchar-1) ")")
			     line))))
    (let ((devices '("pdf" "png" "trellice.device" "dev.copy" "bmp" "jpeg" "tiff" "gif"))
	  (r-regexpr-pattern ".+\\\\.(pdf|png|bmp|jpg|tiff|gif)")
	  (r-expression "with(list(exec=\"%s\",textline='%s'),{expr <- parse(text=textline)[[1]]; filename <- if( !is.null(expr$file) ) expr$file else {for(e in as.list(expr)) if(is.character(e)&&grepl(\"%s\",e)||is.call(e)&&any(sapply(e[1:2],`==`,quote(sprintf)))) break; e}; if(is.call(filename)) filename <- eval(filename); if(file.exists(filename)) system(paste(exec,filename)) else \"no match\"})")
	  exec matched-expression)
      (setq exec (if arg "~/bin/compresspdf"
		   (if (eq system-type 'darwin) "open -a \\\"Preview\\\"" 
		     (if (eq system-type 'gnu/linux) "gnome-open"))))
      (setq matched-expression
	    (let (x tmp out)
	      (dolist (x devices out)
		(if (and (not tmp) (setq tmp (searchback x)))
		    (setq out (check-lastchar (strip-newlines tmp)))))))
      ;; (print (format r-expression exec matched-expression r-regexpr-pattern)))))
      (ess-eval-linewise (format r-expression exec matched-expression r-regexpr-pattern)
      			 nil nil nil 'wait))))

;;;_* OS X (PDF functions)
(defun operate-on-pdf (fn &optional arg)
  (let (pdf-file pos1 pos2)
    (setq pdf-file
	  (if (region-active-p) ;; pdf name high-lighted
	      (buffer-substring-no-properties
	       (region-beginning) (region-end))
	    (if (or arg
		    (progn
		      (setq pos1 (point)
			    pos2 (save-excursion
				   (previous-line)
				   (line-beginning-position)))
		      (string-match "dev\\.off()" (buffer-substring-no-properties pos1 pos2))))
		(save-excursion ;; point after dev.off()
		  ;; (search-backward-regexp "[^a-zA-Z0-9]pdf[(,].*\"\\(.+\\.pdf\\)\".*)")
		  (search-backward-regexp "^.*pdf[(,].*\"\\(.+\\.pdf\\)\".*)")
		  (match-string-no-properties 1))
	      (save-excursion ;; point over pdf name
		(search-backward "\"")
		(setq pos1 (point))
		(forward-char)
		(search-forward "\"")
		(setq pos2 (point))
		(buffer-substring-no-properties pos1 pos2)))))
    (setq pdf-file (replace-regexp-in-string "\"?\\([^\"]+\\)\"?" 
					     "\\1" pdf-file))
    (if (string-match "\\.pdf$" pdf-file)
	(funcall fn pdf-file)
      (message (format "%s is not a pdf file." pdf-file)))))

(defun preview (filename)
  (start-process-shell-command "preview" nil
			       (format "open -a \"Preview\" %s" filename)))

(defun compresspdf (filename)
  (interactive)
  (flet ((escape-space (x) (replace-regexp-in-string "[ ]" "\\\\ " x)))
    (let ((tmpfile (concat filename "~"))
	  origin haserror)
      (shell-command (format "pdftk %s cat output %s compress dont_ask"
			     (escape-space filename) (escape-space tmpfile)))
      (setq iserror
	    (save-excursion
	      (set-buffer "*Shell Command Output*")
	      (search-backward "error" () t)))
      (if haserror 
	  (if (file-exists-p tmpfile)
	      (delete-file tmpfile nil))
	(rename-file tmpfile filename t))
      nil)))

(defun point-and-compresspdf (&optional arg)
  (interactive)
  (operate-on-pdf 'compresspdf 'arg))

(defun send-to-preview (&optional arg)
  (interactive)
  (operate-on-pdf 'preview 'arg))

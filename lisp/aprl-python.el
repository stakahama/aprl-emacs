;;_* ===== Python-mode =====

;; disable Loveshack Python
;; (if (featurep 'python)
;;     (unload-feature 'python))

;; enable python-mode.el from elpa
(autoload 'python-mode "python-mode" "Python editing mode." t)
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(setq interpreter-mode-alist (cons '("python" . python-mode) interpreter-mode-alist))

;; need to load this after autoload commands to get py-shell
(require 'aprl-utils)
(setq py-install-directory (aprl-search-package 'python "~/.emacs.d/site-lisp"))
(add-to-list 'load-path py-install-directory)
(load (path-join py-install-directory "python-mode.el"))

;;_ . hook
(add-hook 'python-mode-hook 
	  '(lambda () 
	     (local-set-key (kbd "C-c z") 'py-oschdir)
	     (local-set-key (kbd "C-c C-j") 'py-execute-line)
	     (local-set-key (kbd "C-c C-p") 'py-execute-paragraph)
	     (local-set-key (kbd "<C-return>") 'py-execute-region)))

;;_ . functions
(defun py-mark-line ()
  (interactive)
  (end-of-line)
  (push-mark (point))
  (beginning-of-line)
  (exchange-point-and-mark)
  (py-keep-region-active))
(defun py-execute-line (&optional async)
  (interactive "P")
  (save-excursion
    (py-mark-line)
    (py-execute-region (mark) (point) async)))
(defun py-mark-paragraph ()
  (interactive)
  (forward-paragraph)
  (push-mark (point))
  (backward-paragraph)
  (exchange-point-and-mark)
  (py-keep-region-active))
(defun py-execute-paragraph (&optional async)
  (interactive "P")
  (save-excursion
    (py-mark-paragraph)
    (py-execute-region (mark) (point) async))
  (forward-paragraph)) ;; appended 15/08/2012
(defun py-oschdir ()
  (interactive)
  (let ((txt (format "import os; os.chdir(\"%s\")" 
		     (file-name-directory (buffer-file-name)))))
    (save-window-excursion
      (with-temp-buffer
	(insert txt)
	(py-execute-buffer)))))

;;;_ . set variables and custom variables

; http://www.jesshamrick.com/2012/09/18/emacs-as-a-python-ide/
(customize-save-variable 'py-shell-switch-buffers-on-execute nil)
(setq py-switch-buffers-on-execute-p nil)
; split windows
(setq py-split-windows-on-execute-p t)
; try to automagically figure out indentation
(customize-save-variable 'py-smart-indentation t)

;; (customize-save-variable 'py-python-command-args 
;; 			 '("--pylab"))
;; (customize-save-variable 'py-python-command-args
;; 			 '("--gui=wx" "--pylab=wx" "-colors" "Linux"))


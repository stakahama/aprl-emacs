;;;_* ===== Shell-mode =====

(require 'shell)
(define-key minibuffer-local-map (kbd "C-i") 'comint-dynamic-complete)
(add-hook 'shell-mode-hook
	  '(lambda()
	     (local-set-key (kbd "C-c p") 'copy-pwd)
	     (local-set-key (kbd "C-c c") (shell-mode-change-directory))
	     (local-set-key (kbd "C-c d") 'dirs)
	     (local-set-key (kbd "C-c l") 'clear-shell)))
(add-hook 'eshell-mode-hook
	  '(lambda()
	     (local-set-key (kbd "C-c p") 'copy-pwd)
	     (local-set-key (kbd "C-c c") (shell-mode-change-directory))))

(defun shell-mode-change-directory (&optional arg)
  (lexical-let (send-input-fn)
    (setq arg (if arg arg major-mode))
    (setq send-input-fn
	  (if (eq arg 'shell-mode)
	      'comint-send-input
	    (if (eq arg 'eshell-mode)
		'eshell-send-input
	      (if (eq arg 'term-mode)
		  'term-send-input))))
  (lambda (&optional arg)
    (interactive "P")
    (goto-char (point-max))
    (insert (concat "cd " (copy-pwd arg)))
    (eval (list send-input-fn)))))

(when (eq system-type 'cygwin)
  (defun cygwin-shell ()
    "Run cygwin bash in shell mode."
    (interactive)
    (let ((explicit-shell-file-name "C:/cygwin/bin/bash"))
      (call-interactively 'shell)))
  (add-to-list 'explicit-bash-args "--login"))

(defun clear-shell ()
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))

;;;_ . --- custom variables ---

(customize-save-variable 'explicit-shell-file-name "/bin/bash")

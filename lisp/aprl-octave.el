
(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))
;; (setq auto-mode-alist (cons '("\\.m$" . octave-mode) auto-mode-alist))

(add-hook 'octave-mode-hook
	  '(lambda ()
	     (local-set-key (kbd "C-c C-j") 'octave-send-line)
	     (local-set-key (kbd "C-c C-p") 'octave-send-block)
	     (local-set-key (kbd "<C-return>") 'octave-send-region)
	     (local-set-key (kbd "C-c !") 'run-octave)
	     (setq comment-start "% "
		   commend-end "")))


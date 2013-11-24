;;_* ===== markdown-mode =====
(load (path-join (aprl-search-package 'markdown-mode "~/.emacs.d/site-lisp") 
		 "markdown-mode"))
(setq auto-mode-alist (cons '("\\.md$" . markdown-mode) auto-mode-alist))

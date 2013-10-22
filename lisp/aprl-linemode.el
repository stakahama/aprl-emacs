;;;_* ===== Line wrapping =====

(if (>= emacs-version-number 23)
    (progn
      ;; Emacs 23.1
      ;; Visual-line-mode
      (global-visual-line-mode -1)
      (add-hook 'text-mode-hook '(lambda () (visual-line-mode 1)))
      (add-hook 'LaTeX-mode-hook '(lambda () (visual-line-mode 1)))
      (add-hook 'PDFLaTeX-mode-hook '(lambda () (visual-line-mode 1))))
  (progn
    ;; Enable longlines mode
    (add-hook 'text-mode-hook 'longlines-mode)
    (add-hook 'latex-mode-hook 'longlines-mode)
    (add-hook 'latex-mode-hook
	      '(lambda () (setq longlines-wrap-follows-window-size t)))))

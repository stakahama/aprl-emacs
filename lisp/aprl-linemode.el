;;;_* ===== Line wrapping =====

(defadvice toggle-truncate-lines (before toggle-truncate-lines-switch-visual-line disable)
  (cond ((and (not truncate-lines)
	      visual-line-mode)
	 (visual-line-mode -1))
	((and truncate-lines
	      (member major-mode '(text-mode tex-mode latex-mode csv-mode org-mode))
	      (not visual-line-mode))
	 (visual-line-mode))))

(if (>= emacs-major-version 23)
    (progn
      ;; Emacs 23.1
      ;; Visual-line-mode
      (global-visual-line-mode -1)
      (add-hook 'text-mode-hook '(lambda () (visual-line-mode 1)))
      (add-hook 'LaTeX-mode-hook '(lambda () (visual-line-mode 1)))
      ;; (add-hook 'PDFLaTeX-mode-hook '(lambda () (visual-line-mode 1)))
      ;; switch off for toggle-truncate-lines
      (ad-enable-advice 'toggle-truncate-lines 'before 'toggle-truncate-lines-switch-visual-line)
      (ad-activate 'toggle-truncate-lines))
  (progn
    ;; Enable longlines mode
    (add-hook 'text-mode-hook 'longlines-mode)
    (add-hook 'latex-mode-hook 'longlines-mode)
    (add-hook 'latex-mode-hook
	      '(lambda () (setq longlines-wrap-follows-window-size t)))))

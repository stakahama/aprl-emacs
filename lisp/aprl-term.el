;;;_* ===== term-mode =====

(defun ash-term-hooks ()
  (setq term-default-bg-color (face-background 'default))
  (setq term-default-fg-color (face-foreground 'default)))
(defun term-colors-emacswiki ()
  (setq term-default-bg-color (face-background 'default))
  (setq term-default-fg-color "#dddd00"))
;; (add-hook 'term-mode-hook 'ash-term-hooks)
(add-hook 'term-mode-hook 'term-colors-emacswiki)

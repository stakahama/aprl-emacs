;;;_* ===== CUA mode =====
(if (>= emacs-major-version 23)
    (cua-mode -1))
(customize-save-variable 'cua-delete-selection nil)
(customize-save-variable 'cua-enable-cua-keys nil)

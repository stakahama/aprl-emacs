;;;_* ===== CUA mode =====
(if (>= emacs-major-version 23)
    (cua-mode -1))
(setq-default cua-delete-selection nil) ;custom
(setq-default cua-enable-cua-keys nil) ;custom

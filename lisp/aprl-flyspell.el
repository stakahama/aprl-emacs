;;;_* ===== Flyspell mode =====

(if (eq system-name 'windows)
    (setq-default ispell-program-name "aspell"))
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)

;;;_ . --- custom variables ---

(customize-set-variable flyspell-issue-message-flag nil)

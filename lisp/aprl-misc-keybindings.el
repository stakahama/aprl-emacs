;;;_* global key bindings

;;;_ . rebindings
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-DEL") 'backward-kill-word)

;;;_ . keybindings
(global-set-key (kbd "C-c m") 'execute-extended-command)
(global-set-key (kbd "C-c &") 'auto-revert-mode)
(global-set-key (kbd "C-c t") 'toggle-truncate-lines)
(global-set-key (kbd "C-c ;") 'comment-region)
(global-set-key (kbd "C-<tab>") 'other-window)
(global-set-key (kbd "C-c q") 'delete-other-windows-vertically)


;;;_* ===== ns settings =====

;;;_ . --- functions ---
(defun ns-command-as-meta ()
  (interactive)
  (setq ns-command-modifier 'meta))
(defun ns-command-as-control ()
  (interactive)
  (setq ns-command-modifier 'control))

;;;_ . --- key bindings ---
(ns-command-as-meta)

;;;_ . --- unset ns-keys ---
(global-unset-key (kbd "s-p")) 
(global-unset-key (kbd "s-q")) 
(global-unset-key (kbd "s-w")) 
(global-unset-key (kbd "s-t")) 

;;;_ --- custom variables ---

(customize-save-variable 'ns-command-modifier (quote control))

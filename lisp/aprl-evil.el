
(require 'evil)
(global-undo-tree-mode -1)
(define-key evil-motion-state-map (kbd "C-o") 'evil-execute-in-normal-state)
(define-key evil-motion-state-map "j" #'evil-next-visual-line)
(define-key evil-motion-state-map "k" #'evil-previous-visual-line)
(define-key evil-motion-state-map "$" #'evil-end-of-visual-line)
(define-key evil-motion-state-map "^" #'evil-first-non-blank-of-visual-line)
(define-key evil-motion-state-map "0" #'evil-beginning-of-visual-line)

;;http://stackoverflow.com/questions/10569165/how-to-map-jj-to-esc-in-emacs-evil-mode
;;Exit insert mode by pressing j and then k quickly
(require 'key-chord)
(setq key-chord-two-keys-delay 0.5)
(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)
(key-chord-mode 1)

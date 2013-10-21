;;;_* ===== libraries =====

(require 'cl)
(require 'find-lisp)

;;;_* ===== settings =====

(if (< emacs-major-version 23)
    (transient-mark-mode t))
(setq delete-active-region nil)
(delete-selection-mode -1)
(normal-erase-is-backspace-mode 0)
(show-paren-mode 1)
(setq ring-bell-function 'ignore)
(blink-cursor-mode -1)
(setq inhibit-splash-screen t)
(setq line-number-mode t)
(setq column-number-mode t)
(mouse-wheel-mode t)			; activate mouse scrolling
(global-font-lock-mode t)		; syntax highlighting
(tool-bar-mode -1)
(setq initial-scratch-message nil)
;; (setq initial-scratch-message nil)
(fset 'yes-or-no-p 'y-or-n-p)
;; (setq show-paren-delay 0.0)
;; (setq visible-bell t)
;; (require 's-region)
(when (eq system-type 'gnu/linux)
  ;; make emacs use the clipboard
  (setq x-select-enable-clipboard t)
  (setq interprogram-paste-function 'x-cut-buffer-or-selection-value))

;;;_* ===== search highlight =====
(setq search-highlight           t) ; Highlight search object
(setq query-replace-highlight    t) ; Highlight query object
(setq mouse-sel-retain-highlight t) ; Keep mouse highlighting

;;;_* ===== buffer management =====
;;;_ . --- ibuffer ---
(autoload 'ibuffer "ibuffer" "List buffers." t)

;;;_ . --- uniquify ---
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;;;_* ===== dired =====

;;;_ . --- dired customizations ---
(setq dired-listing-switches "-alhF")

;;;_ . --- use ls-lisp on OS X and Windows ---
(when (or (eq system-type 'darwin))
  (require 'ls-lisp)
  (setq ls-lisp-use-insert-directory-program nil))

;;;_ . --- buffer name ends in slash ---

(defun ensure-buffer-name-ends-in-slash ()
  "change buffer name to end with slash" ; author: Trey Jackson
  (let ((name (buffer-name)))
    (if (not (string-match "/$" name))
        (rename-buffer (concat name "/") t))))

(add-hook 'dired-mode-hook 'ensure-buffer-name-ends-in-slash)

;;;_* ===== line wrapping =====

(if (>= emacs-major-version 23)
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

;;;_* ===== tramp-mode =====

(setq tramp-default-method "ssh")

;;;_* ===== custom variables =====

(setq-default indicate-empty-lines t) ;custom
(setq-default pop-up-windows nil) ;custom
(setq-default warning-suppress-types (quote ((server)))) ;custom
(setq-default safe-local-variable-values (quote ((outline-minor-mode) (whitespace-style face tabs spaces trailing lines space-before-tab::space newline indentation::space empty space-after-tab::space space-mark tab-mark newline-mark)))) ;custom
(setq-default same-window-buffer-names (quote ("*shell*" "*shell*<2>" "*shell*<2>" "*shell*<3>" "*shell*<4>" "*shell*<5>" "*mail*" "*inferior-lisp*" "*ielm*" "*scheme*" "*Help*" "*Async Shell Command*" "*grep*" "*rgrep*" "*Directory*"))) ;custom


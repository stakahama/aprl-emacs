
;;------------------------------------------------------------------------------
;;
;;    This file is part of aprl-emacs.
;;    
;;    aprl-emacs is free software: you can redistribute it and/or modify
;;    it under the terms of the GNU General Public License as published by
;;    the Free Software Foundation, either version 3 of the License, or
;;    (at your option) any later version.
;;    
;;    aprl-emacs is distributed in the hope that it will be useful,
;;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;    GNU General Public License for more details.
;;    
;;    You should have received a copy of the GNU General Public License
;;    along with aprl-emacs.  If not, see <http://www.gnu.org/licenses/>.
;;
;;------------------------------------------------------------------------------


;;;_* ===== Multi-term=====


;;Elscreen has to be loaded first, or will have conflicts(?)
;;http://emacs-fu.blogspot.com/2009/07/keeping-related-buffers-together-with.html
;;comments section

;;;_ . load

(require 'multi-term)
(setq multi-term-program "/bin/bash")
;; (setq term-term-name "xterm-color")
(defalias 'mterm 'multi-term)
(defalias 'mtn 'multi-term-next)

;;;_ . custom set 1

(defun term-mode-change-directory ())
(fset 'term-mode-change-directory (shell-mode-change-directory 'term-mode))

;;http://code.google.com/p/dea/source/browse/trunk/my-lisps/multi-term-settings.el
(defun term-my-send-kill-line ()
  "Kill line in term mode."
  (interactive)
  (call-interactively 'kill-line)
  (term-send-raw-string "\C-k"))

(defun term-my-send-yank ()
  "Yank in term mode."
  (interactive)
  (yank)
  (term-send-raw-string (current-kill 0)))

(defun term-my-send-backward-kill-word ()
  (interactive)
  (term-send-raw-string "\e\C-H"))

(defun term-my-send-undo ()
  (interactive)
  (term-send-raw-string "\C-_"))

(let ((termkeys '(("M-DEL"		.	term-my-send-backward-kill-word)
		  ("C-<backspace>"	.	term-my-send-backward-kill-word)
		  ("M-d"		.	term-send-forward-kill-word)
		  ("C-c C-j"		.	term-line-mode)
		  ("C-c C-k"		.	term-char-mode)
		  ("C-c C-c"		.	term-stop-subjob)
		  ("C-x u"              .       term-my-send-undo)
		  ;; ("C-z"             . term-stop-subjob)
		  ("C-k" 		.       term-my-send-kill-line) ;; was (term-send-raw) by default
		  ("C-y" 		.       term-my-send-yank)
		  ("C-c c"		.	term-mode-change-directory))))
  (dolist (elem termkeys nil)
    (add-to-list 'term-bind-key-alist elem)))

;;;_ . custom set 2

;;http://www.reddit.com/r/emacs/comments/mdxdn/help_me_make_multiterm_more_like_shell_or_eshell/

;; (eval-after-load "multi-term"
;;   (progn
;;     (defun term-send-quote ()
;;       (interactive)
;;       (term-send-raw-string "\C-v"))

;;     (defun term-send-M-x ()
;;       (interactive)
;;       (term-send-raw-string "\ex"))

;;     (defun term-send-backward-kill-word ()
;;       (interactive)
;;       (term-send-raw-string "\C-H"))

;;     (dolist
;; 	(bind '(("C-<right>"     . term-send-forward-word)
;; 		("C-<left>"      . term-send-backward-word)
;; 		("C-<backspace>" . term-send-backward-kill-word)
;; 		("C-<delete>"    . term-send-forward-kill-word)
;; 		("C-k"           . term-send-raw)
;; 		("C-y"           . term-send-raw)
;; 		("C-c C-z"       . term-stop-subjob)
;; 		("C-z"           . term-stop-subjob)))
;;       (add-to-list 'term-bind-key-alist bind))))

;;;_ . customize
(setq-default term-default-bg-color "#000000") ; background color (black)
(setq-default term-default-fg-color "#dddd00") ; foreground color (yellow)


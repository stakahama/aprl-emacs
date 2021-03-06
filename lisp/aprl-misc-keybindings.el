
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


;;;_* global key bindings


;;;_ . rebindings
(global-set-key (kbd "C-x C-b") 'ibuffer)
(global-set-key (kbd "M-DEL") 'backward-kill-word)
(global-set-key (kbd "M-/") 'hippie-expand)		;; built-in

;;;_ . keybindings
(global-set-key (kbd "C-c m") 'execute-extended-command)
(global-set-key (kbd "C-c &") 'auto-revert-mode)
(global-set-key (kbd "C-c t") 'toggle-truncate-lines)
(global-set-key (kbd "C-c ;") 'comment-region)
(global-set-key (kbd "C-<tab>") 'other-window)
(global-set-key (kbd "C-c q") 'delete-other-windows-vertically)


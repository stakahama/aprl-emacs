
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


;;;_* ===== term-mode =====


(defun ash-term-hooks ()
  (setq term-default-bg-color (face-background 'default))
  (setq term-default-fg-color (face-foreground 'default)))
(defun term-colors-emacswiki ()
  (setq term-default-bg-color (face-background 'default))
  (setq term-default-fg-color "#dddd00"))
;; (add-hook 'term-mode-hook 'ash-term-hooks)
(add-hook 'term-mode-hook 'term-colors-emacswiki)

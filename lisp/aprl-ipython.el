
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


;;_* ===== iPython =====

(load (aprl-path-join (aprl-search-package 'ipython "~/.emacs.d/site-lisp") "ipython"))
;; (require 'ipython)
;; (when (eq system-type 'darwin)
;;   (setq ipython-command "/opt/local/bin/ipython"))

; use IPython (from http://www.jesshamrick.com/2012/09/18/emacs-as-a-python-ide/)
(setq-default py-shell-name "ipython")
(setq-default py-which-bufname "IPython")
; use the wx backend, for both mayavi and matplotlib
(setq py-force-py-shell-name-p t)

;;_ . clear screen
(defun comint-clear-screen ()
  (interactive)
  (let ((comint-buffer-maximum-size 0))
    (comint-truncate-buffer)))

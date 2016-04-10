
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


;; installed from https://github.com/shosti/elscreen

;;   not in MELPA repo as advertised

;;;_* --- load ---
(add-to-list 'load-path (aprl-search-package 'elscreen "~/.emacs.d/site-lisp"))
(load "elscreen" "ElScreen" t)
(elscreen-start) ;new requirement

;;;_* --- key bindings ---
(define-key elscreen-map "r" 'elscreen-reset)

;;;_* ... functions ---
(defun elscreen-reset ()
  "Cycles through screens so that window configurations are reset (prevents flashing from redraw-frame[?] after each keystroke)"
  (interactive)
  ;; only happens when number of screens > 1
  (when (> (elscreen-get-number-of-screens) 1)
    (let* ((screen-list (elscreen-get-screen-list))
	   (current-screen (elscreen-get-current-screen))
	   (screen-seq (append (delq current-screen screen-list)
			       (list current-screen))))
      (mapc 'elscreen-goto screen-seq))))

(defadvice set-frame-size (after elscreen-set-frame-size activate)
  (elscreen-reset))

;; (defadvice toggle-fullscreen (after elscreen-toggle-fullscreen activate)
;;   (elscreen-reset))

;; (let ()
;;   (ad-disable-advice 'set-frame-size 'after 'elscreen-set-frame-size)
;;   (ad-activate 'set-frame-size))

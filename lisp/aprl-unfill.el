
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


;;;_* keybindings


;;;_ . rebindings
(global-set-key "\M-q" 'fill-or-unfill-paragraph)

;;;_* functions
(defun fill-or-unfill-paragraph (&optional justify region)
  "Fill paragraph at or after point (see `fill-paragraph').
   Does nothing if `visual-line-mode' is on.
   From http://stackoverflow.com/questions/1416171/emacs-visual-line-mode-and-fill-paragraph"
  (interactive (progn
         (barf-if-buffer-read-only)
         (list (if current-prefix-arg 'full) t)))
  (if visual-line-mode
      (unfill-paragraph)
    (fill-paragraph justify region)))

(defun unfill-buffer ()
  "Undo filling for all paragraphs."
  (interactive)
  (goto-char (point-min))
  (let ((fill-column 99999))
    (fill-paragraph nil)
    (while (< (point) (point-max))
      (forward-paragraph)
      (fill-paragraph nil))))

(defun unfill-paragraph ()
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

(defun unwrap-line ()
  "Remove all newlines until we get to two consecutive ones.
Or until we reach the end of the buffer.
Great for unwrapping quotes before sending them on IRC."
  (interactive)
  (let ((start (point))
        (end (copy-marker (or (search-forward "\n\n" nil t)
                              (point-max))))
        (fill-column (point-max)))
    (fill-region start end)
    (goto-char end)
    (newline)
    (goto-char start)))

;; http://xahlee.org/emacs/elisp_examples.html
(defun remove-line-breaks ()
  "Remove line endings in a paragraph."
  (interactive)
  (let ((fill-column (point-max)))
    (fill-paragraph nil)))

;; mine

(defun maybe-fill-paragraph (&optional justify region)
  "Fill paragraph at or after point (see `fill-paragraph').
   Does nothing if `visual-line-mode' is on.
   From http://stackoverflow.com/questions/1416171/emacs-visual-line-mode-and-fill-paragraph"
  (interactive (progn
         (barf-if-buffer-read-only)
         (list (if current-prefix-arg 'full) t)))
  (or visual-line-mode
      (fill-paragraph justify region)))


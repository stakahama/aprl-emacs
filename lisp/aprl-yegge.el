
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


;;;_* --- keybindings ---


(global-set-key (kbd "C-x W") 'rename-file-and-buffer)

;;;_* --- functions ---
;; source: http://steve.yegge.googlepages.com/my-dot-emacs-file
(defun rename-file-and-buffer (new-name)
  "Renames both current buffer and file it's visiting to NEW-NAME."
  (interactive "sNew name: ")
  (let ((name (buffer-name))
    (filename (buffer-file-name)))
    (if (not filename)
    (message "Buffer '%s' is not visiting a file!" name)
      (if (get-buffer new-name)
      (message "A buffer named '%s' already exists!" new-name)
    (progn
      (rename-file name new-name 1)
      (rename-buffer new-name)
      (set-visited-file-name new-name)
      (set-buffer-modified-p nil))))))

(defun move-buffer-file (dir)
 "Moves both current buffer and file it's visiting to DIR." 
 (interactive "DNew directory: ")
 (let* ((name (buffer-name))
	(filename (buffer-file-name))
	(dir
	 (if (string-match dir "\\(?:/\\|\\\\)$")
	     (substring dir 0 -1) dir))
	(newname (concat dir "/" name)))

   (if (not filename)
       (message "Buffer '%s' is not visiting a file!" name)
     (progn 	
       (copy-file filename newname 1) 	
       (delete-file filename) 	
       (set-visited-file-name newname) 	
       (set-buffer-modified-p nil) 
       t))))

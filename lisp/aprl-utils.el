
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


(require 'cl)


(defun path-join (dirname filename)
  (concat (file-name-as-directory dirname) filename))

(defun aprl-search-package (package-symb package-directory)
  (let ((package-name (symbol-name package-symb))
	var out)
    (dolist (var (directory-files package-directory) out)
      (if (search package-name var)
	  (setq out var)))
    (if out
	(path-join package-directory out)
      nil)))

(provide 'aprl-utils)

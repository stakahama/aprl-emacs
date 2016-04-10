
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


;; required for finding cygwin executables

;; http://stackoverflow.com/questions/9167614/python-mode-in-emacs-no-such-file-or-directory-pdb
(when (eq system-type 'cygwin)
  (setenv "PATH" (concat "/usr/bin:" (getenv "PATH")))
  (setq exec-path (split-string (getenv "PATH") path-separator)))

;; required by ESS
(when (and (or (eq system-type 'cygwin)
	       (eq system-type 'windows-nt))
	   (not (fboundp 'w32-short-file-name)))
  (fset 'w32-short-file-name 'identity))

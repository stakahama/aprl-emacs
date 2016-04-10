
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


;;;_* ===== Fortran =====


(add-hook 'fortran-mode-hook
	  '(lambda() (linum-mode 1)))
(add-hook 'f90-mode-hook
	  '(lambda() 
	     (linum-mode 1)
	     (toggle-truncate-lines 1)))

;;;_* ===== GDB =====

'(gdb-many-windows t)
'(gdb-show-main t)



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


;; package manager

(require 'package)
(package-initialize)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
;(add-to-list 'package-archives '("elpy" . "http://jorgenschaefer.github.io/packages/" t))


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




(add-to-list 'auto-mode-alist '("\\.m$" . octave-mode))
;; (setq auto-mode-alist (cons '("\\.m$" . octave-mode) auto-mode-alist))

(add-hook 'octave-mode-hook
	  '(lambda ()
	     (local-set-key (kbd "C-c C-j") 'octave-send-line)
	     (local-set-key (kbd "C-c C-p") 'octave-send-block)
	     (local-set-key (kbd "<C-return>") 'octave-send-region)
	     (local-set-key (kbd "C-c ;") 'comment-region)
	     (local-set-key (kbd "C-c !") 'run-octave)
	     (setq comment-start "% "
		   commend-end "")))


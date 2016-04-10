
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


;;;_* ===== ido mode =====


(if (>= emacs-major-version 22)
    (progn
      (require 'ido)
      (ido-mode t)
      ;; (setq confirm-nonexistent-file-or-buffer nil)
      (add-hook 'ibuffer-mode-hook
		(lambda ()
		  (define-key ibuffer-mode-map [remap ibuffer-visit-buffer] 
		    'ibuffer-like-ido-visit-buffer)
		  (define-key ibuffer-mode-map [remap ibuffer-find-file]
		    'ido-find-file))) ;; added 3/8/2012
      ;; make ibuffer like ido-mode
      (defun ibuffer-like-ido-visit-buffer (&optional single)
	"Visit the buffer on this line.
If optional argument SINGLE is non-nil, then also ensure there is only
one window."
	(interactive "P")
	(let ((buf (ibuffer-current-buffer t)))
	  (bury-buffer (current-buffer))
	  (ido-visit-buffer buf ido-default-buffer-method)
	  (when single
	    (delete-other-windows)))))
  (progn
    (iswitchb-mode t)
    (icomplete-mode t)))

;;;_ . keybindings

(global-set-key (kbd "C-c f") 'ido-find-file-other-frame)
(global-set-key (kbd "C-c b") 'ido-switch-buffer-other-frame)

;;;_ . custom-set-variables

(setq-default ido-enable-flex-matching t) ;custom
(setq-default ido-enable-last-directory-history nil) ;custom
(setq-default ido-max-work-directory-list 0) ;custom
(setq-default ido-max-work-file-list 0) ;custom
(setq-default ido-record-commands nil) ;custom
(setq-default ido-save-directory-list-file nil) ;custom
(setq ido-auto-merge-work-directories-length -1) ; custom

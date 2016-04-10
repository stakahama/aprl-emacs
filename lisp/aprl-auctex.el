
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


;;;_* ===== AUCTeX =====


;;;_ . Load AUCTeX and preview-latex.
(require 'tex)
(require 'preview)
(if (eq system-type 'windows)
    (require 'tex-mik))

;; Minimal OS X-friendly configuration of AUCTeX. Since there is no
;; DVI viewer for the platform, use pdftex/pdflatex by default for
;; compilation. Furthermore, use 'open' to view the resulting PDF.
;; Until Preview learns to refresh automatically on file updates, Skim
;; (http://skim-app.sourceforge.net) is a nice PDF viewer.
(setq TeX-PDF-mode t)
(setq TeX-output-view-style
      '(("^dvi$" "^xdvi$" "xdvi %dS %d")
	("^dvi$" "." "open %dS %d")
	;;("^pdf$" "." "open %o")
	("^pdf$" "." "open -a \"Preview\" %o")
	("^html?$" "." "open %o")))

;; Add standard Sweave file extensions to the list of files recognized
;; by AUCTeX.
(setq TeX-file-extensions
      '("Snw" "Rnw" "snw" "rnw" "tex" "sty" "cls" "ltx" "texi" "texinfo" "dtx"))

;;;_ . functions

(require 'aprl-latex)

;;;_ . hooks

(setq TeX-mode-hook '(lambda ()
		       (local-set-key (kbd "C-c e") 
				      (LaTeX-enclose-expression "$"))
		       (local-set-key (kbd "C-c r")
				      'LaTeX-wrap-environment-around-thing-or-region)
		       (local-set-key (kbd "C-c j") 
				      'LaTeX-insert-item-no-newline)))

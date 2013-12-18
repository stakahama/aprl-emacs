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

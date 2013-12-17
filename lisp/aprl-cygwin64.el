;;http://stackoverflow.com/questions/9167614/python-mode-in-emacs-no-such-file-or-directory-pdb
(when (eq system-type 'cygwin)
  (setenv "PATH" (concat "/usr/bin:" (getenv "PATH")))
  (setq exec-path (split-string (getenv "PATH") path-separator)))

;;https://stat.ethz.ch/pipermail/ess-help/2004-August/002010.html
(when (or (eq system-type 'cygwin)
	  (eq system-type 'windows-nt))
  (defun w32-short-file-name (x)
    "Placeholder for use with Xemacs.
The real function in Emacs returns the short file name version (8.3) of
the full path of FILENAME. This placeholder version returns its argument."
    x))

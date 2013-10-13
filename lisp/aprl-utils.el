(defun path-join (dirname filename)
  (concat (file-name-as-directory dirname) filename))

(defun aprl-search-package (package-symb package-directory)
  (let ((package-name (symbol-name package-symb))
	var out)
    (dolist (var (directory-files package-directory) out)
      (if (search package-name var)
	  (setq out var)))
    (path-join package-directory out)))

(provide 'aprl-utils)

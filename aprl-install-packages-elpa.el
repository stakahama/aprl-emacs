;#!/usr/bin/emacs --script

(if (< emacs-major-version 24)
    (error "no package manager"))

;;;_* load the package manager; add repos
(load "~/.emacs.d/aprl/lisp/aprl-elpa")

;;;_* set global var
(setq aprl-package-directory "~/.emacs.d/elpa")
(setq aprl-desired-packages '(python-mode ipython ess auctex))

;;;_* define functions

(load "~/.emacs.d/aprl/lisp/aprl-utils")

(defun aprl-package-install-conditional (package-symb)
  ;; aprl-package-directory is dynamically-scoped
  (if (not (aprl-search-package package-symb aprl-package-directory))
      (package-install package-symb)))

(defun aprl-package-cons (package-symb)
  ;; aprl-package-directory is dynamically-scoped
  ;; returns a cons cell
  (cons package-name (aprl-search-package package-symb aprl-package-directory))

(path-join aprl-package-directory out))))

;;;_* install
;; (mapc 'package-install '(python-mode ipython ess))
(mapc 'aprl-package-install-conditional aprl-desired-packages)

;;;_* create alist of packages
(setq aprl-package-alist
      (mapcar 'aprl-package-cons aprl-desired-packages))

;;;;_* write to file
(with-temp-file "~/.emacs.d/aprl/aprl-package-elpa-alist.el"
  (insert "(setq aprl-package-elpa-alist '(")
  (let ((count 0) var)
    (dolist (var aprl-package-alist)
      (when (> count 0)
	(insert "\n"))
      (when (cdr var)
	(insert (format "(\"%s\" . \"%s\")" (car var) (cdr var)))
	(setq count (1+ count)))))
  (insert ")"))

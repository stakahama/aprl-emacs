#!/usr/bin/emacs --script

(if (< emacs-major-version 24)
    (error "no package manager"))

;;;_* set global var
(setq aprl-package-directory "~/.emacs.d/elpa")
(setq aprl-desired-packages '(ess auctex))

;;;_* load the package manager (add repos); define additional functions
(load "~/.emacs.d/aprl/lisp/aprl-elpa")
(load "~/.emacs.d/aprl/lisp/aprl-utils")

;;;_* define functions

(defun aprl-package-install-conditional (package-symb)
  ;; aprl-package-directory is dynamically-scoped
  (if (not (aprl-search-package package-symb aprl-package-directory))
      (package-install package-symb)))

(defun aprl-package-cons (package-symb)
  ;; aprl-package-directory is dynamically-scoped
  ;; returns a cons cell
  (let ((package-name (symbol-name package-symb))
	(full-path (aprl-search-package package-symb aprl-package-directory)))
    (cons package-name full-path)))

;;;_* create directory

(when (not (file-exists-p aprl-package-directory))
  (mkdir aprl-package-directory))

;;;_* install

;; (mapc 'package-install '(python-mode ipython ess))
(list-packages)
(mapc 'aprl-package-install-conditional aprl-desired-packages)

;;;_* create alist of packages
(setq aprl-package-alist
      (mapcar 'aprl-package-cons aprl-desired-packages))

;;;;_* write to file
;; (with-temp-file "~/.emacs.d/aprl/aprl-package-elpa-alist.el"
;;   (insert "(setq aprl-package-elpa-alist '(")
;;   (let ((count 0) var)
;;     (dolist (var aprl-package-alist)
;;       (when (> count 0)
;; 	(insert "\n"))
;;       (when (cdr var)
;; 	(insert (format "(\"%s\" . \"%s\")" (car var) (cdr var)))
;; 	(setq count (1+ count)))))
;;   (insert ")"))

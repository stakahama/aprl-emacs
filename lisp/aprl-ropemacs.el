
(add-to-list 'load-path (aprl-search-package 'ropemacs "~/.emacs.d/site-lisp"))
(add-to-list 'load-path (aprl-search-package 'Pymacs "~/.emacs.d/site-lisp"))

;; from http://www.jesshamrick.com/2012/09/18/emacs-as-a-python-ide/
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(autoload 'pymacs-autoload "pymacs")

(require 'pymacs)
(pymacs-load "ropemacs" "rope-")

# Emacs configuration for APRL members

[TOC]

First, download the emacs configuration files, then create a local file which calls the specific libraries.

## Download configuration files


Clone `aprl-emacs` repository to `~/.emacs.d/aprl`:

```sh
$ git clone https://github.com/stakahama/aprl-emacs ~/.emacs.d/aprl
```

## Install packages


The default installation directory for the Emacs Lisp Package Archive (ELPA) is `~/.emacs.d/elpa/`. A suggested location for packages installed individually is `~/.emacs.d/site-lisp/`.

### ELPA

Install ESS and AUCTeX through ELPA.
```sh
$ cd ~/.emacs.d/aprl
$ emacs -Q --script aprl-install-packages-elpa.el
```
Some packages (or their latest versions) are not available through ELPA (even with additional repositories). This includes python-mode and ipython; see below.

### Python-mode


I use `python-mode.el` (not `python.el`, also known as "Loveshack Python" that comes with emacs). You can get the latest `python-mode.el` here: [https://launchpad.net/python-mode](https://launchpad.net/python-mode). Move the tar'ed directory to `~/.emacs.d/site-lisp/`. For instance, mine is `~/.emacs.d/site-lisp/python-mode.el-6.1.2/`. Alternatively, install from bzr and bytecompile:

```sh
$ mkdir ~/.emacs/site-lisp
$ cd ~/.emacs.d/site-lisp/
$ bzr branch lp:python-mode
$ emacs -Q--batch --eval '(byte-recompile-directory "python-mode" 0)'
```

[Optional] To use ipython as your interpretor, you also need `ipython.el`, which
you can get here:
[https://raw.github.com/ipython/ipython/master/docs/emacs/ipython.el](https://raw.github.com/ipython/ipython/master/docs/emacs/ipython.el). From the command line:

```sh
$ mkdir ~/.emacs.d/site-lisp/ipython && cd ~/.emacs.d/site-lisp/ipython
$ wget -c https://raw.github.com/ipython/ipython/master/docs/emacs/ipython.el
$ emacs -Q --batch -l python-mode/python-mode.el -f batch-byte-compile ipython.el
```

### Byte-compiling


To byte-compile everything in the `"~/.emacs.d/aprl/lisp"` (and/or `"~/.emacs.d/site-lisp"`) directory, evaluate this expression in the `*scratch*` buffer (replace with appropriate directory name):

```common-lisp
(let ((elisp-directory "~/.emacs.d/aprl/lisp") 
      (filename nil))
  (dolist (filename (cddr (directory-files elisp-directory t)))
    (if (file-directory-p filename) ;; is directory
	(byte-recompile-directory filename 0 t)
      (if (equal "el" (file-name-extension filename)) ;; is not directory and is an .el file
	  (byte-compile-file filename)))))
```	

Additional reading:

- [My notes on emacs keybindings and configuration specific to aprl-emacs](http://stakahama.github.io/resources/emacs/index.html)
- [Emacs as a Python IDE](http://www.jesshamrick.com/2012/09/18/emacs-as-a-python-ide/)


## APRL configuration


Create a file called `"~/.emacs.d/aprl-local.el` with the following contents (or similar; remove call to package configurations--e.g., `aprl-python.el` and `aprl-ipython.el`--if appropriate packages such as `python-mode` and `ipython.el` are not installed):

```common-lisp
;; -----------------------------------------------------------------------------
;; ELPA is required by several packages below
;; -----------------------------------------------------------------------------
;;
(require 'package)
(package-initialize) ; assuming not initialized in ~/.emacs
;;
;; -----------------------------------------------------------------------------
;; APRL configuration files
;; -----------------------------------------------------------------------------
;;
(add-to-list 'load-path "~/.emacs.d/aprl/lisp")
;;
;; -----------------------------------------------------------------------------
;; General settings
;; -----------------------------------------------------------------------------
;;
(load "aprl-misc-settings")
(load "aprl-misc-keybindings")
(load "aprl-misc-functions")
(load "aprl-autosaves")
(load "aprl-ido")
(load "aprl-org")
(load "aprl-fortran")
(load "aprl-shell")
(load "aprl-outline")
;;
;; -----------------------------------------------------------------------------
;; Find cygwin executables
;; -----------------------------------------------------------------------------
;;
;;(load "aprl-cygwin64") ;; need for cygwin64 packages
;;
;; -----------------------------------------------------------------------------
;; Packages from elpa
;; -----------------------------------------------------------------------------
;;
(load "aprl-ess")
(load "aprl-auctex")
;;
;; -----------------------------------------------------------------------------
;; Packages in site-lisp
;; -----------------------------------------------------------------------------
;;
;;(load "aprl-python")
;;(load "aprl-ipython")
;;(load "aprl-elscreen")
;;(load "aprl-folding")
;;(load "aprl-markdown")
;;
;; -----------------------------------------------------------------------------
;; Extra preferences (ST)
;; -----------------------------------------------------------------------------
;;
;;(load "aprl-frames")
(load "aprl-frames-resizing")
(load "aprl-buffers")
(load "aprl-cua")
(load "aprl-flyspell")
(load "aprl-ns")
(load "aprl-yegge")
(load "aprl-unfill")
(load "aprl-unsafechars")
;;
;; -----------------------------------------------------------------------------
```

To test only this configuration, suppress loading of usual `~/.emacs` and only load this file:

```sh
$ emacs -Q --load ~/.emacs.d/aprl-local.el &
```

If working, include a statement to load this file from `~/.emacs`. Using the command line:

```sh
$ echo '(load "~/.emacs.d/aprl-local")' >> ~/.emacs
```

## User-specific configuration (optional)

### Packages

Additional packages can be installed through ELPA (emacs-major-version >= 24) by calling `M-x package-list`. Further explanation on the package system described [here](http://ergoemacs.org/emacs/emacs_package_system.html "Xah Lee's guide to the package system"). You can add melpa and marmalade repos if desired (note that state of marmalade packages has mixed reviews):

```common-lisp
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
```

Some packages that may be worth considering (not in any particular order):

- `org` (if the one that comes with emacs is outdated)
- `markdown-mode` (markdown mode)
- `polymode` (for R markdown)
- `elscreen` (creates tabs to save multiple windows)
- `undo-tree` (undo tree; installed with evil)
- `octave-mode` (edit octave)
- `langtool` (grammar check utility using LanguageTool, which you have to install separately)
- `sr-speedbar` (adds directory navigation column to window)
- `json-mode` (read/edit JSON)
- `nxml` (edit HTML/XML files)
- `magit` (git revision control through emacs)
- `autopair` (pair braces)
- `sublimity` (for features like minimap from Sublime Text)
- `evil` (Vim emulation)
- `YASnippet` (templates)

In addition, there are other packages not available on these repositories. `el-get` may have them (more advanced), or you may have to download them from various repositories. A partial list:

- [`matlab-emacs`](http://matlab-emacs.sourceforge.net/)
- [`igor-mode`](https://github.com/yamad/igor-mode)
- [`folding`](http://www.emacswiki.org/emacs/FoldingMode)
- [`yaml-mode`](https://www.emacswiki.org/emacs/YamlMode)

and so on. Remember to byte-compile them. For example:

```sh
$ emacs -Q --batch -f batch-byte-compile folding/folding.el
```

### Color preferences

Note that use of [`deftheme`](http://batsov.com/articles/2012/02/19/color-theming-in-emacs-reloaded/) is preferred over `color-theme` for managing colors since Emacs 24, though once a theme is selected, it is more difficult to revert with the `deftheme` approach. Many color defthemes can be installed from MELPA.

### Configuration

Configuration for additional packages can be included in `~/.emacs`, or in a separate file as set up for `~/.emacs.d/aprl-local.el`. For instance, I have a file called `settings-local.el` such that my `~/.emacs` contents are:

```common-lisp
(load "~/.emacs.d/aprl-local")
(load "~/.emacs.d/settings-local")
```

My `settings-local.el` contains many additional configurations:

```common-lisp
;; -----------------------------------------------------------------------------
;; Paths
;; -----------------------------------------------------------------------------
;;
(setenv "PATH" (concat "/anaconda/bin:/opt/local/bin:" (getenv "PATH") ))
(setq exec-path (append '("/anaconda/bin") exec-path))
;;
;; -----------------------------------------------------------------------------
;; Font
;; -----------------------------------------------------------------------------
;;
(set-face-attribute 'default nil :family "Lucida Console" :height 120 :weight 'normal)
;;
;; -----------------------------------------------------------------------------
;; Color
;; -----------------------------------------------------------------------------
;;
(require 'flatland-theme)
;;
;; -----------------------------------------------------------------------------
;; Load dired+ only after color theme
;; -----------------------------------------------------------------------------
;;
(setq diredp-hide-details-initially-flag nil)
(require 'dired+)
;;
;; -----------------------------------------------------------------------------
;; Initial frame parameters for OS X
;; -----------------------------------------------------------------------------
;;
(load "aprl-osxframe-init")
(setq split-width-threshold nil)
(setq split-height-threshold nil)
;;
;; -----------------------------------------------------------------------------
;; Expand region
;; -----------------------------------------------------------------------------
;;
(require 'expand-region)
(global-set-key (kbd "C-=") 'er/expand-region)
;;
;; -----------------------------------------------------------------------------
;; Spell/grammar check
;; -----------------------------------------------------------------------------
;;
;; Ispell/Aspell
(setq ispell-program-name "/opt/local/bin/ispell")
;; LanguageTool
;; https://joelkuiper.eu/spellcheck_emacs
(require 'langtool)
(setq langtool-language-tool-jar "~/programs/LanguageTool/languagetool-commandline.jar"
      langtool-mother-tongue "en"
      langtool-disabled-rules '("WHITESPACE_RULE"
                                "EN_UNPAIRED_BRACKETS"
                                "COMMA_PARENTHESIS_WHITESPACE"
                                "EN_QUOTES"))
;;								
;; -----------------------------------------------------------------------------
;; Additional modes
;; -----------------------------------------------------------------------------
;;
;; YAML
(add-to-list 'load-path "~/.emacs.d/site-lisp/yaml-mode")
(require 'yaml-mode)
;; R markdown
(defun rmd-mode ()
  "ESS Markdown mode for rmd files"
  (interactive)
  (require 'poly-R)
  (require 'poly-markdown)     
  (poly-markdown+r-mode))
(add-to-list 'auto-mode-alist '("\\.Rmd\\'" . rmd-mode))
;; AUCTEX
;;
(load "aprl-auctex-2")
;;
;; -----------------------------------------------------------------------------
;; For evil-mode (experimenting)
;; -----------------------------------------------------------------------------
;;
;;takes over ctrl-z unless (defcustom evil-toggle-key "C-`") is set
(require 'evil) 
(define-key evil-motion-state-map (kbd "C-o") 'evil-execute-in-normal-state)
(define-key evil-motion-state-map "j" #'evil-next-visual-line)
(define-key evil-motion-state-map "k" #'evil-previous-visual-line)
(define-key evil-motion-state-map "$" #'evil-end-of-visual-line)
(define-key evil-motion-state-map "^" #'evil-first-non-blank-of-visual-line)
(define-key evil-motion-state-map "0" #'evil-beginning-of-visual-line)
;;
(when (featurep 'elscreen)
  (elscreen-set-prefix-key (kbd "C-,"))
  (add-hook 'org-mode-hook
            '(lambda ()
               (local-unset-key (kbd "C-,"))))) ; to avoid conflict with C-z
;;
```

## OS configurations

### Mac OS X

Note that `emacs` is nominally `/usr/bin/emacs`. For OS X, instead of the pre-installed version (terminal-only) I use the cocoa port of emacs, which is installed to `/Applications/Emacs.app/Contents/MacOS/Emacs`. You can create an alias in `~/.bash_profile` (and remember to `source ~/.bash_profile` or start a new shell for this to take effect):

```sh
alias emacs=/Applications/Emacs.app/Contents/MacOS/Emacs
```

### Cygwin emacs-w32


Create desktop (menu) shortcut as [described here](http://emacstragic.net/installing-emacs-in-cygwin/). With some modifications,

- Target: `%SystemDrive%\cygwin64\bin\run.exe /usr/bin/emacsclient -c -a /usr/bin/emacs`
- Start in: `%SystemDrive%\cygwin64\home\%USERNAME%`
- Icon: `%SystemDrive%\cygwin64\bin\emacs-w32.exe`

Note that `%SystemDrive%` is nominally `C:`.

Currently leaves `run.exe.stackdump` on desktop; doesn't seem to affect function but some suggestions for getting rid of this appears [here](http://stackoverflow.com/questions/4746187/why-my-emacs-in-cygwin-running-on-windows-seven-always-create-crash-dump).


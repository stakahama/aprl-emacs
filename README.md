Emacs configuration for APRL members
===

Download
---

Clone `aprl-emacs` repository to `~/.emacs.d/aprl`:

```sh
$ git clone http://bitbucket.org/stakahama/aprl-emacs ~/.emacs.d/aprl
```

Install packages
---

The default installation directory for the Emacs Lisp Package Archive (ELPA) is `~/.emacs.d/elpa/`. A suggested location for packages installed individually is `~/.emacs.d/site-lisp/`.

Install ESS, AUCTeX through the ELPA.
```sh
$ cd ~/.emacs.d/aprl
$ emacs -Q --script aprl-install-packages-elpa.el
```

Note that `emacs` is nominally `/usr/bin/emacs`. For OS X, instead of the pre-installed version (terminal-only) I use the cocoa port of emacs, which is installed to `/Applications/Emacs.app/Contents/MacOS/Emacs`. You can create an alias in `~/.bash_profile` (and remember to `source ~/.bash_profile` or start a new shell for this to take effect):

```sh
alias emacs=/Applications/Emacs.app/Contents/MacOS/Emacs
```

Some packages (or their latest versions) are not available through ELPA (even with additional repositories). This includes python-mode and ipython; see below.

Python-mode
---

I use `python-mode.el` (not `python.el`, also known as "Loveshack Python" that comes with emacs). You can get the latest `python-mode.el` here: [https://launchpad.net/python-mode](https://launchpad.net/python-mode). Move the tar'ed directory to `~/.emacs.d/site-lisp/`. For instance, mine is `~/.emacs.d/site-lisp/python-mode.el-6.1.2/`. Alternatively, install from bzr:

```sh
$ cd ~/.emacs.d/site-lisp/
$ bzr branch lp:python-mode
```

To use ipython as your interpretor, you also need `ipython.el`, which
you can get here:
[https://raw.github.com/ipython/ipython/master/docs/emacs/ipython.el](https://raw.github.com/ipython/ipython/master/docs/emacs/ipython.el). From the command line:

```sh
$ mkdir ~/.emacs.d/site-lisp/ipython && cd ~/.emacs.d/site-lisp/ipython
$ wget -c https://raw.github.com/ipython/ipython/master/docs/emacs/ipython.el
```

These files will not get byte-compiled automatically as with ELPA packages; they can be compiled from the command line:

```sh
$ cd ~/.emacs.d/site-lisp
$ emacs -q --batch --eval '(byte-recompile-directory "python-mode" 0)'
$ emacs -q --batch -l python-mode/python-mode.el -f batch-byte-compile ipython/ipython.el
```

Additional reading:

- [My notes on emacs keybindings and configuration specific to aprl-emacs](http://stakahama.github.io/resources/emacs/index.html)
- [Emacs as a Python IDE](http://www.jesshamrick.com/2012/09/18/emacs-as-a-python-ide/)

Configure
---

Create a file called `"~/.emacs.d/aprl-local.el` with the following contents (or similar):

```common-lisp
;; --- ELPA required by several packages below ---
(require 'package)
(package-initialize) ; assuming not initialized in ~/.emacs
;; --- load desired scripts ---
(add-to-list 'load-path "~/.emacs.d/aprl/lisp")
(load "aprl-misc-settings")
(load "aprl-misc-keybindings")
(load "aprl-misc-functions")
(load "aprl-autosaves")
(load "aprl-ido")
(load "aprl-org")
(load "aprl-python")
(load "aprl-ipython")
(load "aprl-ess")
(load "aprl-auctex")
(load "aprl-fortran")
(load "aprl-shell")
(load "aprl-outline")
;; --- extras (ST) uncomment if available ---
;;(load "aprl-frames")
;;(load "aprl-cua")
;;(load "aprl-flyspell")
;;(load "aprl-folding")
;;(load "aprl-ns")
;;(load "aprl-elscreen")
;;(load "aprl-yegge")
;;(load "aprl-unfill")
;;(load "aprl-unsafechars")
```

To test only this configuration, suppress loading of usual `~/.emacs` and load this file:

```sh
$ emacs -q --load ~/.emacs.d/aprl-local.el &
```

If working, include a statement to load this file from `~/.emacs`. Using the command line:

```sh
$ echo '(load "~/.emacs.d/aprl-local")' >> ~/.emacs
```

Extend (user-specific; optional)
---

Additional packages can be installed through ELPA (emacs-major-version >= 24) by calling `M-x package-list`. You can add melpa and marmalade repos if desired (note that state of marmalade packages has mixed reviews):

```common-lisp
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
```

Some packages that may be worth considering (not in any particular order):

- `org` (if the one that comes with emacs is outdated)
- `color-theme` (customize colors)
- `zenburn-theme` or `solarized-theme` (custom color themes)
- `tangotango-theme` (custom color theme)
- `langtool` (grammar check utility using LanguageTool, which you have to install separately)
- `elscreen` (creates tabs to save multiple windows)
- `sr-speedbar` (adds directory navigation column to window)
- `octave-mod` (edit octave)
- `nxml` (edit HTML/XML files)
- `magit` (git revision control through emacs)
- `autopair` (pair braces)

Further explanation on the package system described [here](http://ergoemacs.org/emacs/emacs_package_system.html "Xah Lee's guide to the package system").

In addition, there are other packages not available on these repositories. `El-get` may have them (more advanced), or you may have to download them from various repositories. A partial list:

- [`matlab-emacs`](http://matlab-emacs.sourceforge.net/)
- [`igor-mode`](https://github.com/yamad/igor-mode)
- [`folding`](http://www.emacswiki.org/emacs/FoldingMode)

and so on. Remember to byte-compile them:

```sh
$ emacs -q --batch -f batch-byte-compile folding/folding.el
```

Configuration for these additional packages can be included in `~/.emacs`, or in a separate file as set up for `~/.emacs.d/aprl-local.el`.

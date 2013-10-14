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

Some packages (or their latest versions) are not available through ELPA (even with additional repositories). This includes python-mode and ipython; see below.


Python-mode
---

I use `python-mode.el` (not `python.el`, also known as "Loveshack Python" that comes with emacs). You can get the latest `python-mode.el` here: https://launchpad.net/python-mode. Move the untar'ed directory to `~/.emacs.d/site-lisp/`. For instance, mine is `~/.emacs.d/site-lisp/python-mode.el-6.1.2/`. Alternatively, install from bzr:

```sh
$ cd ~/.emacs.d/site-lisp/
$ bzr branch lp:python-mode
```

To use ipython as your interpretor, you also need `ipython.el`, which
you can get here:
https://raw.github.com/ipython/ipython/master/docs/emacs/ipython.el

```sh
$ mkdir ~/.emacs.d/site-lisp/ipython && cd ~/.emacs.d/site-lisp/ipython
$ wget -c https://raw.github.com/ipython/ipython/master/docs/emacs/ipython.el
```

Additional reading:

- [Emacs as a Python IDE](http://www.jesshamrick.com/2012/09/18/emacs-as-a-python-ide/)

Configure
---

Create a file called `"~/.emacs.d/aprl-local.el` with the following contents:

```common-lisp
;; ELPA required by several packages below
(require 'package)
(package-initialize) ; assuming not initialized in ~/.emacs
;; load desired scripts
(add-to-list 'load-path "~/.emacs.d/aprl/lisp")
(load "aprl-miscsettings")
(load "aprl-misckeybindings")
(load "aprl-autosaves")
(load "aprl-ido")
(load "aprl-python")
(load "aprl-ipython")
(load "aprl-ess")
(load "aprl-auctex")
(load "aprl-fortran")
(load "aprl-shell")
(load "aprl-outline")
```

To test only this configuration, suppress loading of usual `~/.emacs` and load this file:

```sh
$ emacs -q --load ~/.emacs.d/aprl-local.el &
```

If working, call to this file from `~/.emacs`:

```sh
$ echo '(load "~/.emacs.d/aprl-local")' >> ~/.emacs
```

Extend (user-specific; optional)
---

Additional packages can be installed through ELPA (emacs-major-version >= 24) by calling `M-x package-list`. You can add melpa and marmalade repos if desired:

```common-lisp
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
```

Some packages that may be worth considering (not in any particular order):

- `org` (if the one that comes with emacs is outdated)
- `color-theme` (customize colors)
- `zenburn-theme` or `solarized-theme` (custom color themes)
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
- [`color-theme-tangotango`](https://github.com/juba/color-theme-tangotango)

and so on. 

Configuration for these additional packages can be included in `~/.emacs`, or in a separate file as set up for `~/.emacs.d/aprl-local.el`.



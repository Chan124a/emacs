;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  (setq-default
   ;; Base distribution to use. This is a layer contained in the directory
   ;; `+distribution'. For now available distributions are `spacemacs-base'
   ;; or `spacemacs'. (default 'spacemacs)
   dotspacemacs-distribution 'spacemacs

   ;; Lazy installation of layers (i.e. layers are installed only when a file
   ;; with a supported type is opened). Possible values are `all', `unused'
   ;; and `nil'. `unused' will lazy install only unused layers (i.e. layers
   ;; not listed in variable `dotspacemacs-configuration-layers'), `all' will
   ;; lazy install any layer that support lazy installation even the layers
   ;; listed in `dotspacemacs-configuration-layers'. `nil' disable the lazy
   ;; installation feature and you have to explicitly list a layer in the
   ;; variable `dotspacemacs-configuration-layers' to install it.
   ;; (default 'unused)
   dotspacemacs-enable-lazy-installation 'unused

   ;; If non-nil then Spacemacs will ask for confirmation before installing
   ;; a layer lazily. (default t)
   dotspacemacs-ask-for-lazy-installation t

   ;; List of additional paths where to look for configuration layers.
   ;; Paths must have a trailing slash (i.e. "~/.mycontribs/")
   dotspacemacs-configuration-layer-path '()

   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(html
     rust
     (python :variables python-backend 'lsp)
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     ;; auto-completion
     ;; better-defaults
     emacs-lisp
     git
     helm
     (shell :variables shell-default-shell 'vterm)
     ;; lsp
     markdown
     (multiple-cursors :variables multiple-cursors-backend 'mc)
     org
     chinese
     (latex :variables latex-backend 'lsp)
     (c-c++ :variables
            c-c++-backend 'lsp-clangd
            c-c++-enable-organize-includes-on-save nil
            c-c++-enable-clang-format-on-save t
            c-c++-formatter-indent-line t)
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     ;; spell-checking
     ;; syntax-checking
     ;; version-control
     epub
     treemacs
     (auto-completion :variables
                      auto-completion-enable-snippets-in-popup t)
     syntax-checking
     (go :variables
         go-format-before-save t
         go-use-golangci-lint t)
     (claude-code :variables
                  claude-code-ide-window-side 'right
                  claude-code-ide-window-width 100)
     solidity
     )


   ;; List of additional packages that will be installed without being wrapped
   ;; in a layer (generally the packages are installed only and should still be
   ;; loaded using load/require/use-package in the user-config section below in
   ;; this file). If you need some configuration for these packages, then
   ;; consider creating a layer. You can also put the configuration in
   ;; `dotspacemacs/user-config'. To use a local version of a package, use the
   ;; `:location' property: '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages '(evil-escape ob-go gptel mustache code-review org-anki)

   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '(org-download)

   ;; A list of packages that will not be installed and loaded.
   dotspacemacs-excluded-packages '()

   ;; Defines the behaviour of Spacemacs when installing packages.
   ;; Possible values are `used-only', `used-but-keep-unused' and `all'.
   ;; `used-only' installs only explicitly used packages and deletes any unused
   ;; packages as well as their unused dependencies. `used-but-keep-unused'
   ;; installs only the used packages but won't delete unused ones. `all'
   ;; installs *all* packages supported by Spacemacs and never uninstalls them.
   ;; (default is `used-only')
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  "Initialization:
This function is called at the very beginning of Spacemacs startup,
before layer configuration.
It should only modify the values of Spacemacs settings."
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   ;; If non-nil then enable support for the portable dumper. You'll need to
   ;; compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
   ;;
   ;; WARNING: pdumper does not work with Native Compilation, so it's disabled
   ;; regardless of the following setting when native compilation is in effect.
   ;;
   ;; (default nil)
   dotspacemacs-enable-emacs-pdumper nil

   ;; Name of executable file pointing to emacs 27+. This executable must be
   ;; in your PATH.
   ;; (default "emacs")
   dotspacemacs-emacs-pdumper-executable-file "emacs"

   ;; Name of the Spacemacs dump file. This is the file will be created by the
   ;; portable dumper in the cache directory under dumps sub-directory.
   ;; To load it when starting Emacs add the parameter `--dump-file'
   ;; when invoking Emacs 27.1 executable on the command line, for instance:
   ;;   ./emacs --dump-file=$HOME/.emacs.d/.cache/dumps/spacemacs-27.1.pdmp
   ;; (default (format "spacemacs-%s.pdmp" emacs-version))
   dotspacemacs-emacs-dumper-dump-file (format "spacemacs-%s.pdmp" emacs-version)

   ;; If non-nil ELPA repositories are contacted via HTTPS whenever it's
   ;; possible. Set it to nil if you have no way to use HTTPS in your
   ;; environment, otherwise it is strongly recommended to let it set to t.
   ;; This variable has no effect if Emacs is launched with the parameter
   ;; `--insecure' which forces the value of this variable to nil.
   ;; (default t)
   dotspacemacs-elpa-https t

   ;; Maximum allowed time in seconds to contact an ELPA repository.
   ;; (default 5)
   dotspacemacs-elpa-timeout 5

   ;; Set `gc-cons-threshold' and `gc-cons-percentage' when startup finishes.
   ;; This is an advanced option and should not be changed unless you suspect
   ;; performance issues due tno garbage collection operations.
   ;; (default '(100000000 0.1))
   dotspacemacs-gc-cons '(100000000 0.1)

   ;; Set `read-process-output-max' when startup finishes.
   ;; This defines how much data is read from a foreign process.
   ;; Setting this >= 1 MB should increase performance for lsp servers
   ;; in emacs 27.
   ;; (default (* 1024 1024))
   dotspacemacs-read-process-output-max (* 1024 1024)

   ;; If non-nil then Spacelpa repository is the primary source to install
   ;; a locked version of packages. If nil then Spacemacs will install the
   ;; latest version of packages from MELPA. Spacelpa is currently in
   ;; experimental state please use only for testing purposes.
   ;; (default nil)
   dotspacemacs-use-spacelpa nil

   ;; If non-nil then verify the signature for downloaded Spacelpa archives.
   ;; (default t)
   dotspacemacs-verify-spacelpa-archives t

   ;; If non-nil then spacemacs will check for updates at startup
   ;; when the current branch is not `develop'. Note that checking for
   ;; new versions works via git commands, thus it calls GitHub services
   ;; whenever you start Emacs. (default nil)
   dotspacemacs-check-for-update nil

   ;; If non-nil, a form that evaluates to a package directory. For example, to
   ;; use different package directories for different Emacs versions, set this
   ;; to `emacs-version'. (default 'emacs-version)
   dotspacemacs-elpa-subdirectory 'emacs-version

   ;; One of `vim', `emacs' or `hybrid'.
   ;; `hybrid' is like `vim' except that `insert state' is replaced by the
   ;; `hybrid state' with `emacs' key bindings. The value can also be a list
   ;; with `:variables' keyword (similar to layers). Check the editing styles
   ;; section of the documentation for details on available variables.
   ;; (default 'vim)
   dotspacemacs-editing-style 'emacs

   ;; If non-nil show the version string in the Spacemacs buffer. It will
   ;; appear as (spacemacs version)@(emacs version)
   ;; (default t)
   dotspacemacs-startup-buffer-show-version t

   ;; Specify the startup banner. Default value is `official', it displays
   ;; the official spacemacs logo. An integer value is the index of text
   ;; banner, `random' chooses a random text banner in `core/banners'
   ;; directory. A string value must be a path to an image format supported
   ;; by your Emacs build.
   ;; If the value is nil then no banner is displayed. (default 'official)
   dotspacemacs-startup-banner 'official

   ;; Scale factor controls the scaling (size) of the startup banner. Default
   ;; value is `auto' for scaling the logo automatically to fit all buffer
   ;; contents, to a maximum of the full image height and a minimum of 3 line
   ;; heights. If set to a number (int or float) it is used as a constant
   ;; scaling factor for the default logo size.
   dotspacemacs-startup-banner-scale 'auto

   ;; List of items to show in startup buffer or an association list of
   ;; the form `(list-type . list-size)`. If nil then it is disabled.
   ;; Possible values for list-type are:
   ;; `recents' `recents-by-project' `bookmarks' `projects' `agenda' `todos'.
   ;; List sizes may be nil, in which case
   ;; `spacemacs-buffer-startup-lists-length' takes effect.
   ;; The exceptional case is `recents-by-project', where list-type must be a
   ;; pair of numbers, e.g. `(recents-by-project . (7 .  5))', where the first
   ;; number is the project limit and the second the limit on the recent files
   ;; within a project.
   dotspacemacs-startup-lists '((recents . 5)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Show numbers before the startup list lines. (default t)
   dotspacemacs-show-startup-list-numbers t

   ;; The minimum delay in seconds between number key presses. (default 0.4)
   dotspacemacs-startup-buffer-multi-digit-delay 0.4

   ;; If non-nil, show file icons for entries and headings on Spacemacs home buffer.
   ;; This has no effect in terminal or if "all-the-icons" package or the font
   ;; is not installed. (default nil)
   dotspacemacs-startup-buffer-show-icons nil

   ;; Default major mode for a new empty buffer. Possible values are mode
   ;; names such as `text-mode'; and `nil' to use Fundamental mode.
   ;; (default `text-mode')
   dotspacemacs-new-empty-buffer-major-mode 'text-mode

   ;; Default major mode of the scratch buffer (default `text-mode')
   dotspacemacs-scratch-mode 'text-mode

   ;; If non-nil, *scratch* buffer will be persistent. Things you write down in
   ;; *scratch* buffer will be saved and restored automatically.
   dotspacemacs-scratch-buffer-persistent nil

   ;; If non-nil, `kill-buffer' on *scratch* buffer
   ;; will bury it instead of killing.
   dotspacemacs-scratch-buffer-unkillable nil

   ;; Initial message in the scratch buffer, such as "Welcome to Spacemacs!"
   ;; (default nil)
   dotspacemacs-initial-scratch-message nil

   ;; List of themes, the first of the list is loaded when spacemacs starts.
   ;; Press `SPC T n' to cycle to the next theme in the list (works great
   ;; with 2 themes variants, one dark and one light)
   dotspacemacs-themes '(spacemacs-light
                         spacemacs-dark)


   ;; Set the theme for the Spaceline. Supported themes are `spacemacs',
   ;; `all-the-icons', `custom', `doom', `vim-powerline' and `vanilla'. The
   ;; first three are spaceline themes. `doom' is the doom-emacs mode-line.
   ;; `vanilla' is default Emacs mode-line. `custom' is a user defined themes,
   ;; refer to the DOCUMENTATION.org for more info on how to create your own
   ;; spaceline theme. Value can be a symbol or list with additional properties.
   ;; (default '(spacemacs :separator wave :separator-scale 1.5))
   dotspacemacs-mode-line-theme '(spacemacs :separator wave :separator-scale 1.5)

   ;; If non-nil the cursor color matches the state color in GUI Emacs.
   ;; (default t)
   dotspacemacs-colorize-cursor-according-to-state t

   ;; Default font or prioritized list of fonts. The `:size' can be specified as
   ;; a non-negative integer (pixel size), or a floating-point (point size).
   ;; Point size is recommended, because it's device independent. (default 10.0)
   dotspacemacs-default-font '("Source Code Pro"
                               :size 10.0
                               :weight normal
                               :width normal)

   ;; The leader key (default "SPC")
   dotspacemacs-leader-key "SPC"

   ;; The key used for Emacs commands `M-x' (after pressing on the leader key).
   ;; (default "SPC")
   dotspacemacs-emacs-command-key "SPC"

   ;; The key used for Vim Ex commands (default ":")
   dotspacemacs-ex-command-key ":"

   ;; The leader key accessible in `emacs state' and `insert state'
   ;; (default "M-m")
   dotspacemacs-emacs-leader-key "M-m"

   ;; Major mode leader key is a shortcut key which is the equivalent of
   ;; pressing `<leader> m`. Set it to `nil` to disable it. (default ",")
   dotspacemacs-major-mode-leader-key ","

   ;; Major mode leader key accessible in `emacs state' and `insert state'.
   ;; (default "C-M-m" for terminal mode, "<M-return>" for GUI mode).
   ;; Thus M-RET should work as leader key in both GUI and terminal modes.
   ;; C-M-m also should work in terminal mode, but not in GUI mode.
   dotspacemacs-major-mode-emacs-leader-key (if window-system "<M-return>" "C-M-m")

   ;; These variables control whether separate commands are bound in the GUI to
   ;; the key pairs `C-i', `TAB' and `C-m', `RET'.
   ;; Setting it to a non-nil value, allows for separate commands under `C-i'
   ;; and TAB or `C-m' and `RET'.
   ;; In the terminal, these pairs are generally indistinguishable, so this only
   ;; works in the GUI. (default nil)
   dotspacemacs-distinguish-gui-tab nil

   ;; Name of the default layout (default "Default")
   dotspacemacs-default-layout-name "Default"

   ;; If non-nil the default layout name is displayed in the mode-line.
   ;; (default nil)
   dotspacemacs-display-default-layout nil

   ;; If non-nil then the last auto saved layouts are resumed automatically upon
   ;; start. (default nil)
   dotspacemacs-auto-resume-layouts nil

   ;; If non-nil, auto-generate layout name when creating new layouts. Only has
   ;; effect when using the "jump to layout by number" commands. (default nil)
   dotspacemacs-auto-generate-layout-names nil

   ;; Size (in MB) above which spacemacs will prompt to open the large file
   ;; literally to avoid performance issues. Opening a file literally means that
   ;; no major mode or minor modes are active. (default is 1)
   dotspacemacs-large-file-size 1

   ;; Location where to auto-save files. Possible values are `original' to
   ;; auto-save the file in-place, `cache' to auto-save the file to another
   ;; file stored in the cache directory and `nil' to disable auto-saving.
   ;; (default 'cache)
   dotspacemacs-auto-save-file-location 'cache

   ;; Maximum number of rollback slots to keep in the cache. (default 5)
   dotspacemacs-max-rollback-slots 5

   ;; If non-nil, the paste transient-state is enabled. While enabled, after you
   ;; paste something, pressing `C-j' and `C-k' several times cycles through the
   ;; elements in the `kill-ring'. (default nil)
   dotspacemacs-enable-paste-transient-state nil

   ;; Which-key delay in seconds. The which-key buffer is the popup listing
   ;; the commands bound to the current keystroke sequence. (default 0.4)
   dotspacemacs-which-key-delay 0.4

   ;; Which-key frame position. Possible values are `right', `bottom' and
   ;; `right-then-bottom'. right-then-bottom tries to display the frame to the
   ;; right; if there is insufficient space it displays it at the bottom.
   ;; (default 'bottom)
   dotspacemacs-which-key-position 'bottom

   ;; Control where `switch-to-buffer' displays the buffer. If nil,
   ;; `switch-to-buffer' displays the buffer in the current window even if
   ;; another same-purpose window is available. If non-nil, `switch-to-buffer'
   ;; displays the buffer in a same-purpose window even if the buffer can be
   ;; displayed in the current window. (default nil)
   dotspacemacs-switch-to-buffer-prefers-purpose nil

   ;; If non-nil a progress bar is displayed when spacemacs is loading. This
   ;; may increase the boot time on some systems and emacs builds, set it to
   ;; nil to boost the loading time. (default t)
   dotspacemacs-loading-progress-bar t

   ;; If non-nil the frame is fullscreen when Emacs starts up. (default nil)
   ;; (Emacs 24.4+ only)
   dotspacemacs-fullscreen-at-startup nil

   ;; If non-nil `spacemacs/toggle-fullscreen' will not use native fullscreen.
   ;; Use to disable fullscreen animations in OSX. (default nil)
   dotspacemacs-fullscreen-use-non-native nil

   ;; If non-nil the frame is maximized when Emacs starts up.
   ;; Takes effect only if `dotspacemacs-fullscreen-at-startup' is nil.
   ;; (default t) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup t

   ;; If non-nil the frame is undecorated when Emacs starts up. Combine this
   ;; variable with `dotspacemacs-maximized-at-startup' to obtain fullscreen
   ;; without external boxes. Also disables the internal border. (default nil)
   dotspacemacs-undecorated-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes the
   ;; transparency level of a frame background when it's active or selected. Transparency
   ;; can be toggled through `toggle-background-transparency'. (default 90)
   dotspacemacs-background-transparency 90

   ;; If non-nil show the titles of transient states. (default t)
   dotspacemacs-show-transient-state-title t

   ;; If non-nil show the color guide hint for transient state keys. (default t)
   dotspacemacs-show-transient-state-color-guide t

   ;; If non-nil unicode symbols are displayed in the mode line.
   ;; If you use Emacs as a daemon and wants unicode characters only in GUI set
   ;; the value to quoted `display-graphic-p'. (default t)
   dotspacemacs-mode-line-unicode-symbols t

   ;; If non-nil smooth scrolling (native-scrolling) is enabled. Smooth
   ;; scrolling overrides the default behavior of Emacs which recenters point
   ;; when it reaches the top or bottom of the screen. (default t)
   dotspacemacs-smooth-scrolling t

   ;; Show the scroll bar while scrolling. The auto hide time can be configured
   ;; by setting this variable to a number. (default t)
   dotspacemacs-scroll-bar-while-scrolling t

   ;; Control line numbers activation.
   ;; If set to `t', `relative' or `visual' then line numbers are enabled in all
   ;; `prog-mode' and `text-mode' derivatives. If set to `relative', line
   ;; numbers are relative. If set to `visual', line numbers are also relative,
   ;; but only visual lines are counted. For example, folded lines will not be
   ;; counted and wrapped lines are counted as multiple lines.
   ;; This variable can also be set to a property list for finer control:
   ;; '(:relative nil
   ;;   :visual nil
   ;;   :disabled-for-modes dired-mode
   ;;                       doc-view-mode
   ;;                       markdown-mode
   ;;                       org-mode
   ;;                       pdf-view-mode
   ;;                       text-mode
   ;;   :size-limit-kb 1000)
   ;; When used in a plist, `visual' takes precedence over `relative'.
   ;; (default nil)
   dotspacemacs-line-numbers t

   ;; Code folding method. Possible values are `evil', `origami' and `vimish'.
   ;; (default 'evil)
   dotspacemacs-folding-method 'evil

   ;; If non-nil and `dotspacemacs-activate-smartparens-mode' is also non-nil,
   ;; `smartparens-strict-mode' will be enabled in programming modes.
   ;; (default nil)
   dotspacemacs-smartparens-strict-mode nil

   ;; If non-nil smartparens-mode will be enabled in programming modes.
   ;; (default t)
   dotspacemacs-activate-smartparens-mode t

   ;; If non-nil pressing the closing parenthesis `)' key in insert mode passes
   ;; over any automatically added closing parenthesis, bracket, quote, etc...
   ;; This can be temporary disabled by pressing `C-q' before `)'. (default nil)
   dotspacemacs-smart-closing-parenthesis nil

   ;; Select a scope to highlight delimiters. Possible values are `any',
   ;; `current', `all' or `nil'. Default is `all' (highlight any scope and
   ;; emphasis the current one). (default 'all)
   dotspacemacs-highlight-delimiters 'all

   ;; If non-nil, start an Emacs server if one is not already running.
   ;; (default nil)
   dotspacemacs-enable-server t

   ;; Set the emacs server socket location.
   ;; If nil, uses whatever the Emacs default is, otherwise a directory path
   ;; like \"~/.emacs.d/server\". It has no effect if
   ;; `dotspacemacs-enable-server' is nil.
   ;; (default nil)
   dotspacemacs-server-socket-dir nil

   ;; If non-nil, advise quit functions to keep server open when quitting.
   ;; (default nil)
   dotspacemacs-persistent-server nil

   ;; List of search tool executable names. Spacemacs uses the first installed
   ;; tool of the list. Supported tools are `rg', `ag', `pt', `ack' and `grep'.
   ;; (default '("rg" "ag" "pt" "ack" "grep"))
   dotspacemacs-search-tools '("rg" "ag" "ack" "grep")

   ;; Format specification for setting the frame title.
   ;; %a - the `abbreviated-file-name', or `buffer-name'
   ;; %t - `projectile-project-name'
   ;; %I - `invocation-name'
   ;; %S - `system-name'
   ;; %U - contents of $USER
   ;; %b - buffer name
   ;; %f - visited file name
   ;; %F - frame name
   ;; %s - process status
   ;; %p - percent of buffer above top of window, or Top, Bot or All
   ;; %P - percent of buffer above bottom of window, perhaps plus Top, or Bot or All
   ;; %m - mode name
   ;; %n - Narrow if appropriate
   ;; %z - mnemonics of buffer, terminal, and keyboard coding systems
   ;; %Z - like %z, but including the end-of-line format
   ;; If nil then Spacemacs uses default `frame-title-format' to avoid
   ;; performance issues, instead of calculating the frame title by
   ;; `spacemacs/title-prepare' all the time.
   ;; (default "%I@%S")
   dotspacemacs-frame-title-format "%I@%S"

   ;; Format specification for setting the icon title format
   ;; (default nil - same as frame-title-format)
   dotspacemacs-icon-title-format nil

   ;; Color highlight trailing whitespace in all prog-mode and text-mode derived
   ;; modes such as c++-mode, python-mode, emacs-lisp, html-mode, rst-mode etc.
   ;; (default t)
   dotspacemacs-show-trailing-whitespace t

   ;; Delete whitespace while saving buffer. Possible values are `all'
   ;; to aggressively delete empty line and long sequences of whitespace,
   ;; `trailing' to delete only the whitespace at end of lines, `changed' to
   ;; delete only whitespace for changed lines or `nil' to disable cleanup.
   ;; (default nil)
   dotspacemacs-whitespace-cleanup nil

   ;; If non-nil activate `clean-aindent-mode' which tries to correct
   ;; virtual indentation of simple modes. This can interfere with mode specific
   ;; indent handling like has been reported for `go-mode'.
   ;; If it does deactivate it here.
   ;; (default t)
   dotspacemacs-use-clean-aindent-mode t

   ;; Accept SPC as y for prompts if non-nil. (default nil)
   dotspacemacs-use-SPC-as-y nil

   ;; If non-nil shift your number row to match the entered keyboard layout
   ;; (only in insert state). Currently supported keyboard layouts are:
   ;; `qwerty-us', `qwertz-de' and `querty-ca-fr'.
   ;; New layouts can be added in `spacemacs-editing' layer.
   ;; (default nil)
   dotspacemacs-swap-number-row nil

   ;; Either nil or a number of seconds. If non-nil zone out after the specified
   ;; number of seconds. (default nil)
   dotspacemacs-zone-out-when-idle nil

   ;; Run `spacemacs/prettify-org-buffer' when
   ;; visiting README.org files of Spacemacs.
   ;; (default nil)
   dotspacemacs-pretty-docs nil

   ;; If nil the home buffer shows the full path of agenda items
   ;; and todos. If non-nil only the file name is shown.
   dotspacemacs-home-shorten-agenda-source nil

   ;; If non-nil then byte-compile some of Spacemacs files.
   dotspacemacs-byte-compile nil))

(defun dotspacemacs/user-env ()
  "Environment variables setup.
This function defines the environment variables for your Emacs session. By
default it calls `spacemacs/load-spacemacs-env' which loads the environment
variables declared in `~/.spacemacs.env' or `~/.spacemacs.d/.spacemacs.env'.
See the header of this file for more information."
  (spacemacs/load-spacemacs-env)
  )

(defun dotspacemacs/user-init ()
  "Initialization for user code:
This function is called immediately after `dotspacemacs/init', before layer
configuration.
It is mostly for variables that should be set before packages are loaded.
If you are unsure, try setting them in `dotspacemacs/user-config' first."
  (setq configuration-layer-elpa-archives
        '(("melpa-cn" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
          ("org-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/org/")
          ("gnu-cn"   . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
          ("nongnu"   . "https://elpa.nongnu.org/nongnu/")))

  )

(defun dotspacemacs/user-load ()
  "Library to load while dumping.
This function is called only while dumping Spacemacs configuration. You can
`require' or `load' the libraries of your choice that pwill be included in the
dump."

  )



(defun org-config()
  ;;启用org-download
  (require 'org-download)
  ;; Drag-and-drop to `dired`
  (add-hook 'dired-mode-hook 'org-download-enable)
  (use-package org-download
    :after org
    :defer nil
    :custom
    (org-download-method 'directory)
    (org-download-image-dir "/Users/cpd/my_code/org/images")
    (org-download-heading-lvl 0)
    (org-download-screenshot-method "screencapture -i %s")
    :bind
    ("C-S-y" . org-download-screenshot)
    :config
    (require 'org-download))

  ;;启用<s补全代码功能
  (require 'org-tempo)

  (with-eval-after-load 'org
    ;; here goes your Org config :)
    ;; ....
    (setq org-todo-keywords
          '((sequence "TODO(t)" "DOING(i!)" "|" "DONE(d!)"))
          )
    ;; 关闭org自动缩进功能
    (electric-indent-mode -1)
    )

  ;; 设置tectonic,可以让org导出为pdf格式.tectonic依赖于texLive
  ;;(setq org-latex-pdf-process '("tectonic %f"))
  ;;上面那个不知道为啥没用,最终用的是下面的配置
  (setq org-latex-pdf-process
        '("xelatex -interaction nonstopmode -output-directory %o %f"
          "xelatex -interaction nonstopmode -output-directory %o %f"
          "xelatex -interaction nonstopmode -output-directory %o %f"))



  ;;设置agenda view的搜索目录
  (setq org-agenda-files '("~/my_code/org/agenda/"))
  (defun air-org-skip-subtree-if-priority (priority)
    "Skip an agenda subtree if it has a priority of PRIORITY.
PRIORITY may be one of the characters ?A, ?B, or ?C."
    (let ((subtree-end (save-excursion (org-end-of-subtree t)))
          (pri-value (* 1000 (- org-lowest-priority priority)))
          (pri-current (org-get-priority (thing-at-point 'line t))))
      (if (= pri-value pri-current)
          subtree-end
        nil)))
  (setq org-agenda-custom-commands
        '(("c" "Simple agenda view"
           ((tags "PRIORITY=\"A\""
                  ((org-agenda-skip-function '(org-agenda-skip-entry-if 'todo 'done))
                   (org-agenda-overriding-header "High-priority unfinished tasks:")))
            (agenda "")
            (alltodo ""
                     ((org-agenda-skip-function
                       '(or (air-org-skip-subtree-if-priority ?A)
                            (org-agenda-skip-if nil '(scheduled deadline))))))))))

  ;; ob-go enables Org-Babel support for evaluating go code.
  (require 'ob-go)

  (add-hook 'org-mode-hook #'spacemacs/toggle-truncate-lines-off)

  ;; 配置org-protocol
  (server-start)
  (require 'org-protocol)
  ;; Kill the frame if one was created for the capture
  (defvar kk/delete-frame-after-capture 0 "Whether to delete the last frame after the current capture")
  (defun kk/delete-frame-if-neccessary (&rest r)
    (cond
     ((= kk/delete-frame-after-capture 0) nil)
     ((> kk/delete-frame-after-capture 1)
      (setq kk/delete-frame-after-capture (- kk/delete-frame-after-capture 1)))
     (t
      (setq kk/delete-frame-after-capture 0)
      (delete-frame))))
  (advice-add 'org-capture-finalize :after 'kk/delete-frame-if-neccessary)
  (advice-add 'org-capture-kill :after 'kk/delete-frame-if-neccessary)
  (advice-add 'org-capture-refile :after 'kk/delete-frame-if-neccessary)
  (setq org-capture-templates `(
                                ("L" "Protocol Bookmarks" plain (file+headline "/Users/cpd/my_code/org/capture.org" "Reference") "%:annotation %(progn (setq kk/delete-frame-after-capture 1) \"\")":immediate-finish t :kill-buffer t)
                                ("p" "Protocol Bookmarks" entry(file+headline "/Users/cpd/my_code/org/test.org" "Notes") "* %U - %:annotation %^g\n\n  %?" :empty-lines 1 :kill-buffer t)
                                ))

  (add-hook 'org-mode-hook
            (lambda ()
              (local-set-key (kbd "C-c C-x C-v") 'org-toggle-inline-images)
              ))

  ;;配置org-anki
  (require 'org-anki)
  (setq org-anki-ankiconnnect-listen-address "http://127.0.0.1:8765")
  (setq org-anki-default-deck "Default")

  )

(defun my_insert_latex_figure_fun ()
  "完整的截图并插入LaTeX figure环境"
  (interactive)
  (let* ((base-name (format-time-string "%Y%m%d-%H%M%S-%N"))
         (img-name (concat base-name ".png"))
         (img-dir "/Users/cpd/my_code/math_note/flg")
         (full-path (concat img-dir "/" img-name))
         (label (concat "fig:" base-name)))

    ;; 创建目录
    (make-directory img-dir t)

    ;; 截图（根据系统选择命令）
    (cond ((eq system-type 'darwin)
           (shell-command (format "screencapture -i %s" full-path)))
          ((eq system-type 'gnu/linux)
           (shell-command (format "maim -s %s" full-path)))
          (t (error "Unsupported system"))
          )

    ;; 插入LaTeX代码
    (insert (format "
\\begin{figure}[htbp]
\\centering
\\includegraphics[scale=0.6]{%s}
\\caption{请填写描述}
\\label{%s}
\\end{figure}" img-name label)))
  )

(defun cpd/markdown-insert-screenshot ()
  "Capture a screenshot and insert it as a Markdown image link.
The screenshot is saved under an `images' directory next to the current
Markdown file."
  (interactive)
  (unless buffer-file-name
    (user-error "Please save this Markdown buffer before inserting a screenshot"))
  (let* ((base-dir (file-name-directory buffer-file-name))
         (image-dir (expand-file-name "images" base-dir))
         (file-base (file-name-base buffer-file-name))
         (timestamp (format-time-string "%Y%m%d-%H%M%S"))
         (filename (format "%s-%s.png" file-base timestamp))
         (image-path (expand-file-name filename image-dir))
         (relative-path (file-relative-name image-path base-dir))
         (command (cond
                   ((eq system-type 'darwin)
                    (format "screencapture -i %s" (shell-quote-argument image-path)))
                   ((executable-find "gnome-screenshot")
                    (format "gnome-screenshot -a -f %s" (shell-quote-argument image-path)))
                   ((executable-find "import")
                    (format "import %s" (shell-quote-argument image-path)))
                   (t
                    (user-error "No supported screenshot command found")))))
    (make-directory image-dir t)
    (if (zerop (shell-command command))
        (if (file-exists-p image-path)
            (insert (format "![screenshot](%s)" relative-path))
          (message "Screenshot cancelled"))
      (when (file-exists-p image-path)
        (delete-file image-path))
      (message "Screenshot cancelled"))))

(defun cpd/markdown-export-pdf ()
  "Export the current Markdown file to a PDF via pandoc HTML and Chrome."
  (interactive)
  (unless buffer-file-name
    (user-error "Please save this Markdown buffer before exporting to PDF"))
  (unless (executable-find "pandoc")
    (user-error "pandoc is not installed or not in Emacs exec-path"))
  (unless (file-executable-p "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome")
    (user-error "Google Chrome is not installed in /Applications"))
  (save-buffer)
  (let* ((input-file buffer-file-name)
         (base-name (file-name-sans-extension input-file))
         ;; Keep generated files next to the Markdown file for predictable
         ;; relative image paths such as images/foo.png.
         (html-file (concat base-name ".html"))
         (css-file (concat base-name ".pdf.css"))
         (output-file (concat (file-name-sans-extension input-file) ".pdf"))
         (default-directory (file-name-directory input-file))
         ;; Build a standalone HTML file first so raw HTML image tags keep
         ;; working before Chrome prints the page to PDF.
         (html-command (mapconcat
                        #'identity
                        (list "pandoc"
                              (shell-quote-argument input-file)
                              "--standalone"
                              "--embed-resources"
                              "--css"
                              (shell-quote-argument css-file)
                              "-f"
                              "markdown+raw_html"
                              "-t"
                              "html5"
                              "-o"
                              (shell-quote-argument html-file))
                        " "))
         ;; Chrome's print engine preserves the HTML layout better than
         ;; pandoc's LaTeX PDF path for documents with <img> tags.
         (pdf-command (mapconcat
                       #'identity
                       (list (shell-quote-argument "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome")
                             "--headless"
                             "--disable-gpu"
                             "--print-to-pdf-no-header"
                             (format "--print-to-pdf=%s" (shell-quote-argument output-file))
                             (shell-quote-argument (concat "file://" html-file)))
                       " ")))
    ;; This CSS is shared by the generated HTML and Chrome's print view.
    ;; Adjust padding/max-width here to control PDF page margins and content width.
    (with-temp-file css-file
      (insert "html {
  background: #ffffff;
}

body {
  box-sizing: border-box;
  min-width: 200px;
  max-width: 980px;
  width: 100%;
  margin: 0 auto;
  padding: 100px;
  line-height: 1.6;
  -webkit-print-color-adjust: exact;
  print-color-adjust: exact;
}

img {
  max-width: 100%;
  height: auto;
}

@page {
  size: A4;
  margin: 0;
}

@media print {
  html,
  body {
    background: #ffffff;
  }

  body {
    max-width: 980px;
    margin: 0 auto;
    padding: 100px;
  }
}
"))
    ;; Run the two-step export and surface failures in Emacs.
    (unless (eq (shell-command html-command) 0)
      (user-error "Failed to export HTML; check *Shell Command Output*"))
    (if (eq (shell-command pdf-command) 0)
        (message "Exported PDF: %s" output-file)
      (user-error "Failed to export PDF; check *Shell Command Output*"))))

(defun cpd/markdown-config ()
  "Personal Markdown configuration."
  (add-hook 'markdown-mode-hook
            (lambda ()
              (local-set-key (kbd "C-S-y") #'cpd/markdown-insert-screenshot)
              (local-set-key (kbd "C-c C-e p") #'cpd/markdown-export-pdf))))

(defun latex-config ()
  ;;设置xelatex为auctux默认编辑器
  ;; (add-hook 'LaTeX-mode-hook
  ;;           #'(lambda ()
  ;;               (add-to-list 'TeX-command-list '("XeLaTeX" "%`xelatex --synctex=1%(mode)%' %t" TeX-run-TeX nil t))))
  (add-hook 'LaTeX-mode-hook
            (lambda ()
              (setq TeX-engine 'xetex)       ; use xelatex default
              (set (make-local-variable 'TeX-electric-math) (cons "$" ""));输入$时自动替换为两个$

              ;; 修改preview快捷键。主要是将前缀C-x C-p修改为C-c C-x
              ;; 在mac上，C-p被我修改为方向键了，这导致C-x C-p没法用。
              ;; 我不知道怎么修改LaTex-mode-map，所以只能通过local-set-key增加一组新的快捷键
              (local-set-key (kbd "C-c C-x C-p") #'preview-at-point)
              (local-set-key (kbd "C-c C-x C-r") #'preview-region)
              (local-set-key (kbd "C-c C-x C-b") #'preview-buffer)
              (local-set-key (kbd "C-c C-x C-d") #'preview-document)
              (local-set-key (kbd "C-c C-x C-f") #'preview-cache-preamble)
              (local-set-key (kbd "C-c C-x C-c C-f") #'preview-cache-preamble-off)
              (local-set-key (kbd "C-c C-x C-i") #'preview-goto-info-page)
              (local-set-key (kbd "C-c C-x C-e") #'preview-environment)
              (local-set-key (kbd "C-c C-x C-s") #'preview-section)
              (local-set-key (kbd "C-c C-x C-w") #'preview-copy-region-as-mml)
              (local-set-key (kbd "C-c C-x C-c C-p") #'preview-clearout-at-point)
              (local-set-key (kbd "C-c C-x C-c C-r") #'preview-clearout)
              (local-set-key (kbd "C-c C-x C-c C-s") #'preview-clearout-section)
              (local-set-key (kbd "C-c C-x C-c C-b") #'preview-clearout-buffer)
              (local-set-key (kbd "C-c C-x C-c C-d") #'preview-clearout-document)
              ))

  ;;下面这个配置不知道有啥用，spacemacs的latex layer会自动设置为true，所以这里不用设置
  ;;(setq reftex-plug-into-AUCTeX t)

  ;; 配置outline-mode
  (add-hook 'LaTeX-mode-hook #'outline-minor-mode)
  (add-hook 'outline-minor-mode-hook
            (lambda ()
              (let ((map outline-minor-mode-map))
                ;; 移除旧的绑定
                (define-key map (kbd "C-c @") nil)
                ;; 设置新的前缀和命令
                ;; 将前缀从 C-c @ 改为 C-c C-o
                (define-key map (kbd "C-c C-o h") 'outline-hide-body)
                (define-key map (kbd "C-c C-o s") 'outline-show-all)
                (define-key map (kbd "C-c C-o d") 'outline-hide-subtree)
                (define-key map (kbd "C-c C-o a") 'outline-show-subtree)
                (define-key map (kbd "C-c C-o c") 'outline-hide-entry)
                (define-key map (kbd "C-c C-o e") 'outline-show-entry)
                (define-key map (kbd "C-c C-o l") 'outline-hide-leaves)
                (define-key map (kbd "C-c C-o k") 'outline-show-branches)
                (define-key map (kbd "<tab>") 'outline-cycle)
                (define-key map (kbd "<S-tab>") 'outline-cycle-buffer)
                (define-key map (kbd "C-c <up>") 'outline-previous-visible-heading)
                (define-key map (kbd "C-c <down>") 'outline-next-visible-heading)
                )))

  ;; 设置快捷键ctrl+shift+y,用于快速截屏并插入图片到latex文件中
  (add-hook 'LaTeX-mode-hook
            (lambda ()
              (local-set-key (kbd "C-S-y") 'my_insert_latex_figure_fun)))
  )

(defun dotspacemacs/user-config ()
  "Configuration for user code:
This function is called at the very end of Spacemacs startup, after layer
configuration.
Put your configuration code here, except for variables that should be set
before packages are loaded."

  ;;将C-h绑定为删除光标前字符
  (global-set-key (kbd "C-h") 'paredit-backward-delete)

  ;;设置multiple-cursors多行编辑快捷键
  (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
  (global-set-key (kbd "C->") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-+") 'mc/mark-next-like-this)
  (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)
  ;; ;; From active region to multiple cursors:
  ;; (global-set-key (kbd "C-c c r") 'set-rectangular-region-anchor)
  ;; (global-set-key (kbd "C-c c c") 'mc/edit-lines)
  ;; (global-set-key (kbd "C-c c e") 'mc/edit-ends-of-lines)
  ;; (global-set-key (kbd "C-c c a") 'mc/edit-beginnings-of-lines)

  ;;绑定打开最近文件的快捷键
  (global-set-key (kbd "C-x C-r") 'recentf-open-files)

  (global-set-key (kbd "C-o") 'other-window)

  (global-set-key (kbd "M-i") 'imenu-list-smart-toggle)

  (global-set-key (kbd "C-x C-a") 'magit)

  (global-unset-key (kbd "TAB"))
  (global-set-key (kbd "C-i") 'er/expand-region)

  (add-to-list 'spacemacs-large-file-modes-list 'org-mode)

  (with-eval-after-load "nov"
    (when (string-equal system-type "windows-nt")
      (setq process-coding-system-alist
            (cons `(,nov-unzip-program . (gbk . gbk))
                  process-coding-system-alist))))

  ;; mac系统下文件路径会乱码。下面两行设置可以解决这个问题
  (unless (eq window-system 'mac)
    (prefer-coding-system 'gb18030)
    (prefer-coding-system 'utf-8))

  ;; disable menu bar on Mac
  (unless (eq window-system 'mac)
    (menu-bar-mode 0))

  (org-config)
  (latex-config)
  (cpd/markdown-config)

  (add-hook 'go-mode-hook
            (lambda ()
              (local-set-key (kbd "C-w C-r") 'xref-find-references)
              (local-set-key (kbd "C-w C-d") 'xref-find-definitions)
              (local-set-key (kbd "C-w C-i") 'lsp-find-implementation)
              (local-set-key (kbd "C-w C-w") 'kill-region)
              (local-set-key (kbd "C-w C-b") 'xref-go-back)
              ))
  (add-hook 'rust-mode-hook
            (lambda ()
              (local-set-key (kbd "C-w C-r") 'xref-find-references)
              (local-set-key (kbd "C-w C-d") 'xref-find-definitions)
              (local-set-key (kbd "C-w C-i") 'lsp-find-implementation)
              (local-set-key (kbd "C-w C-w") 'kill-region)
              (local-set-key (kbd "C-w C-b") 'xref-go-back)
              ))
  (add-hook 'c++-mode-hook
            (lambda ()
              (local-set-key (kbd "C-w C-r") 'xref-find-references)
              (local-set-key (kbd "C-w C-d") 'xref-find-definitions)
              (local-set-key (kbd "C-w C-i") 'lsp-find-implementation)
              (local-set-key (kbd "C-w C-w") 'kill-region)
              ;; mac系统下用的是xref-go-back,至于原来用的xref-pop-marker-stack,可能是因为在linux系统下有些特殊原因
              (cond ((eq system-type 'darwin)
                     (local-set-key (kbd "C-w C-b") 'xref-go-back))
                    (t
                     (local-set-key (kdb "C-w C-b") 'xref-pop-marker-stack)))
              ))
  (add-hook 'c-mode-hook
            (lambda ()
              (local-set-key (kbd "C-w C-r") 'xref-find-references)
              (local-set-key (kbd "C-w C-d") 'xref-find-definitions)
              (local-set-key (kbd "C-w C-i") 'lsp-find-implementation)
              (local-set-key (kbd "C-w C-w") 'kill-region)
              ;; mac系统下用的是xref-go-back,至于原来用的xref-pop-marker-stack,可能是因为在linux系统下有些特殊原因
              (cond ((eq system-type 'darwin)
                     (local-set-key (kbd "C-w C-b") 'xref-go-back))
                    (t
                     (local-set-key (kbb "C-w C-b") 'xref-pop-marker-stack)))
              ))

  ;; 将llvm的路径添加到emacs的PATH里
  (when (string-equal system-type "darwin")
    (setenv "PATH" (concat "/opt/homebrew/opt/llvm/bin:" (getenv "PATH")))
    (setq exec-path (cons "/opt/homebrew/opt/llvm/bin" exec-path)))

  ;;关闭smartparens的自动转义功能,防止C++ 文件里输入 ' 自动变成 \'\'
  (with-eval-after-load 'smartparens
    (setq sp-escape-quotes-after-insert nil))

  ;; 设置yasnippet模版目录
  (setq yas-snippet-dirs '("/Users/cpd/my_code/emacs/snippets"))

  ;; 配置markdown-xwidget，加强markdown文件的渲染效果
  (add-to-list 'load-path "~/.emacs.d/site-lisp/markdown-xwidget")
  (use-package markdown-xwidget
    :after markdown-mode
    :bind (:map markdown-mode-command-map
                ("x" . markdown-xwidget-preview-mode))
    :custom
    (markdown-xwidget-command "pandoc")       ; 使用 pandoc 渲染
    (markdown-xwidget-github-theme "light")   ; 主题：light / dark / light-high-contrast 等
    )

  (add-to-list 'load-path "/Users/cpd/my_code/org/anki")
  (require 'anki-system)
  (setq anki-system-root "/Users/cpd/my_code/org/anki")
  )


;; Do not write anything past this comment. This is where Emacs will
;; auto-generate custom variable definitions.
(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
  (custom-set-variables
   ;; custom-set-variables was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   '(custom-safe-themes
     '("a0ac98a1bde5d6336295fd350155a4aac1d63c53c1b3773062271074d16ebeb5"
       "7fd8b914e340283c189980cd1883dbdef67080ad1a3a9cc3df864ca53bdc89cf"
       "f3f7f6d6b08c01b78ee82bc864be47fbfbb15f15382c4f5f458666166c51fbe5" default))
   '(org-agenda-files
     '("~/my_code/org/database.org" "/Users/cpd/my_code/org/agenda/agenda.org"))
   '(package-selected-packages
     '(ac-ispell ace-jump-helm-line ace-link add-node-modules-path aggressive-indent
                 all-the-icons anaconda-mode auctex-latexmk auto-compile
                 auto-highlight-symbol auto-yasnippet blacken centered-cursor-mode
                 clean-aindent-mode code-cells column-enforce-mode
                 company-anaconda company-auctex company-math company-reftex
                 company-web concurrent cond-let counsel counsel-css ctable
                 cython-mode define-word devdocs diminish dired-quiCk-Sort
                 dotenv-mode drag-stuff dumb-jump editorconfig elisp-def
                 elisp-slime-nav emmet-mode emr epc esxml eval-sexp-fu evil-anzu
                 evil-args evil-cleverparens evil-collection evil-escape
                 evil-evilified-state evil-exchange evil-goggles evil-iedit-state
                 evil-indent-plus evil-lion evil-lisp-state evil-matchit evil-mc
                 evil-nerd-commenter evil-numbers evil-org evil-surround evil-tex
                 evil-textobj-line evil-tutor evil-unimpaired
                 evil-visual-mark-mode evil-visualstar expand-region eyebrowse
                 fancy-battery flx-ido flycheck-elsa flycheck-package
                 flycheck-pos-tip fuzzy ggtags git-link git-messenger git-modes
                 git-timemachine gitignore-templates gnu-elpa-keyring-update
                 gnuplot golden-ratio google-translate haml-mode helm-ag
                 helm-c-yasnippet helm-company helm-core helm-cscope helm-css-scss
                 helm-descbinds helm-git-grep helm-ls-git helm-lsp helm-make
                 helm-mode-manager helm-org helm-org-rifle helm-projectile
                 helm-purpose helm-pydoc helm-swoop helm-themes helm-xref
                 hide-comnt highlight-indentation highlight-numbers
                 highlight-parentheses hl-todo holy-mode htmlize hungry-delete
                 hybrid-mode impatient-mode importmagic indent-guide info+
                 inspector ivy kv link-hint live-py-mode load-env-vars lorem-ipsum
                 lsp-latex lsp-origami lsp-pyright lsp-treemacs lsp-ui macrostep
                 multi-line multiple-cursors mustache nameless nose nov ob-go
                 open-junk-file org-anki org-cliplink org-download org-mime
                 org-pomodoro org-present org-projectile org-rich-yank
                 org-superstar orgit overseer paradox password-generator pcre2el
                 pip-requirements pipenv pippel poetry popwin prettier-js promise
                 pug-mode py-isort pydoc pyenv-mode pylookup pytest pythonic
                 pyvenv quickrun rainbow-delimiters request restart-emacs ron-mode
                 rust-mode rustic sass-mode scss-mode simple-httpd slim-mode
                 smeargle space-doc spaceline spacemacs-purpose-popwin
                 spacemacs-whitespace-cleanup sphinx-doc string-edit-at-point
                 string-inflection swiper symbol-overlay symon tagedit term-cursor
                 toc-org treemacs-icons-dired treemacs-magit treemacs-persp
                 treemacs-projectile undo-tree use-package uuidgen vi-tilde-fringe
                 vim-powerline volatile-highlights web-beautify
                 web-completion-data web-mode which-key winum writeroom-mode
                 ws-butler xcscope xterm-color yapfify yasnippet-snippets)))
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   )
  )

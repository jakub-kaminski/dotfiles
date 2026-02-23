;; -*- mode: emacs-lisp; lexical-binding: t -*-
;; This file is loaded by Spacemacs at startup.
;; It must be stored in your home directory.

(defun dotspacemacs/layers ()
  "Layer configuration:
This function should only modify configuration layer settings."
  ;; (set-face-attribute 'default nil :family "Source Code Pro")
  ;; (set-face-attribute 'default nil :height 160)

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
   ;; Paths must have a trailing slash (i.e. `~/.mycontribs/')
   dotspacemacs-configuration-layer-path '()


   ;; List of configuration layers to load.
   dotspacemacs-configuration-layers
   '(yaml
     javascript
     python
     ;; ----------------------------------------------------------------
     ;; Example of useful layers you may want to use right away.
     ;; Uncomment some layer names and press `SPC f e R' (Vim style) or
     ;; `M-m f e R' (Emacs style) to install them.
     ;; ----------------------------------------------------------------
     auto-completion
     better-defaults
     emacs-lisp
     git
     helm
     lsp
     dap
     myleetcode
     ;; debug
     ;;markdown
     ;; multiple-cursors
     org
     ;; (shell :variables
     ;;        shell-default-height 30
     ;;        shell-default-position 'bottom)
     (shell :variables
            shell-default-shell 'vterm)
     shell-scripts
     spell-checking
     syntax-checking
     treemacs
     ;; version-control
     )

   ;; JTK unsure
   ;; (defun python/pre-init-dap-mode ()
   ;;   (when (eq python-backend 'lsp)
   ;;     (add-to-list 'spacemacs--dap-supported-modes 'python-mode))
   ;;   (add-hook 'python-mode-local-vars-hook #'spacemacs//python-setup-dap))

   ;; List of additional packages that will be installed without being wrapped
   ;; in a layer (generally the packages are installed only and should still be
   ;; loaded using load/require/use-package in the user-config section below in
   ;; this file). If you need some configuration for these packages, then
   ;; consider creating a layer. You can also put the configuration in
   ;; `dotspacemacs/user-config'. To use a local version of a package, use the
   ;; `:location' property: '(your-package :location "~/path/to/your-package/")
   ;; Also include the dependencies as they will not be resolved automatically.
   dotspacemacs-additional-packages
   '(
     anki-editor
     lsp-mode
     sqlite3
     org-bullets
     websocket
     )

   ;; A list of packages that cannot be updated.
   dotspacemacs-frozen-packages '()

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
   ;; If non-nil then enable support for the portable dumper. You'll need
   ;; to compile Emacs 27 from source following the instructions in file
   ;; EXPERIMENTAL.org at to root of the git repository.
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
   ;; performance issues due to garbage collection operations.
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
   dotspacemacs-editing-style 'vim

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
   dotspacemacs-startup-lists '((recents . 15)
                                (projects . 7))

   ;; True if the home buffer should respond to resize events. (default t)
   dotspacemacs-startup-buffer-responsive t

   ;; Show numbers before the startup list lines. (default t)
   dotspacemacs-show-startup-list-numbers t

   ;; The minimum delay in seconds between number key presses. (default 0.4)
   dotspacemacs-startup-buffer-multi-digit-delay 0.4

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

   ;; changed JTK
   ;; dotspacemacs-themes '(spacemacs-dark
   ;;                      spacemacs-light)

   dotspacemacs-themes '(spacemacs-dark
                         spacemacs-light)

   ;;dotspacemacs-themes '((intern (format "base16-%s" (getenv "BASE16T"))))

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
                               :size 12.0
                               :weight normal
                               :width normal)

   ;; dotspacemacs-default-font '("adobe-source-code-pro"
   ;;                             :size 13
   ;;                             :weight normal
   ;;                             :width normal
   ;;                             :powerline-scale 1.1)

   ;; dotspacemacs-default-font '("Ubuntu Mono"
   ;;                             :size 24.0
   ;;                             :weight normal
   ;;                             :width normal
   ;;                             :powerline-scale 2.0)


   ;;(text-scale-adjust 2)
   ;;(add-to-list 'default-frame-alist '(font .  "Ubuntu Mono" )))
   ;;(set-face-attribute 'default t :font  "Ubuntu Mono" )

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
   ;; (default nil) (Emacs 24.4+ only)
   dotspacemacs-maximized-at-startup nil

   ;; If non-nil the frame is undecorated when Emacs starts up. Combine this
   ;; variable with `dotspacemacs-maximized-at-startup' in OSX to obtain
   ;; borderless fullscreen. (default nil)
   dotspacemacs-undecorated-at-startup nil

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's active or selected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-active-transparency 90

   ;; A value from the range (0..100), in increasing opacity, which describes
   ;; the transparency level of a frame when it's inactive or deselected.
   ;; Transparency can be toggled through `toggle-transparency'. (default 90)
   dotspacemacs-inactive-transparency 90

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
   dotspacemacs-line-numbers nil

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
   dotspacemacs-search-tools '("rg" "ag" "pt" "ack" "grep")

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

   ;; Show trailing whitespace (default t)
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

  (setq org-clock-sound "~/Downloads/mixkit-magic-notification-ring-2344.wav")

  ;; dotspacemacs-themes `( ,(intern (format "base16-%s" (getenv "BASE16T"))))
  (setq python-shell-interpreter "python3")

  (setq python-python-command "~/usr/bin/python3")



  (setq org-src-preserve-indentation t)

  ;; src block indentation / editing / syntax highlighting
  (setq org-src-fontify-natively t
        org-src-window-setup 'current-window ;; edit in current window
        org-src-strip-leading-and-trailing-blank-lines t
        org-src-preserve-indentation t ;; do not put two spaces on the left
        org-src-tab-acts-natively t)

  (setq org-edit-src-content-indentation 0)

  ;; Run/highlight code using babel in org-mode
  ;; Wrapped in with-eval-after-load to ensure org is loaded first
  (with-eval-after-load 'org
    (org-babel-do-load-languages
     'org-babel-load-languages
     '(
       (C . t)
       (python . t)
       (lisp . t)
       (shell . t)
       )))

  (defvar org-babel-eval-verbose t
    "A non-nil value makes `org-babel-eval' display")

  (defun org-babel-eval (command query)
    "Run COMMAND on QUERY. Writes QUERY into a temp-buffer that is processed with `org-babel--shell-command-on-region'.  If COMMAND succeeds then return its results, otherwise display STDERR with `org-babel-eval-error-notify'."
    (let ((error-buffer (get-buffer-create " *Org-Babel Error*")) exit-code)
      (with-current-buffer error-buffer (erase-buffer))
      (with-temp-buffer
        (insert query)
        (setq exit-code
              (org-babel--shell-command-on-region
               command error-buffer))

        (if (or (not (numberp exit-code)) (> exit-code 0)
                (and org-babel-eval-verbose (> (buffer-size error-buffer) 0)))
            (progn
              (with-current-buffer error-buffer
                (org-babel-eval-error-notify exit-code (buffer-string)))
              (save-excursion
                (when (get-buffer org-babel-error-buffer-name)
                  (with-current-buffer org-babel-error-buffer-name
                    (unless (derived-mode-p 'compilation-mode)
                      (compilation-mode))
                    ;; Compilation-mode enforces read-only, but Babel expects the buffer modifiable.
                    (setq buffer-read-only nil))))
              nil)
          (buffer-string)))))


  ;; Syntax highlight in #+BEGIN_SRC blocks
  (setq org-src-fontify-natively t)
  ;; Don't prompt before running code in org
  (setq org-confirm-babel-evaluate nil)
  ;; Fix an incompatibility between the ob-async and ob-ipython packages
  ;; (setq ob-async-no-async-languages-alist '("ipython"))


  ;; tip: load using M-x customize-variable org-load-languages
  ;; (org-babel-do-load-languages
  ;; 'org-babel-load-languages
  ;;    '((python . t)
  ;;      (C . t)))

  ;;(org-babel-python-command
  ;; (or (cdr (assq :python /usr/bin/python3))
  ;;     org-babel-python-command))

  (setq org-babel-python-command "python3")

  (setq x-select-enable-clipboard t)
  )


(defun dotspacemacs/user-load ()
  "Library to load while dumping.
  This function is called only while dumping Spacemacs configuration. You can
  `require' or `load' the libraries of your choice that will be included in the
  dump."
)


(defun dotspacemacs/user-config ()
  "Configuration for user code:
  This function is called at the very end of Spacemacs startup, after layer
  configuration.
  Put your configuration code here, except for variables that should be set
  before packages are loaded."

  "Change magit git log date format"
  (setq magit-log-margin '(t "%Y-%m-%d %H:%M " magit-log-margin-width t 18))
  (setq magit-git-debug t)

  (with-eval-after-load 'magit
    (define-key magit-mode-map (kbd "C-c C-z") 'recenter-top-bottom))

  (with-eval-after-load 'org
    (require 'org-bullets)
    (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

  (defun +org-attach-link-every-attachment-to-current-dir ()
    "Got through current org buffer, check for attachments
  and link them to the current directory so that there
  aren't any issues with pushing images inserted by
  org-download using attachment: link type into Anki.

  Intended as workaround for `anki-editor--ox-html-link'.
  "
    ;; uncomment following line if you want this fn as command in M-x menu
    ;; (interactive)
    (org-element-map (org-element-parse-buffer) 'headline
      (lambda (headline)
        (let ((tags (org-element-property :tags headline))
              (buffer-file-dir
               (directory-file-name
                (file-name-directory
                 (buffer-file-name (org-base-buffer (current-buffer)))))))
          (if (cl-member "ATTACH" tags :test #'string-equal)
              (seq-map
               (lambda (file)
                 (make-symbolic-link
                  file
                  (expand-file-name (file-name-nondirectory file) buffer-file-dir)
                  'ok-if-already-exists))
               (directory-files-recursively
                (org-attach-dir-get-create) ".*" nil)))))))


  (defun make-orgcapture-frame ()
    "Create a new frame and run org-capture."
    (interactive)
    (make-frame '((name . "org-capture") (window-system . x) (width . 100) (height . 24)))
    (select-frame-by-name "org-capture")
    (org-capture)
    )


  ;; org-download
  (require 'org-download)
  ;; org-download use buffer-local variables. Set it individually in files. Otherwise, put things flatly in misc
  ;; folder.
  (setq-default org-download-method 'directory
                org-download-image-dir "/home/jakub/Drive/AnkiImages/"
                org-download-heading-lvl nil
                org-download-delete-image-after-download t
                org-download-screenshot-method "flameshot gui --raw > %s"
                org-download-image-org-width 600
                org-download-annotate-function (lambda (link) "") ;; Don't annotate
                )
  (add-hook 'dired-mode-hook 'org-download-enable)
  (global-set-key (kbd "<print>") 'org-download-screenshot)
  ;; Use #+ATTR_ORG: :width 300px to customized image display width
  (setq org-image-actual-width nil)

  ;;(add-hook 'emacs-lisp-mode-hook #'aggressive-indent-mode)
  ;;(add-hook 'css-mode-hook #'aggressive-indent-mode)

  (global-aggressive-indent-mode 1)
  (add-to-list 'aggressive-indent-excluded-modes 'html-mode)

  (add-to-list
   'aggressive-indent-dont-indent-if
   '(and (derived-mode-p 'c++-mode)
         (null (string-match "\\([;{}]\\|\\b\\(if\\|for\\|while\\)\\b\\)"
                             (thing-at-point 'line)))))

  ;; Org-capture templates
  (setq org-my-anki-file "/home/jakub/Drive/AnkiImages/anki.org")
  (setq org-my-anki-codequick-file "/home/jakub/Drive/AnkiImages/codequick.org")
  (setq org-my-anki-dsa-problems-file "/home/jakub/Drive/AnkiImages/dsa-problems.org")
  (setq org-my-python-course-file "/home/jakub/Drive/AnkiImages/python-course.org")
  (setq org-my-anki-code-quiz-file "/home/jakub/Drive/AnkiImages/code_quiz.org")
  (setq python-course-org-heading "PythonDSA")
  ;; Capturing thoughts and Level 1 Headings.

  ;; Unused templates
  ;; ("c" "Add tasks" ;; Capture first, refile daily
  ;; entry
  ;; (file+headline org-my-todo-file "Inbox")
  ;; "* TODO %?\n" :prepend t)

  ;; ("r" "Read later: Within Emacs"
  ;;  entry
  ;;  (file+olp org-my-todo-file "Reading" "Later")
  ;;  "* TODO %a"
  ;;  :prepend t
  ;; :immediate-finish t)

  ;; ("m" "Appointment"
  ;;  entry
  ;;  (file+headline org-my-todo-file "Inbox")
  ;;  "* APPT %?\n" :prepend t)
  ;;
  ;; ("j" "Decision Log"
  ;;  plain
  ;;  (file+olp+datetree org-my-work-file "Decision Log")
  ;;  ""
  ;;  :prepend t)


  (setq org-capture-templates
        '(
          ("h" "LeetCode - CodeQuick"
           entry
           (file+headline org-my-anki-codequick-file "LeetCode")
           "%[/home/jakub/Drive/AnkiImages/codequick-template.txt]")

          ("s" "Striver Graph - CodeQuick"
           entry
           (file+headline org-my-anki-codequick-file "Striver Graph")
           "%[/home/jakub/Drive/AnkiImages/codequick-template.txt]")

          ;; ("a" "Algorithms - CodeQuick"
          ;;  entry
          ;;  (file+headline org-my-anki-codequick-file "Algorithms")
          ;;  "%[/home/jakub/Drive/AnkiImages/codequick-template.txt]")

          ("a" "Anki Algorithms"
           entry
           (file+headline org-my-anki-file "Algorithms")
           "* %<%H:%M>   :algorithms:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Basic\n:ANKI_DECK: Mega\n:END:\n** Front\n%?\n** URL\n%?\n** Back\n%x\n")

          ("b" "Anki Behavioral"
           entry
           (file+headline org-my-anki-file "Behavioral")
           "* %<%H:%M>   :behavioral:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Basic\n:ANKI_DECK: Mega\n:END:\n** Front\n%?\n** URL\n%?\n** Back\n%x\n")

          ("c" "Anki C++"
           entry
           (file+headline org-my-anki-file "Programming")
           "* %<%H:%M>   :cpp:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Basic\n:ANKI_DECK: Mega\n:END:\n** Front\n%?\n** URL\n%?\n** Back\n%x\n")

          ("q" "Anki Quiz C++"
           entry
           (file+headline org-my-anki-code-quiz-file "C++ Quiz")
           "* %<%H:%M>   :cpp-quiz:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Basic\n:ANKI_DECK: Mega\n:END:\n** Front\n*What is the program output?*\n#+begin_src cpp\n%x\n#+end_src\n** URL\n\n** Back\n\n")

          ("Q" "Anki Quiz Python"
           entry
           (file+headline org-my-anki-code-quiz-file "Python Quiz")
           "* %<%H:%M>   :py-quiz:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Basic\n:ANKI_DECK: Mega\n:END:\n** Front\n%?\n** URL\n%?\n** Back\n%x\n")


          ("C" "Anki C++ Type"
           entry
           (file+headline org-my-anki-file "Programming")
           "* %<%H:%M>   :cpp:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: TypeBasic\n:ANKI_DECK: Mega\n:END:\n** Front\n%?\n** Type\n%x\n** URL\n%?\n** Back\n%?\n")

          ("d" "Anki DevOps"
           entry
           (file+headline org-my-anki-file "DevOps")
           "* %<%H:%M>   :devops:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Basic\n:ANKI_DECK: Mega\n:END:\n** Front\n%?\n** URL\n%?\n** Back\n%x\n")

          ("e" "Anki English"
           entry
           (file+headline org-my-anki-file "English")
           "* %<%H:%M>   :english:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Barron\n:ANKI_DECK: Mega\n:END:\n** word\n%?\n** type\n%?\n** description\n%?\n** example1\n%x\n** image\n%?\n** notes\n%?\n** pl\n%?\n")

          ("p" "Anki DSA-Problems"
           entry
           (file+headline org-my-anki-dsa-problems-file "Dispatch")
           "* %<%H:%M>   :dsa:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: BasicDSA\n:ANKI_DECK: Mega\n:END:\n** Question\n%?\n** Examples\n%?\n** Approach\n- Optimal: \n- Medium: \n - Brute: \n** Solution\n#+begin_src cpp\n%x\n#+end_src \n** Links\n%?\n")

          ("1" "Arrays DSA"
           entry
           (file+headline org-my-anki-dsa-problems-file "Array")
           "* %<%H:%M>   :array:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: BasicDSA\n:ANKI_DECK: MegaDSA\n:END:\n** Question\n%?\n** Examples\n%?\n** Approach\n- Optimal: \n- Medium: \n - Brute: \n** Solution\n#+begin_src cpp\n%x\n#+end_src \n** Links\n%?\n")

          ("2" "Linked List DSA"
           entry
           (file+headline org-my-anki-dsa-problems-file "Linked List")
           "* %<%H:%M>   :linked_list:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: BasicDSA\n:ANKI_DECK: MegaDSA\n:END:\n** Question\n%?\n** Examples\n%?\n** Approach\n- Optimal: \n- Medium: \n - Brute: \n** Solution\n#+begin_src cpp\n%x\n#+end_src \n** Links\n%?\n")

          ("3" "Greedy Algorithm DSA"
           entry
           (file+headline org-my-anki-dsa-problems-file "Greedy Algorithm")
           "* %<%H:%M>   :greedy:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: BasicDSA\n:ANKI_DECK: MegaDSA\n:END:\n** Question\n%?\n** Examples\n%?\n** Approach\n- Optimal: \n- Medium: \n - Brute: \n** Solution\n#+begin_src cpp\n%x\n#+end_src \n** Links\n%?\n")

          ("4" "Recursion DSA"
           entry
           (file+headline org-my-anki-dsa-problems-file "Recursion")
           "* %<%H:%M>   :recursion:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: BasicDSA\n:ANKI_DECK: MegaDSA\n:END:\n** Question\n%?\n** Examples\n%?\n** Approach\n- Optimal: \n- Medium: \n - Brute: \n** Solution\n#+begin_src cpp\n%x\n#+end_src \n** Links\n%?\n")

          ("5" "Binary Search DSA"
           entry
           (file+headline org-my-anki-dsa-problems-file "Binary Search")
           "* %<%H:%M>   :binary_search:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: BasicDSA\n:ANKI_DECK: MegaDSA\n:END:\n** Question\n%?\n** Examples\n%?\n** Approach\n- Optimal: \n- Medium: \n - Brute: \n** Solution\n#+begin_src cpp\n%x\n#+end_src \n** Links\n%?\n")

          ("6" "Heap DSA"
           entry
           (file+headline org-my-anki-dsa-problems-file "Heap")
           "* %<%H:%M>   :heap:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: BasicDSA\n:ANKI_DECK: MegaDSA\n:END:\n** Question\n%?\n** Examples\n%?\n** Approach\n- Optimal: \n- Medium: \n - Brute: \n** Solution\n#+begin_src cpp\n%x\n#+end_src \n** Links\n%?\n")

          ("7" "Stack and Queue DSA"
           entry
           (file+headline org-my-anki-dsa-problems-file "Stack and Queue")
           "* %<%H:%M>   :stack_queue:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: BasicDSA\n:ANKI_DECK: MegaDSA\n:END:\n** Question\n%?\n** Examples\n%?\n** Approach\n- Optimal: \n- Medium: \n - Brute: \n** Solution\n#+begin_src cpp\n%x\n#+end_src \n** Links\n%?\n")

          ("8" "String DSA"
           entry
           (file+headline org-my-anki-dsa-problems-file "String")
           "* %<%H:%M>   :string:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: BasicDSA\n:ANKI_DECK: MegaDSA\n:END:\n** Question\n%?\n** Examples\n%?\n** Approach\n- Optimal: \n- Medium: \n - Brute: \n** Solution\n#+begin_src cpp\n%x\n#+end_src \n** Links\n%?\n")

          ("9" "Tree DSA"
           entry
           (file+headline org-my-anki-dsa-problems-file "Tree")
           "* %<%H:%M>   :tree:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: BasicDSA\n:ANKI_DECK: MegaDSA\n:END:\n** Question\n%?\n** Examples\n%?\n** Approach\n- Optimal: \n- Medium: \n - Brute: \n** Solution\n#+begin_src cpp\n%x\n#+end_src \n** Links\n%?\n")

          ("0" "Graph DSA"
           entry
           (file+headline org-my-anki-dsa-problems-file "Graph")
           "* %<%H:%M>   :graph:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: BasicDSA\n:ANKI_DECK: MegaDSA\n:END:\n** Question\n%?\n** Examples\n%?\n** Approach\n- Optimal: \n- Medium: \n - Brute: \n** Solution\n#+begin_src cpp\n%x\n#+end_src \n** Links\n%?\n")

          ("D" "Dynamic Programming DSA"
           entry
           (file+headline org-my-anki-dsa-problems-file "Dynamic Programming")
           "* %<%H:%M>   :dyn_prog:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: BasicDSA\n:ANKI_DECK: MegaDSA\n:END:\n** Question\n%?\n** Examples\n%?\n** Approach\n- Optimal: \n- Medium: \n - Brute: \n** Solution\n#+begin_src cpp\n%x\n#+end_src \n** Links\n%?\n")

          ("x" "Mixed Problems DSA"
           entry
           (file+headline org-my-anki-dsa-problems-file "Dynamic Programming")
           "* %<%H:%M>   :dsa_misc:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: BasicDSA\n:ANKI_DECK: MegaDSA\n:END:\n** Question\n%?\n** Examples\n%?\n** Approach\n- Optimal: \n- Medium: \n - Brute: \n** Solution\n#+begin_src cpp\n%x\n#+end_src \n** Links\n%?\n")

          ("l" "Anki Python Design Patterns"
           entry
           (file+headline org-my-python-course-file "Python Design Patterns")
           "*** %<%H:%M>   :python:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Basic\n:ANKI_DECK: PythonDeepDive\n:END:\n**** Front\n%?\n**** URL\n%?\n**** Back\n%x\n")

          ("k" "Dive into Design Patterns"
           entry
           (file+headline org-my-anki-file "Dive Into Design Patterns")
           "* %<%H:%M>   :patterns:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Basic\n:ANKI_DECK: Mega\n:END:\n** Front\n%?\n** URL\n%?\n** Back\n%x\n")

          ("y" "anki python course regular"
           entry
           (file+headline org-my-python-course-file "pytest")
           "*** %<%h:%m>   :python:\n:properties:\n:anki_note_type: basic\n:anki_deck: pythondeepdive\n:end:\n**** front\n%?\n**** url\n%?\n**** back\n%x\n")

          ("Y" "Anki Python Course Type answer"
           entry
           (file+headline org-my-python-course-file "Pytest")
           "*** %<%H:%M>   :python:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: TypeBasic\n:ANKI_DECK: PythonDeepDive\n:END:\n**** Front\n%?\n**** Type\n%x\n**** URL\n%?\n**** Back\n%?\n")

          ;; ("y" "Anki Python Course Regular"
          ;;  entry
          ;;  (file+headline org-my-python-course-file "PythonDSA")
          ;;  "* %<%H:%M>   :python:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Basic\n:ANKI_DECK: PythonDeepDive\n:END:\n** Front\n%?\n** URL\n%?\n** Back\n%x\n")

          ;; ("Y" "Anki Python Course Type answer"
          ;;  entry
          ;;  (file+headline org-my-python-course-file "PythonDSA")
          ;;  "* %<%H:%M>   :python:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: TypeBasic\n:ANKI_DECK: PythonDeepDive\n:END:\n** Front\n%?\n** Type\n%x\n** URL\n%?\n** Back\n%?\n")

          ("m" "Anki Control&Motion"
           entry
           (file+headline org-my-anki-file "Robotics")
           "* %<%H:%M>   :motioncontrol:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Basic\n:ANKI_DECK: Mega\n:END:\n** Front\n%?\n** URL\n%?\n** Back\n%x\n")

          ("l" "Anki Mechanical"
           entry
           (file+headline org-my-anki-file "Robotics")
           "* %<%H:%M>   :mechanical:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Basic\n:ANKI_DECK: Mega\n:END:\n** Front\n%?\n** URL\n%?\n** Back\n%x\n")

          ("v" "Anki Vision"
           entry
           (file+headline org-my-anki-file "Robotics")
           "* %<%H:%M>   :vision:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Basic\n:ANKI_DECK: Mega\n:END:\n** Front\n%?\n** URL\n%?\n** Back\n%x\n")

          ("r" "Anki Random/Misc"
           entry
           (file+headline org-my-anki-file "Misc")
           "* %<%H:%M>   :misc:\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Basic\n:ANKI_DECK: Mega\n:END:\n** Front\n%?\n** URL\n%?\n** Back\n%x\n")

          ("A" "Anki cloze"
           entry
           (file+headline org-my-anki-file "Dispatch Shelf")
           "* %<%H:%M>   %^g\n:PROPERTIES:\n:ANKI_NOTE_TYPE: Cloze\n:ANKI_DECK: Mega\n:END:\n** Text\n%x\n** Extra\n")

          ("s" "src"
           (add-to-list 'org-structure-template-alist '("r" . "src R")))

          ("w" "Archive Web Content to Roam"
           entry
           (file org-board-capture-file)
           "* %?%:description :board:\n:PROPERTIES:\n:URL: %:link\n:END:\n%i"
           :prepend t
           :immediate-finish t)
          ("s" "Capture selected text from web"
           entry
           (file org-board-capture-file)
           "* %?%:description \n:PROPERTIES:\n:URL: %:link\n:END:\n\n%i%:body"
           :prepend t)

          ;; ("b" "finance book-keeping"
          ;;  plain
          ;;  (file+headline org-my-beancount-file "Expenses")
          ;;  "bc%?"  ;; yasnippet template
          ;;  :prepend t)
          ))

  ;;(with-eval-after-load 'org
  ;;  (add-to-list 'org-structure-template'("p" . "src python")))

  ;; Allow Emacs to access content from clipboard.
  (setq x-select-enable-clipboard t
        x-select-enable-primary t)

  ;;(python-shell-interpreter "python3")

  (use-package ob-shell
    :after org
    :config
    (setq org-babel-default-header-args:sh '((:results . "output")))
    (setq org-babel-default-header-args:python '((:results . "output")))
    (setq org-babel-default-header-args:shell '((:results . "output"))))

  ;; potentially comment JTK
  (use-package python-mode
    :ensure t
    :hook (python-mode . lsp-deferred)
    :custom
    (python-shell-interpreter "python3")
    (dap-python-executable "python3")
    ;;    (dap-python-executable "/home/jakub/PycharmProjects/Boilerplate/venv/bin/python3")
    (dap-python-debugger 'debugpy)
    ;; (dap-python-debugger 'ptvsd)
    :config
    (require 'dap-python))

  ;; install dap-mode
  ;; (use-package python-mode
  ;;   :ensure t
  ;;   :hook (python-mode . lsp-deferred)
  ;;   :custom
  ;;   (python-shell-interpreter "python3")
  ;;   (dap-python-executable "python3")
  ;;   (dap-python-debugger 'debugpy)
  ;;   :config
  ;;   (require 'dap-mode))

  ;; Enabling only some features
  (setq dap-auto-configure-features '(sessions locals controls tooltip))

  ;; from emacs doom
  ;; (after! dap-mode
  ;;         (setq dap-python-debugger 'debugpy))


  ;; (use-package python-mode
  ;;   :ensure t
  ;;   :hook (python-mode . lsp-deferred)
  ;;   :custom
  ;;   (python-shell-interpreter "/tmp/PythonDSA/bin/python"))

  ;; Python Experimental JTK
  ;; (use-package lsp-pyright
  ;;   :hook (python-mode . (lambda ()
  ;;                          (require 'lsp-pyright)
  ;;                          (lsp-deferred))))

  ;; (use-package python-mode
  ;;   :hook (python-mode . lsp-deferred)
  ;;   :custom
  ;;   ;; NOTE: Set these if Python 3 is called "python3" on your system!
  ;;   ;; (python-shell-interpreter "python3")
  ;;   ;; (dap-python-executable "python3")
  ;;   (dap-python-debugger 'debugpy)
  ;;   :config
  ;;   (require 'dap-python))

  ;; (use-package pyvenv
  ;;   :after python-mode
  ;;   :config
  ;;   (pyvenv-mode 1))

  ;; (use-package py-isort
  ;;   :after python
  ;;   :hook ((python-mode . pyvenv-mode)
  ;;          (before-save . py-isort-before-save)))

  ;; (use-package blacken
  ;;   :delight
  ;;   :hook (python-mode . blacken-mode)
  ;;   :custom (blacken-line-length 79))


  ;; JTK works okay
  ;; (use-package lsp-jedi
  ;;   :ensure t
  ;;   :config
  ;;   (with-eval-after-load "lsp-mode"
  ;;     (add-to-list 'lsp-disabled-clients 'pyls)
  ;;     (add-to-list 'lsp-enabled-clients 'jedi))
  ;;   )

  ;; :custom
  ;; (python-shell-interpreter "python3")

  ;; (setq python-shell-interpreter "python3")

  ;; (setq python-shell-interpreter "/home/jakub/PycharmProjects/ANA* Coding/venv/bin/python3")
  ;; (setq python-python-command "/home/jakub/PycharmProjects/ANA* Coding/venv/bin/python3")
  ;; (setq py-python-command "/home/jakub/PycharmProjects/ANA* Coding/venv/bin/python3")

  (define-key evil-normal-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
  (define-key evil-visual-state-map (kbd "C-a") 'evil-numbers/inc-at-pt)
  (define-key evil-normal-state-map (kbd "C-x") 'evil-numbers/dec-at-pt)
  (define-key evil-visual-state-map (kbd "C-x") 'evil-numbers/dec-at-pt)

  ;; Make C-c C-c behave like C-u C-c C-c in Python mode
  (require 'python)
  (define-key python-mode-map (kbd "C-c C-c")
    (lambda () (interactive) (python-shell-send-buffer t)))

  ;; (setq python-python-command "~/usr/bin/python3")

  ;; (use-package pyvenv
  ;;   :ensure t
  ;;   :config
  ;;   (pyvenv-mode t)

  ;; Set correct Python interpreter
  ;; (setq pyvenv-post-activate-hooks
  ;;       (list (lambda ()
  ;;               (setq python-shell-interpreter (concat pyvenv-virtual-env "bin/python3")))))
  ;; (setq pyvenv-post-deactivate-hooks
  ;;       (list (lambda ()
  ;;               (setq python-shell-interpreter "python3")))))


  ;; (setq py-python-command "python3")

  ;; (setq lsp-jedi-workspace-extra-paths
  ;;       (vconcat lsp-jedi-workspace-extra-paths
  ;;                ["/home/me/src/my-project/.venv/lib/python3.10/site-packages"]))

  ;;(setq lsp-jedi-workspace-extra-paths
  ;;      (vconcat lsp-jedi-workspace-extra-paths
  ;;               ["/home/jakub/PycharmProjects/ANA* Coding/venv/lib/python3.8/site-packages"]))

  ;;(python-shell-interpreter "home/jakub/PycharmProjects/ANA* Coding/venv/bin/python3")

  ;; (python-shell-interpreter "home/jakub/PycharmProjects/ANA* Coding/venv/bin/python3")

  ;; (setq python - shell - interpreter "home/jakub/PycharmProjects/ANA* Coding/venv/bin/python3")
  ;; (setq python - shell - interpreter "python3")

  ;; (require 'lsp-clients)

  ;; (use-package pipenv
  ;;   :hook (python-mode . pipenv-mode)
  ;;   :commands (pipenv-mode
  ;;              pipenv-activate
  ;;              pipenv-run))

  (setq-default dotspacemacs-configuration-layers
                '((debug :variables debug-additional-debuggers '("pdb"))))

  (add-hook 'python-mode-hook (lambda ()
                                (flycheck-mode 1)
                                (semantic-mode 1)
                                (setq flycheck-checker 'python-pylint
                                      flycheck-checker-error-threshold 900
                                      flycheck-pylintrc "~/.pylintrc")))

  (use-package anki-editor
    :after org
    :bind (:map org-mode-map
                ("<f12>" . anki-editor-cloze-region-auto-incr)
                ("<f11>" . anki-editor-cloze-region-dont-incr)
                ("<f10>" . anki-editor-reset-cloze-number)
                ("<f8>" . anki-editor-insert-note)
                ("<f9>"  . anki-editor-push-tree))
    :hook (org-capture-after-finalize . anki-editor-reset-cloze-number) ; Reset cloze-number after each capture.
    :config
    (setq anki-editor-create-decks t ;; Allow anki-editor to create a new deck if it doesn't exist
          anki-editor-org-tags-as-anki-tags t)

    (defun anki-editor-cloze-region-auto-incr (&optional arg)
      "Cloze region without hint and increase card number."
      (interactive)
      (anki-editor-cloze-region my-anki-editor-cloze-number "")
      (setq my-anki-editor-cloze-number (1+ my-anki-editor-cloze-number))
      (forward-sexp))
    (defun anki-editor-cloze-region-dont-incr (&optional arg)
      "Cloze region without hint using the previous card number."
      (interactive)
      (anki-editor-cloze-region (1- my-anki-editor-cloze-number) "")
      (forward-sexp))
    (defun anki-editor-reset-cloze-number (&optional arg)
      "Reset cloze number to ARG or 1"
      (interactive)
      (setq my-anki-editor-cloze-number (or arg 1)))
    (defun anki-editor-push-tree ()
      "Push all notes under a tree."
      (interactive)
      (anki-editor-push-notes '(4))
      (anki-editor-reset-cloze-number))
    ;; Initialize
    (anki-editor-reset-cloze-number)
    )

  ;; allow comment region in the code edit buffer (according to language)
  (defun my-org-comment-dwim (&optional arg)
    (interactive "P")
    (or (org-babel-do-key-sequence-in-edit-buffer (kbd "M-;"))
        (comment-dwim arg)))

  (defun codequick-update ()
    (interactive)
    (insert (shell-command-to-string (format "python3 /home/jakub/PycharmProjects/emacs-algo-playground/src/codequick.py")) (revert-buffer t t)))

  ;; (global-unset-key (kbd "C-f"))
  ;; make `C-c C-v C-x M-;' more convenient
  ;;(define-key org-mode-map
  ;;    (kbd "C-f") 'my-org-comment-dwim)

  (define-key evil-visual-state-map (kbd "C-/") 'my-org-comment-dwim)
  ;; (define-key evil-normal-state-map (kbd "C-/") 'my-org-comment-dwim)

  ;; (define-key evil-normal-state-map (kbd "?\C-?") 'spacemacs/alternate-buffer)
  (define-key evil-normal-state-map [?\C-?] 'spacemacs/alternate-buffer)
  ;; (define-key org-mode-map [?\C-?] 'spacemacs/alternate-buffer)
  (define-key org-mode-map (kbd "<normal-state> ?\C-?") 'spacemacs/alternate-buffer)

  (define-key evil-normal-state-map (kbd "?") 'search-backward)

  ;;(global-unset-key (kbd "C-/"))

  ;;(global-set-key (kbd "C-/") 'my-org-comment-dwim)

  ;; (evilem-default-keybindings ",")

  ;; (evilem-define (kbd ",f") 'evil-forward-word-begin)

  ;; ============================================================
  ;; Claude Code IDE Configuration
  ;; ============================================================
  ;; Load websocket from local clone
  (add-to-list 'load-path "~/.emacs.d/private/local/websocket")
  (require 'websocket)

  ;; Load claude-code-ide from local clone
  (add-to-list 'load-path "~/.emacs.d/private/local/claude-code-ide")
  (require 'claude-code-ide)

  ;; Use vterm as terminal backend
  (setq claude-code-ide-terminal-backend 'vterm)

  ;; Keybindings under SPC a c (applications -> claude)
  (spacemacs/declare-prefix "ac" "claude-code")
  (spacemacs/set-leader-keys
    "acc" 'claude-code-ide-toggle           ;; Toggle Claude Code window
    "acm" 'claude-code-ide-menu             ;; Open Claude menu
    "acp" 'claude-code-ide-send-prompt      ;; Send prompt to Claude
    "acb" 'claude-code-ide-switch-to-buffer ;; Switch to Claude buffer
    "acr" 'claude-code-ide-resume           ;; Resume session
    "acs" 'claude-code-ide-stop             ;; Stop Claude
    )
  ;; Additional convenient keybinding
  (global-set-key (kbd "C-c C-'") 'claude-code-ide-toggle)

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
   '("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default))
 '(evil-want-Y-yank-to-eol nil)
 '(org-babel-load-languages '((C . t) (python . t)))
 '(package-selected-packages
   '(yaml-mode company-shell fish-mode flycheck-bashate insert-shebang shfmt reformatter web-beautify tern prettier-js npm-mode nodejs-repl livid-mode skewer-mode js2-refactor multiple-cursors js2-mode js-doc import-js grizzl impatient-mode simple-httpd add-node-modules-path leetcode graphql aio olivetti virtualenvwrapper lsp-jedi treemacs-tab-bar vcomplete treemacs-all-the-icons python-mode cl-libify aggressive-completion lsp-docker xah-fly-keys counsel-org-capture-string anki-editor yapfify stickyfunc-enhance sphinx-doc pytest pyenv-mode pydoc py-isort poetry pippel pipenv pyvenv pip-requirements nose lsp-python-ms lsp-pyright live-py-mode importmagic epc ctable concurrent deferred helm-pydoc helm-gtags helm-cscope xcscope ggtags dap-mode lsp-treemacs bui lsp-mode cython-mode counsel-gtags counsel swiper ivy company-anaconda blacken anaconda-mode pythonic yasnippet-snippets unfill treemacs-magit smeargle orgit-forge orgit org-rich-yank org-projectile org-category-capture org-present org-pomodoro alert log4e gntp org-mime org-download org-contrib org-cliplink org mwim mmm-mode markdown-toc htmlize helm-org-rifle helm-git-grep helm-company helm-c-yasnippet gnuplot gitignore-templates git-timemachine git-modes git-messenger git-link gh-md fuzzy forge yaml markdown-mode magit ghub closql emacsql-sqlite emacsql treepy magit-section git-commit with-editor transient flyspell-correct-helm flyspell-correct flycheck-pos-tip pos-tip evil-org company auto-yasnippet yasnippet auto-dictionary ac-ispell auto-complete ws-butler writeroom-mode winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package undo-tree treemacs-projectile treemacs-persp treemacs-icons-dired treemacs-evil toc-org symon symbol-overlay string-inflection string-edit spaceline-all-the-icons restart-emacs request rainbow-delimiters quickrun popwin pcre2el password-generator paradox overseer org-superstar open-junk-file nameless multi-line macrostep lorem-ipsum link-hint inspector info+ indent-guide hybrid-mode hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation helm-xref helm-themes helm-swoop helm-purpose helm-projectile helm-org helm-mode-manager helm-make helm-ls-git helm-flx helm-descbinds helm-ag google-translate golden-ratio font-lock+ flycheck-package flycheck-elsa flx-ido fancy-battery eyebrowse expand-region evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-textobj-line evil-surround evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state evil-lion evil-indent-plus evil-iedit-state evil-goggles evil-exchange evil-escape evil-ediff evil-easymotion evil-collection evil-cleverparens evil-args evil-anzu eval-sexp-fu emr elisp-slime-nav editorconfig dumb-jump drag-stuff dotenv-mode dired-quick-sort diminish devdocs define-word column-enforce-mode clean-aindent-mode centered-cursor-mode auto-highlight-symbol auto-compile aggressive-indent ace-link ace-jump-helm-line))
 '(safe-local-variable-values
   '((org-refile-targets)
     (org-download-delete-image-after-download)
     (org-download-method . directory)
     (org-download-heading-lvl . 0)
     (org-download-image-dir . "~/Drive/AnkiImages/")))
 '(warning-suppress-types '((use-package))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)


;; package sources
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
						 ("org"   . "https://orgmode.org/elpa/")
						 ("elpa"  . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; initialize use-package
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (require 'package)
  (setq use-package-always-ensure t
		use-package-expand-minimally t))

;; disable transparency
(set-frame-parameter (selected-frame) 'alpha '(100 . 100))
(add-to-list 'default-frame-alist '(alpha . (100 . 100)))

;; fix frame size
(add-to-list 'default-frame-alist '(height . 25))
(add-to-list 'default-frame-alist '(width . 120))

;; built into emacs >=28.1
(use-package emacs
  :ensure nil
  :init
  (setq modus-themes-italic-constructs t
		modus-themes-bold-constructs t
		modus-themes-paren-match '(bold intense)
		modus-themes-syntax '(green-strings)
		modus-themes-region '(accented no-extend)
		modus-themes-headings
		'((1 . (rainbow bold overline background 1.6))
		  (2 . (rainbow bold background 1.4))
		  (3 . (rainbow bold 1.2))
		  (t . (rainbow semibold))))
  (setq modus-themes-scale-headings t)
  :config
  (load-theme 'modus-operandi)
  (set-background-color "#f8f8ff")
  (custom-set-faces
   '(flymake-error ((((class color)) (:foreground "#B60000" :underline nil :weight bold))))
   '(flymake-note ((((class color)) (:foreground "#003497" :underline nil :weight bold))))
   '(flymake-warning ((((class color)) (:foreground "#70480F" :underline nil :weight bold))))
   '(flyspell-duplicate ((((class color)) (:foreground "#70480F" :underline nil :weight bold))))
   '(flyspell-incorrect ((((class color)) (:foreground "#B60000" :underline nil :weight bold))))))

;; fonts
(set-face-attribute 'default nil
					:font "ZedMono Nerd Font"
					:height 195
					:weight 'medium)
(set-face-attribute 'variable-pitch nil
					:font "ZedMono Nerd Font"
					:height 195
					:weight 'medium)
(set-face-attribute 'fixed-pitch nil
					:font "ZedMono Nerd Font"
					:height 195
					:weight 'medium)
(set-face-attribute 'mode-line nil
					:height 160
					:weight 'bold)
(set-face-attribute 'mode-line-inactive nil
					:height 160
					:weight 'medium)


;; no clutter
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Don’t pop up a buffer to warn me about deprecations and other minor
;; issues.
(setq warning-minimum-level :emergency)

;; get rid of startup buffer
(setq inhibit-startup-message t)

;; cleaner
(setq make-backup-files nil
	  auto-save-default nil)

;; Change yes-or-no questions into y-or-n questions
(defalias 'yes-or-no-p 'y-or-n-p)

;; smooth scrolling
(setq scroll-conservatively 101)

;; move by logical lines rather than visual lines (better for macros)
(setq line-move-visual nil)

;; shorter tab width. Default: 8
(setq-default tab-width 4)

;; set text width to 72 (default: 70)
(setq-default fill-column 72
			  word-wrap t)

;; don't interrupt me with native compilation warnings
(setq native-comp-async-report-warnings-errors nil)

;; blinking cursors are annoying
(blink-cursor-mode 0)

;; remember and restore the last cursor location of opened files
(save-place-mode 1)

;; don't pop up UI dialogs when prompting
(setq use-dialog-box nil)

;; revert buffers when the underlying file has changed
(global-auto-revert-mode 1)

;; revert Dired and other buffers
(setq global-auto-revert-non-file-buffers t)

;; trim trailing whitespaces on save
(add-hook 'before-save-hook
		  'delete-trailing-whitespace)

;; auto-close brackets, braces, quotes, paranthesis
(electric-pair-mode)

(setq-default show-trailing-whitespace t)

;; handy function to reload emacs config
(defun reload-config()
  (interactive)
  (load-file user-init-file)
  (load-file user-init-file))

;; It's a tale as old as time: a stubborn, shell-dwelling, and
;; melodramatic vimmer -- tormented by Vimscript and his boundless
;; productivity -- makes a formal request to the netherworld for a
;; transfer. They agree. The terms? He must lure more unsuspecting souls
;; into a life of eternal bikeshedding. Now he runs the place.
(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit)
		 (:map evil-normal-state-map
			   ("C-u"     . evil-scroll-up) ; not set by default
			   ("C-s x"   . evil-window-delete)
			   ("C-s h"   . evil-window-left)
			   ("C-s j"   . evil-window-down)
			   ("C-s k"   . evil-window-up)
			   ("C-s l"   . evil-window-right)
			   ("C-s _"   . evil-window-split)
			   ("C-s |"   . evil-window-vsplit)
			   ("C-s C-h" . evil-window-decrease-width)
			   ("C-s C-l" . evil-window-increase-width)
			   ("C-s C-j" . evil-window-decrease-height)
			   ("C-s C-k" . evil-window-increase-height)))
  :init
  (setq evil-want-keybinding nil)
  (setq evil-undo-system 'undo-redo)
  :config
  ;; (setq evil-insert-state-cursor 'box)
  (setq evil-split-window-below t)
  (setq evil-vsplit-window-right t)
  (evil-set-leader 'normal (kbd "SPC"))
  (evil-mode 1))

(use-package evil-collection
  :after evil
  :config
  (setq evil-collection-mode-list (delete 'go-mode evil-collection-mode-list))
  (setq evil-collection-mode-list (delete 'eglot evil-collection-mode-list))
  ;; (setq evil-collection-mode-list
  ;; 		'(tetris dired elfeed mu4e magit vterm))
  (setq evil-want-integration t)
  (evil-collection-init))

;; similar to vim-commentary
(use-package evil-commentary
  :init
  (evil-commentary-mode))

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
	"h" 'dired-up-directory
	"l" 'dired-find-file))

;; make Emacs check my spellings
(defun flyspell-learn-word-at-point ()
  "insert word at point into personal dictionary"
  (interactive)
  (let ((current-location (point))
		(word (flyspell-get-word)))
	(when (consp word)
	  (flyspell-do-correct
	   'save nil
	   (car word)
	   current-location
	   (cadr word)
	   (caddr word)
	   current-location))))

(use-package flyspell
  :ensure nil
  :bind (:map evil-normal-state-map
			  ("z g" . flyspell-learn-word-at-point))
  :hook ((text-mode . flyspell-mode))
  :init
  (add-hook 'flyspell-mode-hook #'flyspell-buffer)
  :config
  (setq ispell-personal-dictionary "~/.config/emacs/spell"
		flyspell-issue-message-flag nil))

(use-package vertico
  :bind (:map vertico-map
			  ("C-j" . vertico-next)
			  ("C-k" . vertico-previous))
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package savehist
  :init
  (savehist-mode))

(use-package marginalia
  :after vertico
  :custom
  (marginalia-annotators '(marginalia-annotators-heavy marginalia-annotators-light nil))
  :init
  (marginalia-mode))

(use-package consult
  :bind (:map evil-normal-state-map
			  ("<leader>g" . consult-ripgrep)
			  ("C-f"       . consult-flymake)
			  ("C-/"       . consult-line)))

(use-package project
  :ensure nil
  :bind (:map evil-normal-state-map
			  ("C-p" . project-find-file)))

;; on par with most of the terminal emulators. Only works on
;; Linux/MacOS
(use-package vterm
  :bind (("C-<escape>" . evil-collection-vterm-toggle-send-escape))
  :config
  ;; change cursor shape to box
  (add-hook 'vterm-mode-hook
			(lambda ()
			  (setq-local evil-insert-state-cursor 'box)))

  ;; vterm can have my escape
  ;; (evil-collection-vterm-toggle-send-escape)

  ;; make C-c behave normally
  (evil-define-key 'insert vterm-mode-map (kbd "C-c") #'vterm--self-insert)

  ;; faster
  (setq vterm-timer-delay 0.01))

(use-package vterm-toggle
  :config
  ;; call vterm from anywhere
  (global-set-key (kbd "<C-return>") 'vterm-toggle))

;; docs
(use-package eldoc
  :ensure nil
  :init
  (global-eldoc-mode -1)
  :config
  (defun m/eldoc-message (format-string &rest args)
	"display message in minubuffer as long as it is not empty"
	(unless (and format-string (string-empty-p (apply #'format format-string args)))
	  (apply #'eldoc-minibuffer-message format-string args)))
  (setq eldoc-message-function #'m/eldoc-message)
  :bind (:map evil-normal-state-map
			  ("K" . eldoc-print-current-symbol-info)))

;; lsp client
(use-package eglot
  :hook ((go-mode web-mode) . 'eglot-ensure)
  :bind (:map evil-normal-state-map
			  ("g d" . xref-find-definitions)
			  ("g r" . xref-find-references)
			  ("<leader>ir" . eglot-rename)
			  ("<leader>a"  . eglot-code-actions))
  :config
  (add-to-list 'eglot-server-programs '((web-mode :language-id "html") . ("tailwindcss-language-server")))
  (setq eglot-managed-mode-hook (list (lambda () (eldoc-mode -1)))
		eglot-autoshutdown t
		eglot-send-changes-idle-time 0
		flymake-no-changes-timeout 0))

;; completion engine
(use-package corfu
  ;; :hook ((go-mode) . corfu-mode) ;; run corfu only for go-mode
  :custom
  (corfu-cycle t)
  (corfu-auto t)
  (corfu-auto-delay 0)
  (corfu-auto-prefix 1)
  (corfu-preselect-first t) ;; enable candidate preselection
  :bind (:map corfu-map
			  ("TAB"     . corfu-next)
			  ([tab]     . corfu-next)
			  ("S-TAB"   . corfu-previous)
			  ([backtab] . corfu-previous))
  :init
  (global-corfu-mode)
  (corfu-history-mode)
  (corfu-popupinfo-mode))

;; snippet engine
(use-package yasnippet
  :init
  (yas-global-mode)
  :hook ((go-mode) . yas-minor-mode))

;; automatic code formatting
(use-package apheleia
  :ensure t
  :config
  (apheleia-global-mode +1))

;; Git Porcelain inside Emacs
(use-package magit
  :bind (:map evil-normal-state-map
			  ("g s" . magit-status))
  :config
  ;; highlight commit text in the summary line that goes beyond 50
  ;; characters.
  (use-package git-commit
	:config
	(setq git-commit-summary-max-length 50)))

(use-package perspective
  :custom
  (persp-mode-prefix-key (kbd "C-s"))
  :bind (("C-x C-b" . persp-switch-to-buffer*)
		 ("C-x k"   . persp-kill-buffer*)
		 :map perspective-map
		 ("s"   . persp-switch)
		 ("C-s" . persp-switch-last)
		 ("$"   . persp-rename)
		 ("X"   . persp-kill))
  :init
  (persp-mode))

(use-package direnv
  :config
  (direnv-mode))

(use-package markdown-mode
  :mode "\\.md$")

(use-package yaml-mode
  :mode "\\.ya?ml$")

(use-package protobuf-mode
  :mode "\\.proto$")

(use-package nix-mode
  :mode "\\.nix\\'")

(use-package go-mode
  :mode "\\.go$")

(use-package web-mode
  :mode (("\\.html\\'" . web-mode)
         ("\\.css\\'"  . web-mode)
		 ("\\.js\\'"   . web-mode))
  :custom
  (web-mode-markup-indent-offset 2)
  (web-mode-css-indent-offset 2)
  (web-mode-code-indent-offset 2)
  (web-mode-auto-close-style 1)
  (web-mode-enable-auto-closing t)
  (web-mode-enable-auto-indentation nil)
  (web-mode-enable-auto-quoting nil)
  (web-mode-enable-auto-pairing nil)
  (web-mode-enable-auto-opening nil)
  (css-indent-offset 2)
  (js-indent-level 2))

(use-package emmet-mode
  :ensure t
  :bind
  ("C-j" . emmet-expand-line)
  (:map emmet-mode-keymap
        ("M-}" . emmet-next-edit-point)
        ("M-{" . emmet-prev-edit-point)))

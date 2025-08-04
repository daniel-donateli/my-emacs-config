;; Turn off GUI noise
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-start-screen t)
(setq ring-bell-function 'ignore)
(global-display-line-numbers-mode 1)
(global-font-lock-mode 1)

;; Set UTF-8 everywhere
(prefer-coding-system 'utf-8)

;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Set yes/no to y/n
;; (fset 'yes-or-no-p 'y-or-n-p)

;; Recent files
(recentf-mode 1)
(setq recentf-max-menu-items 25)

;; Initialize package system
(require 'package)
(add-to-list 'package-archives
  '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
  '("gnu" . "https://elpa.gnu.org/packages/") t)
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package if not installed
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Set theme
(use-package catppuccin-theme
  :config
  (setq catppuccin-flavor 'mocha)
  (load-theme 'catppuccin :no-confirm)
  (catppuccin-reload))

;; Show possible keybindings after prefix (like C-x)
(use-package which-key
  :config
  (which-key-mode))

;; Git integration
(use-package magit)

;; Vim keybindings
;; (use-package evil
;;   :config
;;   (evil-mode 1))

(use-package company
  :ensure t
  :hook (after-init . global-company-mode)
  :config
  (setq company-minimum-prefix-length 1
        company-idle-delay 0.0))

(setenv "PATH" (concat "opt/anaconda3/bin:/usr/local/bin:" (getenv "PATH")))
(setq exec-path (append '("/opt/anaconda3/bin" "/usr/local/bin") exec-path))

(use-package python
  :ensure nil ;; built-in
  :mode ("\\.py\\'" . python-mode)
  :hook (python-mode . electric-indent-mode))
(add-hook 'python-mode-hook #'turn-on-font-lock)

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred)
  :hook ((python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp))) ; or lsp-deferred
         (clojure-mode . lsp)
         (clojurec-mode . lsp)
         (clojurescript-mode . lsp))
  :init
  (setq lsp-keymap-prefix "C-c 1") ;; set lsp-command-map prefix
  (setq lsp-completion-provider :capf)
  :config
  (dolist (m '(clojure-mode
               clojurec-mode
               clojurescript-mode
               clojurex-mode))
    (add-to-list 'lsp-language-id-configuration '(,m . "clojure")))
  (lsp-enable-which-key-integration t)) ;; key hints

(use-package lsp-pyright
  :ensure t
  :after lsp-mode
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp)))
  :config
  (setq lsp-pyright-python-executable-cmd "python"))

(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-sideline-enable t
        lsp-ui-sideline-show-diagnostics t
        lsp-ui-sideline-show-hover t
        lsp-ui-doc-enable t))

;; inline errors
(use-package flycheck
  :init (global-flycheck-mode))

;; Syntax highlighting & better editing
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package ivy
  :config
  (ivy-mode 1))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Turn off GUI noise
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-start-screen t)
(setq ring-bell-function 'ignore)
(global-display-line-numbers-mode 1)

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

;; Set theme
(load-theme 'catppuccin :no-confirm)
(setq catppuccin-flavor 'mocha)
(catppuccin-reload)

;; Initialize package system
(require 'package)
(setq package-archives '(
  ("melpa" . "https://melpa.org/packages/")
  ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package if not installed
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

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
  :config
  (global-company-mode))

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
 '(package-selected-packages '(catppuccin-theme which-key)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

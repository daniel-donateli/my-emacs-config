;; editing.el

;; Set UTF-8 everywhere
(prefer-coding-system 'utf-8)

;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Recent files
(recentf-mode 1)
(setq recentf-max-menu-items 25)

;; Show possible keybindings after prefix (like C-x)
(use-package which-key
  :config
  (which-key-mode))

(provide 'editing)

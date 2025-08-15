;; editing.el

;; Set UTF-8 everywhere
(prefer-coding-system 'utf-8)

;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Recent files
(recentf-mode 1)
(setq recentf-max-menu-items 25)

;; Electric pair - Auto close parenthesis except for Lisp languages
(electric-pair-mode 1)

(defun disable-electric-pair ()
  "Disable electric-pair for Lisp languages"
  (electric-pair-local-mode -1))

(add-hook 'lisp-mode-shared-hook #'disable-electric-pair)
(add-hook 'clojure-mode-hook #'disable-electric-pair)

;; Show possible keybindings after prefix (like C-x)
(use-package which-key
  :config
  (which-key-mode))

(provide 'editing)

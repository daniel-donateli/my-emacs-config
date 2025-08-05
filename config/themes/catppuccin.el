;; catppuccin.el

;; Set theme
(use-package catppuccin-theme
  :config
  (setq catppuccin-flavor 'mocha)
  (load-theme 'catppuccin :no-confirm)
  (catppuccin-reload))

(provide 'catppuccin)

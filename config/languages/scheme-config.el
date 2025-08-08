;; scheme-config.el

;; Install Geiser and setup for Chez
(use-package geiser
  :ensure t)

(use-package geiser-chez
  :ensure t)

(setq geiser-chez-binary "chez")
(setq geiser-active-implementations '(chez))

(provide 'scheme-config)

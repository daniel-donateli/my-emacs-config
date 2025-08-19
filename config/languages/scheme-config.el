;; scheme-config.el

;; Install Geiser and setup for Chez
(use-package geiser
  :ensure t)

(use-package geiser-chez
  :ensure t
  :config
  (setq geiser-chez-binary "chez"))

(use-package geiser-chicken
  :ensure t
  :config
  (setq geiser-chicken-binary "csi"))

(setq geiser-active-implementations '(chez chicken))

(provide 'scheme-config)

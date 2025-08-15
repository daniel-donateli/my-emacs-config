;;; smartparens-setup.el

(use-package smartparens
  :ensure smartparens
  :hook (scheme-mode clojure-mode cider-repl-mode)
  :config
  ;; load default config
  (require 'smartparens-config))

(provide 'smartparens-setup)

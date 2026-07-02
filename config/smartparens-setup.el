;;; smartparens-setup.el

(use-package smartparens
  :ensure smartparens
  :hook (scheme-mode
         clojure-mode
         cider-repl-mode
         lisp-mode
         slime-repl-mode)
  :config
  (require 'smartparens-config))

(provide 'smartparens-setup)

;;; clojure.el

(use-package clojure-mode
  :ensure t)

(use-package cider
  :ensure t
  :hook ((clojure-mode . cider-mode))
  :config
  (setq nrepl-log-messages t
        cider-repl-display-help-banner nil
        cider-save-file-on-load t))

(provide 'clojure)

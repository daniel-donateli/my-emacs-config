;;; org-mode-config.el

(use-package org)

(use-package ob-scheme
  :ensure nil) ;; comes with org

(require 'ob-scheme)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((scheme . t)))

(use-package ob-hy
  :after org
  :config
  ;; Enable Hy in Org-Babel
  (add-to-list 'org-babel-load-languages '(hy . t)))

(setq org-confirm-babel-evaluate nil)
(setq org-babel-scheme-eval-fn 'geiser-eval-region)

(provide 'org-mode-config)

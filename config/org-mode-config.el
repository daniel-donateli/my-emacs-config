;;; org-mode-config.el

(use-package org)

(use-package ob-scheme
  :ensure nil) ;; comes with org

(require 'ob-scheme)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((scheme . t)))

(setq org-confirm-babel-evaluate nil)

(provide 'org-mode-config)

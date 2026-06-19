;; treemacs-config.el

(use-package treemacs
  :defer t
  :config
  (treemacs-follow-mode t)       ;; highlight current file automatically
  (treemacs-filewatch-mode t)    ;; watch filesystem changes
  (treemacs-fringe-indicator-mode 'always)
  (setq treemacs-width               35
        treemacs-show-hidden-files   t
        treemacs-silent-refresh      t
        treemacs-recenter-after-file-follow t))

(use-package treemacs-evil
  :after (treemacs evil))

(use-package treemacs-magit
  :after (treemacs magit))

(use-package lsp-treemacs
  :after (lsp-mode treemacs)
  :config
  (lsp-treemacs-sync-mode 1))  ;; sync treemacs workspace with lsp

(my/leader
  "e"   '(:ignore t            :which-key "explorer")
  "et"  '(treemacs             :which-key "toggle")
  "ef"  '(treemacs-find-file   :which-key "find current file in tree")
  "ew"  '(treemacs-select-window :which-key "focus treemacs window")
  "ea"  '(treemacs-add-project-to-workspace    :which-key "add project")
  "ed"  '(treemacs-remove-project-from-workspace :which-key "remove project")
  "es"  '(lsp-treemacs-symbols :which-key "lsp symbols")
  "er"  '(lsp-treemacs-references-at-point :which-key "lsp references"))

(provide 'treemacs-config)

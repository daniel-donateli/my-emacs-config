;; terraform-config.el

(use-package terraform-mode
  :mode "\\.tf\\'"
  :hook ((terraform-mode . lsp-deferred)
         (terraform-mode . terraform-format-on-save-mode))
  :config
  (setq terraform-indent-level 2))

(my/local-leader
  :keymaps 'terraform-mode-map
  "i" '((lambda () (interactive) (compile "terraform init"))     :which-key "init")
  "p" '((lambda () (interactive) (compile "terraform plan"))     :which-key "plan")
  "a" '((lambda () (interactive) (compile "terraform apply"))    :which-key "apply")
  "v" '((lambda () (interactive) (compile "terraform validate")) :which-key "validate")
  "f" '(terraform-format-buffer                                  :which-key "format buffer"))

(provide 'terraform-config)

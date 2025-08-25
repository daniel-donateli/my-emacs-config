;;; c-config.el -- C/C++ specific LSP setup

(use-package cc-mode
  :ensure nil ;; built-in
  :mode ("\\.c\\'" . c-mode)
  :hook (c-mode . (lambda ()
                    (setq c-basic-offset 4
                          tab-width 4))))

;; Hook clangd into lsp
(add-hook 'c-mode-hook #'lsp-deferred)
(add-hook 'c++-mode-hook #'lsp-deferred)

(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration '(c-mode . "c"))
  (add-to-list 'lsp-language-id-configuration '(c++-mode . "cpp"))
  (setq lsp-client-clangd-args
        '("--clang-tidy" "--header-insertion=never" "--std=c23")))

(use-package clang-format
  :bind (:map c-mode-base-map
              ("C-c f" . clang-format-buffer)))

(provide 'c-config)

;;; hy-config.el

(use-package hy-mode
  :ensure t
  :mode "\\.hy\\'"
  :hook ((hy-mode . company-mode)
         (hy-mode . eldoc-mode))
  :bind (:map hy-mode-map
              ;; Update jedhy completions
              ("C-c C-j" . hy-jedhy-update-imports)
              ;; Start Hy REPL
              ("C-c C-z" . run-hy-repl))
  :config
  ;; Use Hy as the inferior Lisp program
  (setq inferior-lisp-program "hy"))

;; Run Hy REPL command
(defun run-hy-repl ()
  "Run Hy REPL in another window."
  (interactive)
  (split-window-below)
  (other-window 1)
  (run-lisp inferior-lisp-program))

(provide 'hy-config)

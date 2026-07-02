;;; common-lisp-config.el

;; Load SLIME from Quicklisp
(load (expand-file-name "~/quicklisp/slime-helper.el"))

;; Set your Lisp implementation
(setq inferior-lisp-program "sbcl")

;; Some SLIME niceties
(setq slime-contribs '(slime-fancy))

(use-package aggressive-indent
  :hook ((lisp-mode       . aggressive-indent-mode)
         (slime-repl-mode . aggressive-indent-mode)))

(provide 'common-lisp-config)

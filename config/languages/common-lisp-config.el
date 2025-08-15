;;; common-lisp-config.el

;; Load SLIME from Quicklisp
(load (expand-file-name "~/quicklisp/slime-helper.el"))

;; Set your Lisp implementation
(setq inferior-lisp-program "sbcl")

;; Some SLIME niceties
(setq slime-contribs '(slime-fancy))

(provide 'common-lisp-config)

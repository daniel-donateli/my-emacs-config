;; evil-config.el

;; Vim keybindings
 (use-package evil
   :init
   (setq evil-want-integration t
         evil-want-keybinding nil)
   :config
   (evil-mode 1))

(use-package general
  :config
  (general-evil-setup t))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(use-package evil-cleverparens
  :hook ((emacs-lisp-mode
          clojure-mode
          scheme-mode
          lisp-mode) . evil-cleverparens-mode)
  :config
  (setq evil-cleverparens-use-additional-movement-keys t)
  (add-hook 'geiser-repl-mode-hook #'evil-cleverparens-mode)
  (add-hook 'slime-repl-mode-hook #'evil-cleverparens-mode))

;; (evil-set-leader '(motion normal) (kbd "SPC"))

;; general keybinds
(general-create-definer my/leader
                        :states '(normal visual)
                        :prefix "SPC")

(general-create-definer my/local-leader
                        :states '(normal visual)
                        :prefix "SPC m")

(general-create-definer my/local-leader-alt
                        :states '(normal visual)
                        :prefix ",")

;; Define Geiser keybindings
(setq my/geiser-bindings
      '("e"  '(:ignore t :which-key "eval")
        "ee" '(geiser-eval-last-sexp :which-key "eval last sexp")
        "ed" '(geiser-eval-definition :which-key "eval definition")
        "eb" '(geiser-eval-buffer :which-key "eval buffer")
        "er" '(geiser-eval-region :which-key "eval region")

        "h"  '(:ignore t :which-key "help")
        "hd" '(geiser-doc-symbol-at-point :which-key "doc for symbol")
        "ha" '(geiser-doc-apropos :which-key "apropos")
        "hm" '(geiser-doc-look-up-manual :which-key "manual lookup")))

;; Apply to both leaders
(dolist (definer '(my/local-leader my/local-leader-alt))
  (eval `(,definer :keymaps 'scheme-mode-map ,@my/geiser-bindings)))

(use-package ace-window
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)
        aw-scope 'frame
        aw-background t))

(my/leader
  "w"  '(:ignore t          :which-key "windows")
  "ww" '(ace-window         :which-key "pick window")
  "wo" '(ace-window-one-command :which-key "one action in window")
  "wv" '(evil-window-vsplit :which-key "split vertical")
  "ws" '(evil-window-split  :which-key "split horizontal")
  "wq" '(evil-window-delete :which-key "close window")
  "wm" '(delete-other-windows :which-key "maximize (close others)")
  ;; resize
  "w+" '(evil-window-increase-height :which-key "increase height")
  "w-" '(evil-window-decrease-height :which-key "decrease height")
  "w>" '(evil-window-increase-width  :which-key "increase width")
  "w<" '(evil-window-decrease-width  :which-key "decrease width")
  "w=" '(balance-windows             :which-key "equalize all")
  ;; swap (Emacs 28+ built-in)
  "wH" '(windmove-swap-states-left  :which-key "swap window left")
  "wJ" '(windmove-swap-states-down  :which-key "swap window down")
  "wK" '(windmove-swap-states-up    :which-key "swap window up")
  "wL" '(windmove-swap-states-right :which-key "swap window right"))

(provide 'evil-config)

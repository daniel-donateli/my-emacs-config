;; evil-config.el

;; Vim keybindings
 (use-package evil
   :init
   (setq evil-want-integration t
         evil-want-keybinding nil)
   :config
   (evil-mode 1))

(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init))

(evil-set-leader '(motion normal) (kbd "SPC"))

(provide 'evil-config)

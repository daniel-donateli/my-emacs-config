;; evil-config.el

;; Vim keybindings
 (use-package evil
   :init
   (setq evil-want-integration t
         evil-want-keybinding nil)
   :config
   (evil-mode 1))

(provide 'evil-config)

;;; init.el -- entry point

;; Get init.el dir
(defvar my/config-dir
  (file-name-directory (file-truename (or load-file-name buffer-file-name))))

(message "my/config-dir: %s" my/config-dir)

;; Add subdirs to load path
(add-to-list 'load-path (expand-file-name "config" my/config-dir))
(add-to-list 'load-path (expand-file-name "config/languages" my/config-dir))
(add-to-list 'load-path (expand-file-name "config/themes" my/config-dir))

;; Debug load-path
(message "load-path contains: %s" load-path)

;; Load main modules
(require 'packages)
(require 'ui)
(require 'editing)
(require 'lsp)
(require 'git)
(require 'evil-config)
(require 'org-mode-config)
(require 'smartparens-setup)

;; Languages configs
(require 'scheme-config)
(require 'clojure)
(require 'common-lisp-config)


;; Themes configs
(require 'catppuccin)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; ui.el

;; Turn off GUI noise
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-start-screen t)
(setq ring-bell-function 'ignore)
(global-display-line-numbers-mode 1)
(global-font-lock-mode 1)

(provide 'ui)

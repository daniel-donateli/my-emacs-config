;; packages.el

;; Initialize package system
(require 'package)

(add-to-list 'package-archives
  '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives
  '("gnu" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives
  '("org" . "https://orgmode.org/elpa/"))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

;; Install use-package if not installed
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(provide 'packages)

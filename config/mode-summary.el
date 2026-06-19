;; mode-summary.el — sidebar with current mode info and keybinds

(require 'subr-x)

(defconst my/ms-buffer "*Mode Summary*")

(defface my/ms-header-face
  '((t :inherit font-lock-keyword-face :height 1.4 :weight bold))
  "Mode summary header.")

(defface my/ms-label-face
  '((t :inherit font-lock-function-name-face :weight bold))
  "Mode summary label.")

(defface my/ms-value-face
  '((t :inherit default))
  "Mode summary value.")

(defface my/ms-key-face
  '((t :inherit font-lock-string-face :weight bold))
  "Mode summary key.")

(defface my/ms-desc-face
  '((t :inherit font-lock-comment-face))
  "Mode summary description.")

(defun my/ms-mode-keybinds ()
  "Return ((key desc) ...) for the current major mode's local leader."
  (cond
   ((eq major-mode 'scheme-mode)
    '(("SPC m e e  /  , e e"  "eval last sexp")
      ("SPC m e d  /  , e d"  "eval definition")
      ("SPC m e b  /  , e b"  "eval buffer")
      ("SPC m e r  /  , e r"  "eval region")
      ("SPC m h d  /  , h d"  "doc for symbol at point")
      ("SPC m h a  /  , h a"  "apropos")
      ("SPC m h m  /  , h m"  "manual lookup")))
   ((derived-mode-p 'lisp-mode)
    '(("C-c C-c"    "compile defun at point")
      ("C-c C-k"    "compile & load file")
      ("C-c C-l"    "load file")
      ("C-c C-z"    "switch to REPL")
      ("C-c C-e"    "eval last expression")
      ("C-c C-d d"  "describe symbol")
      ("C-c C-d h"  "HyperSpec lookup")
      ("C-c C-d a"  "apropos")
      ("M-."        "jump to definition")
      ("M-,"        "pop definition stack")))
   ((derived-mode-p 'clojure-mode)
    '(("C-c C-k"   "load buffer (CIDER)")
      ("C-c C-e"   "eval last sexp")
      ("C-c C-z"   "switch to REPL")
      ("C-c M-j"   "cider-jack-in")))
   ((eq major-mode 'terraform-mode)
    '(("SPC m i  /  , i"  "terraform init")
      ("SPC m p  /  , p"  "terraform plan")
      ("SPC m a  /  , a"  "terraform apply")
      ("SPC m v  /  , v"  "terraform validate")
      ("SPC m f  /  , f"  "format buffer")))
   ((eq major-mode 'python-mode)
    '(("C-c 1"     "LSP prefix (lsp-command-map)")
      ("C-c 1 g g" "go to definition")
      ("C-c 1 g r" "find references")
      ("C-c 1 r r" "rename symbol")))
   ((derived-mode-p 'c-mode 'c++-mode)
    '(("C-c 1"     "LSP prefix (lsp-command-map)")
      ("C-c 1 g g" "go to definition")
      ("C-c 1 g r" "find references")
      ("C-c 1 r r" "rename symbol")))
   (t nil)))

(defun my/ms-lsp-server-name ()
  "Return active LSP server name(s) or nil."
  (when (and (boundp 'lsp-mode) lsp-mode (fboundp 'lsp-workspaces))
    (let ((ws (lsp-workspaces)))
      (when ws
        (mapconcat
         (lambda (w)
           (symbol-name (lsp--workspace-server-id w)))
         ws ", ")))))

(defun my/ms-active-minor-modes ()
  "Return names of relevant active minor modes."
  (seq-filter #'identity
              (mapcar (lambda (m)
                        (when (and (boundp m) (symbol-value m))
                          (symbol-name m)))
                      '(lsp-mode
                        evil-cleverparens-mode
                        smartparens-mode
                        flycheck-mode
                        company-mode
                        electric-pair-mode))))

(defun my/ms-row (key desc key-col-w)
  (let ((pad (make-string (max 0 (- key-col-w (length key))) ?\s)))
    (insert (propertize (concat "    " key pad) 'face 'my/ms-key-face))
    (insert (propertize (concat "  " desc "\n") 'face 'my/ms-desc-face))))

(defun my/ms-field (label value)
  (insert (propertize (format "  %-9s" label) 'face 'my/ms-label-face))
  (insert (propertize (concat value "\n") 'face 'my/ms-value-face)))

(defun my/mode-summary ()
  "Show a sidebar with current buffer mode info and local keybinds."
  (interactive)
  (let* ((src-buf     (current-buffer))
         (file        (buffer-file-name src-buf))
         (mode        (with-current-buffer src-buf (symbol-name major-mode)))
         (lsp-server  (with-current-buffer src-buf (my/ms-lsp-server-name)))
         (minor-modes (with-current-buffer src-buf (my/ms-active-minor-modes)))
         (keybinds    (with-current-buffer src-buf (my/ms-mode-keybinds)))
         (key-col-w   (if keybinds
                          (apply #'max (mapcar (lambda (b) (length (car b))) keybinds))
                        0))
         (buf         (get-buffer-create my/ms-buffer)))
    (with-current-buffer buf
      (let ((inhibit-read-only t))
        (erase-buffer)
        (insert "\n")
        (insert (propertize (concat "  " mode "\n") 'face 'my/ms-header-face))
        (insert "\n")
        (my/ms-field "File"   (or file "(no file)"))
        (when lsp-server
          (my/ms-field "LSP" lsp-server))
        (when minor-modes
          (my/ms-field "Minor" (string-join minor-modes "  ")))
        (when keybinds
          (insert "\n")
          (insert (propertize "  Keybinds\n" 'face 'my/ms-label-face))
          (insert "\n")
          (dolist (bind keybinds)
            (my/ms-row (car bind) (cadr bind) key-col-w)))
        (insert "\n")
        (insert (propertize "  q close\n" 'face 'font-lock-comment-face)))
      (special-mode)
      (goto-char (point-min)))
    (display-buffer buf
                    '(display-buffer-in-side-window
                      (side . right)
                      (window-width . 52)))))

(my/leader "hm" '(my/mode-summary :which-key "mode summary"))

(provide 'mode-summary)

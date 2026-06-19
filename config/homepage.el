;; homepage.el — custom startup screen

(defconst my/homepage-buffer-name "*Homepage*")

(defvar my/homepage-images-dir
  (expand-file-name "assets/splash/" my/config-dir)
  "Directory of startup images. Add any PNG/GIF/JPG to assets/splash/.")

(defvar my/homepage-resize-timer nil)

(defface my/homepage-title-face
  '((t :inherit font-lock-keyword-face :height 2.0 :weight bold))
  "Homepage title.")

(defface my/homepage-section-face
  '((t :inherit font-lock-function-name-face :height 1.1 :weight bold))
  "Homepage section headers.")

(defface my/homepage-key-face
  '((t :inherit font-lock-string-face :weight bold))
  "Keybind keys.")

(defface my/homepage-desc-face
  '((t :inherit font-lock-comment-face))
  "Keybind descriptions.")

(defface my/homepage-dim-face
  '((t :inherit font-lock-comment-face :slant italic))
  "Dimmed/hint text.")

(defun my/hp-center (text &optional face)
  (let* ((width (window-width))
         (len (length text))
         (pad (max 0 (/ (- width len) 2))))
    (insert (make-string pad ?\s))
    (insert (if face (propertize text 'face face) text))
    (insert "\n")))

(defun my/homepage-random-image ()
  "Return a random image path from `my/homepage-images-dir', or nil."
  (when (file-directory-p my/homepage-images-dir)
    (let ((files (seq-filter
                  (lambda (f)
                    (seq-some (lambda (ext) (string-suffix-p ext f t))
                              '(".gif" ".png" ".jpg" ".jpeg")))
                  (directory-files my/homepage-images-dir t nil t))))
      (when files
        (nth (random (length files)) files)))))

(defun my/hp-insert-image ()
  (when (display-graphic-p)
    (if-let ((path (my/homepage-random-image)))
        (let* ((img (create-image path nil nil
                                  :max-width 260 :max-height 260))
               (img-w (car (image-size img t)))
               (win-w (window-pixel-width))
               (pad (max 0 (/ (- win-w img-w) 2)))
               (pad-chars (/ pad (frame-char-width))))
          (insert (make-string pad-chars ?\s))
          (insert-image img)
          ;; Animate if multi-frame (GIF)
          (when (and (fboundp 'image-multi-frame-p)
                     (image-multi-frame-p img))
            (image-animate img 0 t))
          (insert "\n\n"))
      (my/hp-center "[ drop images into assets/splash/ to show one here ]" 'my/homepage-dim-face)
      (insert "\n"))))

(defun my/hp-section (title)
  (insert "\n")
  (my/hp-center (concat "─── " title " ───") 'my/homepage-section-face)
  (insert "\n"))

(defun my/hp-row (key desc col-w)
  (let ((padded (concat "   " key (make-string (max 0 (- col-w (length key))) ?\s))))
    (insert (propertize padded 'face 'my/homepage-key-face)
            (propertize (concat "  " desc "\n") 'face 'my/homepage-desc-face))))

(defun my/hp-table (rows &optional col-w)
  (let ((w (or col-w 22)))
    (dolist (row rows)
      (my/hp-row (car row) (cadr row) w))))

(defun my/homepage-create-buffer ()
  (let ((buf (get-buffer-create my/homepage-buffer-name)))
    (with-current-buffer buf
      (let ((inhibit-read-only t))
        (erase-buffer)

        (insert "\n")
        (my/hp-center "M-x butterfly" 'my/homepage-title-face)
        (insert "\n")

        (my/hp-insert-image)

        (my/hp-section "Motion")
        (my/hp-table
         '(("h / j / k / l"   "move ← ↓ ↑ →")
           ("w / b"            "next / prev word")
           ("gg / G"           "top / bottom of buffer")
           ("C-d / C-u"        "scroll down / up (half page)")
           ("0 / ^/ $"         "line start (col0) / (non-ws) / end")
           ("%"                "jump to matching paren/bracket")))

        (my/hp-section "Edit")
        (my/hp-table
         '(("i / a / o / O"    "insert / append / newline below / above")
           ("dd / yy / p / P"  "delete / yank / paste below / above")
           ("ciw / diw / yiw"  "change / delete / yank word")
           ("ci( / di("        "change / delete inside parens")
           ("u / C-r"          "undo / redo")
           ("gc  (visual)"     "toggle comment on selection")
           ("."                "repeat last change")))

        (my/hp-section "Search & Replace")
        (my/hp-table
         '(("/ <term>"         "search forward (n / N for next/prev)")
           ("? <term>"         "search backward")
           (":s/old/new/g"     "replace in current line")
           (":%s/old/new/gc"   "replace in buffer (c = confirm)")))

        (my/hp-section "Files & Buffers")
        (my/hp-table
         '((":w / :q / :wq"   "save / quit / save+quit")
           (":e <file>"        "open file")
           ("C-x C-f"          "find file (Emacs)")
           ("C-x b"            "switch buffer")
           ("C-x k"            "kill buffer")))

        (my/hp-section "Windows")
        (my/hp-table
         '(("C-w v / C-w s"   "split vertical / horizontal")
           ("C-w h/j/k/l"     "focus left/down/up/right window")
           ("C-w o"            "close all other windows")
           ("C-w q"            "close current window")))

        (my/hp-section "SPC Leader")
        (insert (propertize "   Scheme / Geiser  (SPC m … or , …)\n"
                            'face 'my/homepage-section-face))
        (my/hp-table
         '(("e e"  "eval last sexp")
           ("e d"  "eval definition")
           ("e b"  "eval buffer")
           ("e r"  "eval region")
           ("h d"  "doc for symbol at point")
           ("h a"  "apropos")
           ("h m"  "manual lookup"))
         6)

        (insert "\n")
        (insert (propertize "   Common Lisp / SLIME\n"
                            'face 'my/homepage-section-face))
        (my/hp-table
         '(("C-c C-c"    "compile defun at point")
           ("C-c C-k"    "compile & load file")
           ("C-c C-l"    "load file")
           ("C-c C-z"    "switch to REPL")
           ("C-c C-e"    "eval last expression")
           ("C-c C-d d"  "describe symbol")
           ("C-c C-d h"  "HyperSpec lookup")
           ("C-c C-d a"  "apropos")
           ("M-."        "jump to definition")
           ("M-,"        "pop definition stack"))
         12)

        (my/hp-section "Quick Tips")
        (my/hp-table
         '(("M-x"             "run any command by name")
           ("C-g"             "cancel / escape anything")
           ("C-h k <key>"     "describe what a keybind does")
           ("C-h f <fn>"      "describe a function")
           ("SPC ? / C-h m"   "which-key / describe current mode keys"))
         18)

        (insert "\n")
        (my/hp-center "q  close    r  refresh" 'my/homepage-dim-face)
        (insert "\n"))

      (special-mode)
      (local-set-key (kbd "r") #'my/homepage-refresh)
      (goto-char (point-min)))
    buf))

(defun my/homepage-open ()
  "Open the homepage buffer."
  (interactive)
  (switch-to-buffer (my/homepage-create-buffer)))

(defun my/homepage-refresh ()
  "Recreate homepage content in-place (no buffer switch)."
  (interactive)
  (when-let* ((buf (get-buffer my/homepage-buffer-name))
              (win (get-buffer-window buf)))
    (with-selected-window win
      (my/homepage-create-buffer)
      (goto-char (point-min)))))

(defun my/homepage-on-resize (_frame)
  "Debounced refresh when frame/window is resized."
  (when (and (get-buffer my/homepage-buffer-name)
             (get-buffer-window my/homepage-buffer-name))
    (when (timerp my/homepage-resize-timer)
      (cancel-timer my/homepage-resize-timer))
    (setq my/homepage-resize-timer
          (run-with-idle-timer 0.4 nil #'my/homepage-refresh))))

(add-hook 'window-size-change-functions #'my/homepage-on-resize)

(setq inhibit-startup-screen t
      initial-buffer-choice nil)

(add-hook 'window-setup-hook #'my/homepage-open t)

(provide 'homepage)

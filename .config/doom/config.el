(setq user-full-name "Ankur Kumar")

(setq
 doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 16)
 doom-variable-pitch-font (font-spec :family "JetBrainsMono Nerd Font" :size 16)
 doom-big-font (font-spec :family "JetBrainsMono Nerd Font" :size 24))

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(setq doom-theme 'doom-dracula)

(setq display-line-numbers-type t)
(setq display-line-numbers 'relative)
(after! doom-theme
  (setq use-dialog-box nil))

(setq org-directory "~/org/")

(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config (setq org-auto-tangle-default t))

;; (beacon-mode 1)

(add-hook 'after-save-hook 'executable-make-buffer-file-executable-if-script-p)

(after! neotree
  (setq neo-smart-open t
        neo-window-fixed-size nil))

(after! doom-themes
  (setq doom-neotree-enable-variable-pitch t))

(map! :leader
      :desc "Toggle neotree file viewer" "e" #'neotree-toggle)

(setq minimap-window-location 'right)
(map! :leader
      (:prefix ("t" . "toggle")
       :desc "Toggle minimap-mode" "m" #'minimap-mode))

(define-globalized-minor-mode global-rainbow-mode rainbow-mode
  (lambda ()
    (when (not (memq major-mode
                (list 'org-agenda-mode)))
     (rainbow-mode 1))))
(global-rainbow-mode 1 )

(xterm-mouse-mode 1)

(map! :leader
      :desc "Clone indirect buffer other window" "b c" #'clone-indirect-buffer-other-window)

(setq imenu-list-focus-after-activation t)

;; (map! :leader
;;       (:prefix ("s" . "Search" )
;;        :desc "Menu to jump to places in buffer" "i" #'counsel-imenu))

(map! :leader
      (:prefix ("t" . "Toggle" )
       :desc "Toggle imenu shown in sidebar" "i" #'imenu-list-smart-toggle))

(map! :leader
      :desc "Avy: Jump to line" "j l" #'avy-goto-line )
(map! :leader
      :desc "Avy: Jump to char" "j w" #'evil-avy-goto-char-2 )

(use-package! typescript-mode
  :mode ("\\.tsx\\'" . typescript-tsx-tree-sitter-mode)
  :config
  (setq typescript-indent-level 2)

  (define-derived-mode typescript-tsx-tree-sitter-mode typescript-mode "TypeScript TSX"
    (setq-local indent-line-function 'rjsx-indent-line))

  (add-hook! 'typescript-tsx-tree-sitter-mode-local-vars-hook
             #'+javascript-init-lsp-or-tide-maybe-h
             #'rjsx-minor-mode)
  (map! :map typescript-tsx-tree-sitter-mode-map
        "<" 'rjsx-electric-lt
        ">" 'rjsx-electric-gt))

(after! tree-sitter
  (add-to-list 'tree-sitter-major-mode-language-alist '(typescript-tsx-tree-sitter-mode . tsx)))

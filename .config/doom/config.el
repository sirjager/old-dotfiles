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

;; (setq display-line-numbers-type 'relative)

(xterm-mouse-mode 1)

(add-to-list 'initial-frame-alist '(fullscreen . maximized))
;; (add-hook 'window-setup-hook #'toggle-frame-maximized)
(add-hook 'window-setup-hook #'toggle-frame-fullscreen)

(after! org
  (setq org-fontify-quote-and-verse-blocks nil
        org-fontify-whole-heading-line nil
        org-hide-leading-stars nil
        org-startup-indented nil))

(map! :leader
      :desc "Clone buffer independently" "b c" #'clone-indirect-buffer-other-window)

(after! neotree
  (setq neo-smart-open t
        neo-window-fixed-size nil))

(after! doom-themes
  (setq doom-neotree-enable-variable-pitch t))

(map! :leader
      :desc "Toggle neotree file viewer" "e" #'treemacs)

(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config (setq org-auto-tangle-default t))

(setq org-startup-folded t)
(setq org-startup-indented t)
(setq org-pretty-entities t)
(setq org-hide-emphasis-markers t)
(setq org-startup-with-inline-images t)
(setq org-image-actual-width '(300))

;; Nice bullets
(use-package org-superstar
      :config
      (setq org-superstar-special-todo-items t)
      (add-hook 'org-mode-hook (lambda ()
                                 (org-superstar-mode 1))))
(setq org-superstar-headline-bullets-list '("◉" "○" "◈" "◇" "▣" "▢" ))

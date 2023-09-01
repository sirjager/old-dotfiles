;; Font configs
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

;; Doom emacs theme
(setq doom-theme 'doom-one)

;; Line numbers
(setq display-line-numbers-type t)

;; Org mode settings
(setq org-directory "~/org/")

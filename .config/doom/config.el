;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

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

(setq doom-theme 'doom-one)

(setq display-line-numbers-type t)

(setq org-directory "~/org/")

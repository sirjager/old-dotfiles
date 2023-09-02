(setq user-full-name "Ankur Kumar")
      ;; user-mail-address "john@doe.com")

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





;;;;;;;;;;;;;; Environment / Appearance ;;;;;;;;;;;;;;;;;;;;
;; Solarized Theme (FRBNY-MIKE)
(add-to-list 'load-path "~/.emacs.d/color-theme/")
(add-to-list 'load-path "~/.emacs.d/solarized-color-theme/")
(require 'color-theme)
(require 'color-theme-solarized)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-solarized-dark)))


;; Turn on Scroll-bar
(scroll-bar-mode t)

;; Makes *scratch* empty.
(setq initial-scratch-message "")


;; inhibit Splash Screen
(setq inhibit-splash-screen t)

;; Buffer appearance ;;
 (transient-mark-mode t)
 (show-paren-mode 1)

;; Set Background Color ;;
  (set-background-color "black" )
  (set-foreground-color "salmon")

;; Frame Title

(setq frame-title-format
  '(:eval (if (buffer-name)
                (abbreviate-file-name (buffer-name))
                  "%f")))
;; Buffer List in Current Window
(global-set-key "\C-x\C-b" 'buffer-menu)



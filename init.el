;; Customizations to eMacs.





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


;;;;;;;;;;;;;;;;;; Other nice things ;;;;;;;;;;;;;;;;;;;;;;;;;

;;Functions

(defun truncate-lines ()
  "Toggle line-truncation in current window"
  (interactive)
  (if (= (window-width) (frame-width))
      (if (eq truncate-lines nil)
          (set-variable 'truncate-lines t)
        (set-variable 'truncate-lines nil))
      (if (eq truncate-partial-width-windows nil)
          (set-variable 'truncate-partial-width-windows t)
        (set-variable 'truncate-partial-width-windows nil))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;Neat or useful key bindings
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;"previous-window" binding
(global-set-key "\C-xp" "\C-u\-1\C-xo")


;;; Sample emacs init file ends here
(put 'upcase-region 'disabled nil)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(show-paren-mode t)
 '(text-mode-hook (quote (longlines-mode text-mode-hook-identify)))
 '(transient-mark-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )


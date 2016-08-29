;; Customizations to eMacs.

;;;;;;;;;;;;;; Add-on Packages ;;;;;;;;;;;;;;;;;;;;

;; Added by Package.el.
;; This must come before configurations of installed packages.  
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/elisp/")

;;;;;;;;;;;;;; Tweaks ;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/tweaks/")

;; MacOS Specific Tweeks
(if (eq system-type 'darwin)
    (load "~/.emacs.d/tweaks/ctrl_meta_change")
  )

;;----------------------------------------------------------
;;  Commpany Mode
;;----------------------------------------------------------
;; Start in 'Company Mode' by default
(add-hook 'after-init-hook 'global-company-mode)
;;----------------------------------------------------------
;;  Org-Mode
;;----------------------------------------------------------


(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-todo-keywords
  '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))
  
;;;;;;;;;;;;;; MELPA Package Manager ;;;;;;;;;;;;;;;;;;;;;;;
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.org/packages/")
   t)
  (package-initialize)
  (add-to-list
   'package-archives
   '("melpa" . "http://melpa.milkbox.net/packages/") t)
  (package-initialize)
  )
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;; Exec Path From Shell ;;;;;;;;;;;;;;;
;; A GNU Emacs library to ensure environment variables inside Emacs look the same as in the user's shell.
;; Ever find that a command works in your shell, but not in Emacs?
;; This happens a lot on OS X, where an Emacs instance started from the GUI inherits a default set of environment variables.

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;;;;;;;;; Load Library/Package Specific Behavior;;;;;;;;;;;;
(load "~/.emacs.d/elisp/language_specific_mods/python.el")
;; Python
(setq python-shell-interpreter "/usr/local/bin/python2.7")

;; Scala
;; -  Note:  ENSIME comes from melpa.milkbox.net/packages
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
(add-hook 'scala-mode-hook #'yas-minor-mode)
  
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;; Environment / Appearance ;;;;;;;;;;;;;;;;;;;;
;; Solarized Theme (FRBNY-MIKE)

(add-to-list 'load-path "~/.emacs.d/elisp/themes/color-theme/")
(add-to-list 'load-path "~/.emacs.d/elisp/themes/solarized-color-theme/")
(require 'color-theme)
(require 'color-theme-solarized)
(color-theme-initialize)
(color-theme-solarized-dark)
;; set transparency
(set-frame-parameter (selected-frame) 'alpha '(93 93))
(add-to-list 'default-frame-alist '(alpha 93 93))


;; Turn on Scroll-bar
(scroll-bar-mode t)
;; Scroll one line at a time
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))

;; Makes *scratch* empty.
(setq initial-scratch-message "")

;; inhibit Splash Screen
(setq inhibit-splash-screen t)

;; Buffer appearance ;;
 (transient-mark-mode t)
 (show-paren-mode 1)

;; Frame Title
(setq frame-title-format
  '(:eval (if (buffer-name)
                (abbreviate-file-name (buffer-name))
                  "%f")))
;; Buffer List in Current Window
(global-set-key "\C-x\C-b" 'buffer-menu)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;; Other Things ;;;;;;;;;;;;;;;;;;;;
;;----------------------------------------------------------
;;  Rare but useful instances of things eMacs can do
;;----------------------------------------------------------

;; Byte Compilation in Bulk (of .emacs.d directory)
(defun byte-compile-init-dir ()
  "Byte-compile all your dotfiles."
  (interactive)
  (byte-recompile-directory user-emacs-directory 0))
;; If saving .el file, delete .elc file so that the next
;; byte compilation quasi updates elc file
(defun remove-elc-on-save ()
  "If you're saving an elisp file, likely the .elc is no longer valid."
  (add-hook 'after-save-hook
            (lambda ()
              (if (file-exists-p (concat buffer-file-name "c"))
                  (delete-file (concat buffer-file-name "c"))))
            nil
            t))

(add-hook 'emacs-lisp-mode-hook 'remove-elc-on-save)

;; Get rid of duplicate lines
(defun uniq-lines (beg end)
  "Unique lines in region.
Called from a program, there are two arguments:
BEG and END (region to sort)."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (while (not (eobp))
        (kill-line 1)
        (yank)
        (let ((next-line (point)))
          (while
              (re-search-forward
               (format "^%s" (regexp-quote (car kill-ring))) nil t)
            (replace-match "" nil nil))
          (goto-char next-line))))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (exec-path-from-shell ein company-jedi ensime)))
 '(show-paren-mode t)
 '(text-mode-hook (quote (longlines-mode text-mode-hook-identify))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

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




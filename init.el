;; Customizations to eMacs.

;; Added by Package.el.
;; This must come before configurations of installed packages.  
(package-initialize)

(add-to-list 'load-path "~/.emacs.d/elisp/")

;;;;;;;;;;;;;; Tweaks ;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/tweaks/")


;;--------------------------------------------------
;; Segregate Windows & MacOS Settings
;; Windows:
;; -  Use Cygwin as default shell
;;
;;--------------------------------------------------
(load-file (expand-file-name
            (cond ((eq system-type 'windows-nt) "windows.el")
                  ((eq system-type 'gnu/linux) "linux.el")
		  ((eq system-type 'darwin) "macos.el")
                  (t "default-system.el"))
	    "~/.emacs.d/elisp/tweaks"))

;; MacOS Specific Tweeks
(if (eq system-type 'darwin)
    (load "~/.emacs.d/elisp/tweaks/ctrl_meta_change")
  )

;;--------------------------------------------------
;; Initial Use-Package Install (if required)
;;--------------------------------------------------
(require 'package)
(package-initialize)
(setq package-enable-at-startup nil)
(setq package-archives
      '(("melpa-stable" . "https://stable.melpa.org/packages/")
			 ("melpa" . "http://melpa.org/packages/")
			 ("marmalade"   . "http://marmalade-repo.org/packages/")
			 ("org"         . "http://orgmode.org/elpa/")
			 ("gnu"         . "http://elpa.gnu.org/packages/")))


;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
;;--------------------------------------------------

;;----------------------------------------------------------
;;  HackerNews
;;----------------------------------------------------------
(use-package hackernews
	     :ensure t
	     )
;;----------------------------------------------------------
;;  Exec-Path-From-Shell
;;  Resolves issues where OSX and Emacs Paths work together
;;----------------------------------------------------------
(use-package exec-path-from-shell
  :ensure t
  :if (memq window-system '(mac ns x))
  :config
  (setq exec-path-from-shell-variables '("PATH" "GOPATH"))
  (exec-path-from-shell-initialize))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Python
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;----------------------------------------------------------
;;  Jedi (Python Auto-Complete)
;;----------------------------------------------------------
(use-package jedi
  :init
  (progn
    (setq jedi:complete-on-dot t)
    (setq jedi:setup-keys t)
    (add-hook 'python-mode-hook 'anaconda-mode)
    (add-hook 'python-mode-hook 'anaconda-eldoc-mode)
    (add-hook 'python-mode-hook 'jedi:setup))
  :ensure t)
;;----------------------------------------------------------
;; Elpy
;;----------------------------------------------------------
(use-package elpy
  :ensure t
  :pin melpa-stable

  :init (add-hook 'python-mode-hook #'elpy-enable)
  :config
  ;; Start Elpy in Python mode
  (add-hook 'python-mode-hook 'elpy-mode)
  (add-hook 'python-mode-hook 'elpy-use-ipython)
  (setq elpy-rpc-backend "jedi")
  )
;;---------------------------------------------------------
;;  Commpany Mode
;;----------------------------------------------------------
(use-package company
	     :ensure t
	     :diminish company-mode
	     :defer 2
	     :bind ("C-<tab>" . company-complete)
	     :config
	     (global-company-mode t)
	     )


;;----------------------------------------------------------
;;  Org-Mode
;;----------------------------------------------------------
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))
;;----------------------------------------------------------
;;  Org-Mode
;;----------------------------------------------------------
(require 'org)
(require 'ox-latex)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(setq org-todo-keywords
  '((sequence "TODO" "IN-PROGRESS" "WAITING" "DONE")))

(eval-after-load "org"
  '(require 'ox-md nil t))

;; Source Code Highlighting (buffer)
(setq org-src-fontify-natively t)
;; Source Code Highlighting (pdf output)

;; (add-to-list 'org-latex-packages-alist '("" "minted"))
;; (setq org-latex-listings 'minted) 
;; (setq org-latex-pdf-process
;;       '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;;         "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
;;         "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

;;----------------------------------------------------------
;;  Emacs Speaks Statistics (ESS)
;;----------------------------------------------------------
(use-package ess-site
  :ensure ess
  :defer 3
  :init (setq ess-use-auto-complete 'script-only)
  :init (require 'ess-site)
  )

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
(if (eq system-type 'darwin)
    (setq python-shell-interpreter "/Users/david/anaconda3/bin/python")
  )

;; Scala
;; -  Note:  ENSIME comes from melpa.milkbox.net/packages
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
(add-hook 'scala-mode-hook #'yas-minor-mode)

;; Latex
;; Setting environment path to adhere to OSX
(if (eq system-type 'darwin)
    (setq exec-path (append exec-path '("/Library/TeX/texbin")))
)
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

;; Turn off Annoying Windows chime
(setq visible-bell 1)
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
 '(org-format-latex-options
   (quote
    (:foreground default :background default :scale 1.5 :html-foreground "Black" :html-background "Transparent" :html-scale 1.0 :matchers
		 ("begin" "$1" "$" "$$" "\\(" "\\["))))
 '(package-selected-packages
   (quote
    (0blayout jedi-direx rope-read-mode elpy anaconda-mode markdown-mode exec-path-from-shell ein ensime)))
 '(show-paren-mode t))
 '(python-shell-interpreter "/Users/david/anaconda3/bin/python")
 '(show-paren-mode t)
 '(text-mode-hook (quote (longlines-mode text-mode-hook-identify)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

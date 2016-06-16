;;;;;;;;;;;;;;; Python Specific Modifications ;;;;;;;;;;;;


;;;;;;;;;;;;;;; Company Mode Load ;;;;;;;;;;;;
(defun my/python-mode-hook ()
  (add-to-list 'company-backends 'company-jedi))
(add-hook 'python-mode-hook 'my/python-mode-hook)


(provide 'python-mods)


;;;;;;;;;;;;;;; python.el ends here ;;;;;;;;;;;;;;;


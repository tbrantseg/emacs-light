(use-package eglot
  :config
  (setq company-backends
	(cons 'company-capf (remove 'company-capf company-backends)))
  (add-hook 'python-mode-hook 'eglot-ensure))
(use-package jupyter)

;; init-python.el ends here

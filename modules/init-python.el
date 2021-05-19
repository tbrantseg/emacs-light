(use-package jupyter)

(use-package conda
  :config
  (setq conda-anaconda-home (expand-file-name "~/soft/anaconda3/")))

(use-package pyvenv)

(use-package lsp-pyright
  :ensure t
  :config
  (setq lsp-pyright-venv-directory "/home/tom/soft/anaconda3/envs")
  :hook  
  (python-mode . (lambda ()
		   (require 'lsp-pyright)
		   (lsp-deferred))))

(use-package yapfify
  :hook
  (python-mode . yapf-mode))

(add-hook 'python-mode-hook 'highlight-indent-guides-mode)

;; init-python.el ends here

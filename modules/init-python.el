(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython")
  (setq python-shell-interpreter-args "--classic"))

(use-package jupyter)

(use-package conda
  :config
  
  (setq conda-anaconda-home (expand-file-name "~/soft/anaconda3/")))

(use-package pyvenv)

(use-package pipenv)

(use-package poetry)

(use-package ein)

(use-package yapfify
  :hook
  (python-mode . yapf-mode))

;; (use-package lsp-pyright
;;   :hook (python-mode . (lambda()
;; 			 (require 'lsp-pyright)
;; 			 (lsp-deferred))))

(define-hostmode poly-python-hostmode
  :mode 'python-mode)
(define-auto-innermode poly-sql-fenced-code-innermode
  :mode 'sql-mode
  :head-matcher (cons "f\"\"\"$" 1)
  :tail-matcher (cons "^;\n\"\"\"" 1)
  :head-mode 'host
  :tail-mode 'host)
(define-polymode poly-python-sql-mode
  :hostmode 'poly-python-hostmode
  :innermodes '(poly-sql-fenced-code-innermode))
;; init-python.el ends here

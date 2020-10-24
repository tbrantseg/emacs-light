(use-package sql-indent
  :diminish
  :hook (sql-mode . sqlind-minor-mode))

(use-package sqlup-mode
  :diminish
  :hook sql-mode)

(use-package ejc-sql
  :config
  (require 'ejc-company)
  (load-file (concat user-emacs-directory "secret.el"))
  (push 'ejc-company-backend company-backends)
  (setq-local company-minimum-prefix-length 0))

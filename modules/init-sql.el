(use-package sqlformat
  :diminish
  :config
  (setq sqlformat-command `pgformatter))

(use-package sqlup-mode
  :diminish
  :hook sql-mode)

(use-package flx-ido)

(use-package ejc-sql
  :straight (ejc-sql :type git :host github :repo "kostafey/ejc-sql")
  :config
  (require 'ejc-company)
  (setq ejc-use-flx t)
  (setq ejc-flx-threshold 2)
  (load-file (concat user-emacs-directory "secret.el"))
  (push 'ejc-company-backend company-backends)
  (setq ejc-complete-on-dot t))

(use-package csv-mode)

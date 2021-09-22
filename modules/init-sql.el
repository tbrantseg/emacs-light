(use-package sqlformat
  :diminish
  :config
  (setq sqlformat-command `sqlformat)
  (setq sqlformat-args '("-k" "upper" "-a")))

(use-package sqlup-mode
  :diminish  
  :hook sql-mode
  :config
  (dolist (kw '("match" "ref"))
    (add-to-list 'sqlup-blacklist kw)))

(use-package flx-ido)

(use-package jinja2-mode)

(use-package ejc-sql
  :straight (ejc-sql :type git :host github :repo "kostafey/ejc-sql")
  :config
  (require 'ejc-company)
  (setq ejc-use-flx t)
  (setq ejc-flx-threshold 2)
  (load-file (concat user-emacs-directory "secret.el"))
  (push 'ejc-company-backend company-backends)
  (setq clomacs-httpd-default-port 8090)
  (setq ejc-complete-on-dot t))

(use-package csv-mode)

(define-hostmode poly-sql-hostmode :mode 'sql-mode)
(define-innermode poly-jinja-innermode :mode 'jinja2-mode
  :head-matcher "{[{%]"
  :tail-matcher "}[}%]"
  :head-mode 'host
  :tail-mode 'host)
(define-polymode poly-sql-jinja
  :hostmode 'poly-sql-hostmode
  :innermodes '(poly-jinja-innermode))

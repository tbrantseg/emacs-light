(use-package sqlformat
  :diminish
  :config
  (setq sqlformat-command `sqlfluff))

(use-package sqlup-mode
  :diminish  
  :hook sql-mode
  :config
  (dolist (kw '("match" "ref" "except" "name" "prefix"  "year" "m" "source"))
    (add-to-list 'sqlup-blacklist kw)))

(use-package flx-ido)

;; for dbt
(use-package jinja2-mode)

(use-package ejc-sql
  :config
  (require 'ejc-company)
  (setq ejc-use-flx t)
  (setq ejc-flx-threshold 2)
  (load-file (concat user-emacs-directory "secret.el"))
  (push 'ejc-company-backend company-backends)
  (setq clomacs-httpd-default-port 8090)
  (setq ejc-complete-on-dot t))

(use-package csv-mode)

(define-hostmode dbt-sql-hostmode :mode 'sql-mode)
(define-innermode dbt-jinja-innermode
  :mode 'jinja2-mode
  :head-matcher "{[{%][+-]?"
  :tail-matcher "[+-]?}[%}]}"
  :head-mode 'body
  :tail-mode 'body)
(define-innermode dbt-jinja-comments-innermode
  :head-matcher "{#[+-]?"
  :tail-matcher "[+-]?#}"
  :head-mode 'body
  :tail-mode 'body
  :adjust-face 'font-lock-comment-face
  :head-adjust-face 'font-lock-comment-face
  :tail-adjust-face 'font-lock-comment-face)
(define-polymode dbt-sql-mode
  :hostmode 'dbt-sql-hostmode
  :innermodes '(dbt-jinja-innermode dbt-jinja-comments-innermode))

;; SQL mode defaults
(defun tb-sql-mode-hook ()
  (setq tab-width 4)
  (setq indent-tabs-mode nil))
(add-hook 'sql-mode-hook 'tb-sql-mode-hook)

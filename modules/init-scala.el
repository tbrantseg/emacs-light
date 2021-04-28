(use-package scala-mode
  :mode "\\.s\\(cala\\|bt\\)$"
  :interpreter
  ("scala" . scala-mode))

(use-package sbt-mode
  :commands sbt-start sbt-command
  :config
  (setq sbt:program-options '("-Dsbt.supershell=false")))

(use-package lsp-metals
  :config
  (setq lsp-metals-treeview-show-when-views-received t))


;; init-scala.el ends here

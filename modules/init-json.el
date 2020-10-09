(use-package json-mode
  :config
  (setq js-indent-level 2)
  (defun js-sort-and-indent ()
    ""
    (interactive)
    (json-reformat-region (point-min) (point-max))
    (indent-region (point-min) (point-max)))
  :bind (:map json-mode-map ("C-c i" . js-sort-and-indent)))

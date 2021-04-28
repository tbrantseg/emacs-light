(use-package json-mode
  :init
  (diminish 'hs-minor-mode)
  :config
  (setq js-indent-level 2)
  (defun json-buffer-sort-and-indent ()
    "Sort the keys alphabetically in the current buffer and re-indent the entire region. The indentation amount is taken from js-indent-level."
    (interactive)
    (json-reformat-region (point-min) (point-max))
    (indent-region (point-min) (point-max)))

  :bind
  (:map json-mode-map ("C-c i" . js-sort-and-indent))
  :hook
  (json-mode . hs-minor-mode)
  (json-mode . highlight-indent-guides-mode))

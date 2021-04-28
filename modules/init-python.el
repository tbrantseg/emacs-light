(use-package jupyter)

(use-package conda
  :config
  (setq conda-anaconda-home (expand-file-name "~/soft/anaconda3/")))

(use-package pyvenv)

;; init-python.el ends here

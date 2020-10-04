(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))
(byte-recompile-directory (expand-file-name "modules" user-emacs-directory) 0)

(defvar init-modules
  '("init-startup.el"
    "init-bootstrap.el"
    "init-appearance.el"
    "init-helm.el"
    "init-hydra.el"
    "init-ide.el"
    "init-python.el"
    "init-org.el"))	       

(mapc 'load init-modules)

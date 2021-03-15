(add-to-list 'load-path (expand-file-name "modules" user-emacs-directory))
(byte-recompile-directory (expand-file-name "modules" user-emacs-directory) 0)

(defvar init-modules
  '("init-startup.el"
    "init-bootstrap.el"
    "init-appearance.el"
    "init-helm.el"
    "init-hydra.el"
    "init-ide.el"
    "init-json.el"
    "init-docker.el"
    "init-python.el"
    "init-org.el"
    "init-scala.el"
    "init-sql.el"))	       

(defun reload-init ()
  "Reload all init modules."
  (interactive)
  (byte-recompile-directory (expand-file-name "modules" user-emacs-directory) 0)
  (mapc 'load init-modules))

(defun upgrade-installed ()
  "Upgrade all installed modules."
  (interactive)
  (straight-pull-all)
  (reload-init))

(mapc 'load init-modules)

;; init.el ends here

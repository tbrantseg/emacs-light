(use-package conda
  :config
  (conda-env-initialize-interactive-shells)
  (conda-env-initialize-eshell)
  (setq conda-anaconda-home "/home/tom/soft/anaconda3"))

(use-package elpy
  :defer t
  :init
  (advice-add 'python-mode :before 'elpy-enable)
  :config
  (setq python-shell-interpreter "jupyter")
  (setq python-shell-interpreter-args "console --simple-prompt")
  (setq python-shell-prompt-detect-failure-warning nil)
  (add-to-list 'python-shell-completion-native-disabled-interpreters "jupyter"))

;; init-python.el ends here

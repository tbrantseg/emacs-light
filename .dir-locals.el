;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

((emacs-lisp-mode . ((eval . (add-hook 'after-save-hook
				       (lambda ()
			       		 (byte-recompile-directory (expand-file-name "modules" user-emacs-directory) 0)))))))

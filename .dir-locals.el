;;; Directory Local Variables
;;; For more information see (info "(emacs) Directory Variables")

((nil . ((helm-ff-skip-boring-files . t)))
 (emacs-lisp-mode . ((eval . (add-hook 'after-save-hook
				       (lambda nil
					 (byte-recompile-directory
					  (expand-file-name "modules" user-emacs-directory)
					  0)))))))

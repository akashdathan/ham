(provide 'ni-templates)
(require 'ni-base)

;;;======================================================================
;;; Template
;;;======================================================================
(agl-begin-time-block "Template")
(defun tpl-cpp-guards ()
  (interactive)
  (let ((GUARD (replace-regexp-in-string
                        "\\."
                        "_"
                        (upcase (concat "__" (buffer-name) "_" (agl-uuid3) "__"))
                         )))
    (beginning-of-buffer)
    (insert (concat "#ifndef " GUARD)) (newline)
    (insert (concat "#define " GUARD)) (newline)
    (end-of-buffer)
    (insert (concat "#endif // " GUARD)) (newline)
    ))
 
(defun datestamp ()
  (interactive)
  (call-process "date" nil t))

(global-set-key (kbd "<f6>") 'datestamp)

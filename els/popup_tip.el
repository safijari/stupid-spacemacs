(use-package popup :ensure t)

(defun describe-function-in-popup ()
  (interactive)
  (let* ((thing (symbol-at-point))
         (description (save-window-excursion
                        (describe-function thing)
                        (switch-to-buffer "*Help*")
                        (buffer-string))))
    (popup-tip description
               :point (point)
               :around t
               :height 30
               :scroll-bar t
               :margin t)))

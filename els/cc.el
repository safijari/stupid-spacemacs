(defun my/c-c ()
  (interactive)
  (setq unread-command-events (listify-key-sequence (kbd "C-c"))))

(defun my/c-x ()
  (interactive)
  (setq unread-command-events (listify-key-sequence (kbd "C-x"))))

(evil-define-key '(normal magit) global-map (kbd ",") 'my/c-c)
;; (evil-define-key 'normal global-map (kbd "cx") 'my/c-x)

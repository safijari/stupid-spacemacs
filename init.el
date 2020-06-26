(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;;(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
;;(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package nord-theme :ensure t)

(use-package magit :ensure t)
(use-package evil-magit :ensure t)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; https://gist.github.com/mads-hartmann/3402786#gistcomment-693878
(defun toggle-maximize-buffer () "Maximize buffer"
  (interactive)
  (if (= 1 (length (window-list)))
      (jump-to-register '_) 
    (progn
      (window-configuration-to-register '_)
      (delete-other-windows))))

(eval-when-compile
  (require 'use-package))

(use-package helm :ensure t)
(use-package projectile :ensure t)
(use-package helm-swoop :ensure t)
(use-package helm-projectile :ensure t)
;;(setq helm-display-function 'helm-display-buffer-popup-frame)


(use-package general :ensure t)

(use-package smooth-scrolling :ensure t
  :init
  (smooth-scrolling-mode)
  )

;; evil settings
(use-package evil :ensure t
  :init
  (setq evil-move-cursor-back nil)
  (setq evil-normal-state-cursor '(box "gray"))
  )
(evil-mode 1)

(use-package neotree :ensure t)
(use-package winum :ensure t
  :init (winum-mode) )

(use-package key-chord :ensure t
  :init
  (setq key-chord-two-keys-delay 0.25)
  (key-chord-define evil-insert-state-map "fd" 'evil-normal-state)
  (key-chord-mode 1)
  )

(use-package which-key
  :ensure t
  :init
  (which-key-mode)
  (setq which-key-idle-delay 0.25)
  )

(use-package company :ensure t
  :config
  (setq company-idle-delay 0.1)
  :init (global-company-mode)
  )


(global-linum-mode)


(define-key key-translation-map (kbd "ESC") (kbd "C-g"))


(add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/themes/"))
(load-theme 'nord t)


(general-define-key
 :states '(normal visual insert emacs)
 :prefix "SPC"
 :non-normal-prefix "M-SPC"
 "SPC" 'helm-M-x
 "wm" 'toggle-maximize-buffer
 "w/" 'split-window-horizontally
 "ws" 'split-window-vertically
 "wl" 'evil-window-right
 "wh" 'evil-window-left
 "wj" 'evil-window-down
 "wk" 'evil-window-up
 "fs" 'save-buffer
 "qq" 'evil-quit-all
 "fr" 'load-file "~/.emacs"
)


(general-define-key
 :states '(magit)
 "," 'magit-dispatch
 )


(general-define-key
 :states '(normal visual)
 :prefix "SPC"
 "cl" 'comment-or-uncomment-region
 "bb" 'helm-buffers-list
 "bp" 'previous-buffer
 "bn" 'next-buffer
 "bd" 'kill-buffer
 "1" 'winum-select-window-1
 "2" 'winum-select-window-2
 "3" 'winum-select-window-3
 "4" 'winum-select-window-4
 "5" 'winum-select-window-5
 "6" 'winum-select-window-6
 "7" 'winum-select-window-7
 "8" 'winum-select-window-8
 "9" 'winum-select-window-9
;; "0" 'winum-select-window-0
 ;; "0" 'neotree
 "ss" 'helm-swoop
 "gs" 'magit-status
 "gb" 'magit-blame
 "pt" 'neotree-toggle
 "pp" 'helm-projectile-switch-project
 "pb" 'helm-projectile-switch-to-buffer
 "pf" 'helm-projectile-find-file
 "ff" 'helm-find-files
)


;; (general-define-key :map helm-map
;; 	 "C-j" 'helm-next-line
;; 	 "C-k" 'helm-previous-line
;; 	 )

(define-key helm-map (kbd "C-j") 'helm-next-line)
(define-key helm-map (kbd "C-k") 'helm-previous-line)

(define-key company-active-map (kbd "C-j") 'company-select-next)
(define-key company-active-map (kbd "C-k") 'company-select-previous)


(use-package anaconda-mode :ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (anaconda-mode ## helm-projectile neotree projectile evil-magit magit treemacs helm-swoop doom-modeline nord-theme winum which-key-posframe smooth-scrolling key-chord helm general which-key company carbon-now-sh evil))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

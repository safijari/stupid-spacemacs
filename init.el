(setq config-dir "~/.emacs.d")
(setq els-dir (concat config-dir "/els"))
(setq config-path (concat config-dir "/init.el"))
(defun load-subconfig (name)
  (load-file (concat els-dir "/" name)))
(load-subconfig "setup_packaging.el")
(load-subconfig "smooth_scroll.el")

(defalias 'yes-or-no-p 'y-or-n-p)
(menu-bar-mode -1)
(tool-bar-mode -1)
(toggle-scroll-bar -1)

(defun helm-jump-in-buffer ()
  "Jump in buffer using `imenu' facilities and helm."
  (interactive)
  (call-interactively
   (cond
    ((eq major-mode 'org-mode) 'helm-org-in-buffer-headings)
    (t 'helm-semantic-or-imenu))))

(recentf-mode 1)
(setq recentf-max-menu-items 50)
(setq recentf-max-saved-items 50)

(use-package general :ensure t)
(use-package all-the-icons)
(use-package nord-theme :ensure t)

(use-package magit :ensure t)


(use-package evil :ensure t
  :init
  (setq evil-move-cursor-back nil)
  (setq evil-normal-state-cursor '(box "gray"))
  )
(evil-mode 1)

;; (use-package evil-collection
;;   :init (evil-collection-init)
;;   :ensure t)

(use-package evil-magit
  :after magit evil
  :ensure t)

(use-package evil-surround
  :after evil
  :general (:states '(visual)
	    "s" 'evil-surround-region)
  :ensure t)


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


(use-package helm
  :init (helm-mode) (helm-autoresize-mode)
  :config
  (setq helm-default-display-buffer-functions '(display-buffer-in-side-window))
  (setq helm-autoresize-max-height 35
	helm-autoresize-min-height 35
	)
  :ensure t)

(use-package helm-ag
  :after helm
  :ensure t)

(use-package helm-org
  :after helm org
  :ensure t)

(use-package org-bullets
  :config
  (add-hook 'org-mode-hook 'org-bullets-mode)
  (setq org-bullets-bullet-list '("◉" "○" "►" "◇" "◎" ))
  :ensure t)

(general-define-key
 :keymaps 'helm-map
 "TAB" 'helm-execute-persistent-action)

(use-package projectile
  :init (projectile-global-mode)
  :config
  (setq projectile-completion-system 'helm
        projectile-enable-caching    t
        projectile-globally-ignored-files
        (append '(".pyc"
                  "~"
		  "#")
                projectile-globally-ignored-files))
  (projectile-mode)
  (helm-projectile-on)
  (defconst projectile-mode-line-lighter " P"))


(use-package helm-swoop
  :config
  (setq helm-swoop-split-with-multiple-windows t)
  (setq helm-swoop-pre-input-function (lambda () ""))
  (setq helm-swoop-speed-or-color t)
  :ensure t)
(use-package helm-projectile :ensure t)


;; evil settings
(use-package treemacs
  :ensure t)
(use-package treemacs-evil
  :after treemacs evil
  :ensure t
  )
(use-package treemacs-projectile
  :after treemacs projectile
  :ensure t)
(use-package treemacs-magit
  :after treemacs magit
  :ensure t)

(use-package treemacs-icons-dired
  :ensure t)

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
  (setq company-minimum-prefix-length 2)
  :init (global-company-mode)
  :general
  ;; (:keymaps 'company-active-map
  ;; 	    "RET" 'company-complete-selection
  ;; 	    "TAB" 'company-complete-selection
  ;; 	    )
  )


(use-package nlinum :ensure t)

(global-nlinum-mode)


(define-key key-translation-map (kbd "ESC") (kbd "C-g"))


(add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/themes/"))
(load-theme 'nord t)

(defun load-config ()
  (interactive)
  (load-file "~/.emacs.d/init.el")
  )

(general-define-key
 :states '(normal visual emacs)
 :prefix "SPC"
 :non-normal-prefix "M-SPC"
 "SPC" 'helm-M-x
 "wm" 'toggle-maximize-buffer
 "w/" 'split-window-horizontally
 "ws" 'split-window-vertically
 "wd" 'delete-window
 "wl" 'evil-window-right
 "wh" 'evil-window-left
 "wj" 'evil-window-down
 "wk" 'evil-window-up
 "fs" 'save-buffer
 "qq" 'evil-quit-all
 "fr" 'load-config
 "/"  'helm-projectile-ag
 "fe" '(lambda () (interactive) (find-file "~/.emacs.d/init.el"))
)


(use-package evil-commentary
  :general
  (:prefix "SPC"
  :states '(normal visual)
  "cl" 'evil-commentary-line)
  :ensure t)

(use-package carbon-now-sh :ensure t)

(general-define-key
 :keymaps 'org-mode-map
 :states '(normal)
 :prefix "SPC"
 "t" 'org-todo
 )

(general-define-key
 :states '(normal visual emacs treemacs)
 :prefix "SPC"
 "bb" 'helm-mini
 "bp" 'previous-buffer
 "bn" 'next-buffer
 "bd" 'kill-current-buffer
 "1" 'winum-select-window-1
 "2" 'winum-select-window-2
 "3" 'winum-select-window-3
 "4" 'winum-select-window-4
 "5" 'winum-select-window-5
 "6" 'winum-select-window-6
 "7" 'winum-select-window-7
 "8" 'winum-select-window-8
 "9" 'winum-select-window-9
 "0" 'treemacs-select-window
 "ss" 'helm-swoop
 "gs" 'magit-status
 "gb" 'magit-blame
 "pt" 'treemacs
 "pp" 'helm-projectile-switch-project
 "pb" 'helm-projectile-switch-to-buffer
 "pf" 'helm-projectile-find-file
 "ff" 'helm-find-files
 "ji" 'helm-jump-in-buffer
 "oi" 'helm-org-agenda-files-headings
 "+" 'text-scale-adjust
)

(define-key helm-map (kbd "C-j") 'helm-next-line)
(define-key helm-map (kbd "C-k") 'helm-previous-line)

(define-key company-active-map (kbd "C-j") 'company-select-next)
(define-key company-active-map (kbd "C-k") 'company-select-previous)


(setq org-todo-keywords
    '((sequence "TODO(t!)" "NEXT(n!)" "DOINGNOW(d!)" "BLOCKED(b!)" "TODELEGATE(g!)" "DELEGATED(D!)" "FOLLOWUP(f!)" "TICKLE(T!)" "|" "CANCELLED(c!)" "DONE(F!)")))
(setq org-todo-keyword-faces
    '(("TODO" . (:foreground "red" :weight bold))
	("DOINGNOW" . (:foreground "yellow"))
	("CANCELED" . (:foreground "white" :background "#4d4d4d" :weight bold))
	("DELEGATED" . "pink")
	("NEXT" . "#008080")))


(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(setq org-agenda-files
       '("~/org/daily_tracker.org"))




;; (use-package anaconda-mode :ensure t)
(use-package pyvenv :ensure t)
(use-package flycheck :ensure t)
(use-package elpy
  :ensure t
  :init
  (elpy-enable))

(when (load "flycheck" t t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))


(load "~/.emacs.d/els/popup_tip.el")

;; Setting font name/size
(set-default-font "DejaVu Sans Mono 14")

(setq nlinum-format "%4d ")

(set-face-attribute 'helm-source-header nil :height 1.0)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 
 '(package-selected-packages
   (quote
    (evil-collection helm-ag flycheck elpy helm-company org-bullets helm-org evil-org nlinum pyvenv pyenv smooth-scroll winum which-key use-package treemacs-projectile treemacs-magit treemacs-icons-dired treemacs-evil sublimity smooth-scrolling nord-theme neotree key-chord helm-swoop helm-projectile general evil-surround evil-magit evil-commentary doom-modeline company carbon-now-sh anaconda-mode))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

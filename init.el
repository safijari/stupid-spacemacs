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
(column-number-mode 1)
(setq inhibit-startup-screen t)
(electric-pair-mode 1)

(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

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
(use-package all-the-icons :ensure t)

(use-package doom-themes :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)
  
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(load-theme 'doom-city-lights t)

;; themes
;; (load-subconfig "themes/nord.el")
;; (load-subconfig "themes/dracula.el")
;; (load-subconfig "themes/base16.el")

(use-package magit
  :general
  (:prefix "C-c"
	   "," 'with-editor-finish
	   "k" 'with-editor-cancel)
  :ensure t)


(use-package evil :ensure t
  :init
  (setq evil-move-cursor-back nil)
  (setq evil-normal-state-cursor '(box "gray"))
  :general
  (:states '(normal emacs visual)
	   "j" 'evil-next-visual-line
	   "k" 'evil-previous-visual-line)
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
  :general (:states '(visual operator)
		    "s" 'evil-surround-region)
  :config (global-evil-surround-mode 1)
    (setq evil-symbol-word-search t)
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

(setq helm-display-function 'helm-display-buffer-in-own-frame
      helm-display-buffer-reuse-frame t
      helm-use-undecorated-frame-option t
      )

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
(load-subconfig "treemacs.el")
(evil-define-key 'treemacs treemacs-mode-map (kbd "h") #'treemacs-TAB-action)
(evil-define-key 'treemacs treemacs-mode-map (kbd "l") #'treemacs-TAB-action)


;; (load-subconfig "neotree.el")

(use-package persp-mode
  :ensure t)

(use-package winum :ensure t
  :init (winum-mode) )

(use-package evil-escape
  :init (evil-escape-mode)
  :config
  (setq-default evil-escape-key-sequence "fd")
  :ensure t)

(use-package which-key
  :ensure t
  :init
  (which-key-mode)
  (setq which-key-idle-delay 0.25)
  )

(use-package company :ensure t
  :config
  (setq company-idle-delay 0.2)
  (setq company-minimum-prefix-length 2)
  :init (global-company-mode)
  :general
  )

;; (use-package nlinum :ensure t)
;; (global-nlinum-mode)
(global-display-line-numbers-mode 1)


(define-key key-translation-map (kbd "ESC") (kbd "C-g"))


(add-to-list 'custom-theme-load-path (expand-file-name "~/.emacs.d/themes/"))

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
 "fa" 'ranger
 "qq" 'evil-quit
 "fr" 'load-config
 "/"  'helm-projectile-ag
 "*"  '(lambda ()
	 (interactive)
	 (let
	     ((helm-ag-insert-at-point 'symbol))
	   (helm-projectile-ag)))
 "fe" '(lambda () (interactive) (find-file "~/.emacs.d/init.el"))
 "v" 'describe-variable
 "se" 'evil-iedit-state/iedit-mode
 )

(general-define-key
 :states '(normal visual emacs)
 :prefix "C-c"
 "gg" 'evil-goto-definition
 "b" 'beginning-of-defun
 "e" 'end-of-defun
 )


(use-package evil-commentary
  :general
  (:prefix "SPC"
	   :states '(normal visual)
	   "cl" 'evil-commentary-line)
  :ensure t)

(use-package carbon-now-sh :ensure t)

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
 "pp" 'helm-projectile-switch-project
 "pb" 'helm-projectile-switch-to-buffer
 "pf" 'helm-projectile-find-file
 "pI" 'projectile-invalidate-cache
 "pc" 'projectile-compile-project
 "ff" 'helm-find-files
 "ji" 'helm-jump-in-buffer
 "oi" 'helm-org-agenda-files-headings
 "+" 'text-scale-adjust
 "fb" 'beginning-of-defun
 "fn" 'end-of-defun
 "pt" 'treemacs
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
  (setq evil-org-use-additional-insert t)
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
	    (lambda ()
	      (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys)

  (with-eval-after-load 'goto-chg
    (defun goto-last-change-reverse ()
      "Fix goto-last-change-reverse code that doesn't work properly"
      (interactive)
      ;; Make 'goto-last-change-reverse' look like 'goto-last-change'
      (cond ((eq last-command this-command)
	     (setq last-command 'goto-last-change)))
      (setq this-command 'goto-last-change)
      ;; FIXME: Fix so can pass in any number of previous argument
      (goto-last-change '-1))

    )


  (general-define-key
   :keymaps 'org-mode-map
   :states '(normal)
   :prefix "C-c"
   "t" 'org-todo
   "," 'org-ctrl-c-ctrl-c
   )

  )

(setq org-agenda-files
      '("~/org/daily_tracker.org"))
(add-hook 'org-mode-hook '(lambda () (company-mode -1)))

;; (use-package anaconda-mode :ensure t)
(use-package pyvenv :ensure t)
(use-package flycheck :ensure t)
(use-package elpy
  :ensure t
  :init
  (elpy-enable)
  :general
  (:prefix "C-c"
	   "=" 'elpy-black-fix-code
	   )
  :config (setq
	   elpy-rpc-timeout 2)
  )

(when (load "flycheck" t t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
(setq elpy-rpc-virtualenv-path 'current)


;; Setting font name/size
(set-default-font "DejaVu Sans Mono 14")

(setq nlinum-format "%4d ")

(set-face-attribute 'helm-source-header nil :height 1.0)

(visual-line-mode)

(load-subconfig "cc.el")

(setq doom-modeline-buffer-file-name-style 'file-name)

(set-face-attribute 'mode-line nil :height 120)
(set-face-attribute 'mode-line-inactive nil :height 120)

(setq flycheck-temp-prefix "/tmp/flycheck")

(global-auto-revert-mode t)
(global-visual-line-mode)

(use-package yaml-mode
  :ensure t)

(use-package iedit
  :ensure t)

(set-face-attribute 'iedit-occurrence t :inherit 'region)

(use-package evil-iedit-state
  :after evil iedit
  :ensure t)

(use-package ranger
  :config
  (setq ranger-width-parents 0.25)
  (setq ranger-width-preview 0.5)
  :ensure t)


;; (load-subconfig "elegance.el")

;; (add-hook 'python-mode-hook (lambda () (pyvenv-workon "cv")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("632694fd8a835e85bcc8b7bb5c1df1a0164689bc6009864faed38a9142b97057" "2a998a3b66a0a6068bcb8b53cd3b519d230dd1527b07232e54c8b9d84061d48d" default)))
 '(helm-completion-style (quote emacs))
 '(package-selected-packages
   (quote
    (calfw-ical calfw-org calfw ranger base16-theme dracula-theme yaml-mode persp-mode evil-collection helm-ag flycheck elpy helm-company org-bullets helm-org evil-org nlinum pyvenv pyenv smooth-scroll winum which-key use-package treemacs-projectile treemacs-icons-dired treemacs-evil sublimity smooth-scrolling nord-theme neotree key-chord helm-swoop helm-projectile general evil-surround evil-magit evil-commentary doom-modeline company carbon-now-sh anaconda-mode)))
 '(persp-mode t nil (persp-mode))
 '(treemacs-follow-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

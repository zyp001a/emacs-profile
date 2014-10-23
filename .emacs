;; .emacs
;;; uncomment this line to disable loading of "default.el" at startup
;; (setq inhibit-default-init t)
(package-initialize)
;; turn on font-lock mode
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode 0))

;; enable visual feedback on selections
;(setq transient-mark-mode t)

;; default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")

;; always end a file with a newline
;(setq require-final-newline 'query)


; show colors
(global-font-lock-mode t)
; set indent
(setq c-default-style "k&r"
			c-basic-offset 2)

(require 'package)
;; Add the original Emacs Lisp Package Archive
(add-to-list 'package-archives
             '("elpa" . "http://tromey.com/elpa/"))
;; Add the user-contributed repository
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
;(load flex-mode)




(setq-default tab-width 2)
(setq tab-always-indent nil)
(put 'upcase-region 'disabled nil)

(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))

(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; coffeescript
(custom-set-variables
 '(coffee-tab-width 2)
 '(coffee-args-compile '("-c" "--bare")))

(eval-after-load "coffee-mode"
  '(progn
     (define-key coffee-mode-map [(meta r)] 'coffee-compile-buffer)
     (define-key coffee-mode-map (kbd "C-j") 'coffee-newline-and-indent)))

;;(add-hook 'js-mode-hook 'js2-minor-mode)

(add-to-list 'interpreter-mode-alist '("node" . js2-mode))
(require 'auto-complete)
(global-auto-complete-mode t)
(global-set-key (kbd "C-x ?") 'auto-complete)
(setq ac-candidate-limit nil)
(setq ac-use-menu-map t)

;; Default settings
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)

;(require 'dired-details)
;(setq-default dired-details-hidden-string "")
;(dired-details-install)
;(dired-at-point)
;(split-window-right -25)


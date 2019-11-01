;;js2-mode
;;auto-complete
;;pyim
;;coffee-mode
;;init 
(setq jpk-packages
      '(
        ac-dabbrev
        ...
        yasnippet
        ))

(package-initialize)
;;(add-to-list 'package-archives
 ;;            '("melpa" . "http://melpa.org/packages/"))
;;(add-to-list 'package-archives
 ;;            '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives
	     '("popkit" . "http://elpa.popkit.org/packages/"))
;; install any packages in jpk-packages, if they are not installed already
(let ((refreshed nil))
  (when (not package-archive-contents)
    (package-refresh-contents)
    (setq refreshed t))
  (dolist (pkg jpk-packages)
    (when (and (not (package-installed-p pkg))
             (assoc pkg package-archive-contents))
      (unless refreshed
        (package-refresh-contents)
        (setq refreshed t))
      (package-install pkg))))

(defun package-list-unaccounted-packages ()
  "Like `package-list-packages', but shows only the packages that
  are installed and are not in `jpk-packages'.  Useful for
  cleaning out unwanted packages."
  (interactive)
  (package-show-package-list
   (remove-if-not (lambda (x) (and (not (memq x jpk-packages))
                            (not (package-built-in-p x))
                            (package-installed-p x)))
                  (mapcar 'car package-archive-contents))))

(add-to-list 'load-path "~/.emacs.d/custom/go-mode.el")
(autoload 'go-mode "go-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.go\\'" . go-mode))


;; pyim
(require 'pyim)
(require 'pyim-basedict) ; 拼音词库设置，五笔用户 *不需要* 此行设置
(pyim-basedict-enable)   ; 拼音词库，五笔用户 *不需要* 此行设置
(setq default-input-method "pyim")


;; auto complete
(require 'auto-complete)
(global-auto-complete-mode t)
(global-set-key (kbd "C-x ?") 'auto-complete)
(setq ac-candidate-limit nil)
(setq ac-use-menu-map t)



;; select by mode
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.babel$" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . rjsx-mode))
(add-to-list 'interpreter-mode-alist '("node" . js2-mode))

(defun replace-regexp-entire-buffer (pattern replacement)
  "Perform regular-expression replacement throughout buffer."
  (interactive
   (let ((args (query-replace-read-args "Replace" t)))
     (setcdr (cdr args) nil)    ; remove third value returned from query---args
     args))
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward pattern nil t)
      (replace-match replacement))))

;; keyboard binding
(define-key ac-menu-map "\C-n" 'ac-next)
(define-key ac-menu-map "\C-p" 'ac-previous)
(global-set-key (kbd "C-x r") 'replace-regexp-entire-buffer)
(global-set-key (kbd "C-c M-c") 'comment-region)
(global-set-key (kbd "C-c M-v") 'uncomment-region)

;; general
(setq-default tab-width 2)
(setq tab-always-indent nil)


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coffee-args-compile (quote ("-c" "--bare")))
 '(coffee-tab-width 2)
 '(js-indent-level 2)
 '(package-selected-packages
	 (quote
		(rjsx-mode popup auto-complete pyim js2-mode yasnippet php-mode json-mode json dired-details coffee-mode))))

(eval-after-load "coffee-mode"
  '(progn
     (define-key coffee-mode-map [(meta r)] 'coffee-compile-buffer)
     (define-key coffee-mode-map (kbd "C-j") 'coffee-newline-and-indent)))


(defvar sl-highlights nil "highlight for Soul language")
(setq sl-highlights
      '(
				("`\\(\\\\.\\|[^\\\\`]\\)*`" . font-lock-warning-face)
				("'\\(\\\\.\\|[^\\\\']\\)*'" . font-lock-string-face)
				("\"\\(\\\\.\\|[^\\\\\"]\\)*\"" . font-lock-string-face)
        ("\\@\\([A-Za-z_][A-Za-z0-9]*\\)[^@]*@" . font-lock-builtin-face)
				("[A-Za-z0-9_$]+ *:" . font-lock-type-face)				
				("sfunc" . font-lock-keyword-face)				
				("for" . font-lock-keyword-face)
				("while" . font-lock-keyword-face)
				("mget" . font-lock-keyword-face)								
				("if" . font-lock-keyword-face)
				("arr" . font-lock-keyword-face)
				("dic" . font-lock-keyword-face)
				("call" . font-lock-keyword-face)
				("return" . font-lock-keyword-face)
				("break" . font-lock-keyword-face)
				("continue" . font-lock-keyword-face)
				("readFile" . font-lock-keyword-face)
				("writeFile" . font-lock-keyword-face)
				("readArgv" . font-lock-keyword-face)				
				("\\$" . font-lock-keyword-face)				
				("\\$ *\\([^ ]*\\)" . (1 font-lock-function-name-face))
				("\\(\\@[A-Za-z_][A-Za-z0-9_]*\\)`" . (1 font-lock-variable-name-face))
				("\\/\\/.*" . font-lock-comment-face)
        ("\\/\\*[^\\*]*\\*\\/" . font-lock-comment-face)
				)
			)
(defun test-font-lock-extend-region ()
  "Extend the search region to include an entire block of text."
  ;; Avoid compiler warnings about these global variables from font-lock.el.
  ;; See the documentation for variable `font-lock-extend-region-functions'.
  (eval-when-compile (defvar font-lock-beg) (defvar font-lock-end))
  (save-excursion
    (goto-char font-lock-beg)
    (let ((found (or (re-search-backward "\n" nil t) (point-min))))
      (goto-char font-lock-end)
      (when (re-search-forward "\n" nil t)
        (beginning-of-line)
        (setq font-lock-end (point)))
      (setq font-lock-beg found))))

(define-derived-mode sl-mode fundamental-mode "Soul"
  "major mode for editing Soul language code."
  (setq font-lock-defaults '(sl-highlights))
  (setq indent-tabs-mode nil)
  (set (make-local-variable 'font-lock-multiline) t)
  (setq font-lock-keywords-only t) 
	(add-hook 'font-lock-extend-region-functions
            'test-font-lock-extend-region)	
	)

(add-to-list 'auto-mode-alist '("\\.sl$" . sl-mode))

(defvar slt-highlights nil "highlight for Soul template language")
(setq slt-highlights
      '(
				;;				("~=\\(\\\\.\\|[^\\\\~]\\)+~" . font-lock-function-name-face)
				("~=[^~]+~" . font-lock-string-face)
				("~:[^~]+~" . font-lock-string-face)				
				("~[^~]+~" . font-lock-comment-face)
				("\\^[0-9A-Za-z_$]+" . font-lock-constant-face)
         ))
(define-derived-mode slt-mode fundamental-mode "Soul template"
  "major mode for editing Soul template language code."
  (setq font-lock-defaults '(slt-highlights t))
  (setq indent-tabs-mode nil)		
  (set (make-local-variable 'font-lock-multiline) t)
	(add-hook 'font-lock-extend-region-functions
            'test-font-lock-extend-region)
	)
(add-to-list 'auto-mode-alist '("\\.slt$" . slt-mode))

(defun my-after-save-actions ()
  "Used in `after-save-hook'."
  (when (memq this-command '(save-buffer save-some-buffers))
    (font-lock-fontify-buffer nil)
    ))

(add-hook 'after-save-hook 'my-after-save-actions)

(add-to-list 'load-path "~/.emacs.d/rust-mode")
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

;;; ac-dabbrev-autoloads.el --- automatically extracted autoloads
;;
;;; Code:
(add-to-list 'load-path (directory-file-name (or (file-name-directory #$) (car load-path))))

;;;### (autoloads nil "ac-dabbrev" "ac-dabbrev.el" (23126 12908 190250
;;;;;;  553000))
;;; Generated autoloads from ac-dabbrev.el

(autoload 'ac-dabbrev-get-candidates "ac-dabbrev" "\


\(fn ABBREV)" nil nil)

(defvar ac-source-dabbrev '((candidates lambda nil (all-completions ac-target (ac-dabbrev-get-candidates ac-target))) (candidate-face . ac-dabbrev-menu-face) (selection-face . ac-dabbrev-selection-face)) "\
Source for dabbrev")

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; End:
;;; ac-dabbrev-autoloads.el ends here

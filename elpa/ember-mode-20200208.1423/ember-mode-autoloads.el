;;; ember-mode-autoloads.el --- automatically extracted autoloads
;;
;;; Code:

(add-to-list 'load-path (directory-file-name
                         (or (file-name-directory #$) (car load-path))))


;;;### (autoloads nil "ember-mode" "ember-mode.el" (0 0 0 0))
;;; Generated autoloads from ember-mode.el

(autoload 'ember-mode "ember-mode" "\
Mode for navigating around ember-cli applications.

If called interactively, enable Ember mode if ARG is positive,
and disable it if ARG is zero or negative.  If called from Lisp,
also enable the mode if ARG is omitted or nil, and toggle it if
ARG is `toggle'; disable the mode otherwise.

\(fn &optional ARG)" t nil)

(if (fboundp 'register-definition-prefixes) (register-definition-prefixes "ember-mode" '("*ember--" "base-prefixes" "ember-")))

;;;***

;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; ember-mode-autoloads.el ends here

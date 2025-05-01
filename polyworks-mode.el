;;; polyworks-mode.el --- major mode for nps  -*- lexical-binding: t; -*-

;;; Commentary:
;;;  By Joseph T. Foley <foley@ru.is>
;;;  A Major mode for working with Innovmetric PolyWorks 2023+ macros
;;;  Based upon generic-x.el examples
;;; Emacs documentation says:

;; Generic modes are simple major modes with basic support for comment
;; syntax and Font Lock mode. To define a generic mode, use the macro
;; define-generic-mode. See the file generic-x.el for some examples of
;; the use of define-generic-mode.

;; macro define-generic-mode mode comment-list keyword-list
;; font-lock-list auto-mode-list function-list \&optional docstring
;; This macro defines a generic mode command named mode (a symbol, not
;; quoted). The optional argument docstring is the documentation for
;; the mode command. If you do not supply it, define-generic-mode
;; generates one by default.

;; The argument comment-list is a list in which each element is either
;; a character, a string of one or two characters, or a cons cell. A
;; character or a string is set up in the mode’s syntax table as a
;; comment starter. If the entry is a cons cell, the CAR is set up as
;; a comment starter and the CDR as a comment ender. (Use nil for the
;; latter if you want comments to end at the end of the line.) Note
;; that the syntax table mechanism has limitations about what comment
;; starters and enders are actually possible. See Syntax Tables.

;; The argument keyword-list is a list of keywords to highlight with
;; font-lock-keyword-face. Each keyword should be a string. Meanwhile,
;; font-lock-list is a list of additional expressions to highlight.
;; Each element of this list should have the same form as an element
;; of font-lock-keywords. See Search-based Fontification.

;; The argument auto-mode-list is a list of regular expressions to add
;; to the variable auto-mode-alist. They are added by the execution of
;; the define-generic-mode form, not by expanding the macro call.

;; Finally, function-list is a list of functions for the mode command to call for additional setup. It calls these functions just before it runs the mode hook variable mode-hook.

(provide 'polyworks-mode)
;;; Code:

(define-generic-mode 'polyworks-mode
  '("#")
  '("DECLARE" "MACRO")
  nil
  '(".pwmacro\\'" )
  nil)

;;; polyworks-mode.el ends here

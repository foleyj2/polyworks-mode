;;; polyworks-mode.el --- major mode for nps  -*- lexical-binding: t; -*-

;;; Commentary:
;;;  By Joseph T. Foley <foley@ru.is>
;;;  A Major mode for working with Innovmetric PolyWorks 2023+ macros
;;;  Based upon https://www.omarpolo.com/post/writing-a-major-mode.html
(provide 'polyworks-mode)
;;; Code:
(eval-when-compile
  (require 'rx))


(defconst polyworks--font-lock-defaults
  (let ((keywords '("assert" "const" "include" "proc" "testing"))
        (types '("str" "u8" "u16" "u32")))
    `(((,(rx-to-string `(: (or ,@keywords))) 0 font-lock-keyword-face)
       ("\\([[:word:]]+\\)\s*(" 1 font-lock-function-name-face)
       (,(rx-to-string `(: (or ,@types))) 0 font-lock-type-face)))))



(defvar polyworks-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?\{ "(}" st)
    (modify-syntax-entry ?\} "){" st)
    (modify-syntax-entry ?\( "()" st)

    ;; ;; - and _ are word constituents
    ;; (modify-syntax-entry ?_ "w" st)
    ;; (modify-syntax-entry ?- "w" st)

    ;; ;; both single and double quotes makes strings
    ;; (modify-syntax-entry ?\" "\"" st)
    ;; (modify-syntax-entry ?' "'" st)

    ;; ;; add comments. lua-mode does something similar, so it shouldn't
    ;; ;; bee *too* wrong.
    ;; (modify-syntax-entry ?# "<" st)
    ;; (modify-syntax-entry ?\n ">" st)

    ;; '==' as punctuation
    (modify-syntax-entry ?= ".")
    st))


(defun polyworks-indent-line ()
  "Indent current line."
  (let (indent
        boi-p                           ;begin of indent
        move-eol-p
        (point (point)))                ;lisps-2 are truly wonderful
    (save-excursion
      (back-to-indentation)
      (setq indent (car (syntax-ppss))
            boi-p (= point (point)))
      ;; don't indent empty lines if they don't have the in it
      (when (and (eq (char-after) ?\n)
                 (not boi-p))
        (setq indent 0))
      ;; check whether we want to move to the end of line
      (when boi-p
        (setq move-eol-p t))
      ;; decrement the indent if the first character on the line is a
      ;; closer.
      (when (or (eq (char-after) ?\))
                (eq (char-after) ?\}))
        (setq indent (1- indent)))
      ;; indent the line
      (delete-region (line-beginning-position)
                     (point))
      (indent-to (* tab-width indent)))
    (when move-eol-p
      (move-end-of-line nil))))

(defvar polyworks-mode-abbrev-table nil
  "Abbreviation table used in `nps-mode' buffers.")

(define-abbrev-table 'nps-mode-abbrev-table
  '())

;;;###autoload
(define-derived-mode nps-mode prog-mode "polyworks"
  "Major mode for nps files."
  :abbrev-table polyworks-mode-abbrev-table
  (setq font-lock-defaults polyworks-font-lock-defaults)
  (setq-local comment-start "#")
  (setq-local comment-start-skip "#+[\t ]*")
  (setq-local indent-line-function #'polyworks-indent-line)
  (setq-local indent-tabs-mode t))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.nps" . nps-mode))
;;; polyworks-mode.el ends here

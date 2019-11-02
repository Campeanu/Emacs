;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

(global-set-key (kbd "C-x g") 'magit-status)

;; ===================================================
;; == The default costum
;; ===================================================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-default nil)
 '(auto-save-interval 0)
 '(auto-save-list-file-prefix nil)
 '(auto-save-timeout 0)
 '(auto-show-mode t t)
 '(custom-enabled-themes (quote (misterioso)))
 '(delete-auto-save-files nil)
 '(delete-old-versions (quote other))
 '(imenu-auto-rescan t)
 '(imenu-auto-rescan-maxout 500000)
 '(make-backup-file-name-function (quote ignore))
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(mouse-wheel-follow-mouse nil)
 '(mouse-wheel-progressive-speed nil)
 '(mouse-wheel-scroll-amount (quote (15)))
 '(package-selected-packages (quote (magit)))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Window split to right by default.
(split-window-right)

;; Display time.
(display-time)

;; Active and customize h1 line mode.
(global-hl-line-mode 1)
(set-face-background 'hl-line "#333e4d")
(set-face-foreground 'highlight nil)

;; Finally, in other applications, pasting usually replaces the selected text with the contents of the clipboard.
;; To enable this behavior in Emacs, use DeleteSelectionMode with the following:
(delete-selection-mode)

;; No screwing with my middle mouse button.
(global-unset-key [mouse-2])

;; Required modes and libraries
(load-library "view")
(require 'cc-mode)
(require 'ido)
(require 'compile)
(ido-mode t)

;; ===================================================
;; == Variables
;; ===================================================

;; Stop Emacs from losing undo information.
(setq undo-limit 20000000)
(setq undo-strong-limit 40000000)

(setq visible-bell 1)
(setq inhibit-startup-screen t)
(setq delete-by-moving-to-trash t)

(setq make-backup-files nil) ;; stop creating backup~ files
(setq auto-save-default nil) ;; stop creating #autosave# files
(setq create-lockfiles  nil) ;; This will completely stop emacs from creating temoporary symbolic link files.

;; Smooth scroll
(setq scroll-step 3)

;; OS variables
(setq campeanu-aquamacs (featurep 'aquamacs))
(setq campeanu-linux    (featurep 'x))
(setq campeanu-win32    (not (or campeanu-aquamacs campeanu-linux)))

(setq campeanu-todo-file "d:/todo.txt")
(setq campeanu-log-file "d:/log.txt")

;; ===================================================
;; == Variables for Windows 10
;; ===================================================

(setq compilation-directory-locked nil)
(setq enable-local-variables nil)

(when campeanu-win32 
  (setq campeanu-makescript "build.bat")
  (setq campeanu-font "outline-Liberation Mono")
)

;; ===================================================
;; == C++ Configurations
;; ===================================================

;; Accepted file extensions and their appropriate modes
(setq auto-mode-alist
      (append
       '(("\\.cpp$"    . c++-mode)
         ("\\.hin$"    . c++-mode)
         ("\\.cin$"    . c++-mode)
         ("\\.inl$"    . c++-mode)
         ("\\.rdc$"    . c++-mode)
         ("\\.h$"      . c++-mode)
         ("\\.c$"      . c++-mode)
         ("\\.cc$"     . c++-mode)
         ("\\.c8$"     . c++-mode)
         ("\\.txt$"    . indented-text-mode)
         ("\\.emacs$"  . emacs-lisp-mode)
         ("\\.gen$"    . gen-mode)
         ("\\.ms$"     . fundamental-mode)
         ("\\.m$"      . objc-mode)
         ("\\.mm$"     . objc-mode)
         ) auto-mode-alist))

;; C++ indentation style
(defconst campeanu-big-fun-c-style
  '((c-electric-pound-behavior   . nil)
    (c-tab-always-indent         . t)
    (c-comment-only-line-offset  . 0)
    (c-hanging-braces-alist      . ((class-open)
                                    (class-close)
                                    (defun-open)
                                    (defun-close)
                                    (inline-open)
                                    (inline-close)
                                    (brace-list-open)
                                    (brace-list-close)
                                    (brace-list-intro)
                                    (brace-list-entry)
                                    (block-open)
                                    (block-close)
                                    (substatement-open)
                                    (statement-case-open)
                                    (class-open)))
    (c-hanging-colons-alist      . ((inher-intro)
                                    (case-label)
                                    (label)
                                    (access-label)
                                    (access-key)
                                    (member-init-intro)))
    (c-cleanup-list              . (scope-operator
                                    list-close-comma
                                    defun-close-semi))
    (c-offsets-alist             . ((arglist-close         .  c-lineup-arglist)
                                    (label                 . -4)
                                    (access-label          . -4)
                                    (substatement-open     .  0)
                                    (statement-case-intro  .  4)
                                    (case-label            .  4)
                                    (block-open            .  0)
                                    (inline-open           .  0)
                                    (topmost-intro-cont    .  0)
                                    (knr-argdecl-intro     . -4)
                                    (brace-list-open       .  0)
                                    (brace-list-intro      .  4)))
    (c-echo-syntactic-information-p . t))
    "Campeanu's Big Fun C++ Style")

(define-key global-map [C-tab] 'other-window)

;; ===================================================
;; == Editing stuff                              ---->
;; ===================================================

(defun campeanu-replace-string (FromString ToString)
  "Replace a string without moving point."
  (interactive "sReplace: \nsReplace: %s  With: ")
  (save-excursion
    (replace-string FromString ToString)
  ))
  
(define-key global-map [f8] 'campeanu-replace-string)

(defun campeanu-replace-in-region (old-word new-word)
  "Perform a replace-string in the current region."
  (interactive "sReplace: \nsReplace: %s  With: ")
  (save-excursion (save-restriction
		    (narrow-to-region (mark) (point))
		    (beginning-of-buffer)
		    (replace-string old-word new-word)
		    ))
  )

(define-key global-map "\el" 'campeanu-replace-in-region)
(define-key global-map "\eo" 'query-replace)
(define-key global-map "\eO" 'campeanu-replace-string)

;; ===================================================
;; == Editing stuff                              <----
;; ===================================================



;; ===================================================
;; == Move lines of code
;; ===================================================

(defun move-lines--internal (n)
  "Moves the current line or, if region is actives, the lines surrounding
region, of N lines. Down if N is positive, up if is negative"

  (let* (text-start
         text-end
         (region-start (point))
         (region-end region-start)
         swap-point-mark
         delete-latest-newline)

    ;; STEP 1: identifying the text to cut.
    (when (region-active-p)
      (if (> (point) (mark))
          (setq region-start (mark))
        (exchange-point-and-mark)
        (setq swap-point-mark t
              region-end (point))))

    ;; text-end and region-end
    (end-of-line)
    ;; If point !< point-max, this buffers doesn't have the trailing newline.
    (if (< (point) (point-max))
        (forward-char 1)
      (setq delete-latest-newline t)
      (insert-char ?\n))
    (setq text-end (point)
          region-end (- region-end text-end))

    ;; text-start and region-start
    (goto-char region-start)
    (beginning-of-line)
    (setq text-start (point)
          region-start (- region-start text-end))

    ;; STEP 2: cut and paste.
    (let ((text (delete-and-extract-region text-start text-end)))
      (forward-line n)
      ;; If the current-column != 0, I have moved the region at the bottom of a
      ;; buffer doesn't have the trailing newline.
      (when (not (= (current-column) 0))
        (insert-char ?\n)
        (setq delete-latest-newline t))
      (insert text))

    ;; STEP 3: Restoring.
    (forward-char region-end)

    (when delete-latest-newline
      (save-excursion
        (goto-char (point-max))
        (delete-char -1)))

    (when (region-active-p)
      (setq deactivate-mark nil)
      (set-mark (+ (point) (- region-start region-end)))
      (if swap-point-mark
          (exchange-point-and-mark)))))

;;;###autoload
(defun move-lines-up (n)
  "Moves the current line or, if region is actives, the lines surrounding
region, up by N lines, or 1 line if N is nil."
  (interactive "p")
  (if (eq n nil)
      (setq n 1))
  (move-lines--internal (- n)))

;;;###autoload
(defun move-lines-down (n)
  "Moves the current line or, if region is actives, the lines surrounding
region, down by N lines, or 1 line if N is nil."
  (interactive "p")
  (if (eq n nil)
      (setq n 1))
  (move-lines--internal n))

;;;###autoload
(defun move-lines-binding ()
  "Sets the default key binding for moving lines. M-p or M-<up> for moving up
and M-n or M-<down> for moving down."
  (global-set-key (kbd "M-p") 'move-lines-up)
  (global-set-key (kbd "M-<up>") 'move-lines-up)
  (global-set-key (kbd "M-n") 'move-lines-down)
  (global-set-key (kbd "M-<down>") 'move-lines-down))

(provide 'move-lines)

;; Make the moving lines mode active
(move-lines-binding)

;; ===================================================
;; == Key bindings
;; ===================================================

;; Setup my find-files
(define-key global-map "\ef" 'find-file)
(define-key global-map "\eF" 'find-file-other-window)

(global-set-key (read-kbd-macro "\eb")  'ido-switch-buffer)
(global-set-key (read-kbd-macro "\eB")  'ido-switch-buffer-other-window)

(defun campeanu-ediff-setup-windows (buffer-A buffer-B buffer-C control-buffer)
  (ediff-setup-windows-plain buffer-A buffer-B buffer-C control-buffer)
  )

(setq ediff-window-setup-function 'campeanu-ediff-setup-windows)
(setq ediff-split-window-function 'split-window-horizontally)

;; ===================================================
;; == Setup my compilation mode and TODO / NOTE 
;; ===================================================

(defun campeanu-big-fun-compilation-hook ()
  (make-local-variable 'truncate-lines)
  (setq truncate-lines nil)
)

(add-hook 'compilation-mode-hook 'campeanu-big-fun-compilation-hook)

(defun load-todo ()
  (interactive)
  (find-file campeanu-todo-file)
)

(define-key global-map "\et" 'load-todo)

(defun insert-timeofday ()
   (interactive "*")
   (insert (format-time-string "---------------- %a, %d %b %y: %I:%M%p")))
(defun load-log ()
  (interactive)
  (find-file campeanu-log-file)
  (if (boundp 'longlines-mode) ()
    (longlines-mode 1)
    (longlines-show-hard-newlines))
  (if (equal longlines-mode t) ()
    (longlines-mode 1)
    (longlines-show-hard-newlines))
  (end-of-buffer)
  (newline-and-indent)
  (insert-timeofday)
  (newline-and-indent)
  (newline-and-indent)
  (end-of-buffer)
  )

(define-key global-map "\eT" 'load-log)

;; Bright-red TODOs
 (setq fixme-modes '(c++-mode c-mode emacs-lisp-mode))
 (make-face 'font-lock-fixme-face)
 (make-face 'font-lock-note-face)
 (mapc (lambda (mode)
	 (font-lock-add-keywords
	  mode
	  '(("\\<\\(TODO\\)" 1 'font-lock-fixme-face t)
            ("\\<\\(NOTE\\)" 1 'font-lock-note-face  t))))
	fixme-modes)
 (modify-face 'font-lock-fixme-face "Red"        nil nil t nil t nil nil)
 (modify-face 'font-lock-note-face  "Dark Green" nil nil t nil t nil nil)

;; ===================================================
;; == C++ mode handling                          ----> 
;; ===================================================
(defun campeanu-big-fun-c-hook ()
  ;; Set my style for the current buffer.
  (c-add-style "BigFun" campeanu-big-fun-c-style t)
  
  ;; Make 4-space tabs.
  (setq tab-width 4
        indent-tabs-mode nil)

  ;; Additional style stuff.
  (c-set-offset 'member-init-intro '++)

  ;; No hungry backspace.
  (c-toggle-auto-hungry-state -1)

  ;; Newline indents, semi-colon doesn't.
  (define-key c++-mode-map "\C-m" 'newline-and-indent)
  (setq c-hanging-semi&comma-criteria '((lambda () 'stop)))

  ;; Handle super-tabbify (TAB completes, shift-TAB actually tabs).
  (setq dabbrev-case-replace t)
  (setq dabbrev-case-fold-search t)
  (setq dabbrev-upcase-means-case-search t)

  ;; Abbrevation expansion.
  (abbrev-mode 1)
 
  (defun campeanu-header-format ()
     "Format the given file as a header file."
     (interactive)
     (setq BaseFileName (file-name-sans-extension (file-name-nondirectory buffer-file-name)))
     (insert "#if !defined(")
     (push-mark)
     (insert BaseFileName)
     (upcase-region (mark) (point))
     (pop-mark)
     (insert "_H)\n")
     (insert "/* ========================================================================\n")
     (insert "   $File: $\n")
     (insert "   $Date: $\n")
     (insert "   $Revision: $\n")
     (insert "   $Creator: Campeanu Vasile $\n")
     (insert "   $Notice: (C) Copyright 2019 by Campeanu Vasile, Inc. All Rights Reserved. $\n")
     (insert "   ======================================================================== */\n")
     (insert "\n")
     (insert "#define ")
     (push-mark)
     (insert BaseFileName)
     (upcase-region (mark) (point))
     (pop-mark)
     (insert "_H\n")
     (insert "#endif")
  )

  (defun campeanu-source-format ()
     "Format the given file as a source file."
     (interactive)
     (setq BaseFileName (file-name-sans-extension (file-name-nondirectory buffer-file-name)))
     (insert "/* ========================================================================\n")
     (insert "   $File: $\n")
     (insert "   $Date: $\n")
     (insert "   $Revision: $\n")
     (insert "   $Creator: Campeanu Vasile $\n")
     (insert "   $Notice: (C) Copyright 2019 by Campeanu Vasile, Inc. All Rights Reserved. $\n")
     (insert "   ======================================================================== */\n")
  )

  (cond ((file-exists-p buffer-file-name) t)
        ((string-match "[.]hin" buffer-file-name) (campeanu-source-format))
        ((string-match "[.]cin" buffer-file-name) (campeanu-source-format))
        ((string-match "[.]h"   buffer-file-name) (campeanu-header-format))
        ((string-match "[.]cpp" buffer-file-name) (campeanu-source-format)))

  (defun campeanu-find-corresponding-file ()
    "Find the file that corresponds to this one."
    (interactive)
    (setq CorrespondingFileName nil)
    (setq BaseFileName (file-name-sans-extension buffer-file-name))
    (if (string-match "\\.c" buffer-file-name)
       (setq CorrespondingFileName (concat BaseFileName ".h")))
    (if (string-match "\\.h" buffer-file-name)
       (if (file-exists-p (concat BaseFileName ".c")) (setq CorrespondingFileName (concat BaseFileName ".c"))
	   (setq CorrespondingFileName (concat BaseFileName ".cpp"))))
    (if (string-match "\\.hin" buffer-file-name)
       (setq CorrespondingFileName (concat BaseFileName ".cin")))
    (if (string-match "\\.cin" buffer-file-name)
       (setq CorrespondingFileName (concat BaseFileName ".hin")))
    (if (string-match "\\.cpp" buffer-file-name)
       (setq CorrespondingFileName (concat BaseFileName ".h")))
    (if CorrespondingFileName (find-file CorrespondingFileName)
       (error "Unable to find a corresponding file")))
  (defun campeanu-find-corresponding-file-other-window ()
    "Find the file that corresponds to this one."
    (interactive)
    (find-file-other-window buffer-file-name)
    (campeanu-find-corresponding-file)
    (other-window -1))

  ;; Find corresponding file
  (define-key c++-mode-map [f12]   'campeanu-find-corresponding-file)
  (define-key c++-mode-map [M-f12] 'campeanu-find-corresponding-file-other-window)

  ;; Alternate bindings for F-keyless setups (ie MacOS X terminal).
  (define-key c++-mode-map "\ec" 'campeanu-find-corresponding-file)
  (define-key c++-mode-map "\eC" 'campeanu-find-corresponding-file-other-window)

  ;; Error parsing devenv.com .
  (add-to-list 'compilation-error-regexp-alist 'campeanu-devenv)
  (add-to-list 'compilation-error-regexp-alist-alist '(campeanu-devenv
   "*\\([0-9]+>\\)?\\(\\(?:[a-zA-Z]:\\)?[^:(\t\n]+\\)(\\([0-9]+\\)) : \\(?:see declaration\\|\\(?:warnin\\(g\\)\\|[a-z ]+\\) C[0-9]+:\\)"
    2 3 nil (4)))
)
(add-hook 'c-mode-common-hook 'campeanu-big-fun-c-hook)
;; ===================================================
;; == C++ mode handling                         <----
;; ===================================================

;; Errors
(define-key global-map [f9]  'first-error)
(define-key global-map [f10] 'previous-error)
(define-key global-map [f11] 'next-error)

;; Buffers
(define-key global-map "\er" 'revert-buffer)
(define-key global-map "\ek" 'kill-this-buffer)


;; ===================================================
;; == Compilation
;; ===================================================

(setq max-lisp-eval-depth 10000)

(setq compilation-context-lines 0)
(setq compilation-error-regexp-alist
    (cons '("^\\([0-9]+>\\)?\\(\\(?:[a-zA-Z]:\\)?[^:(\t\n]+\\)(\\([0-9]+\\)) : \\(?:fatal error\\|warnin\\(g\\)\\) C[0-9]+:" 2 3 nil (4))
     compilation-error-regexp-alist))

(defun find-project-directory-recursive ()
  "Recursively search for a makefile."
  (interactive)
  (if (file-exists-p campeanu-makescript) t
      (cd "../")
      (find-project-directory-recursive)))

(defun lock-compilation-directory ()
  "The compilation process should NOT hunt for a makefile"
  (interactive)
  (setq compilation-directory-locked t)
  (message "Compilation directory is locked."))

(defun unlock-compilation-directory ()
  "The compilation process SHOULD hunt for a makefile"
  (interactive)
  (setq compilation-directory-locked nil)
  (message "Compilation directory is roaming."))

(defun find-project-directory ()
  "Find the project directory."
  (interactive)
  (setq find-project-from-directory default-directory)
  (switch-to-buffer-other-window "*compilation*")
  (if compilation-directory-locked (cd last-compilation-directory)
  (cd find-project-from-directory)
  (find-project-directory-recursive)
  (setq last-compilation-directory default-directory)))

(defun make-without-asking ()
  "Make the current build."
  (interactive)
  (if (find-project-directory) (compile campeanu-makescript))
  (other-window 1))
(define-key global-map "\em" 'make-without-asking)

;; Commands
(set-variable 'grep-command "grep -irHn ")
(when campeanu-win32
    (set-variable 'grep-command "findstr -s -n -i -l "))

;; ===================================================
;; == Compilation
;; ===================================================

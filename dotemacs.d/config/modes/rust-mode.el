;; (use-package racer)
;; (use-package flycheck-rust)

;; (setq flycheck-rust-cargo-executable "/usr/sbin/cargo")
;; (with-eval-after-load 'rust-mode
 ;;  (add-hook 'flycheck-mode-hook #'flycheck-rust-setup))

;; (add-hook 'rust-mode-hook #'racer-mode)
;; (add-hook 'rust-mode-hook #'eldoc-mode)
;; (add-hook 'rust-mode-hook #'rustic-mode)
;; (add-hook 'racer-mode-hook #'rustic-mode)
;; (add-hook 'rust-mode-hook #'company-mode)

;; (use-package company-lsp)
(setq company-tooltip-align-annotations t)

;; (define-key rust-mode-map (kbd "TAB") #'company-indent-or-complete-common) ;; Map TAB key to completions.
;; (define-key rust-mode-map (kbd "C-c C-j") #'lsp-find-definition)

;; https://lupan.pl/dotemacs/#common-settings-for-programming-modes

(defun my-rustic-mode-hook-fn ()
  "needed for lsp-format-buffer to indent with 4 spaces"
  (setq tab-width 4
        indent-tabs-mode nil))

(use-package flycheck-rust)

(use-package rustic
  :mode "\\.rs\\"
  :init
  ;; to use rustic-mode even if rust-mode also installed
  (push 'rustic-clippy flycheck-checkers)
  :hook ((rustic-mode . my-rustic-mode-hook-fn)
         (flycheck-mode-hook . flycheck-rust-setup)))


  
(use-package company
  :init
  (setq company-idle-delay nil  ; avoid auto completion popup, use TAB
                                ; to show it
        company-tooltip-align-annotations t)
  :hook (after-init . global-company-mode)
  :bind
  (:map prog-mode-map
        ("C-i" . company-indent-or-complete-common)
        ("C-M-i" . completion-at-point)))

(use-package company-lsp
  :defer)

(use-package lsp-mode
  :commands lsp
  ;; reformat code and add missing (or remove old) imports
  :hook ((before-save . lsp-format-buffer)
         (before-save . lsp-organize-imports))
  :bind (("C-c d" . lsp-describe-thing-at-point)
         ;; ("C-c e n" . flymake-goto-next-error)
         ;; ("C-c e p" . flymake-goto-prev-error)
         ("C-c e r" . lsp-find-references)
         ("C-c e R" . lsp-rename)
         ("C-c e i" . lsp-find-implementation)
         ("C-c C-j" . lsp-find-definition)
         ("C-c e t" . lsp-find-type-definition)))

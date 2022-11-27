;;; init-local.el --- my own config -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;启用org-download
(require 'org-download)
;; Drag-and-drop to `dired`
(add-hook 'dired-mode-hook 'org-download-enable)
(use-package org-download
  :after org
  :defer nil
  :custom
  (org-download-method 'directory)
  (org-download-image-dir "e:/org/images")
  (org-download-screenshot-method "e:/IrfanView/i_view64.exe /capture=4 /convert=\"%s\"")
  :bind
  ("C-S-y" . org-download-screenshot)
  :config
  (require 'org-download))

;; ;;启用yasnippet
;; (require 'yasnippet)
;; (yas-reload-all)
;; (add-hook 'org-mode-hook 'yas-minor-mode) ;;只有在org文件下才打开yas功能
;; ;;(yas-global-mode 1) ;;启动自动打开yas功能

(add-to-list 'load-path "~/emacs.d/lisp/c_ide")
(require 'setup-general)
;; (if (version< emacs-version "24.4")
;;     (require 'setup-ivy-counsel)
;;   (require 'setup-helm)
;;   (require 'setup-helm-gtags))
;; (require 'setup-ggtags)
(require 'setup-cedet)
(require 'setup-editing)


(provide 'init-local)
;;; init-locales.el ends here
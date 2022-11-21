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



(provide 'init-local)
;;; init-locales.el ends here
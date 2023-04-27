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
  (org-download-heading-lvl 0)
  (org-download-screenshot-method "e:/IrfanView/i_view64.exe /capture=4 /convert=\"%s\"")
  :bind
  ("C-S-y" . org-download-screenshot)
  :config
  (require 'org-download))

(provide 'init-org-download)

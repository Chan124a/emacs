;;; init-local.el --- my own config -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;;启用lsp
;; (require 'lsp-mode)
;; (add-hook 'XXX-mode-hook #'lsp)

;; 设置这个是为了让magit的ssh服务能够正常运行
(setenv "HOME" "C:\\Users\\123")

;;加快tramp的启动
;; (setq tramp-auto-save-directory "~/tmp/tramp/")
;; (setq tramp-chunksize 2000)

;;将C-h绑定为删除光标前字符
(global-set-key (kbd "C-h") 'paredit-backward-delete)
(provide 'init-local)
;;; init-locales.el ends here

;;启用yasnippet
(require 'yasnippet)
(yas-reload-all)
(add-hook 'org-mode-hook 'yas-minor-mode) ;;只有在org文件下才打开yas功能
;;(yas-global-mode 1) ;;启动自动打开yas功能

(provide 'init-yasnippet)

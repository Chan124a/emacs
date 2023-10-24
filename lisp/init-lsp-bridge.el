;; lsp-bridge
(add-to-list 'load-path "E:\\emacs.d\\elpa-28.2\\lsp-bridge")

(require 'yasnippet)
(yas-global-mode 1)

(require 'lsp-bridge)
(global-lsp-bridge-mode)

;; 打开调试日志
(setq lsp-bridge-enable-log t)

(setq lsp-bridge-python-command "python.exe")

(provide 'init-lsp-bridge)

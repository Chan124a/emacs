;; lsp-bridge
(add-to-list 'load-path "E:\\emacs.d\\elpa-28.2\\lsp-bridge")

(require 'yasnippet)
(yas-global-mode 1)

(require 'lsp-bridge)
(global-lsp-bridge-mode)

(provide 'init-lsp-bridge)

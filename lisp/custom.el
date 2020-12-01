(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(cdlatex-command-alist
   (quote
    (("m" "Insert \\mbox{} " "\\mbox{?} " cdlatex-position-cursor nil nil t)
     ("li" "Insert \\lim\\limits_{n \\to \\infty}" "\\lim\\limits_{n \\to ?\\infty}" cdlatex-position-cursor nil nil t)
     ("lix" "Insert \\lim\\limits_{x \\to }" "\\lim\\limits_{x \\to ? }" cdlatex-position-cursor nil nil t)
     ("lixx " "Insert \\lim\\limits_{x \\to x_0}" "\\lim\\limits_{x \\to x_0} " ignore nil nil t)
     ("le" "Insert \\leq" "\\leq " ignore nil nil t)
     ("ge" "Insert \\geq" "\\geq " ignore nil nil t)
     ("ne" "Insert \\neq" "\\neq " ignore nil nil t)
     ("the" "Insert \\begin{theorem}  \\end{theorem}" "\\begin{theorem}
 ?
\\end{theorem}" cdlatex-position-cursor nil t nil)
     ("i" "Insert \\[  \\]" "\\[ ? \\]" cdlatex-position-cursor nil t nil))))
 '(cdlatex-math-symbol-alist
   (quote
    ((49
      ("x_0" "t_0"))
     (50
      ("f" "f(x)"))
     (51
      ("g" "g(x)"))
     (112
      ("\\pi" "\\pm")))))
 '(cdlatex-paired-parens "$[{(")
 '(custom-safe-themes
   (quote
    ("a2cde79e4cc8dc9a03e7d9a42fabf8928720d420034b66aecc5b665bbf05d4e9" default)))
 '(monokai-background "#272822")
 '(monokai-highlight "#49483E")
 '(monokai-highlight-alt "#3E3D31")
 '(monokai-highlight-line "#3C3D37")
 '(org-emphasis-alist
   (quote
    (("*" bold)
     ("/" italic)
     ("=" org-verbatim verbatim)
     ("~" org-code verbatim)
     ("+"
      (:strike-through t)))))
 '(package-selected-packages
   (quote
    (highlight-symbol popwin auctex counsel swiper js2-mode monokai-theme smartparens htmlize company)))
 '(popwin:popup-window-position (quote right))
 '(popwin:popup-window-width 70)
 '(word-wrap nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(iedit-occurrence ((t (:inherit highlight))))
 '(region ((t (:inherit highlight :background "blue")))))

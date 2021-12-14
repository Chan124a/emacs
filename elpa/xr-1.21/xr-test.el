;;; xr-test.el --- Tests for xr.el                   -*- lexical-binding: t -*-

;; Copyright (C) 2019-2020 Free Software Foundation, Inc.

;; Author: Mattias Engdegård <mattiase@acm.org>

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.


(require 'xr)
(require 'ert)


(ert-deftest xr-basic ()
  (should (equal (xr "a\\$b\\\\c\\[\\]\\q")
                 "a$b\\c[]q"))
  (should (equal (xr "\\(?:ab\\|c*d\\)?")
                 '(opt (or "ab" (seq (zero-or-more "c") "d")))))
  (should (equal (xr ".+")
                 '(one-or-more nonl)))
  (should-error (xr "b\\"))
  )

(ert-deftest xr-repeat ()
  (should (equal (xr "\\(?:x?y\\)\\{3\\}")
                 '(= 3 (opt "x") "y")))
  (should (equal (xr "\\(?:x?y\\)\\{3,8\\}")
                 '(repeat 3 8 (opt "x") "y")))
  (should (equal (xr "\\(?:x?y\\)\\{3,\\}")
                     '(>= 3 (opt "x") "y")))
  (should (equal (xr "\\(?:x?y\\)\\{,8\\}")
                 '(repeat 0 8 (opt "x") "y")))
  (should (equal (xr "\\(?:xy\\)\\{4,4\\}")
                 '(= 4 "xy")))
  (should (equal (xr "a\\{,\\}")
                 '(zero-or-more "a")))
  (should (equal (xr "a\\{0\\}")
                 '(repeat 0 0 "a")))
  (should (equal (xr "a\\{0,\\}")
                 '(zero-or-more "a")))
  (should (equal (xr "a\\{0,0\\}")
                 '(repeat 0 0 "a")))
  (should (equal (xr "a\\{\\}")
                 '(repeat 0 0 "a")))
  (should (equal (xr "a\\{,1\\}")
                 '(repeat 0 1 "a")))
  (should (equal (xr "a\\{1,\\}")
                 '(>= 1 "a")))
  (should-error (xr "a\\{3,2\\}"))
  (should-error (xr "a\\{1,2,3\\}"))
  )

(ert-deftest xr-backref ()
  (should (equal (xr "\\(ab\\)\\(?3:cd\\)\\1\\3")
                 '(seq (group "ab") (group-n 3 "cd") (backref 1) (backref 3))))
  (should (equal (xr "\\01")
                 "01"))
  (should-error (xr "\\(?abc\\)"))
  (should-error (xr "\\(?2\\)"))
  (should-error (xr "\\(?0:xy\\)"))
  (should (equal (xr "\\(?29:xy\\)")
                 '(group-n 29 "xy")))
  (should-error (xr "\\(c?"))
  (should-error (xr "xy\\)"))
  )

(ert-deftest xr-misc ()
  (should (equal (xr "^.\\w\\W\\`\\'\\=\\b\\B\\<\\>\\_<\\_>$")
                 '(seq bol nonl wordchar not-wordchar bos eos point
                       word-boundary not-word-boundary bow eow
                       symbol-start symbol-end eol)))
  (should-error (xr "\\_a"))
  )

(ert-deftest xr-syntax ()
  (should (equal (xr "\\s-\\s \\sw\\sW\\s_\\s.\\s(\\s)\\s\"")
                 '(seq (syntax whitespace) (syntax whitespace) (syntax word)
                       (syntax word)
                       (syntax symbol) (syntax punctuation)
                       (syntax open-parenthesis) (syntax close-parenthesis)
                       (syntax string-quote))))
  (should (equal (xr "\\s\\\\s/\\s$\\s'\\s<\\s>\\s!\\s|")
                 '(seq (syntax escape) (syntax character-quote)
                       (syntax paired-delimiter) (syntax expression-prefix)
                       (syntax comment-start) (syntax comment-end)
                       (syntax comment-delimiter) (syntax string-delimiter))))
  (should (equal (xr "\\S-\\S<")
                 '(seq (not (syntax whitespace))
                       (not (syntax comment-start)))))
  (should-error (xr "\\s"))
  (should-error (xr "\\S"))
  (should-error (xr "\\sq"))
  (should-error (xr "\\Sq"))
  )

(ert-deftest xr-category ()
  (should (equal (xr "\\c0\\c1\\c2\\c3\\c4\\c5\\c6\\c7\\c8\\c9\\c<\\c>")
                 '(seq (category consonant) (category base-vowel)
                       (category upper-diacritical-mark)
                       (category lower-diacritical-mark)
                       (category tone-mark) (category symbol) (category digit)
                       (category vowel-modifying-diacritical-mark)
                       (category vowel-sign) (category semivowel-lower)
                       (category not-at-end-of-line)
                       (category not-at-beginning-of-line))))
  (should (equal (xr "\\cA\\cC\\cG\\cH\\cI\\cK\\cN\\cY\\c^")
          '(seq (category alpha-numeric-two-byte) (category chinese-two-byte)
                (category greek-two-byte) (category japanese-hiragana-two-byte)
                (category indian-two-byte)
                (category japanese-katakana-two-byte)
                (category korean-hangul-two-byte) (category cyrillic-two-byte)
                (category combining-diacritic))))
  (should (equal (xr "\\ca\\cb\\cc\\ce\\cg\\ch\\ci\\cj\\ck\\cl\\co\\cq\\cr")
          '(seq (category ascii) (category arabic) (category chinese)
                (category ethiopic) (category greek) (category korean)
                (category indian)  (category japanese)
                (category japanese-katakana) (category latin) (category lao)
                (category tibetan) (category japanese-roman))))
  (should (equal (xr "\\ct\\cv\\cw\\cy\\c|")
                 '(seq (category thai) (category vietnamese) (category hebrew)
                       (category cyrillic) (category can-break))))
  (should (equal (xr "\\C2\\C^")
                 '(seq (not (category upper-diacritical-mark))
                       (not (category combining-diacritic)))))
  (should (equal (xr "\\cR\\C.\\cL\\C ")
                 '(seq (category strong-right-to-left)
                       (not (category base)) (category strong-left-to-right)
                       (not (category space-for-indent)))))
  (should (equal (xr "\\c%\\C+")
                 '(seq (category ?%) (not (category ?+)))))
  (should-error (xr "\\c"))
  (should-error (xr "\\C"))
  )

(ert-deftest xr-lazy ()
  (should (equal (xr "\\(?:a.\\)*?")
                 '(*? "a" nonl)))
  (should (equal (xr "\\(?:a.\\)+?")
                 '(+? "a" nonl)))
  (should (equal (xr "\\(?:a.\\)??")
                 '(?? "a" nonl)))
  (should (equal (xr "\\(?:.\\(a+\\(?:b+?c*\\)?\\)??\\)*")
                 '(zero-or-more
                   nonl
                   (?? (group (one-or-more "a")
                              (opt (+? "b")
                                   (zero-or-more "c")))))))
  )

(ert-deftest xr-char-classes ()
  (should (equal (xr "[[:alnum:][:blank:]][[:alpha:]][[:cntrl:][:digit:]]")
                 '(seq (any alnum blank) alpha (any cntrl digit))))
  (should (equal (xr "[^[:lower:][:punct:]][^[:space:]]")
                 '(seq (not (any lower punct)) (not space))))
  (should (equal (xr "^[a-z]*")
                 '(seq bol (zero-or-more (any "a-z")))))
  (should (equal (xr "some[.]thing")
                 "some.thing"))
  (should (equal (xr "[^]-c]")
                 '(not (any "]-c"))))
  (should (equal (xr "[-^]")
                 '(any "^-")))
  (should (equal (xr "[a-z-+/*%0-4[:xdigit:]]")
                 '(any "0-4a-z" "%*+/-" xdigit)))
  (should (equal (xr "[^]A-Za-z-]*")
                 '(zero-or-more (not (any "A-Za-z" "]-")))))
  (should (equal (xr "[+*%A-Ka-k0-3${-}]")
                 '(any "0-3A-Ka-k{-}" "$%*+")))
  (should (equal (xr "[^\\\\o][A-\\\\][A-\\\\-a]")
                 '(seq (not (any "\\o")) (any "A-\\") (any "A-a"))))
  (should (equal (xr "[^A-FFGI-LI-Mb-da-eg-ki-ns-tz-v]")
                 '(not (any "A-FI-Ma-eg-ns-t" "G"))))
  (should (equal (xr "[z-a][^z-a]")
                 '(seq (any) anything)))
  (should (equal (xr "[[:alpha]]")
                 '(seq (any ":[ahlp") "]")))
  (should (equal (xr "[:alpha:]")
                 '(any ":ahlp")))
  (should (equal (xr "[[:digit:]-z]")
                 '(any "z-" digit)))
  (should (equal (xr "[A-[:digit:]]")
                 '(seq (any "A-[" ":dgit") "]")))
  (should (equal (xr "[^\n]")
                 'nonl))
  (should-error (xr "[[::]]"))
  (should-error (xr "[[:=:]]"))
  (should-error (xr "[[:letter:]]"))
  (should-error (xr "[a-f"))
  (should (equal (xr "[aaaaaa][bananabanana][aaaa-cccc][a-ca-ca-c]")
                 '(seq "a" (any "abn") (any "a-c") (any "a-c"))))
  (should (equal (xr "[a-fb-gc-h][a-fc-kh-p]")
                 '(seq (any "a-h") (any "a-p"))))
  )

(ert-deftest xr-empty ()
  (should (equal (xr "")
                 ""))
  (should (equal (xr "a\\|")
                 '(or "a" "")))
  (should (equal (xr "\\|a")
                 '(or "" "a")))
  (should (equal (xr "a\\|\\|b")
                 '(or "a" "" "b")))
  )

(ert-deftest xr-anything ()
  (should (equal (xr "\\(?:.\\|\n\\)?\\(\n\\|.\\)*")
                 '(seq (opt anything) (zero-or-more (group anything)))))
  )

(ert-deftest xr-real ()
  (should (equal (xr "\\*\\*\\* EOOH \\*\\*\\*\n")
                 "*** EOOH ***\n"))
  (should (equal (xr "\\<\\(catch\\|finally\\)\\>[^_]")
                 '(seq bow (group (or "catch" "finally")) eow
                       (not (any "_")))))
  (should (equal (xr "[ \t\n]*:\\([^:]+\\|$\\)")
                 '(seq (zero-or-more (any "\t\n ")) ":"
                       (group (or (one-or-more (not (any ":")))
                                  eol)))))
  )

(ert-deftest xr-edge-cases ()
  (should (equal (xr "^a^b\\(?:^c^\\|^d^\\|e^\\)^")
                 '(seq bol "a^b" (or (seq bol "c^") (seq bol "d^") "e^") "^")))
  (should (equal (xr "$a$b\\(?:$c$\\|$d$\\|$e$\\)$")
                 '(seq "$a$b" (or (seq "$c" eol) (seq "$d" eol) (seq "$e" eol))
                       eol)))
  (should (equal (xr "*a\\|*b\\(*c\\)")
                 '(or "*a" (seq "*b" (group "*c")))))
  (should (equal (xr "+a\\|+b\\(+c\\)")
                 '(or "+a" (seq "+b" (group "+c")))))
  (should (equal (xr "?a\\|?b\\(^?c\\)")
                 '(or "?a" (seq "?b" (group bol "?c")))))
  (should (equal (xr "^**")
                 '(seq bol (zero-or-more "*"))))
  (should (equal (xr "^+")
                 '(seq bol "+")))
  (should (equal (xr "^?")
                 '(seq bol "?")))
  (should (equal (xr "*?a\\|^??b")
                 '(or (seq (opt "*") "a") (seq bol (opt "?") "b"))))
  (should (equal (xr "^\\{xy")
                 '(seq bol "{xy")))
  (should (equal (xr "\\{2,3\\}")
                 "{2,3}"))
  (should (equal (xr "\\(?:^\\)*")
                 '(zero-or-more bol)))
  (should (equal (xr "\\(?:^\\)\\{3\\}")
                 '(= 3 bol)))
  (should (equal (xr "\\^+")
                 '(one-or-more "^")))
  (should (equal (xr "\\c^?")
                 '(opt (category combining-diacritic))))
  (should (equal (xr "a^*")
                 '(seq "a" (zero-or-more "^"))))
  (should (equal (xr "a^\\{2,7\\}")
                 '(seq "a" (repeat 2 7 "^"))))
  )

(ert-deftest xr-simplify ()
  (should (equal (xr "a\\(?:b?\\(?:c.\\)d*\\)e")
                 '(seq "a" (opt "b") "c" nonl (zero-or-more "d") "e")))
  (should (equal (xr "a\\(?:b\\(?:c.d\\)e\\)f")
                 '(seq "abc" nonl "def")))
  )

(ert-deftest xr-pretty ()
  (should (equal (xr-pp-rx-to-str "A\e\r\n\t\0 \x7f\x80\ B\xff\x02")
                 "\"A\\e\\r\\n\\t\\x00 \\x7f\\200B\\xff\\x02\"\n"))
  (should (equal (xr-pp-rx-to-str '(?? nonl))
                 "(?? nonl)\n"))
  (should (equal (xr-pp-rx-to-str '(? ?\s))
                 "(? ?\\s)\n"))
  (should (equal (xr-pp-rx-to-str '(+? (*? ?*)))
                 "(+? (*? ?*))\n"))
  (should (equal (xr-pp-rx-to-str '(seq "a" ?a ?\s ?\n ?\" ?\\ ?0 ?\0 ?\177))
                 "(seq \"a\" ?a ?\\s ?\\n ?\\\" ?\\\\ ?0 #x00 #x7f)\n"))
  (should (equal (xr-pp-rx-to-str '(category ?Q))
                 "(category ?Q)\n"))
  (should (equal (xr-pp-rx-to-str '(any ?a ?\n ?\( ?\\ ?\200 ?Å ?Ω #x3fff80 32))
                 "(any ?a ?\\n ?\\( ?\\\\ #x80 ?Å ?Ω #x3fff80 ?\\s)\n"))
  (should (equal (xr-pp-rx-to-str '(any (?0 . ?9)))
                 "(any (?0 . ?9))\n"))
  (should (equal (xr-pp-rx-to-str '(repeat 42 ?a))
                 "(repeat 42 ?a)\n"))
  (should (equal (xr-pp-rx-to-str '(repeat 10 13 ?b))
                 "(repeat 10 13 ?b)\n"))
  (should (equal (xr-pp-rx-to-str '(** 9 32 ?c))
                 "(** 9 32 ?c)\n"))
  (should (equal (xr-pp-rx-to-str '(= 3 ?d))
                 "(= 3 ?d)\n"))
  (should (equal (xr-pp-rx-to-str '(>= 8 ?e))
                 "(>= 8 ?e)\n"))
  (should (equal (xr-pp-rx-to-str '(group-n 7 ?f))
                 "(group-n 7 ?f)\n"))
  (should (equal (xr-pp-rx-to-str '(backref 12 ?g))
                 "(backref 12 ?g)\n"))
  (let ((indent-tabs-mode nil))
    (should (equal (xr-pp-rx-to-str
                    '(seq (1+ nonl
                              (or "a"
                                  (not (any space))))
                          (* (? (not cntrl)
                                blank
                                (| nonascii "abcdef")))))
                   (concat
                    "(seq (1+ nonl\n"
                    "         (or \"a\"\n"
                    "             (not (any space))))\n"
                    "     (* (? (not cntrl)\n"
                    "           blank\n"
                    "           (| nonascii \"abcdef\"))))\n")))
    (with-temp-buffer
      (should (equal (xr-pp ".?\\|b+") nil))
      (should (equal (buffer-string)
                     (concat
                      "(or (opt nonl)\n"
                      "    (one-or-more \"b\"))\n"))))
    (with-temp-buffer
      (should (equal (xr-skip-set-pp "^ac-nq\\-u") nil))
      (should (equal (buffer-string) "(not (any \"c-n\" \"aqu-\"))\n"))))
  )

(ert-deftest xr-dialect ()
  (should (equal (xr "a*b+c?d\\{2,5\\}\\(e\\|f\\)[gh][^ij]" 'medium)
                 '(seq (zero-or-more "a") (one-or-more "b") (opt "c")
                       (repeat 2 5 "d") (group (or "e" "f"))
                       (any "gh") (not (any "ij")))))
  (should (equal (xr "a*b+c?d\\{2,5\\}\\(e\\|f\\)[gh][^ij]" 'verbose)
                 '(seq (zero-or-more "a") (one-or-more "b") (zero-or-one "c")
                       (repeat 2 5 "d") (group (or "e" "f"))
                       (any "gh") (not (any "ij")))))
  (should (equal (xr "a*b+c?d\\{2,5\\}\\(e\\|f\\)[gh][^ij]" 'brief)
                 '(seq (0+ "a") (1+ "b") (opt "c")
                       (repeat 2 5 "d") (group (or "e" "f"))
                       (any "gh") (not (any "ij")))))
  (should (equal (xr "a*b+c?d\\{2,5\\}\\(e\\|f\\)[gh][^ij]" 'terse)
                 '(: (* "a") (+ "b") (? "c")
                     (** 2 5 "d") (group (| "e" "f"))
                     (in "gh") (not (in "ij")))))
  (should (equal (xr "^\\`\\<.\\>\\'$" 'medium)
                 '(seq bol bos bow nonl eow eos eol)))
  (should (equal (xr "^\\`\\<.\\>\\'$" 'verbose)
                 '(seq line-start string-start word-start not-newline
                       word-end string-end line-end)))
  (should (equal (xr "^\\`\\<.\\>\\'$" 'brief)
                 '(seq bol bos bow nonl eow eos eol)))
  (should (equal (xr "^\\`\\<.\\>\\'$" 'terse)
                 '(: bol bos bow nonl eow eos eol)))
  (should-error (xr "a" 'asdf))
  )

(ert-deftest xr-lint ()
  (let ((text-quoting-style 'grave))
    (should (equal (xr-lint "^a*\\[\\?\\$\\(b\\{3\\}\\|c\\)[^]\\a-d^-]$")
                   nil))
    (should (equal (xr-lint "a^b$c")
                   '((1 . "Unescaped literal `^'")
                     (3 . "Unescaped literal `$'"))))
    (should (equal (xr-lint "^**$")
                   '((1 . "Unescaped literal `*'"))))
    (should (equal (xr-lint "a[\\\\[]b[d-g.d-g]c")
                   '((3 . "Duplicated `\\' inside character alternative")
                     (12 . "Duplicated `d-g' inside character alternative"))))
    (should (equal (xr-lint "\\{\\(+\\|?\\)\\[\\]\\}\\\t")
                   '((0  . "Escaped non-special character `{'")
                     (4  . "Unescaped literal `+'")
                     (7  . "Unescaped literal `?'")
                     (14 . "Escaped non-special character `}'")
                     (16 . "Escaped non-special character `\\t'"))))
    (should (equal (xr-lint "\\}\\w\\a\\b\\%")
                   '((0 . "Escaped non-special character `}'")
                     (4 . "Escaped non-special character `a'")
                     (8 . "Escaped non-special character `%'"))))
    (should (equal (xr-lint "a?+b+?\\(?:c*\\)*d\\{3\\}+e*?\\{2,5\\}")
                   '((2  . "Repetition of option")
                     (14 . "Repetition of repetition")
                     (25 . "Repetition of repetition"))))
    (should (equal (xr-lint "\\(?:a+\\)?")
                   nil))
    (should (equal (xr-lint "\\(a*\\)*\\(b+\\)*\\(c*\\)?\\(d+\\)?")
                   '((6 .  "Repetition of repetition")
                     (13 . "Repetition of repetition")
                     (20 . "Optional repetition"))))
    (should (equal (xr-lint "\\(a?\\)+\\(b?\\)?")
                   '((6 . "Repetition of option")
                     (13 . "Optional option"))))
    (should (equal (xr-lint "\\(e*\\)\\{3\\}")
                   '((6 . "Repetition of repetition"))))
    (should (equal (xr-lint "\\(a?\\)\\{4,7\\}")
                   '((6 . "Repetition of option"))))
    (should (equal (xr-lint "[]-Qa-fz-t]")
                   '((1 . "Reversed range `]-Q' matches nothing")
                     (7 . "Reversed range `z-t' matches nothing"))))
    (should (equal (xr-lint "[z-a][^z-a]")
                   nil))
    (should (equal (xr-lint "[^A-FFGI-LI-Mb-da-eg-ki-ns-t33-7]")
                   '((5  . "Character `F' included in range `A-F'")
                     (10 . "Ranges `I-L' and `I-M' overlap")
                     (16 . "Ranges `a-e' and `b-d' overlap")
                     (22 . "Ranges `g-k' and `i-n' overlap")
                     (25 . "Two-character range `s-t'")
                     (29 . "Character `3' included in range `3-7'"))))
    (should (equal (xr-lint "[a[:digit:]b[:punct:]c[:digit:]]")
                   '((22 . "Duplicated character class `[:digit:]'"))))
    (should (equal (xr-lint "a*\\|b+\\|\\(?:a\\)*")
                   '((8 . "Duplicated alternative branch"))))
    (should (equal (xr-lint "a\\{,\\}")
                   '((1 . "Uncounted repetition"))))
    (should (equal (xr-lint "a\\{\\}")
                   '((1 . "Implicit zero repetition"))))
    (should (equal (xr-lint "[0-9[|]*/]")
                   '((4 . "Suspect `[' in char alternative"))))
    (should (equal (xr-lint "[^][-].]")
                   nil))
    (should (equal (xr-lint "[0-1]")
                   nil))
    (should (equal (xr-lint "[^]-][]-^]")
                   '((6 . "Two-character range `]-^'"))))
    (should (equal
             (xr-lint "[-A-Z][A-Z-][A-Z-a][^-A-Z][]-a][A-Z---.]")
             '((16 .
                "Literal `-' not first or last in character alternative"))))
    (should (equal (xr-lint "\\'*\\<?\\(?:$\\)+")
                   '((2 . "Repetition of zero-width assertion")
                     (5 . "Optional zero-width assertion")
                     (13 . "Repetition of zero-width assertion"))))
    (should (equal
             (xr-lint "\\`\\{2\\}\\(a\\|\\|b\\)\\{,8\\}")
             '((2 . "Repetition of zero-width assertion")
               (17 . "Repetition of expression matching an empty string"))))
    ))

(ert-deftest xr-lint-repetition-of-empty ()
  (let ((text-quoting-style 'grave))
    (should (equal
             (xr-lint "\\(?:a*b?\\)*\\(c\\|d\\|\\)+\\(^\\|e\\)*\\(?:\\)*")
             '((10 . "Repetition of expression matching an empty string")
               (21 . "Repetition of expression matching an empty string"))))
    (should (equal
             (xr-lint "\\(?:a*?b??\\)+?")
             '((12 . "Repetition of expression matching an empty string"))))
    (should (equal (xr-lint "\\(?:a*b?\\)?")
                   '((10 . "Optional expression matching an empty string"))))))

(ert-deftest xr-lint-branch-subsumption ()
  (let ((text-quoting-style 'grave))
    (should (equal (xr-lint "a.cde*f?g\\|g\\|abcdefg")
                   '((14 . "Branch matches subset of a previous branch"))))
    (should (equal (xr-lint "abcd\\|e\\|[aA].[^0-9z]d")
                   '((9 . "Branch matches superset of a previous branch"))))
    (should (equal (xr-lint "\\(?:\\(a\\)\\|.\\)\\(?:a\\|\\(.\\)\\)")
                   '((21 . "Branch matches superset of a previous branch"))))
    (should (equal (xr-lint ".\\|\n\\|\r")
                   '((6 . "Branch matches subset of a previous branch"))))
    (should (equal (xr-lint "[^mM]\\|[^a-zA-Z]")
                   '((7 . "Branch matches subset of a previous branch"))))
    (should (equal (xr-lint "[^mM]\\|[^A-LN-Z]")
                   nil))
    (should (equal (xr-lint "[ab]\\|[^bcd]")
                   nil))
    (should (equal (xr-lint "[ab]\\|[^cd]")
                   '((6 . "Branch matches superset of a previous branch"))))
    (should (equal (xr-lint ".\\|[a\n]")
                   nil))
    (should (equal (xr-lint "ab?c+\\|a?b*c*")
                   '((7 . "Branch matches superset of a previous branch"))))
    (should (equal (xr-lint "\\(?:[aA]\\|b\\)\\|a")
                   '((15 . "Branch matches subset of a previous branch"))))
    (should (equal (xr-lint "\\(?:a\\|b\\)\\|[abc]")
                   '((12 . "Branch matches superset of a previous branch"))))
    (should (equal (xr-lint "\\(?:a\\|b\\)\\|\\(?:[abd]\\|[abc]\\)")
                   '((12 . "Branch matches superset of a previous branch"))))
    (should (equal (xr-lint "ab\\|abc?")
                   '((4 . "Branch matches superset of a previous branch"))))
    (should (equal (xr-lint "abc\\|abcd*e?")
                   '((5 . "Branch matches superset of a previous branch"))))
    (should (equal (xr-lint "[a[:digit:]]\\|[a\n]")
                   nil))
    (should (equal (xr-lint "[a[:ascii:]]\\|[a\n]")
                   '((14 . "Branch matches subset of a previous branch"))))

    (should (equal (xr-lint "[[:alnum:]]\\|[[:alpha:]]")
                   '((13 . "Branch matches subset of a previous branch"))))
    (should (equal (xr-lint "[[:alnum:]%]\\|[[:alpha:]%]")
                   '((14 . "Branch matches subset of a previous branch"))))
    (should (equal (xr-lint "[[:xdigit:]%]\\|[[:alpha:]%]")
                   nil))
    (should (equal (xr-lint "[[:alnum:]]\\|[^[:alpha:]]")
                   nil))
    (should (equal (xr-lint "[^[:alnum:]]\\|[[:alpha:]]")
                   nil))
    (should (equal (xr-lint "[[:digit:]]\\|[^[:punct:]]")
                   '((13 . "Branch matches superset of a previous branch"))))
    (should (equal (xr-lint "[^[:digit:]]\\|[[:punct:]]")
                   '((14 . "Branch matches subset of a previous branch"))))
    (should (equal (xr-lint "[^[:digit:]]\\|[^[:xdigit:]]")
                   '((14 . "Branch matches subset of a previous branch"))))
    (should (equal (xr-lint "[^[:print:]]\\|[[:ascii:]]")
                   nil))
    (should (equal (xr-lint "[[:print:]]\\|[^[:ascii:]]")
                   nil))
    (should (equal (xr-lint "[^[:print:]]\\|[^[:ascii:]]")
                   nil))
    (should (equal (xr-lint "[[:digit:][:cntrl:]]\\|[[:ascii:]]")
                   '((22 . "Branch matches superset of a previous branch"))))
    (should (equal (xr-lint "[[:alpha:]]\\|A")
                   '((13 . "Branch matches subset of a previous branch"))))
    (should (equal (xr-lint "[[:alpha:]]\\|[A-E]")
                   '((13 . "Branch matches subset of a previous branch"))))
    (should (equal (xr-lint "[[:alpha:]3-7]\\|[A-E46]")
                   '((16 . "Branch matches subset of a previous branch"))))
    (should (equal (xr-lint "[^[:alpha:]]\\|[123]")
                   '((14 . "Branch matches subset of a previous branch"))))
    (should (equal (xr-lint "[!-@]\\|[[:digit:]]")
                   '((7 . "Branch matches subset of a previous branch"))))
    (should (equal (xr-lint "[^a-z]\\|[[:digit:]]")
                   '((8 . "Branch matches subset of a previous branch"))))
    (should (equal (xr-lint "[^[:punct:]]\\|[a-z]")
                   '((14 . "Branch matches subset of a previous branch"))))
    (should (equal (xr-lint "[[:space:]]\\|[ \t\f]")
                   '((13 . "Branch matches subset of a previous branch"))))
    (should (equal (xr-lint "[[:word:]]\\|[a-gH-P2357]")
                   '((12 . "Branch matches subset of a previous branch"))))
    (should (equal (xr-lint "[^[:space:]]\\|[a-gH-P2357]")
                   '((14 . "Branch matches subset of a previous branch"))))
    (should (equal (xr-lint "[^z-a]\\|[^0-9[:space:]]")
                   '((8 . "Branch matches subset of a previous branch"))))

    (should (equal (xr-lint "\\(?:.\\|\n\\)\\|a")
                   '((12 . "Branch matches subset of a previous branch"))))
    (should (equal (xr-lint "\\s-\\| ")
                   '((5 . "Branch matches subset of a previous branch"))))
    (should (equal (xr-lint "\\S-\\|x")
                   '((5 . "Branch matches subset of a previous branch"))))
    (should (equal (xr-lint "\\cl\\|å")
                   '((5 . "Branch matches subset of a previous branch"))))
    (should (equal (xr-lint "\\Ca\\|ü")
                   '((5 . "Branch matches subset of a previous branch"))))
    
    (should (equal (xr-lint "\\w\\|[^z-a]")
                   '((4 . "Branch matches superset of a previous branch"))))
    (should (equal (xr-lint "\\W\\|[^z-a]")
                   '((4 . "Branch matches superset of a previous branch"))))
    (should (equal (xr-lint "\\w\\|a")
                   '((4 . "Branch matches subset of a previous branch"))))
    (should (equal (xr-lint "\\W\\|\f")
                   '((4 . "Branch matches subset of a previous branch"))))
    (should (equal (xr-lint "[[:punct:]]\\|!")
                   '((13 . "Branch matches subset of a previous branch"))))
    (should (equal (xr-lint "[[:ascii:]]\\|[^α-ω]")
                   '((13 . "Branch matches superset of a previous branch"))))
    (should (equal (xr-lint "[^a-f]\\|[h-z]")
                   '((8 . "Branch matches subset of a previous branch"))))
    (should (equal (xr-lint "[0-9]\\|\\S(")
                   '((7 . "Branch matches superset of a previous branch"))))
    (should (equal (xr-lint "a+\\|[ab]+")
                   '((4 . "Branch matches superset of a previous branch"))))
    (should (equal (xr-lint "[ab]?\\|a?")
                   '((7 . "Branch matches subset of a previous branch"))))
  ))

(ert-deftest xr-lint-subsumed-repetition ()
  (let ((text-quoting-style 'grave))
    (should (equal (xr-lint "\\(?:a.c\\|def\\)+\\(?:abc\\)*")
                   '((24 . "Repetition subsumed by preceding repetition"))))

    ;; Exhaustive test of all possible combinations.
    (should (equal (xr-lint "[ab]+a?,a?[ab]+,[ab]+a*,a*[ab]+")
                   '((6 . "Repetition subsumed by preceding repetition")
                     (14 . "Repetition subsumes preceding repetition")
                     (22 . "Repetition subsumed by preceding repetition")
                     (30 . "Repetition subsumes preceding repetition"))))

    (should (equal (xr-lint "[ab]*a?,a?[ab]*,[ab]*a*,a*[ab]*")
                   '((6 . "Repetition subsumed by preceding repetition")
                     (14 . "Repetition subsumes preceding repetition")
                     (22 . "Repetition subsumed by preceding repetition")
                     (30 . "Repetition subsumes preceding repetition"))))

    (should (equal (xr-lint "a+a?,a?a+,a+a*,a*a+,a*a?,a?a*,a*a*")
                   '((3 . "Repetition subsumed by preceding repetition")
                     (8 . "Repetition subsumes preceding repetition")
                     (13 . "Repetition subsumed by preceding repetition")
                     (18 . "Repetition subsumes preceding repetition")
                     (23 . "Repetition subsumed by preceding repetition")
                     (28 . "Repetition subsumes preceding repetition")
                     (33 . "Repetition subsumed by preceding repetition"))))

    (should (equal (xr-lint "[ab]+a??,a??[ab]+,[ab]+a*?,a*?[ab]+")
                   '((6 . "Repetition subsumed by preceding repetition")
                     (16 . "Repetition subsumes preceding repetition")
                     (24 . "Repetition subsumed by preceding repetition")
                     (34 . "Repetition subsumes preceding repetition"))))

    (should (equal (xr-lint "[ab]*a??,a??[ab]*,[ab]*a*?,a*?[ab]*")
                   '((6 . "Repetition subsumed by preceding repetition")
                     (16 . "Repetition subsumes preceding repetition")
                     (24 . "Repetition subsumed by preceding repetition")
                     (34 . "Repetition subsumes preceding repetition"))))

    (should (equal (xr-lint "a+a??,a??a+,a+a*?,a*?a+,a*a??,a??a*,a*a*?,a*?a*")
                   '((3 . "Repetition subsumed by preceding repetition")
                     (10 . "Repetition subsumes preceding repetition")
                     (15 . "Repetition subsumed by preceding repetition")
                     (22 . "Repetition subsumes preceding repetition")
                     (27 . "Repetition subsumed by preceding repetition")
                     (34 . "Repetition subsumes preceding repetition")
                     (39 . "Repetition subsumed by preceding repetition")
                     (46 . "Repetition subsumes preceding repetition"))))

    (should (equal (xr-lint "[ab]+?a?,a?[ab]+?,[ab]+?a*,a*[ab]+?")
                   nil))

    (should (equal (xr-lint "[ab]*?a?,a?[ab]*?,[ab]*?a*,a*[ab]*?")
                   nil))

    (should (equal (xr-lint "a+?a?,a?a+?,a+?a*,a*a+?,a*?a?,a?a*?,a*?a*,a*a*?")
                   '((40 . "Repetition subsumes preceding repetition")
                     (45 . "Repetition subsumed by preceding repetition"))))

    (should (equal (xr-lint "[ab]+?a??,a??[ab]+?,[ab]+?a*?,a*?[ab]+?")
                   '((7 . "Repetition subsumed by preceding repetition")
                     (17 . "Repetition subsumes preceding repetition")
                     (27 . "Repetition subsumed by preceding repetition")
                     (37 . "Repetition subsumes preceding repetition"))))

    (should (equal (xr-lint "[ab]*?a??,a??[ab]*?,[ab]*?a*?,a*?[ab]*?")
                   '((7 . "Repetition subsumed by preceding repetition")
                     (17 . "Repetition subsumes preceding repetition")
                     (27 . "Repetition subsumed by preceding repetition")
                     (37 . "Repetition subsumes preceding repetition"))))

    (should (equal (xr-lint "a+?a??,a??a+?,a+?a*?,a*?a+?,a*?a??,a??a*?,a*?a*?")
                   '((4 . "Repetition subsumed by preceding repetition")
                     (11 . "Repetition subsumes preceding repetition")
                     (18 . "Repetition subsumed by preceding repetition")
                     (25 . "Repetition subsumes preceding repetition")
                     (32 . "Repetition subsumed by preceding repetition")
                     (39 . "Repetition subsumes preceding repetition")
                     (46 . "Repetition subsumed by preceding repetition"))))
    ))

(ert-deftest xr-lint-wrapped-subsumption ()
  (let ((text-quoting-style 'grave))
    (should (equal
             (xr-lint "\\(?:a*x[ab]+\\)*")
             '((14 . "Last item in repetition subsumes first item (wrapped)"))))
    (should (equal
             (xr-lint "\\([ab]*xya?\\)+")
             '((13 . "First item in repetition subsumes last item (wrapped)"))))
    (should (equal
             (xr-lint "\\(?3:a*xa*\\)\\{7\\}")
             '((14 . "Last item in repetition subsumes first item (wrapped)"))))
    ))

(ert-deftest xr-lint-bad-anchor ()
  (let ((text-quoting-style 'grave))
    (should (equal (xr-lint "a\\(?:^\\)")
                   '((1 . "Non-newline followed by line-start anchor"))))
    (should (equal (xr-lint "a?\\(?:^\\)")
                   '((2 . "Non-newline followed by line-start anchor"))))
    (should (equal (xr-lint "a\\(?:^\\|b\\)")
                   '((1 . "Non-newline followed by line-start anchor"))))
    (should (equal (xr-lint "a?\\(?:^\\|b\\)")
                   nil))
    (should (equal (xr-lint "\\(?:$\\)a")
                   '((7 . "End-of-line anchor followed by non-newline"))))
    (should (equal (xr-lint "\\(?:$\\)\\(\n\\|a\\)")
                   '((7 . "End-of-line anchor followed by non-newline"))))
    (should (equal (xr-lint "\\(?:$\\|b\\)a")
                   '((10 . "End-of-line anchor followed by non-newline"))))
    (should (equal (xr-lint "\\(?:$\\|b\\)\\(\n\\|a\\)")
                   nil))
    (should (equal (xr-lint "\\(?3:$\\)[ab]\\(?2:^\\)")
                   '((8 . "End-of-line anchor followed by non-newline")
                     (12 . "Non-newline followed by line-start anchor"))))
    (should (equal (xr-lint ".\\(?:^$\\).")
                   '((1 . "Non-newline followed by line-start anchor")
                     (9 . "End-of-line anchor followed by non-newline"))))
    (should (equal (xr-lint "\\'b")
                   '((2 . "End-of-text anchor followed by non-empty pattern"))))
    (should (equal (xr-lint "\\'b?")
                   '((3 . "End-of-text anchor followed by non-empty pattern"))))
    (should (equal (xr-lint "\\(?:a\\|\\'\\)b")
                   '((11 .
                      "End-of-text anchor followed by non-empty pattern"))))
    (should (equal (xr-lint "\\'\\(a\\|b?\\)")
                   '((2 . "End-of-text anchor followed by non-empty pattern"))))
    (should (equal (xr-lint "\\(?:a\\|\\'\\)b?")
                   nil))
    ))

(ert-deftest xr-lint-file ()
  (let ((text-quoting-style 'grave))
    (should (equal (xr-lint "a.b\\.c.*d.?e.+f." 'file)
                   '((1 . "Possibly unescaped `.' in file-matching regexp")
                     (15 . "Possibly unescaped `.' in file-matching regexp"))))
    (should (equal (xr-lint "^abc$" 'file)
                   '((0 . "Use \\` instead of ^ in file-matching regexp")
                     (4 . "Use \\' instead of $ in file-matching regexp"))))))

(ert-deftest xr-skip-set ()
  (should (equal (xr-skip-set "0-9a-fA-F+*")
                 '(any "0-9a-fA-F" "+*")))
  (should (equal (xr-skip-set "^ab-ex-")
                 '(not (any "b-e" "ax-"))))
  (should (equal (xr-skip-set "-^][\\")
                 '(any "^][-")))
  (should (equal (xr-skip-set "\\^a\\-bc-\\fg")
                 '(any "c-f" "^abg-")))
  (should (equal (xr-skip-set "\\")
                 '(any)))
  (should (equal (xr-skip-set "--3^Q-\\")
                 '(any "--3Q-\\" "^")))
  (should (equal (xr-skip-set "^Q-\\c-\\n")
                 '(not (any "Q-c" "n-"))))
  (should (equal (xr-skip-set "\\\\A-")
                 '(any "\\A-")))
  (should (equal (xr-skip-set "[a-z]")
                 '(any "a-z" "[]")))
  (should (equal (xr-skip-set "[:ascii:]-[:digit:]")
                 '(any "-" ascii digit)))
  (should (equal (xr-skip-set "A-[:blank:]")
                 '(any "A-[" ":blank]")))
  (should (equal (xr-skip-set "\\[:xdigit:]-b")
                 '(any "]-b" "[:xdigt")))
  (should (equal (xr-skip-set "^a-z+" 'terse)
                 '(not (in "a-z" "+"))))
  (should-error (xr-skip-set "[::]"))
  (should-error (xr-skip-set "[:whitespace:]"))
  (should (equal (xr-skip-set ".")
                 "\\."))
  (should (equal (xr-skip-set "^")
                 'anything))
  (should (equal (xr-skip-set "[:alnum:]")
                 'alnum))
  (should (equal (xr-skip-set "^[:print:]")
                 '(not print)))
  )

(ert-deftest xr-skip-set-lint ()
  (let ((text-quoting-style 'grave))
    (should (equal (xr-skip-set-lint "A[:ascii:]B[:space:][:ascii:]")
                   '((20 . "Duplicated character class `[:ascii:]'"))))
    (should (equal (xr-skip-set-lint "a\\bF-AM-M\\")
                   '((1 . "Unnecessarily escaped `b'")
                     (3 . "Reversed range `F-A'")
                     (6 . "Single-element range `M-M'")
                     (9 . "Stray `\\' at end of string"))))
    (should (equal (xr-skip-set-lint "A-Fa-z3D-KM-N!3-7\\!b")
                   '((7 . "Ranges `A-F' and `D-K' overlap")
                     (10 . "Two-element range `M-N'")
                     (14 . "Range `3-7' includes character `3'")
                     (17 . "Duplicated character `!'")
                     (17 . "Unnecessarily escaped `!'")
                     (19 . "Character `b' included in range `a-z'"))))
    (should (equal (xr-skip-set-lint "!-\\$")
                   '((2 . "Unnecessarily escaped `$'"))))
    (should (equal (xr-skip-set-lint "[^a-z]")
                   '((0 . "Suspect skip set framed in `[...]'"))))
    (should (equal (xr-skip-set-lint "[0-9]+")
                   '((0 . "Suspect skip set framed in `[...]'"))))
    (should (equal (xr-skip-set-lint "[[:space:]].")
                   '((0 . "Suspect character class framed in `[...]'"))))
    (should (equal (xr-skip-set-lint "")
                   '((0 . "Empty set matches nothing"))))
    (should (equal (xr-skip-set-lint "^")
                   '((0 . "Negated empty set matches anything"))))
    (should (equal (xr-skip-set-lint "A-Z-")
                   nil))
    (should (equal (xr-skip-set-lint "-A-Z")
                   nil))
    (should (equal (xr-skip-set-lint "^-A-Z")
                   nil))
    (should (equal (xr-skip-set-lint "A-Z-z")
                   '((3 . "Literal `-' not first or last"))))
    ))

(provide 'xr-test)

;;; xr-test.el ends here

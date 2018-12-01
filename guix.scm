;; Copyright © 2019 Oleg Pykhalov <go.wigust@gmail.com>
;; Released under the GNU GPLv3 or any later version.

(use-modules (ice-9 popen)
             (ice-9 rdelim)
             (guix build utils)
             (guix gexp)
             (guix git-download)
             (guix packages)
             (guix build-system python)
             (gnu packages bash)
             (gnu packages python)
             (gnu packages admin)
             (gnu packages xml)
             (guix packages)
             ((guix licenses) #:prefix license:))

(define %source-dir (dirname (current-filename)))

(define (git-output . args)
  "Execute 'git ARGS ...' command and return its output without trailing
newspace."
  (with-directory-excursion %source-dir
    (let* ((port   (apply open-pipe* OPEN_READ "git" args))
           (output (read-string port)))
      (close-port port)
      (string-trim-right output #\newline))))

(define (current-commit)
  (git-output "log" "-n" "1" "--pretty=format:%H"))

(let ((commit (current-commit)))
  (package
    (name "nmap2json")
    (version (string-append "0.1"
                            "-" (string-take commit 7)))
    (source (local-file %source-dir
                        #:recursive? #t
                        #:select? (git-predicate %source-dir)))
    (build-system python-build-system)
    (inputs
     `(("nmap" ,nmap)
       ("python" ,python)
       ("python-xmltodict" ,python-xmltodict)))
    (synopsis "")
    (description "")
    (home-page "")
    (license license:gpl3+)))

;;; guix.scm ends here

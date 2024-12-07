;; minimize garbage collection during startup
(setq gc-cons-threshold most-positive-fixnum)

;; lower threshold back to 8 MiB (default is 800kB)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (expt 2 23))))

(setq read-process-output-max (* 4 1024 1024))
(setq process-adaptive-read-buffering nil)

;; prevent emacs from littering init.el
(setq custom-file "~/.config/emacs/custom.el")

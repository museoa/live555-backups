;; -*- mode: scheme; coding: utf-8; fill-column: 80 -*-

(use-modules (guix packages)
             (gnu packages bash)
             (gnu packages crypto)
             (gnu packages curl))

(packages->manifest
 (list bash
       coreutils
       curl
       rhash))

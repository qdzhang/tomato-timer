;;; tomato-timer.el --- A tomato-timer using pomodoro technique  -*- lexical-binding: t; -*-

;; Copyright (C) 2022  qdzhang

;; Author:  qdzhang <qdzhangcn@gmail.com>
;; Created: 21 October 2022
;; URL: https://github.com/qdzhang/tomato-timer
;; Version: 0.1
;; Keywords: timer, pomodoro technique
;; Package-Requires: ((emacs "26.1"))
;; SPDX-License-Identifier: GPL-3.0-or-later

;; This file is not part of GNU Emacs.

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:

;; A simple tomato timer using pomodoro technique

;;; Code:

(require 'notifications)

(defun tomato-send-notification ()
  "When the tomato clock ends, send a notification"
  (notifications-notify :title "Tomato ends"
                        :body "25 min passed, take a break!"))

;;;###autoload
(defun tomato-timer ()
  "Set a tomato timer for 25 minutes."
  (interactive)
  (message "Set a tomato timer")
  (run-with-timer 1500 nil 'tomato-send-notification))


(provide 'tomato-timer)
;;; tomato-timer.el ends here

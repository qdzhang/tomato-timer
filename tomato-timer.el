;;; tomato-timer.el --- A tomato-timer using pomodoro technique  -*- lexical-binding: t; -*-

;; Copyright (C) 2022  qdzhang

;; Author:  qdzhang <qdzhangcn@gmail.com>
;; Created: 21 October 2022
;; URL: https://github.com/qdzhang/tomato-timer
;; Version: 0.2
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

;; Tomato-timer
;; ============

;;   A tomato-timer using pomodoro technique. Use the built-in
;;   `notifications' library.


;; Installation
;; ~~~~~~~~~~~~

;;   Download the repository, then

;;   ,----
;;   | (load "/path/to/tomato-timer.el")
;;   | (require 'tomato-timer)
;;   `----


;; Usage
;; ~~~~~

;;   `M-x Tomato-timer' . This function will start a new tomato timer.

;;   Use `list-timers' to show all timer. If you want to close a tomato
;;   timer, put your point in the entry, press `c' will cancel it.


;; Customization
;; ~~~~~~~~~~~~~

;;   - `tomato-timer-play-sound-p' : whether play sound when a tomato-timer
;;     ends. Default is `t' , set to nil to make it silent.
;;   - `tomato-timer-audio-file-path' : the path of alert audio
;;     file. Default is the plugin directory.
;;   - `tomato-timer-audio-player' : the audio player to play the alert
;;     audio. Default is mpv.
;;   - `tomato-timer-mpv-args' : the extra mpv arguments. Default is
;;     `--no-config' in order to avoid conflict with your other fancy mpv
;;     configurations.
;;   - `tomato-timer-work-time' : the time in minutes for a tomato-timer
;;     period. Default is 25.


;;; Code:

(require 'notifications)

(defgroup tomato-timer nil
  "tomato-timer"
  :prefix "tomato-timer-"
  :group 'convenience)

(defconst tomato-timer-dir
  (file-name-directory (or load-file-name buffer-file-name))
  "tomato-timer directory where audio files store")

(defcustom tomato-timer-play-sound-p t
  "Should tomato-timer play sounds when the timer ends.
Set to nil will make alert silent."
  :group 'tomato-timer
  :type 'boolean)

(defcustom tomato-timer-audio-file-path
  (convert-standard-filename
   (expand-file-name "tone.ogg"
                     tomato-timer-dir))
  "The alert audio file path"
  :group 'tomato-timer
  :type 'string)

(defcustom tomato-timer-audio-player "mpv"
  "The audio player used to play the alert sound. Default is mpv."
  :group 'tomato-timer
  :type 'string)

(defcustom tomato-timer-mpv-args
  "--no-config"
  "The arguments used for mpv"
  :group 'tomato-timer
  :type 'string)

(defcustom tomato-timer-work-time 25
  "Length of time in minutes for a tomato-timer period"
  :group 'tomato-timer
  :type 'integer)

(defun tomato-timer-minutes-to-seconds (minutes)
  "Convert the minutes time to seconds"
  (* 60 minutes))

(defun tomato-play-alert-sound ()
  "Play the sound when tomato clock ends"
  (start-process "tomato-alert"
                 "*tomato-play-audio-buffer*"
                 tomato-timer-audio-player
                 tomato-timer-mpv-args
                 tomato-timer-audio-file-path))

(defun tomato-send-notification ()
  "When the tomato clock ends, send a notification"
  (notifications-notify :title "Tomato ends"
                        :body "25 min passed, take a break!")
  (when tomato-timer-play-sound-p
    (tomato-play-alert-sound)))

;;;###autoload
(defun tomato-timer ()
  "Set a tomato timer for 25 minutes."
  (interactive)
  (message "Set a tomato timer for %s minutes." tomato-timer-work-time)
  (run-with-timer
   (tomato-timer-minutes-to-seconds tomato-timer-work-time)
   nil 'tomato-send-notification))


(provide 'tomato-timer)
;;; tomato-timer.el ends here

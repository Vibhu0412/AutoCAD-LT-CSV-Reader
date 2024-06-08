(defun trim-string (str)
  (vl-string-trim " " str))

;; (defun split-string-by-comma (str)
;;   (if (zerop (strlen str))
;;       '()
;;     (progn
;;       (princ (strcat "\nSplitting string: " str)) ; Debug print
;;       (let ((comma-index (vl-string-search "," str)))
;;         (if comma-index
;;             (progn
;;               (princ (strcat "\nComma index found at: " (itoa comma-index))) ; Debug print
;;               (cons (substr str 1 comma-index)
;;                     (split-string-by-comma (substr str (1+ comma-index)))))
;;             (list str)))))) ; Closing parenthesis corrected

(defun split-string-by-comma (str)
  (vl-string-split str ","))



(defun read-csv-file (file-path)
  (setq data '())
  (setq file (open file-path "r"))
  (princ "\n HAHA I AM CALLED\n")
  (if file
      (progn
        ;; Skip the header line
        (read-line file)
        (while (setq line (read-line file))
          (if line ; Check if line is nil
              (progn
                (setq line (trim-string line)) ; Trim whitespace
                (princ (strcat "\nRead line: " line)) ; Debug print
                (setq split-line (split-string-by-comma line))
                (if (and split-line (= 3 (length split-line))) ; Check if split line has 3 components
                    (setq data (cons split-line data))
                    (progn
                      (princ (strcat "\nInvalid line: " line)) ; Print invalid line
                      (princ " - Skipping line.")))))) ; Print error message
        (close file)
        (reverse data))
      (princ "Error: Unable to open file.")))

(defun draw-shapes-from-csv (file-path)
  (setq file-data (read-csv-file file-path))
  (if file-data
      (progn
        (foreach row file-data
                 (setq shape (car row))
                 (setq length (cadr row))
                 (setq breadth (caddr row))
                 (cond ((= "Square" shape)
                        (command "._RECTANG" "0,0" (strcat length "," length)))
                       ((= "Rectangle" shape)
                        (command "._RECTANG" "0,0" (strcat length "," breadth))))))
    (princ "No data to draw shapes.")))

(defun c:V3Selectfile ()
  (setq file-path (getfiled "Select File" "" "csv" 4))
  (if file-path
      (progn
        (princ (strcat "\nThe following file is selected: " file-path))
        (draw-shapes-from-csv file-path))
    (princ "\nOUTSIDE IF NO file selected.")))

(princ "\nType V3Selectfile to run the program.")

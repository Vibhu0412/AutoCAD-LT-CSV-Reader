(defun read-csv-file (filename)
  (if (setq file (open filename "r"))
    (progn
      (setq data (read-line file))  ; Skip the header
      (setq result nil)
      (while (setq data (read-line file))
        (setq result (cons (parse-csv-line data) result)))
      (close file)
      (reverse result))
    (progn
      (princ (strcat "Failed to open file: " filename "\n"))
      nil)))

(defun parse-csv-line (line)
  (setq parts (vl-string->list line ","))
  (list (nth 0 parts) (atof (nth 1 parts)) (atof (nth 2 parts))))

(defun vl-string->list (str sep)
  (if (not (vl-string-search sep str))
    (list str)
    (cons (substr str 1 (vl-string-search sep str))
          (vl-string->list (substr str (+ (vl-string-search sep str) 2))
                           sep))))

(defun format-coord (x y)
  (strcat (rtos x 2 2) "," (rtos y 2 2)))

(defun draw-square (x y size)
  (command "_RECTANG" (format-coord x y) (format-coord (+ x size) (+ y size))))

(defun draw-rectangle (x y length breadth)
  (command "_RECTANG" (format-coord x y) (format-coord (+ x length) (+ y breadth))))

(defun draw-circle (x y radius)
  (command "_CIRCLE" (format-coord x y) (rtos radius)))

(defun draw-shapes-from-csv (filename)
  (setq shapes (read-csv-file filename))
  (if shapes
    (progn
      (setq y 0)
      (foreach shape shapes
        (setq type (nth 0 shape))
        (setq param1 (nth 1 shape))
        (setq param2 (nth 2 shape))
        (if (equal type "Square")
          (draw-square 0 y param1)
          (if (equal type "Rectangle")
            (draw-rectangle 0 y param1 param2)
            (if (equal type "Circle")
              (draw-circle 0 y param1)
              (princ (strcat "Unsupported shape type: " type "\n")))))
        (setq y (+ y (max param1 param2) 10))))
    (princ "No shapes to draw.")))

(defun c:R3_drawshapes ()
  (draw-shapes-from-csv "C:\\Users\\vaibh\\Documents\\autocad_task\\8_6_2024\\Circle_Square_Rectangle.csv"))

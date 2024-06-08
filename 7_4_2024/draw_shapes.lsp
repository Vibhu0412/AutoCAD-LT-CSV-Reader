(defun draw-rectangle (x1 y1 x2 y2)
  (command "RECTANG" (list x1 y1) (list x2 y2)))


(defun draw-circle (center-x center-y radius)
  (command "CIRCLE" (list center-x center-y) radius))

;; Example usage
(draw-rectangle 0 0 2 3) ;; Draw a rectangle with opposite corners at (0,0) and (10,5)
(draw-circle 30 30 2)      ;; Draw a circle with center at (30,30) and radius of 5

;;; my-house.lsp

(defun draw-house ()
  (let ((roof-width 5)
        (house-width 10)
        (house-height 8))
    (draw-roof roof-width)
    (draw-house-body house-width house-height)))

(defun draw-roof (width)
  (loop for i from 1 to width do
       (format t "~v@{~a~:*~}~%" i '#\*)
       (decf width)))

(defun draw-house-body (width height)
  (loop for i from 1 to height do
       (format t "~v@{~a~:*~}~%~v@{~a~:*~}~%" (/ (- width 2) 2) '#\| (/ width 2) '#\|)
       (decf height)))

;;; Load and run the draw-house function
(draw-house)

(* 3 *)
datatype 'a heap = empty | node of 'a * 'a heap * 'a heap

fun isHeap (node(_, empty, empty)) = true
  | isHeap (node(D, node(A, a, b), empty)) =
    D < A andalso isHeap (node(A, a, b))
  | isHeap (node(D, empty, node(A, a, b))) =
    D < A andalso isHeap (node(A, a, b))
  | isHeap (node(D, node(A, l1, r1), node(B, l2, r2))) =
    D < A andalso D < B
          andalso (isHeap (node(A, l1, r1)))
          andalso (isHeap (node(B, l2, r2)));


(* 5 metria lisi *)
fun itermap _ [] = []
  | itermap F (h::t) =
  let
    val L = map F t
  in
    (h:: (itermap F L))
  end

(* 5 komple *)
fun loop f a 0 = a
  | loop f a times = loop f (f a) (times - 1)

fun Itermap f [] times prev = rev prev
  | Itermap f (h::t) times prev =
    Itermap f t (times+1) ((loop f h times)::prev)

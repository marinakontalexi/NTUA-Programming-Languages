datatype 'a tree = empty | n of 'a * 'a tree * 'a tree

fun Sum empty = (empty, 0)
  | Sum (n(D, empty, empty)) = (n(D, empty, empty), D)
  | Sum (n(D, l, r)) =
    let
      val (L, A) = Sum l
      val (R, B) = Sum r
    in
      (n(A + B, L, R), A + B)
    end

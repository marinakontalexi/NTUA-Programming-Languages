datatype 'a tree = empty | node of 'a * 'a tree * 'a tree

fun parity empty P = (empty, nil)
  | parity (node(Data, l, r)) P =
    let
      val (L, L2) = parity l P
      val (R, R2) = parity r P
    in
      if (Data mod 2 = P) then (node(Data, L, R), L2@R2)
      else (empty, [(node(Data, l, r))])
    end

fun findall nil prev = prev
  | findall [empty] prev = prev
  | findall (empty::t) prev = findall t prev
  | findall ((node(D, l, r))::t) prev =
    let
      val (T, List) = parity (node(D, l, r)) (D mod 2)
    in
      findall (t@List) (T::prev)
    end

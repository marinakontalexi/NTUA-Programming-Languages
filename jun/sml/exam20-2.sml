(* 2a *)
fun enum low high =
  let
    fun tr prev n low =
      if (n = low) then prev
      else tr ((n-1) :: prev) (n-1) low;
  in
    tr [] (high+1) low
  end

(* 4 *)
fun mergeSort nil = nil
  | mergeSort [a] = [a]
  | mergeSort theList =
    let
      fun halve nil = (nil, nil)
        | halve [a] = ([a], nil)
        | halve (a::b::cs) =
          let
            val (x, y) = halve cs
          in
            (a::x, b::y)
          end
      fun merge (nil, b) = b
        | merge (a, nil) = a
        | merge ((indexa, a)::at, (indexb, b)::bt) =
          if indexa < indexb then (indexa, a) :: merge (at, ((indexb, b)::bt))
                   else (indexb, b) :: merge (((indexa, a)::at), bt)

      val (x, y) = halve theList
    in
      merge (mergeSort x, mergeSort y)
    end

fun sum [] _ prev = ([], prev)
  | sum a n prev =
    let
      val (i, p) = hd a
    in
      if (i = n) then sum (tl a) n (prev + p)
      else (a, prev)
    end

fun loop [] i = []
  | loop a i =
    let
      val (newa, s) = sum a i 0
    in
      s :: (loop newa (i+1))
    end

fun bidList L =
  let
    val newL = mergeSort L
  in
    loop newL 0
  end

fun bidlist L =
let
  fun comp ((x,_), (y,_)) = x > y
  fun help nil prev _ sum = sum :: prev
    | help ((n, key)::t) prev current sum =
      if (current = n) then help t prev current (sum + key)
      else help ((n, key)::t) (sum :: prev) (current + 1) 0
in
  rev (help (ListMergeSort.sort comp L) [] 0 0)
end

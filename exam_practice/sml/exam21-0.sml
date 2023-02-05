(* 2a *)
fun reduceB g F [a] = F (a, g)
  | reduceB g F (a::t) = F(a, reduceB g F t);

(* 2b *)
fun count (_, c) = c + 1;
fun len a = reduceB 0 count a;

(* 2c *)
fun tail (a, res) = (a :: (hd res)) :: res;
fun suffixes a = reduceB [[]] tail a;

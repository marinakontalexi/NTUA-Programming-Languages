fun modify nil N = nil
  | modify x N =
    let
      fun fixarr nil N = nil
        | fixarr [x] N = [~x - N]
        | fixarr (h::t) M = (~h - N) :: (fixarr t N);

      fun prefixarr nil k n = nil
        | prefixarr [x] k n = [((x + k), n)]
        | prefixarr (a :: t) k n = ((a + k), n) :: (prefixarr t (a + k) (n + 1));

      val fixed = fixarr x N
      val pref = prefixarr fixed 0 1
    in
      (0,0)::pref
    end

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
        | merge ((a, indexa)::at, (b, indexb)::bt) =
          if a < b then (a, indexa) :: merge (at, ((b, indexb)::bt))
                   else (b, indexb) :: merge (((a, indexa)::at), bt)

      val (x, y) = halve theList
    in
      merge (mergeSort x, mergeSort y)
    end

fun reverse xs =
  let
    fun rev (nil, z) = z
      | rev (y::ys, z) = rev (ys, y::z)
  in
    rev (xs, nil)
  end

fun newarr nil k = nil
  | newarr ((x, indx)::t) k =
    if (indx > k) then indx :: (newarr t indx)
                  else k :: (newarr t k);

fun maxindex xs =
  let
    val revdone = reverse xs
    val newr = newarr revdone ~1
  in
    reverse newr
  end

fun answer nil nil = 0
  | answer a nil = 0
  | answer nil b = 0
  | answer ((a, indexa)::nil) (b::nil) = (b - indexa)
  | answer ((a, indexa)::ta) (b::tb) =
  let
    val m = answer ta tb
  in
    if (b - indexa > m) then (b - indexa) else m
  end

fun longestf (0, N, x) = 0
  | longestf (M, N, nil) = 0
  | longestf (M, N, x) =
    let
      val array = reverse x
      val prefix = modify array N
      val sorted = mergeSort prefix
      val maxInd = maxindex sorted
    in
      answer sorted maxInd
    end

fun parse file =
  let
	(* A function to read an integer from specified input. *)
    fun readInt input =
	    Option.valOf (TextIO.scanStream (Int.scan StringCvt.DEC) input)
    	(* Open input file. *)
    val inStream = TextIO.openIn file
      (* Read 2 integers and consume newline. *)
    val M = readInt inStream
    val N = readInt inStream
    val _ = TextIO.inputLine inStream
      (* A function to read M integers from the open file. *)
    fun readInts 0 acc = acc (* Replace with 'rev acc' for proper order. *)
    	  | readInts i acc = readInts (i - 1) (readInt inStream :: acc)
  in
  	(M, N, readInts M [])
  end


fun longest fileName = (
  print (Int.toString (longestf (parse fileName)))
)

(*val testsuite = [
  ("one positive", 1, 1, [2], 0),
  ("one negative", 1, 1, [~2], 1),
  ("all", 5, 1, [~1, ~2, ~1, ~1, ~1], 5),
  ("all except last", 4, 1, [~1, ~1, ~3, 100], 3),
  ("all except first and last", 5, 2, [100, ~1, ~2, ~3, 100], 3),
  ("classic", 11, 3, [42, ~10, 8, 1, 11, ~6, ~12, 16, ~15, ~11, 13], 5),
  ("new", 7, 1, [~4, 3, ~3, ~5, 4, ~4, 4], 6),
  ("20", 20, 5, [~50,~68,~2,~26,~46,~12,22,57,~12,59,26,~30,~33,~63,~100,23,1,~76,~58,~84], 20)
]

fun runtests f [] = ()
  | runtests f ((name, M, N, input, output)::testcases) = (
      print ("Testcase " ^ name ^ ": ");
      if f M N input = output then print "OK\n"
                              else print "FAILED\n";
      runtests f testcases
    )

fun test f = runtests f testsuite*)

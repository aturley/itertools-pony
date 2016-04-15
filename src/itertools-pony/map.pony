class MapFn[A, B] is Iterator[B]
  """

  Take an iterator and a function and return an iterator where each
  item's value is the application of the given function to the value
  in the original iterator.

  ## Example program

  Double all of the numbers given as command line arguments.

  ```pony
  use "itertools"

  actor Main
    new create(env: Env) =>
      for x in MapFn[String, I32](env.args.slice(1).values(),
                                  lambda (s: String): I32 =>
                                    try
                                      s.i32() * 2
                                    else
                                      0
                                    end) do
        env.out.print(x.string())
      end
  ```
  """
  let _fn: {(A): B ?} val
  let _iter: Iterator[A^]

  new create(iter: Iterator[A^], fn: {(A): B ?} val) =>
    _iter = iter
    _fn = fn

  fun ref has_next(): Bool =>
    _iter.has_next()

  fun ref next(): B ? =>
    _fn(_iter.next())

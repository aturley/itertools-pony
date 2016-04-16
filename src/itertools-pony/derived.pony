use "collections"

class Skip[A] is Iterator[A]
  """
  Create an iterator that skips over items from the source iterator.

  ## Example Code

  This example only prints every 3rd argument to the program. For example:

  ```
  % skip a b c d e f g h i j
  a
  d
  g
  j
  ```

  ```
  actor Main
    new create(env: Env) =>
      for a in Skip[String](env.args.values(), 3) do
        env.out.print(a)
      end
  ```
  """
  let _i: Iterator[A] delegate Iterator[A]
  new create(i: Iterator[A^], skip: U64) =>
    _i = MapFn[(U64^, A), A](Filter[(U64^, A^)](Zip2[U64^, A^](Cycle[U64](Range[U64](0, skip)), i),
                                                lambda(x: (U64^, A)): Bool => x._1 == 0 end),
                             lambda(x: (U64^, A)): A => x._2 end)